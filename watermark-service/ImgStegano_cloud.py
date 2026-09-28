#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
ImgStegano Cloud API – LSB-only version.
All SteganoGAN code removed for compatibility.
"""

import json
import os
import traceback
import uuid
import logging
import sys
import shutil

import redis
from flask import Flask, request, jsonify

# ---------------------------------------------------------------------------
# Logging
# ---------------------------------------------------------------------------
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('img_stegano.log', encoding='utf-8'),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)

# ---------------------------------------------------------------------------
# App & environment
# ---------------------------------------------------------------------------
app = Flask(__name__)

INPUT_DIR = os.environ.get('INPUT_DIR', '/app/cache/input_pictures')
ENCODED_DIR = os.environ.get('ENCODED_DIR', '/app/cache/encoded_pictures')
DECODED_DIR = os.environ.get('DECODED_DIR', '/app/cache/decoded_pictures')
ENCODER_OUTPUT_DIR = os.environ.get('ENCODER_OUTPUT_DIR', '/app/cache/watermark/encoder')

REDIS_HOST = os.environ.get('REDIS_HOST', 'redis')
REDIS_PORT = int(os.environ.get('REDIS_PORT', 6379))
REDIS_PASSWORD = os.environ.get('REDIS_PASSWORD', None)
REDIS_DB = int(os.environ.get('REDIS_DB', 0))

FLASK_HOST = os.environ.get('FLASK_HOST', '0.0.0.0')
FLASK_PORT = int(os.environ.get('FLASK_PORT', 5001))

QUEUE_NAME = os.environ.get('QUEUE_NAME', 'imgstegano:encode:queue')
RESULT_PREFIX = os.environ.get('RESULT_PREFIX', 'imgstegano:result:')
MAX_RETRY = int(os.environ.get('MAX_RETRY', 3))
TIMEOUT = int(os.environ.get('TIMEOUT', 60))

os.makedirs(INPUT_DIR, exist_ok=True)
os.makedirs(ENCODED_DIR, exist_ok=True)
os.makedirs(DECODED_DIR, exist_ok=True)

# Redis client
redis_kwargs = {
    'host': REDIS_HOST,
    'port': REDIS_PORT,
    'db': REDIS_DB,
}
if REDIS_PASSWORD:
    redis_kwargs['password'] = REDIS_PASSWORD

r = redis.Redis(**redis_kwargs)
logger.info(f"Redis configured: {REDIS_HOST}:{REDIS_PORT} db={REDIS_DB}")


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
def _encode_lsb(input_path, output_path, message):
    """LSB encode."""
    from stegano.lsb import hide
    hide(input_path, message).save(output_path)


def _decode_lsb(image_path):
    """LSB decode; return None on failure."""
    try:
        from stegano.lsb import reveal
        return reveal(image_path)
    except Exception:
        return None


# ---------------------------------------------------------------------------
# Endpoints
# ---------------------------------------------------------------------------
@app.route('/health', methods=['GET'])
def health():
    try:
        r.ping()
        redis_status = 'ok'
    except Exception as e:
        redis_status = f'error: {e}'
    return jsonify({
        'status': 'healthy',
        'redis': redis_status,
        'service': 'imgstegano-lsb'
    })


@app.route('/encode', methods=['POST'])
def encode():
    """
    Encode a message into an image (LSB only).
    JSON body: file_name, message, method (ignored, always LSB)
    """
    try:
        data = request.json
        if 'file_name' not in data or 'message' not in data:
            return jsonify({'error': 'file_name and message are required'}), 400

        file_name = data['file_name']
        message = data['message']

        input_path = os.path.join(INPUT_DIR, file_name)
        if not os.path.exists(input_path):
            return jsonify({'error': f'input image not found: {input_path}'}), 404

        task_id = str(uuid.uuid4())
        method = 'lsb'

        encoded_dir = os.path.join(ENCODED_DIR, method)
        os.makedirs(encoded_dir, exist_ok=True)
        output_path = os.path.join(encoded_dir, f'{task_id}.png')

        encoder_dir = os.path.join(ENCODER_OUTPUT_DIR, method, task_id)
        os.makedirs(encoder_dir, exist_ok=True)
        encoder_output_path = os.path.join(encoder_dir, f'{task_id}.png')

        _encode_lsb(input_path, output_path, message)

        try:
            shutil.copy2(output_path, encoder_output_path)
            logger.info(f"Task {task_id}: copied to {encoder_output_path}")
        except Exception as copy_e:
            logger.warning(f"Task {task_id}: copy failed: {copy_e}")

        encoded_rel = os.path.join(method, f'{task_id}.png')
        result = json.dumps({
            'success': True,
            'encoded_image_name': encoded_rel,
            'method': method
        })
        r.setex(f'{RESULT_PREFIX}{task_id}', TIMEOUT, result)

        return jsonify({
            'status': 'completed',
            'task_id': task_id,
            'result': {
                'success': True,
                'encoded_image_name': encoded_rel,
                'method': method
            }
        })
    except Exception as e:
        logger.error(f"Encode failed: {e}")
        logger.error(traceback.format_exc())
        return jsonify({'error': str(e)}), 500


@app.route('/encode/result', methods=['GET'])
def encode_result():
    task_id = request.args.get('task_id')
    if not task_id:
        return jsonify({'error': 'task_id required'}), 400

    result_json = r.get(f'{RESULT_PREFIX}{task_id}')
    if result_json is None:
        return jsonify({'status': 'pending'})

    result = json.loads(result_json)
    return jsonify({'task_id': task_id, 'result': result})


@app.route('/decode', methods=['POST'])
def decode():
    """
    Decode a hidden message from an image (LSB only).
    JSON body: file_name
    """
    try:
        data = request.json
        if 'file_name' not in data:
            return jsonify({'error': 'file_name is required'}), 400

        file_name = data['file_name']
        input_path = os.path.join(DECODED_DIR, file_name)
        if not os.path.exists(input_path):
            return jsonify({'error': 'input image not found'}), 404

        message = _decode_lsb(input_path)
        if message:
            return jsonify({'success': True, 'message': message, 'method': 'lsb'}), 200
        else:
            return jsonify({'error': 'no hidden message found'}), 500
    except Exception as e:
        logger.error(f"Decode failed: {e}")
        logger.error(traceback.format_exc())
        return jsonify({'error': str(e)}), 500


# Inline worker: process encode tasks from Redis queue in the same process
def process_queue():
    """Process encode tasks inline (LSB is instant, no async worker needed)."""
    while True:
        try:
            task_json = r.blpop(QUEUE_NAME, timeout=1)
            if task_json is None:
                break  # no pending tasks
            _, data = task_json
            task = json.loads(data)
            task_id = task.get('task_id', str(uuid.uuid4()))
            file_name = task['file_name']
            message = task['message']

            input_path = os.path.join(INPUT_DIR, file_name)
            if not os.path.exists(input_path):
                result = json.dumps({'success': False, 'error': f'input image not found: {input_path}'})
                r.setex(f'{RESULT_PREFIX}{task_id}', TIMEOUT, result)
                continue

            method = 'lsb'
            encoded_dir = os.path.join(ENCODED_DIR, method)
            os.makedirs(encoded_dir, exist_ok=True)
            output_path = os.path.join(encoded_dir, f'{task_id}.png')

            encoder_dir = os.path.join(ENCODER_OUTPUT_DIR, method, task_id)
            os.makedirs(encoder_dir, exist_ok=True)
            encoder_output_path = os.path.join(encoder_dir, f'{task_id}.png')

            _encode_lsb(input_path, output_path, message)

            try:
                shutil.copy2(output_path, encoder_output_path)
                logger.info(f"Queue task {task_id}: copied to {encoder_output_path}")
            except Exception as copy_e:
                logger.warning(f"Queue task {task_id}: copy failed: {copy_e}")

            result = json.dumps({
                'success': True,
                'encoded_image_name': os.path.join(method, f'{task_id}.png'),
                'method': method
            })
            r.setex(f'{RESULT_PREFIX}{task_id}', TIMEOUT, result)
        except Exception as e:
            logger.error(f"Queue error: {e}")
            break


# ---------------------------------------------------------------------------
# Startup
# ---------------------------------------------------------------------------
if __name__ == '__main__':
    logger.info("ImgStegano LSB-only service starting on port %s", FLASK_PORT)
    logger.info("Processing any pending queue tasks...")
    process_queue()
    logger.info("Starting Flask...")
    app.run(host=FLASK_HOST, port=FLASK_PORT, debug=False)
