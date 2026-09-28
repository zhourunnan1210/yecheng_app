# 🚀 椰城项目 - 从零到上线完整部署指南

> **目标读者**：没有运维经验的新手，跟着步骤复制粘贴就能部署成功。
> 
> **预估总耗时**：首次部署约 **2~3 小时**，熟练后 **1 小时**。
> 
> **当前版本**：**混合水印方案**（LSB + SteganoGAN）
> - `< 300KB` 图片 → **LSB** 最低有效位隐写（轻量、100% 可靠）
> - `300KB ~ 3MB` 图片 → **SteganoGAN** 深度学习隐写（高安全性）
> - `> 3MB` 图片 → Java 后端先压缩，再使用 **SteganoGAN**
> 
> 两种编码方式由 Java 后端根据文件大小自动选择，无需人工干预。

---

## ⚠️ 开工前必读：文档与代码的两处不一致

本文按**混合水印方案**描述（这也是项目设计目标），但仓库里 `watermark-service/Dockerfile`
实际构建的是 **LSB-only 版本**——只安装 `stegano` 库、只运行 `ImgStegano_cloud.py`，
**不包含 SteganoGAN**（该文件头注释写明 `All SteganoGAN code removed for compatibility`）。

因此：

| 事项 | 本仓库实际情况 |
|------|----------------|
| `docker-compose up` 构建出的水印服务 | LSB-only，同步编码，不依赖 Redis 任务队列 |
| 下文提到的 `worker_encode_cloud.py`、`ImgStegano.py`、`worker_encode.py` | 仓库里有源码，但**不在镜像里**，需自行补 PyTorch/SteganoGAN 依赖后使用 |
| 水印容器内存限制 | compose 里是 **2G**；下文按 SteganoGAN 方案写的 **6G** 只在你启用完整版时才需要 |

另外有一个组件**不在本仓库**：文本向量服务（`embedding.service.url`，默认 `http://textembed:5000`）。
它负责人才/岗位的语义搜索与推荐排序（Qwen3-Embedding + Qwen3-Reranker）。
不部署它不影响登录、浏览、发布等主流程，但相关搜索接口会走降级逻辑或返回空结果。

如果你只需要 LSB 水印，本文照做即可；如果要 SteganoGAN 深度隐写，
参考 `watermark-service/USAGE_GUIDE.md` 自行构建镜像。

---

## 📋 目录

