#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
ImgStegano Cloud Worker – Docker/cloud-adapted background worker.
All paths and Redis settings are read from environment variables.
"""

import os
import json
import time
import shutil
import traceback
import logging
import sys

import redis
import requests
from PIL import Image
from steganogan import SteganoGAN

# ---------------------------------------------------------------------------
# Logging
# ---------------------------------------------------------------------------
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('worker_encode.log', encoding='utf-8'),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)

# ---------------------------------------------------------------------------
# Environment
# ---------------------------------------------------------------------------
INPUT_DIR = os.environ.get('INPUT_DIR', '/app/cache/input_pictures')
ENCODED_DIR = os.environ.get('ENCODED_DIR', '/app/cache/encoded_pictures')
ENCODER_OUTPUT_DIR = os.environ.get('ENCODER_OUTPUT_DIR', '/app/cache/watermark/encoder')

REDIS_HOST = os.environ.get('REDIS_HOST', 'redis')
REDIS_PORT = int(os.environ.get('REDIS_PORT', 6379))
REDIS_PASSWORD = os.environ.get('REDIS_PASSWORD', None)
REDIS_DB = int(os.environ.get('REDIS_DB', 0))

MAX_RETRY = int(os.environ.get('MAX_RETRY', 3))
TIMEOUT = int(os.environ.get('TIMEOUT', 60))
QUEUE_NAME = os.environ.get('QUEUE_NAME', 'imgstegano:encode:queue')
RESULT_PREFIX = os.environ.get('RESULT_PREFIX', 'imgstegano:result:')

# ---------------------------------------------------------------------------
# Redis & Model
# ---------------------------------------------------------------------------
redis_kwargs = {
    'host': REDIS_HOST,
    'port': REDIS_PORT,
    'db': REDIS_DB,
}
if REDIS_PASSWORD:
    redis_kwargs['password'] = REDIS_PASSWORD

r = redis.Redis(**redis_kwargs)
logger.info(f"Worker Redis configured: {REDIS_HOST}:{REDIS_PORT} db={REDIS_DB}")

model = SteganoGAN.load(architecture='dense', cuda=False)
logger.info("Worker SteganoGAN model loaded (cpu).")

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
def _encode_lsb(input_path, output_path, message):
    """LSB encode using stegano."""
    from stegano.lsb import hide
    secret = hide(input_path, message)
    secret.save(output_path)


def _encode_steganogan(input_path, output_path, message):
    """SteganoGAN encode."""
    model.encode(input_path, output_path, message)


# ---------------------------------------------------------------------------
# Main loop
# ---------------------------------------------------------------------------
while True:
    try:
        task_data = r.brpop(QUEUE_NAME, timeout=5)
        if not task_data:
            continue

        _, task_json = task_data
        task = json.loads(task_json)
        task_id = task['task_id']
        file_name = task['file_name']
        message = task['message']
        method = task.get('method', 'steganogan')
        retry = task.get('retry', 0)

        try:
            start_time = time.time()
            input_path = os.path.join(INPUT_DIR, file_name)
            if not os.path.exists(input_path):
                raise FileNotFoundError(f'Input image not found: {input_path}')

            # SteganoGAN: resize oversized images
            if method == 'steganogan':
                image = Image.open(input_path)
                max_pixels = 2250000
                width, height = image.size
                total_pixels = width * height
                if total_pixels > max_pixels:
                    scale = (max_pixels / total_pixels) ** 0.5
                    new_width = int(width * scale)
                    new_height = int(height * scale)
                    image = image.resize((new_width, new_height), Image.ANTIALIAS)
                    image.save(input_path)
                    logger.info(f"Task {task_id}: image resized to {new_width}x{new_height}")

            # Internal output path: /app/cache/encoded_pictures/<method>/<task_id>.png
            encoded_dir = os.path.join(ENCODED_DIR, method)
            os.makedirs(encoded_dir, exist_ok=True)
            output_path = os.path.join(encoded_dir, f'{task_id}.png')

            # Shared encoder output: /app/cache/watermark/encoder/<method>/<task_id>/<task_id>.png
            encoder_dir = os.path.join(ENCODER_OUTPUT_DIR, method, task_id)
            os.makedirs(encoder_dir, exist_ok=True)
            encoder_output_path = os.path.join(encoder_dir, f'{task_id}.png')

            # Timeout guard
            if time.time() - start_time > TIMEOUT:
                raise TimeoutError('Encoding timed out')

            # Encode
            if method == 'lsb':
                _encode_lsb(input_path, output_path, message)
            else:
                _encode_steganogan(input_path, output_path, message)

            # Copy to shared encoder directory
            try:
                shutil.copy2(output_path, encoder_output_path)
                logger.info(f"Task {task_id}: copied to {encoder_output_path}")
            except Exception as copy_e:
                logger.warning(f"Task {task_id}: copy to encoder dir failed: {copy_e}")

            encoded_image_rel_path = os.path.join(method, f'{task_id}.png')
            result = {
                'success': True,
                'encoded_image_name': encoded_image_rel_path,
                'method': method
            }
            r.set(RESULT_PREFIX + task_id, json.dumps(result), ex=3600)

            # Callback notification
            callback_url = task.get('callback_url')
            if callback_url:
                try:
                    requests.post(callback_url, json={'task_id': task_id, 'result': result})
                except Exception as cb_e:
                    logger.warning(f"Callback failed: {cb_e}")

        except Exception as e:
            logger.error(f"Task {task_id} failed: {e}")
            logger.error(traceback.format_exc())

            if retry + 1 < MAX_RETRY:
                task['retry'] = retry + 1
                r.lpush(QUEUE_NAME, json.dumps(task))
            else:
                result = {'success': False, 'error': str(e), 'method': method}
                r.set(RESULT_PREFIX + task_id, json.dumps(result), ex=3600)

                callback_url = task.get('callback_url')
                if callback_url:
                    try:
                        requests.post(callback_url, json={'task_id': task_id, 'result': result})
                    except Exception as cb_e:
                        logger.warning(f"Callback failed: {cb_e}")

    except Exception as e:
        logger.error(f"Worker main-loop exception: {e}")
        logger.error(traceback.format_exc())
        time.sleep(2)
