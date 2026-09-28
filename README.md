# 椰城 · 海南高企服务咨询平台

> 面向高新技术企业的一站式服务平台：政策、人才、金融、技术成果四类资源在这里对接。
> 前后端分离，含深度学习图像水印模块，Docker Compose 一键部署。

[English summary](#english-summary) · [快速开始](#快速开始docker-一键跑起来) · [部署文档](deploy/README.md) · [已知限制](#已知限制与待补齐部分)

---

## 项目简介

这个项目为海南的高新技术企业提供四类服务对接：

| 模块 | 解决的问题 |
|------|-----------|
| **政策服务** | 自贸港政策、人才认定政策、高企申报政策的发布与检索 |
| **人才服务** | 企业发布人才需求，个人发布求职简历，双向智能匹配与推荐 |
| **金融服务** | 融资需求发布、金融产品与机构展示、信用材料查询 |
| **技术成果** | 技术需求发布、技术成果展示、成果评价报告 |

此外还有园区信息、新闻资讯、在线咨询，以及基于深度学习的**图片数字水印**（上传的证件照、简历照片会嵌入不可见水印，可用于溯源）。

## 功能与技术栈

| 模块 | 技术栈 | 说明 |
|------|--------|------|
| `backend/` | Spring Boot 2.3.4 · Java 8 · MyBatis-Plus · Druid · Redis · MySQL 8 | 260 个 Java 文件、40 个 Controller。集成 Swagger(knife4j)、阿里云 OSS SDK、webmagic 爬虫 |
| `frontend/` | uni-app · Vue 2 · uView UI · Vuex | 117 个页面、74 个组件，H5 单端部署，可扩展小程序 |
| `watermark-service/` | Python 3.9 · Flask · Redis · `stegano` / SteganoGAN | 异步图像隐写服务，LSB 与深度隐写两种方案 |
| `deploy/` | Docker Compose · MySQL 8 · Redis 7 · Nginx | 5 个容器一键编排 |
| `database/` | MySQL 8 | 65 张表，含建表语句与脱敏后的示例数据 |

其中**图像水印**是相对少见的部分：Java 后端按文件大小路由到不同隐写算法，Flask 服务负责实际编码，Redis 做任务队列，编码结果通过回调写回业务表。

---

## 项目结构

```
yecheng_app/
├── backend/                     # Java 后端（Spring Boot）
│   ├── src/main/java/com/hnu/highlynewapp/
│   │   ├── app/                 #   业务接口（人才/金融/政策/技术）
│   │   ├── controller/          #   水印、OSS、回调等接口
│   │   ├── service/ dao/ entity/#   服务层、数据层、实体
│   │   ├── authentication/      #   企业/高校注册审核
│   │   └── utils/               #   OssUtil、TextEmbeddingUtils 等
│   ├── src/main/resources/
│   │   ├── application.yml      #   主配置（Redis、水印、OSS、CORS）
│   │   ├── application-dev.yml  #   Docker 部署用（连容器内网）
│   │   ├── application-local.yml#   本地开发用
│   │   └── mapper/              #   MyBatis XML
│   └── Dockerfile
├── frontend/                    # uni-app H5 前端
│   ├── pages/                   #   117 个页面
│   ├── components/ static/      #   组件与静态资源
│   ├── utils/api.js             #   ★ 后端接口地址在这里配置
│   └── manifest.json            #   ★ appid / 域名占位符在这里替换
├── watermark-service/           # Python 图像隐写服务
│   ├── ImgStegano.py            #   完整版：Flask + Redis + SteganoGAN
│   ├── worker_encode.py         #   SteganoGAN 编码 Worker
│   ├── ImgStegano_cloud.py      #   云端版：LSB-only，无 SteganoGAN
│   ├── worker_encode_cloud.py   #   LSB Worker（当前镜像未打包）
│   └── Dockerfile               #   ⚠️ 构建的是 LSB-only 版本
├── database/
│   └── yecheng_app_2604.sql     # 建表 + 脱敏示例数据（65 张表）
├── deploy/
│   ├── docker-compose.yml       # 5 容器编排
│   ├── .env.example             # ★ 环境变量模板，密码在这里填
│   ├── nginx/                   # Nginx 配置与前端静态资源目录
│   └── scripts/deploy.sh        # 一键部署脚本
├── docs/                        # 补充文档
└── LICENSE                      # MIT
```

★ 标记的文件是部署前**必须改**的地方。

---

## 快速开始（Docker 一键跑起来）

### 前置要求

- Docker 与 Docker Compose
- 2 核 4G 内存起步（水印服务需要额外内存）
- 前端要单独打包一次（见下方第 3 步）

### 步骤

**1. 配置环境变量**

```bash
cd deploy
cp .env.example .env
vim .env          # 填写 MYSQL_ROOT_PASSWORD / MYSQL_PASSWORD / REDIS_PASSWORD
```

密码留空 compose 会直接报错退出——这是刻意设计的，避免用默认弱口令把服务暴露到公网。

**2. 构建后端**

```bash
cd backend
mvn clean package -DskipTests
```

**3. 打包前端**

用 HBuilderX 打开 `frontend/` 目录，先把 `utils/api.js` 里的 `BASE_URL` 改成你的服务器地址，然后
点菜单栏 **发行 → 网站-H5 手机版**，把 `unpackage/dist/build/h5/` 下的文件全部复制到 `deploy/nginx/html/`。

**4. 启动全部服务**

```bash
cd deploy
docker-compose up -d --build
```

首次启动会自动导入 `database/yecheng_app_2604.sql`（建表 + 示例数据），约 5~10 分钟。

**5. 验证**

```bash
docker ps                                    # 应看到 5 个容器
curl http://localhost:5001/health            # 水印服务
```

| 服务 | 地址 |
|------|------|
| 前端页面 | `http://你的服务器IP` |
| 后端 API | `http://你的服务器IP:10086` |
| 水印服务 | `http://你的服务器IP:5001/health` |
| 接口文档 | `http://你的服务器IP:10086/doc.html`（knife4j） |

### 演示账号

数据库里的示例数据是脱敏后重新生成的，可以直接登录：

| 入口 | 账号 | 密码 |
|------|------|------|
| 前台用户（`user` 表，MD5 存储） | `user001` | `123456` |
| 后台管理员（`sys_user` 表，BCrypt） | `admin` | `admin123` |

> 后台管理界面属于另一套基于 RuoYi 的系统，**不在本仓库内**。
> `sys_*` 系列表和上面的管理员账号由那份代码使用，本仓库只保留了表结构。

---

## 本地开发

### 后端

1. 本地起 MySQL 8 与 Redis，导入 `database/yecheng_app_2604.sql`
2. 按需修改 `backend/src/main/resources/application-local.yml`，或直接用环境变量覆盖：
   ```bash
   DB_HOST=localhost DB_PORT=3306 DB_NAME=yecheng_app_2604 \
   DB_USERNAME=root DB_PASSWORD=你的密码 \
   mvn spring-boot:run
   ```
3. 服务起在 `10086`，接口文档 `http://localhost:10086/doc.html`

### 前端

见 [frontend/README.md](frontend/README.md)，用 HBuilderX 打开即可，配置后端地址改 `frontend/utils/api.js`。

### 水印服务

```bash
cd watermark-service
pip install Pillow Flask redis requests stegano
python ImgStegano_cloud.py       # LSB-only，不需要 Redis
```

---

## 配置说明

所有敏感配置都走环境变量，代码里没有硬编码密钥。

| 变量 | 用途 | 必填 |
|------|------|------|
| `MYSQL_ROOT_PASSWORD` / `MYSQL_PASSWORD` | MySQL 密码 | ✅ |
| `REDIS_PASSWORD` | Redis 密码 | ✅ |
| `OSS_ENDPOINT` / `OSS_BUCKET_NAME` / `OSS_ACCESS_KEY_ID` / `OSS_ACCESS_KEY_SECRET` | 阿里云 OSS，图片上传用 | 图片上传功能需要 |
| `CORS_ALLOWED_ORIGINS` | 允许跨域的前端来源，逗号分隔 | 部署后建议设置 |
| `EMBEDDING_SERVICE_URL` | 文本向量服务地址 | 见下方说明 |
| `BASE_CACHE_DIR` | 图片暂存目录 | 有默认值 |

> `OSS_BUCKET_NAME` 和 `OSS_ENDPOINT` 必须填对：后端会用它们拼出 `oss.bucket-domain`，
> 用来判断图片 URL 是否指向自己的桶。填错会导致上传的图片被误判为失效链接、显示成默认占位图。

---

## 已知限制与待补齐部分

以下是这个仓库**目前不完整**的地方，避免你按文档操作时踩坑：

**1. 文本向量服务不在仓库内。**
人才/岗位的语义搜索与推荐依赖一个独立的向量服务（`embedding.service.url`，默认 `http://textembed:5000`），
提供 `/embed`、`/embed_batch`、`/rerank`、`/search_and_rerank` 四个接口，设计上配合
Qwen3-Embedding-0.6B + Qwen3-Reranker-0.6B 使用。这个服务没有包含在仓库里，需要自行部署。
不部署它不影响登录、浏览、发布等主流程，但相关搜索接口会走降级逻辑（纯向量检索）或返回空结果。

**2. 水印服务镜像只打包了 LSB 版本。**
`watermark-service/Dockerfile` 只安装 `stegano` 库、只运行 `ImgStegano_cloud.py`，
**不含 SteganoGAN**（该文件头注释写明 `All SteganoGAN code removed for compatibility`）。
带 SteganoGAN 的完整版本（`ImgStegano.py` + `worker_encode.py`）源码在仓库里，
需要自行补 PyTorch 等依赖后构建。
因此 `deploy/README.md` 里"混合水印方案""内存改 6G""两条 python 进程"等描述
只在启用完整版时才适用；默认镜像用 2G 内存足够。

**3. `deploy/README.md` 与 `docs/部署指南.md` 保留了原始描述。**
两份文档按混合水印方案编写，与当前 Dockerfile 存在上述偏差，阅读时请以本节的说明为准。

**4. 前端有两处历史遗留的目录/命名问题**（不影响运行，改起来会牵动多个文件）：
- `frontend/components/pickerAddress.vue/` 其实是个**目录**，里面套着同名文件，
  6 个页面按 `'.../components/pickerAddress.vue/pickerAddress.vue'` 这种路径导入。
- `frontend/pages/finance/` 下有两个**文件名带空格**的页面（`cridit inquiry.vue`、`project inquiry.vue`），
  且 `cridit` 是 `credit` 的拼写错误。

**5. 示例数据已脱敏。**
`database/yecheng_app_2604.sql` 保留了全部 65 张表的建表语句和行数，但人名、手机号、邮箱、
证件照路径、后台账号等字段已替换为虚构数据。所以页面上的联系人信息都是假的，这是预期行为。

**6. CORS 有两处配置，其中一处放开了所有来源。**
`config/WebConfig.java` 从环境变量 `CORS_ALLOWED_ORIGINS` 读取白名单，
但 `config/AppConfig.java` 里另有一份 `allowedOrigins("*")` 的配置。两者同时生效，
实际效果是**任意来源都能跨域访问后端**（`AppConfig` 里 `allowCredentials(false)`，
所以不涉及携带 Cookie 的请求）。如果你要收紧跨域限制，需要把 `AppConfig` 里那份一起改掉，
只改 `WebConfig` 不起作用。这是项目原有的实现，未在整理过程中改动行为。

---

## 文档

| 文档 | 内容 |
|------|------|
| [deploy/README.md](deploy/README.md) | 完整部署指南（云服务器选购、HTTPS、OSS 配置、排错） |
| [docs/部署指南.md](docs/部署指南.md) | 部署速查版 |
| [frontend/README.md](frontend/README.md) | 前端项目说明与 HBuilderX 配置 |
| [watermark-service/USAGE_GUIDE.md](watermark-service/USAGE_GUIDE.md) | 水印服务架构与接口 |
| [docs/stegano-callback-usage.md](docs/stegano-callback-usage.md) | 水印编码回调接入说明 |
| [docs/前端推荐算法说明.md](docs/前端推荐算法说明.md) | 推荐算法设计说明 |

---

## English summary

A service platform for high-tech enterprises in Hainan, China — connecting companies with
policy programs, talent, financing, and technology transfer.

- **`backend/`** — Spring Boot 2.3.4 / Java 8 REST API (MyBatis-Plus, MySQL 8, Redis, Aliyun OSS)
- **`frontend/`** — uni-app + Vue 2 mobile web app (117 pages, uView UI)
- **`watermark-service/`** — Flask image steganography service (LSB and SteganoGAN variants)
- **`deploy/`** — Docker Compose stack (MySQL, Redis, backend, watermark, Nginx)
- **`database/`** — full schema plus anonymized sample data (65 tables)

Start with `deploy/.env.example` → `.env`, build the backend and frontend, then `docker-compose up -d --build`.
Demo login: `user001` / `123456`. See [已知限制与待补齐部分](#已知限制与待补齐部分) for what is
*not* included (the text-embedding service, and SteganoGAN support in the shipped image).

Licensed under the [MIT License](LICENSE).