1. [架构总览](#一架构总览)
2. [云服务器与云存储推荐](#二云服务器与云存储推荐)
3. [部署前准备](#三部署前准备)
4. [购买并配置云服务器](#四购买并配置云服务器)
5. [服务器环境安装](#五服务器环境安装)
6. [打包并上传项目](#六打包并上传项目)
7. [部署上线](#七部署上线)
8. [配置域名与 HTTPS](#八配置域名与https可选但强烈建议)
9. [配置阿里云 OSS（图片云存储）](#九配置阿里云oss图片云存储)
10. [附录 A：dual_watermark 进阶方案（暂不使用）](#十附录-adual_watermark-进阶方案暂不使用)
11. [常见问题排查](#十一常见问题排查)
12. [运维常用命令](#十二运维常用命令)

---

## 一、架构总览

本项目由 **5 个服务** 组成，全部用 Docker 一键启动：

```
用户浏览器/微信
       │
       ▼
   ┌─────────┐     ┌─────────────────┐
   │  Nginx  │────▶│   前端 H5       │ (Uni-app 打包的静态网页)
   │  :80    │     │   nginx/html    │
   └────┬────┘     └─────────────────┘
        │
        │ /api/*
        ▼
   ┌─────────────┐     ┌─────────┐     ┌─────────────┐
   │ Java 后端   │────▶│  MySQL  │     │   Redis     │
   │ :10086      │     │ :3306   │     │   :6379     │
   └──────┬──────┘     └─────────┘     └─────────────┘
          │
          │ HTTP 调用
          ▼
   ┌────────────────────┐
   │ ImgStegano         │  ← 当前使用：混合水印方案
   │ :5001              │     LSB（小图）+ SteganoGAN（大图）
   │                    │     自动选择、内存占用 ~1-2GB
   └────────────────────┘
```

> 📝 **关于 dual_watermark**：本项目代码中保留了 `dual_watermark`（基于 PyTorch 深度学习的数字水印方案），但目前**暂不启用**。如需使用，请参考 [附录 A](#十附录-adual_watermark-进阶方案暂不使用)。

---

## 二、云服务器与云存储推荐

### 2.1 云服务器推荐

| 项目 | 推荐方案 | 说明 |
|------|----------|------|
| **厂商** | 阿里云 / 腾讯云 | 国内访问快，文档齐全，学生有优惠 |
| **实例类型** | 共享型 s6 / 轻量应用服务器 | 性价比最高 |
| **配置** | **2核 4G~8G 内存** | ✅ 混合方案中 SteganoGAN 加载模型需 ~1GB 内存，建议 4G 起步，生产环境 8G 更稳 |
| **带宽** | **3M 及以上** | 图片上传下载多，带宽太小会卡 |
| **系统盘** | 40GB SSD | 系统 + Docker 镜像占用约 10GB |
| **数据盘** | 50GB | 存放图片缓存、日志 |
| **操作系统** | **Ubuntu 22.04** | 推荐 Ubuntu，Docker 兼容性最好 |
| **地域** | 离你用户最近的节点 | 华南选深圳，华东选杭州 |

**💰 费用预估**（混合水印版）：
- 阿里云轻量 2核4G5M：约 **100~150 元/月**（最低推荐，SteganoGAN 模型加载后内存约 1GB）
- 阿里云轻量 2核8G6M：约 **200~300 元/月**（生产环境推荐，更稳定）
- 腾讯云轻量 2核4G6M：约 **100~150 元/月**

> 💡 **省钱技巧**：阿里云/腾讯云都有"新人首单"优惠，首年可能只要几十块。学生认证更便宜。
>
> ⚠️ **注意**：混合方案中 SteganoGAN 加载 PyTorch 模型后常驻内存约 **1~1.5GB**，建议至少 **4G 内存**。如果预算有限，可临时添加 Swap 虚拟内存（见 [常见问题 Q6](#q6服务器内存不足oom)）。

### 2.2 云存储推荐（图片存储）

| 项目 | 推荐方案 |
|------|----------|
| **对象存储** | **阿里云 OSS** |
| **原因** | 项目代码已集成阿里云 OSS SDK，直接可用 |
| **费用** | 标准存储约 0.12 元/GB/月，流量费 0.5~0.8 元/GB |
| **优势** | 图片走 CDN，用户访问快；不占用服务器带宽 |

> 如果项目初期用户少，也可以**先用服务器本地存储**，上线后再迁移到 OSS。

---

## 三、部署前准备

### 3.1 本地需要准备的工具

| 工具 | 用途 | 下载地址 |
|------|------|----------|
| **HBuilderX** | 打包前端 H5 | [官网](https://www.dcloud.io/hbuilderx.html) |
| **FinalShell / XShell** | 连接云服务器（SSH） | [FinalShell](http://www.hostbuf.com/) |
| **FileZilla** | 上传文件到服务器（SFTP） | [官网](https://filezilla-project.org/) |

### 3.2 你需要知道的信息

- 云服务器的 **公网 IP 地址**（购买后可在控制台看到）
- **root 密码**（购买时设置，或重置密码）
- 一个 **域名**（可选，配置 HTTPS 需要）

---

## 四、购买并配置云服务器

### 4.1 购买服务器（以阿里云为例）

1. 打开 [阿里云官网](https://www.aliyun.com/)
2. 登录账号 -> 进入"云服务器 ECS"控制台
3. 点击"创建实例"
4. 按下图选择配置：
   - **付费模式**：包年包月（长期使用）或按量付费（测试）
   - **地域**：选择离你最近的
   - **实例规格**：**2核 4G**（ImgStegano 很轻量，4G 足够）
   - **镜像**：**Ubuntu 22.04 64位**
   - **带宽**：**3M 或 5M**
   - **安全组**：勾选 SSH(22)、HTTP(80)、HTTPS(443)
5. 设置 root 密码（记住！）
6. 确认订单，支付

### 4.2 配置安全组（放行端口）

服务器买好后，必须放行以下端口，否则外网无法访问：

| 端口 | 用途 | 授权对象 |
|------|------|----------|
| 22 | SSH 远程连接 | 你的本机 IP |
| 80 | HTTP 网页访问 | 0.0.0.0/0（所有人） |
| 443 | HTTPS 安全网页 | 0.0.0.0/0 |
| 10086 | Java 后端 API | 0.0.0.0/0 |
| 5001 | ImgStegano 水印服务（调试用）| **你的本机 IP** |
| 3306 | MySQL 数据库 | **你的本机 IP**（不要公开！） |
| 6379 | Redis 缓存 | **你的本机 IP**（不要公开！） |

**操作步骤**：
1. 进入阿里云控制台 -> 云服务器 ECS -> 你的实例
2. 点击"安全组" -> "配置规则"
3. 点击"手动添加"，添加上述端口

> ⚠️ **安全警告**：3306(MySQL) 和 6379(Redis) 只允许你自己的 IP 访问！如果你不知道本机 IP，先设置为 `0.0.0.0/0`，部署完成后再限制。

---

## 五、服务器环境安装

### 5.1 连接服务器

打开 **FinalShell**（或 XShell）：
- 主机：你的服务器公网 IP
- 端口：22
- 用户名：root
- 密码：购买时设置的密码

连接成功后，你会看到类似这样的命令行：
```
root@iZbp1xxxxxxxxxZ:~#
```

### 5.2 安装 Docker + Docker Compose

把下面的命令**逐行复制粘贴**到 FinalShell 中执行：

```bash
# ========== 1. 更新系统 ==========
apt update && apt upgrade -y

# ========== 2. 安装必要工具 ==========
apt install -y curl wget git vim unzip

# ========== 3. 安装 Docker ==========
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

# 启动 Docker
systemctl start docker
systemctl enable docker

# 测试 Docker
docker --version
# 输出类似：Docker version 24.0.7, build afdd53b

# ========== 4. 安装 Docker Compose ==========
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 添加执行权限
chmod +x /usr/local/bin/docker-compose

# 创建软链接
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# 测试
docker-compose --version
# 输出类似：Docker Compose version v2.23.0

# ========== 5. 配置 Docker 镜像加速（国内必做）==========
mkdir -p /etc/docker
cat > /etc/docker/daemon.json << 'EOF'
{
  "registry-mirrors": [
    "https://docker.mirrors.ustc.edu.cn",
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com"
  ]
}
EOF

# 重启 Docker
systemctl restart docker
```

> ⏱️ 这一步大约需要 **10~15 分钟**。

### 5.3 创建项目目录

```bash
mkdir -p /opt/yecheng
cd /opt/yecheng
```

---

## 六、打包并上传项目

### 6.1 打包 Java 后端

**在本地电脑上操作**（用 IDEA 或命令行）：

```bash
# 进入后端项目目录
cd backend

# Maven 打包（跳过测试，速度快）
mvn clean package -DskipTests

# 打包成功后，会生成 target/highly-new-app-0.0.1-SNAPSHOT.jar
```

> 如果你本地没有 Maven，用 IDEA 直接点击右侧 Maven 面板 -> Lifecycle -> package。

### 6.2 打包前端 H5

**⚠️ 打包前必须修改 API 地址：**

打开 `frontend/utils/api.js`（或类似位置），将 `BASE_URL` 从 `http://localhost:10086` 改为你的服务器地址：

```javascript
const BASE_URL = "http://你的服务器IP:10086"  // ← 改成这个
```

同时检查 `frontend/manifest.json` 中的 `domain` 字段，如果有硬编码的 IP，也改为你的服务器 IP 或域名。

**用 HBuilderX 打包：**

1. 打开 **HBuilderX**
2. 打开项目 `frontend`
3. 点击菜单栏：**发行 -> 网站-H5手机版**
4. 等待编译完成（左下角看进度）
5. 打包产物在：`frontend/unpackage/dist/build/h5/`

> 打包后的目录结构应该是：
> ```
> h5/
> ├── index.html
> ├── static/
> │   ├── css/
> │   ├── js/
> │   └── img/
> └── ...
> ```

### 6.3 上传项目到服务器

**方法 A：用 FileZilla（推荐新手）**

1. 打开 FileZilla
2. 填写连接信息：
   - 主机：`sftp://你的服务器IP`
   - 用户名：`root`
   - 密码：你的密码
   - 端口：22
3. 连接后，左侧是本机，右侧是服务器
4. 将本机的整个项目文件夹拖到服务器的 `/opt/yecheng/` 目录

**方法 B：用命令行（如果你熟悉）**

```bash
# 从本地打包整个项目上传到服务器
# 注意：先把 node_modules 和 .git 删掉，减少体积

# 本地执行
scp -r /path/to/yecheng_app root@你的服务器IP:/opt/yecheng/
```

**必须上传的文件清单**：

```
/opt/yecheng/
├── backend/                    # Java 后端
│   ├── Dockerfile
│   ├── pom.xml
│   └── src/
│   └── target/highly-new-app-0.0.1-SNAPSHOT.jar  ← 打包产物
├── frontend/                 # 前端源码（备用）
├── python/
│   └── ImgStegano/                 # Python 水印服务（当前使用）
│       ├── Dockerfile
│       ├── ImgStegano_cloud.py     ← API 服务（云端适配版）
│       ├── worker_encode_cloud.py  ← 异步 Worker（云端适配版）
│       └── ImgStegano.py           ← 原始版本（Windows本地开发用）
├── database/
│   └── yecheng_app_2604.sql        # 数据库 SQL
└── deploy/                         # 部署配置文件夹
    ├── docker-compose.yml
    ├── .env.example
    ├── nginx/
    │   ├── nginx.conf
    │   └── html/                   # 这里放前端打包产物
    ├── database/
    └── scripts/
        └── deploy.sh
```

> 📝 关于 `python/dual_watermark/`：该目录保留但不参与当前部署，如需使用请参考 [附录 A](#十附录-adual_watermark-进阶方案暂不使用)。

### 6.4 放置前端打包产物

在服务器上执行：

```bash
# 将 H5 打包产物复制到 nginx 目录
cp -r /opt/yecheng/frontend/unpackage/dist/build/h5/* /opt/yecheng/deploy/nginx/html/

# 验证
cat /opt/yecheng/deploy/nginx/html/index.html
```

### 6.5 放置数据库 SQL

```bash
# SQL 只有一份，放在 /opt/yecheng/database/，compose 会自动挂载并导入，无需手动拷贝
```

---

## 七、部署上线

### 7.1 配置环境变量

```bash
cd /opt/yecheng/deploy

# 复制环境变量模板
cp .env.example .env

# 编辑 .env（推荐用 nano，比 vim 简单）
nano .env
```

> 💡 **nano 使用方法**：方向键移动光标，直接打字修改。改完后按 `Ctrl+O` 保存，按 `Enter` 确认，再按 `Ctrl+X` 退出。
>
> 如果你坚持用 vim：按 `i` 进入编辑模式，修改后按 `Esc`，输入 `:wq` 保存退出。

**必须修改的内容：**
```bash
MYSQL_ROOT_PASSWORD=你的强密码        # MySQL root 密码
MYSQL_PASSWORD=你的强密码             # MySQL 普通用户密码（Java后端用）
REDIS_PASSWORD=你的强密码             # Redis 密码
```

> ⚠️ **三个密码建议设置不同的值**，尤其是 `MYSQL_ROOT_PASSWORD` 和 `MYSQL_PASSWORD` 不要相同。

### 7.2 执行一键部署脚本

```bash
cd /opt/yecheng/deploy
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

脚本会自动完成：
1. 检查 Docker 环境
2. 拉取基础镜像
3. 构建 Java 后端镜像
4. 构建 ImgStegano 水印服务镜像（**基于 miniconda3 + PyTorch，构建约 15~30 分钟**）
5. 启动 MySQL、Redis、Nginx
6. 健康检查

> ⏱️ **首次构建时间较长**：miniconda3 基础镜像约 400MB，PyTorch 1.0.0 + steganogan 模型下载约 500MB，总构建时间 **15~30 分钟**（取决于网络速度）。
> 
> 💡 **加速技巧**：如果构建卡住，确保已配置 Docker 镜像加速（见 [5.2 步骤](#52-安装-docker--docker-compose)）。
>
> ⏱️ 后续更新（只改业务代码不改 Dockerfile）约 **5~10 分钟**。
> 
> 如果卡住不动，按 `Ctrl+C` 取消，重新运行 `./scripts/deploy.sh`。

### 7.3 验证部署结果

```bash
# 查看所有容器状态
docker ps

# 应该看到 5 个容器都在运行：
# yecheng-nginx
# yecheng-app
# yecheng-watermark   ← ImgStegano 服务
# yecheng-mysql
# yecheng-redis
```

**浏览器测试**：
- 打开 `http://你的服务器IP`
- 应该能看到前端 H5 页面
- 打开 `http://你的服务器IP:10086`
- 应该能看到 Java 后端（可能显示 Whitelabel Error Page，这是正常的）
- 打开 `http://你的服务器IP:5001/health`
- 应该返回 JSON：`{"status":"healthy","redis":"ok","service":"imgstegano"}`

### 7.4 导入初始数据（如果数据库为空）

如果页面能打开但登录报错，可能是数据库没数据。手动导入：

```bash
# 复制 SQL 到 MySQL 容器
docker cp /opt/yecheng/database/yecheng_app_2604.sql yecheng-mysql:/tmp/

# 进入 MySQL 容器执行导入
docker exec -i yecheng-mysql mysql -uroot -p你的密码 yecheng_app_2604 < /opt/yecheng/database/yecheng_app_2604.sql
```

---

## 八、配置域名与 HTTPS（可选但强烈建议）（可选但强烈建议）

没有域名也能用 IP 访问，但有域名更好记，且能配 HTTPS。

### 8.1 购买域名

1. 阿里云/腾讯云搜索"域名注册"
2. 输入你想要的域名（如 `yecheng.com`）
3. 选一个未注册的，加入清单，付款
4. 实名认证（必须，否则无法解析）

### 8.2 域名解析到服务器

1. 进入域名控制台 -> 解析
2. 添加一条 **A 记录**：
   - 主机记录：`www`（或 `@`）
   - 记录值：你的服务器公网 IP
3. 等待 10 分钟生效

### 8.3 申请免费 SSL 证书

1. 阿里云控制台搜索 **SSL 证书**
2. 点击"免费证书" -> "创建证书"
3. 填写域名，验证方式选"自动 DNS 验证"
4. 下载 **Nginx 格式**的证书（得到 `.crt` 和 `.key` 两个文件）

### 8.4 上传证书并启用 HTTPS

```bash
# 在服务器上创建证书目录
mkdir -p /opt/yecheng/deploy/nginx/ssl

# 用 FileZilla 把下载的两个证书文件上传到 ssl 目录
```

修改 nginx 配置：

```bash
vim /opt/yecheng/deploy/nginx/nginx.conf
```

把文件底部的 HTTPS server 块取消注释，修改 `server_name` 和证书路径：

```nginx
server {
    listen       443 ssl;
    server_name  www.your-domain.com;  # ← 改成你的域名

    ssl_certificate      /etc/nginx/ssl/your-domain.crt;  # ← 证书文件名
    ssl_certificate_key  /etc/nginx/ssl/your-domain.key;  # ← 私钥文件名
    ...
}
```

重启 Nginx：
```bash
cd /opt/yecheng/deploy && docker-compose restart nginx
```

现在可以用 `https://www.your-domain.com` 访问了！

---

## 九、配置阿里云 OSS（图片云存储）

如果用户上传的图片直接存服务器，磁盘和带宽很快会被占满。**强烈建议上线后接入 OSS**。

### 9.1 开通 OSS

1. 阿里云控制台 -> 对象存储 OSS
2. 点击"创建 Bucket"
3. 配置：
   - **Bucket 名称**：全局唯一，如 `yecheng-images-2024`
   - **地域**：和服务器选同一个
   - **存储类型**：标准存储
   - **读写权限**：公共读（图片能被外链访问）
4. 创建成功

### 9.2 获取 AccessKey

1. 右上角头像 -> AccessKey 管理
2. 创建 AccessKey（保存 `AccessKey ID` 和 `AccessKey Secret`，只显示一次！）

### 9.3 配置后端读取 OSS 凭据

后端的 OSS 配置**不在代码里**，全部通过环境变量注入，所以不需要改代码、不需要重新打包。
在 `deploy/.env` 里补上这四行即可：

```bash
OSS_ENDPOINT=oss-cn-hangzhou.aliyuncs.com   # 换成你的 bucket 所在地域
OSS_BUCKET_NAME=your-bucket-name
OSS_ACCESS_KEY_ID=你的 AccessKey ID
OSS_ACCESS_KEY_SECRET=你的 AccessKey Secret
```

然后重启后端容器让它读到新变量：

```bash
cd /opt/yecheng/deploy
docker-compose up -d yecheng-app
```

> ⚠️ **不要把 AccessKey 写进 `application.yml` 或任何被 git 跟踪的文件。**
> 一旦提交上去，即使之后删掉，密钥仍留在 git 历史里，只能靠轮换密钥补救。

> 说明：`application.yml` 里的 `oss.bucket-domain` 由 `OSS_BUCKET_NAME` 和 `OSS_ENDPOINT`
> 自动拼接，业务代码用它判断图片 URL 是否指向本桶。所以这两个变量必须写对，
> 否则上传的图片会被误判成失效链接、被替换成默认占位图。

### 9.4 配置 CDN（可选，加速图片访问）

1. 阿里云控制台 -> CDN
2. 添加加速域名：`images.your-domain.com`
3. 源站选择 OSS 域名
4. 在域名解析添加一条 CNAME 记录
5. 图片 URL 变为 `https://images.your-domain.com/xxx.jpg`

---

## 十、附录 A：水印技术方案对比

> 📌 **当前部署使用的是混合方案（LSB + SteganoGAN），兼具两种技术的优点。**

### A.1 三种水印方案对比

| 特性 | LSB 隐写 | SteganoGAN 隐写 | **混合方案（当前使用）** |
|------|----------|-----------------|------------------------|
| **技术原理** | 最低有效位替换 | GAN 生成对抗网络隐写 | 智能路由：小图 LSB，大图 SteganoGAN |
| **安全性** | 一般（肉眼不可见，但易被检测） | 高（抗统计分析、抗压缩） | **高**（小图用 LSB 保可靠，大图用 GAN 保安全） |
| **解码可靠性** | 100%（只要图片不被压缩） | 概率性（小图成功率低，大图高） | **100% 小图 + 高概率大图** |
| **内存占用** | ~50MB | ~1-1.5GB（模型常驻内存） | **~1-1.5GB**（模型常驻） |
| **启动时间** | < 1 秒 | 10-30 秒（加载模型） | **10-30 秒**（加载模型） |
| **构建时间** | < 1 分钟 | 15-30 分钟（下载 PyTorch） | **15-30 分钟** |
| **服务器要求** | 2核2G 足够 | 建议 2核4G+ | **2核4G 起步，推荐 2核8G** |
| **适用场景** | 小图片、快速部署 | 大图片、高安全要求 | **全场景覆盖** |

### A.2 文件大小与编码方式自动路由

Java 后端根据上传图片的文件大小自动选择编码方式：

| 文件大小 | 编码方式 | 原因 |
|----------|----------|------|
| `< 300KB` | **LSB** | 小图 SteganoGAN 解码成功率低，LSB 100% 可靠 |
| `300KB ~ 3MB` | **SteganoGAN** | 大图 SteganoGAN 解码成功率高，安全性更好 |
| `> 3MB` | **Java 压缩 → SteganoGAN** | 超大图先压缩到 3MB 以内，再用 SteganoGAN |

> 💡 **这个路由逻辑在 Java 后端自动完成**，无需修改 Python 服务配置。

### A.3 如需调整路由阈值

修改 Java 后端代码中的阈值常量（`ImgSteganoController.java` 和 `FinancialInstitutionServiceImpl.java`）：

```java
// 当前阈值
private static final long LSB_MAX_SIZE = 300 * 1024;      // 300KB
private static final long STEGANOGAN_MAX_SIZE = 3 * 1024 * 1024;  // 3MB
```

修改后重新打包部署：
```bash
cd backend && mvn clean package -DskipTests
# 上传新 jar 到服务器，然后重启
cd /opt/yecheng/deploy && docker-compose up -d --build yecheng-app
```

---

## 十一、常见问题排查

### Q1：Docker 镜像下载特别慢/失败

**原因**：默认从 Docker Hub 下载，国内网络慢。

**解决**：确保已配置镜像加速（见 5.2 步骤），然后重试：
```bash
docker-compose build --no-cache
```

### Q2：ImgStegano 水印服务启动失败

**原因**：可能是依赖安装失败或 Redis 连接不上。

**解决**：
```bash
# 查看水印服务日志
docker logs -f yecheng-watermark

# 检查 Redis 是否正常运行
docker exec yecheng-redis redis-cli ping
```

### Q3：Java 后端连接数据库失败

**原因**：数据库还没初始化完，后端就先启动了。

**解决**：
```bash
# 重启后端
docker-compose restart yecheng-app

# 查看报错日志
docker logs yecheng-app | tail -50
```

### Q4：前端页面白屏

**原因**：前端 API 地址可能还是 `localhost`。

**解决**：检查前端 `manifest.json` 或 `main.js` 中的 `baseUrl`，改为服务器 IP 或域名。

### Q5：图片上传成功但访问不了

**原因**：
1. 文件只存了本地路径，没配 OSS
2. Nginx 没配静态资源访问

**解决**：检查 `application.yml` 的 `storage.base-dir`，确保和 Docker 卷挂载路径一致（`/app/cache`）。

### Q6：服务器内存不足（OOM）

**原因**：SteganoGAN 加载 PyTorch 模型后常驻内存约 **1~1.5GB**，加上 Java 后端、MySQL、Redis 等，总内存占用约 **2~3GB**。

**解决**：
- **推荐**：升级服务器到 **2核8G** 配置。
- **临时方案**：添加 Swap 虚拟内存：
```bash
# 添加 4G 虚拟内存（建议至少 2~4G）
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
# 设置开机自动挂载
echo '/swapfile none swap sw 0 0' >> /etc/fstab
```

> ⚠️ **注意**：使用 Swap 会导致 SteganoGAN 推理速度变慢（磁盘 I/O 替代内存），建议仅作为临时方案。

---

## 十二、运维常用命令

```bash
# ========== 查看状态 ==========
docker ps                              # 查看运行中的容器
docker-compose ps                      # 查看 compose 项目状态

# ========== 查看日志 ==========
docker logs -f yecheng-app             # 实时查看 Java 后端日志
docker logs -f yecheng-watermark       # 实时查看 ImgStegano 水印日志
docker logs -f yecheng-mysql           # 查看数据库日志
docker logs --tail 100 yecheng-app     # 只看最后 100 行

# ========== 重启/停止/启动 ==========
docker-compose restart                 # 重启所有服务
docker-compose restart yecheng-app     # 只重启后端
docker-compose restart imgstegano      # 只重启水印服务
docker-compose stop                    # 停止所有服务
docker-compose start                   # 启动所有服务
docker-compose down                    # 停止并删除容器（保留数据卷）
docker-compose down -v                 # 停止并删除容器+数据卷（清空数据！）

# ========== 进入容器内部 ==========
docker exec -it yecheng-app bash       # 进入 Java 容器
docker exec -it yecheng-watermark bash # 进入 ImgStegano 容器
docker exec -it yecheng-mysql bash     # 进入 MySQL 容器
mysql -uroot -p                        # 进入 MySQL 命令行

# ========== 备份数据库 ==========
docker exec yecheng-mysql mysqldump -uroot -p你的密码 yecheng_app_2604 > backup.sql

# ========== 更新部署 ==========
# 1. 本地修改代码 -> 打包 -> 上传到服务器
# 2. 重新构建并启动
cd /opt/yecheng/deploy
docker-compose up -d --build
```

---

## 十三、部署文件清单

本项目已为你生成以下部署文件：

| 文件 | 说明 |
|------|------|
| `deploy/docker-compose.yml` | 5 个服务的编排配置（ImgStegano 版） |
| `deploy/.env.example` | 环境变量模板 |
| `deploy/nginx/nginx.conf` | Nginx 反向代理配置 |
| `deploy/nginx/html/` | 前端 H5 静态资源目录 |
| `database/` | 数据库建表与示例数据 SQL（compose 首次启动自动导入）|
| `deploy/scripts/deploy.sh` | 一键部署脚本 |
| `python/ImgStegano/Dockerfile` | **混合水印服务镜像**（当前使用，miniconda3 + PyTorch） |
| `python/ImgStegano/ImgStegano_cloud.py` | 云端/Docker 适配版 API 服务（支持 LSB/SteganoGAN/auto） |
| `python/ImgStegano/worker_encode_cloud.py` | 云端/Docker 适配版 Worker（自动选择编码方式） |
| `python/ImgStegano/docker-entrypoint.sh` | 容器启动脚本（CSDN 补丁 + 双进程启动） |
| `python/ImgStegano/ImgStegano.py` | Windows/WSL 本地开发版 |
| `python/ImgStegano/worker_encode.py` | Windows/WSL 本地开发版 Worker |
| `python/dual_watermark/` | 旧版 dual_watermark（已废弃，功能被 SteganoGAN 替代） |

---

## 🎉 恭喜你！

如果按照以上步骤操作，你的椰城项目现在已经成功部署到云服务器上了！

把 `http://你的服务器IP` 或 `https://你的域名` 发给朋友，他们就能直接访问了。

如果遇到问题，先查 **常见问题排查** 章节，或查看容器日志定位错误。
