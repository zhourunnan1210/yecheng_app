#!/bin/bash
# ==========================================
# 椰城项目 - 云服务器一键部署脚本
# 用法：chmod +x deploy.sh && ./deploy.sh
# ==========================================

set -e

PROJECT_NAME="yecheng"
DEPLOY_DIR="$(cd "$(dirname "$0")/.." && pwd)"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# ----------------------------------------
# 步骤 1：检查环境
# ----------------------------------------
log_info "检查 Docker 环境..."
if ! command -v docker &> /dev/null; then
    log_error "Docker 未安装，请先安装 Docker"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    log_error "Docker Compose 未安装，请先安装 Docker Compose"
    exit 1
fi

log_info "Docker 版本: $(docker --version)"
log_info "Docker Compose 版本: $(docker-compose --version)"

# ----------------------------------------
# 步骤 2：检查 .env 文件
# ----------------------------------------
log_info "检查环境变量配置..."
if [ ! -f "$DEPLOY_DIR/.env" ]; then
    log_warn ".env 文件不存在，复制模板文件..."
    cp "$DEPLOY_DIR/.env.example" "$DEPLOY_DIR/.env"
    log_warn "请编辑 $DEPLOY_DIR/.env 文件，填写密码后再运行部署！"
    exit 1
fi

# 载入 .env，后面的健康检查要用里面的密码
set -a
# shellcheck disable=SC1091
. "$DEPLOY_DIR/.env"
set +a

if [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$REDIS_PASSWORD" ]; then
    log_error ".env 里的 MYSQL_ROOT_PASSWORD / REDIS_PASSWORD 不能为空"
    exit 1
fi

# ----------------------------------------
# 步骤 3：检查前端构建产物
# ----------------------------------------
log_info "检查前端 H5 构建产物..."
if [ ! -f "$DEPLOY_DIR/nginx/html/index.html" ]; then
    log_warn "前端构建产物不存在，请将 H5 打包文件放入 $DEPLOY_DIR/nginx/html/"
    log_warn "本地打包命令：在 HBuilder 中点击 发行 -> 网站-H5手机版"
fi

# ----------------------------------------
# 步骤 4：检查数据库初始化 SQL
# ----------------------------------------
log_info "检查数据库初始化文件..."
SQL_FILE="$DEPLOY_DIR/../database/yecheng_app_2604.sql"
if [ ! -f "$SQL_FILE" ]; then
    log_error "找不到 $SQL_FILE，无法初始化数据库"
    exit 1
fi
log_info "找到初始化 SQL：$SQL_FILE"

# ----------------------------------------
# 步骤 5：清理旧容器（可选）
# ----------------------------------------
read -p "是否清理旧容器？(y/N): " clean_old
if [[ $clean_old =~ ^[Yy]$ ]]; then
    log_info "清理旧容器..."
    docker-compose -f "$DEPLOY_DIR/docker-compose.yml" down
else
    log_info "保留现有容器..."
fi

# ----------------------------------------
# 步骤 6：拉取基础镜像
# ----------------------------------------
log_info "拉取基础镜像..."
docker pull mysql:8.0
docker pull redis:7-alpine
docker pull nginx:alpine

# ----------------------------------------
# 步骤 7：构建并启动服务
# ----------------------------------------
log_info "开始构建并启动服务..."
cd "$DEPLOY_DIR"
docker-compose up -d --build

# ----------------------------------------
# 步骤 8：等待服务就绪
# ----------------------------------------
log_info "等待服务启动（首次构建约 15~30 分钟，后续约 2~3 分钟）..."
sleep 60
log_info "服务启动中..."
sleep 60

# ----------------------------------------
# 步骤 9：健康检查
# ----------------------------------------
log_info "执行健康检查..."

# 检查 MySQL
if docker exec yecheng-mysql mysqladmin ping -h localhost -u root -p"$MYSQL_ROOT_PASSWORD" &> /dev/null; then
    log_info "MySQL 运行正常"
else
    log_warn "MySQL 可能未就绪，请稍后手动检查"
fi

# 检查 Redis
if docker exec yecheng-redis redis-cli -a "$REDIS_PASSWORD" ping 2>/dev/null | grep -q PONG; then
    log_info "Redis 运行正常"
else
    log_warn "Redis 可能未就绪，请稍后手动检查"
fi

# 检查 Java 后端
if curl -s http://localhost:10086 &> /dev/null; then
    log_info "Java 后端运行正常"
else
    log_warn "Java 后端可能未就绪，请检查日志: docker logs yecheng-app"
fi

# 检查水印服务
HEALTH_RESPONSE=$(curl -s http://localhost:5001/health 2>/dev/null)
if echo "$HEALTH_RESPONSE" | grep -q '"status".*"healthy"'; then
    log_info "ImgStegano 水印服务运行正常"
    log_info "健康检查响应: $HEALTH_RESPONSE"
else
    log_warn "ImgStegano 水印服务可能未就绪（Flask 启动约需 10~30 秒）"
    log_warn "请稍后手动检查: docker logs yecheng-watermark"
fi

# ----------------------------------------
# 完成
# ----------------------------------------
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}  椰城项目部署完成！${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "访问地址："
echo "  - 前端 H5: http://你的服务器IP"
echo "  - 后端 API: http://你的服务器IP:10086"
echo "  - 水印服务健康检查: http://你的服务器IP:5001/health"
echo ""
echo "常用命令："
echo "  查看 Java 后端日志: docker logs -f yecheng-app"
echo "  查看水印服务日志: docker logs -f yecheng-watermark"
echo "  查看 Flask API 日志: docker exec yecheng-watermark cat img_stegano.log"
echo "  停止服务: docker-compose down"
echo "  重启服务: docker-compose restart"
echo "  仅重启水印服务: docker-compose up -d --build imgstegano"
echo ""
echo -e "${YELLOW}[提示]${NC}"
echo -e "${YELLOW}  - 当前镜像只装了 LSB 隐写（stegano 库），不带 SteganoGAN 模型${NC}"
echo -e "${YELLOW}  - 如需 SteganoGAN 深度隐写，见 watermark-service/USAGE_GUIDE.md${NC}"
echo -e "${YELLOW}  - 内存不足时，请参考 deploy/README.md 常见问题添加 Swap${NC}"
