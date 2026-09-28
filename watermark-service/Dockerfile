FROM python:3.9-slim

# Use Aliyun mirror for faster apt in China
RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list.d/debian.sources

RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    zlib1g-dev \
    libjpeg-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple/ \
    Pillow==9.5.0 \
    Flask==2.2.5 \
    redis==5.0.8 \
    requests==2.31.0 \
    stegano==0.8.1

WORKDIR /app

COPY ImgStegano_cloud.py docker-entrypoint.sh ./

RUN chmod +x docker-entrypoint.sh

EXPOSE 5001

ENTRYPOINT ["./docker-entrypoint.sh"]
