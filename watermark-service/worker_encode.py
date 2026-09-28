import os
import json
import time
import redis
import traceback
import logging
import sys
from PIL import Image
from steganogan import SteganoGAN
import datetime
import requests

# 配置logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('worker_encode.log', encoding='utf-8'),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)

# Redis配置
r = redis.Redis(host='localhost', port=6379, db=0)

# 隐写模型
model = SteganoGAN.load(architecture='dense', cuda=False)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# 与 Java 后端共享的缓存目录（通过 Windows 挂载路径）
SHARED_CACHE_BASE = '/mnt/d/Code/yecheng-back-26-04/yecheng_app/cache'
INPUT_DIR = os.path.join(SHARED_CACHE_BASE, 'input_pictures')
ENCODED_DIR = os.path.join(SHARED_CACHE_BASE, 'encoded_pictures')

# Windows 共享输出目录（用于 Java 后端直接读取）
WINDOWS_ENCODER_BASE = '/mnt/d/Code/yecheng-back-26-04/image/watermark/encoder'

# 配置
MAX_RETRY = 3
TIMEOUT = 60  # 单个任务最大处理秒数
QUEUE_NAME = 'imgstegano:encode:queue'
RESULT_PREFIX = 'imgstegano:result:'


def _encode_lsb(input_path, output_path, message):
    """使用 LSB 编码"""
    from stegano.lsb import hide
    secret = hide(input_path, message)
    secret.save(output_path)


def _encode_steganogan(input_path, output_path, message):
    """使用 SteganoGAN 编码"""
    model.encode(input_path, output_path, message)


while True:
    try:
        task_data = r.brpop(QUEUE_NAME, timeout=5)
        if not task_data:
            continue  # 队列空，继续等待
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
                raise FileNotFoundError(f'输入图片不存在: {input_path}')

            file_name_only = os.path.basename(input_path)

            # 读取图片（SteganoGAN 模式下需要检查尺寸）
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

            # 构建输出路径
            # Linux 内部: cache/encoded_pictures/<method>/<task_id>.png
            encoded_dir = os.path.join(ENCODED_DIR, method)
            os.makedirs(encoded_dir, exist_ok=True)
            output_path = os.path.join(encoded_dir, f'{task_id}.png')

            # Windows 共享路径: /mnt/d/.../image/watermark/encoder/<method>/<task_id>/<task_id>.png
            windows_dir = os.path.join(WINDOWS_ENCODER_BASE, method, task_id)
            os.makedirs(windows_dir, exist_ok=True)
            windows_output_path = os.path.join(windows_dir, f'{task_id}.png')

            # 超时控制
            if time.time() - start_time > TIMEOUT:
                raise TimeoutError('隐写处理超时')

            # 根据 method 选择编码方式
            if method == 'lsb':
                _encode_lsb(input_path, output_path, message)
            else:
                _encode_steganogan(input_path, output_path, message)

            # 同时复制到 Windows 共享路径
            try:
                import shutil
                shutil.copy2(output_path, windows_output_path)
                logger.info(f'任务{task_id}已复制到Windows路径: {windows_output_path}')
            except Exception as copy_e:
                logger.warning(f'任务{task_id}复制到Windows路径失败: {copy_e}')

            encoded_image_rel_path = os.path.join(method, f'{task_id}.png')
            result = {
                'success': True,
                'encoded_image_name': encoded_image_rel_path,
                'method': method
            }
            r.set(RESULT_PREFIX + task_id, json.dumps(result), ex=3600)

            # 主动回调
            callback_url = task.get('callback_url')
            if callback_url:
                try:
                    requests.post(callback_url, json={'task_id': task_id, 'result': result})
                except Exception as cb_e:
                    logger.warning(f"回调通知失败: {cb_e}")
        except Exception as e:
            logger.error(f"任务{task_id}失败: {e}")
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
                        logger.warning(f"回调通知失败: {cb_e}")
    except Exception as e:
        logger.error(f"Worker主循环异常: {e}")
        logger.error(traceback.format_exc())
        time.sleep(2)
