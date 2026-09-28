#!/bin/bash
set -e

mkdir -p /app/cache/input_pictures
mkdir -p /app/cache/encoded_pictures
mkdir -p /app/cache/decoded_pictures
mkdir -p /app/cache/watermark/encoder

echo "Cache directories ready."
echo "Starting ImgStegano LSB service ..."

exec python /app/ImgStegano_cloud.py
