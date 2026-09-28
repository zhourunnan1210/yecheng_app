#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import os
import traceback
import uuid
import logging
import sys

import redis
from flask import Flask, request, jsonify
from steganogan import SteganoGAN

# 配置logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('img_stegano.log', encoding='utf-8'),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)

app = Flask(__name__)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# 与 Java 后端共享的缓存目录（通过 Windows 挂载路径）
SHARED_CACHE_BASE = '/mnt/d/Code/yecheng-back-26-04/yecheng_app/cache'
INPUT_DIR = os.path.join(SHARED_CACHE_BASE, 'input_pictures')
ENCODED_DIR = os.path.join(SHARED_CACHE_BASE, 'encoded_pictures')
DECODED_DIR = os.path.join(SHARED_CACHE_BASE, 'decoded_pictures')

# Windows 共享输出目录（用于 Java 后端直接读取）
WINDOWS_ENCODER_BASE = '/mnt/d/Code/yecheng-back-26-04/image/watermark/encoder'

# 确保输入输出目录存在
os.makedirs(INPUT_DIR, exist_ok=True)
os.makedirs(ENCODED_DIR, exist_ok=True)
os.makedirs(DECODED_DIR, exist_ok=True)

# 初始化SteganoGAN模型
model = SteganoGAN.load(architecture='dense', cuda=False)

r = redis.Redis(host='localhost', port=6379, db=0)


def _try_steganogan_decode(image_path):
    """尝试用 SteganoGAN 解码，失败返回 None"""
    try:
        return model.decode(image_path)
    except Exception:
        return None


def _try_lsb_decode(image_path):
    """尝试用 LSB 解码，失败返回 None"""
    try:
        from stegano.lsb import reveal
        return reveal(image_path)
    except Exception:
        return None


@app.route('/encode', methods=['POST'])
def encode():
    """
    将消息隐藏到图像中（入队，不直接处理）
    参数:
        - file_name: 图像文件名
        - message: 要隐藏的消息文本
        - callback_url: 结果回调地址（可选）
        - method: 编码方式，"lsb" 或 "steganogan"（可选，默认"steganogan"）
    返回:
        - task_id: 任务唯一ID
    """
    try:
        data = request.json
        if 'file_name' not in data or 'message' not in data:
            return jsonify({'error': '需要提供file_name和message'}), 400
        file_name = data['file_name']
        message = data['message']
        callback_url = data.get('callback_url')
        method = data.get('method', 'steganogan')
        if method not in ('lsb', 'steganogan'):
            return jsonify({'error': 'method必须是"lsb"或"steganogan"'}), 400

        task_id = str(uuid.uuid4())
        task = {
            'task_id': task_id,
            'file_name': file_name,
            'message': message,
            'method': method
        }
        if callback_url:
            task['callback_url'] = callback_url
        r.lpush('imgstegano:encode:queue', json.dumps(task))
        return jsonify({'task_id': task_id, 'status': 'queued'}), 200
    except Exception as e:
        logger.error(f"编码任务入队失败: {e}")
        logger.error(traceback.format_exc())
        return jsonify({'error': str(e)}), 500


@app.route('/encode/result', methods=['GET'])
def encode_result():
    """
    查询隐写任务结果
    参数:
        - task_id: 任务唯一ID
    返回:
        - result: 处理结果
    """
    try:
        task_id = request.args.get('task_id')
        result = r.get(f"imgstegano:result:{task_id}")
        if result:
            return jsonify({'task_id': task_id, 'result': json.loads(result)}), 200
        else:
            return jsonify({'status': 'pending'}), 200
    except Exception as e:
        logger.error(f"查询任务结果失败: {e}")
        logger.error(traceback.format_exc())
        return jsonify({'error': str(e)}), 500


@app.route('/decode', methods=['POST'])
def decode():
    """
    从图像中提取隐藏的消息
    参数:
        - file_name: 图像文件名
        - method: 解码方式，"lsb" / "steganogan" / "auto"（可选，默认"auto"）
    返回:
        - message: 提取的隐藏消息
        - method: 实际使用的解码方式
    """
    try:
        data = request.json
        if 'file_name' not in data:
            return jsonify({'error': '需要提供file_name'}), 400
        file_name = data['file_name']
        method = data.get('method', 'auto')
        if method not in ('lsb', 'steganogan', 'auto'):
            return jsonify({'error': 'method必须是"lsb"、"steganogan"或"auto"'}), 400

        input_path = os.path.join(DECODED_DIR, file_name)
        if not os.path.exists(input_path):
            return jsonify({'error': '输入图片不存在'}), 404

        message = None
        used_method = None

        if method == 'steganogan':
            message = _try_steganogan_decode(input_path)
            used_method = 'steganogan'
        elif method == 'lsb':
            message = _try_lsb_decode(input_path)
            used_method = 'lsb'
        else:  # auto
            message = _try_steganogan_decode(input_path)
            if message:
                used_method = 'steganogan'
            else:
                message = _try_lsb_decode(input_path)
                used_method = 'lsb' if message else None

        if message:
            return jsonify({'success': True, 'message': message, 'method': used_method}), 200
        else:
            return jsonify({'error': '未能提取到隐藏消息'}), 500
    except Exception as e:
        logger.error(f"解码图像失败: {e}")
        logger.error(traceback.format_exc())
        return jsonify({'error': str(e)}), 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
