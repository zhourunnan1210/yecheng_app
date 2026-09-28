# backend — Java 后端

椰城项目的服务端，基于 Spring Boot 2.3.4 + Java 8，对外提供 REST 接口。

## 技术栈

| 类别 | 选型 |
|------|------|
| 框架 | Spring Boot 2.3.4、Java 8 |
| 数据访问 | MyBatis-Plus、Druid 连接池、p6spy（SQL 日志） |
| 数据库 / 缓存 | MySQL 8、Redis（Lettuce） |
| 接口文档 | Springfox Swagger 2 + knife4j 2.0.2 |
| 对象存储 | 阿里云 OSS SDK |
| 其它 | webmagic（爬虫）、Flyway（数据库迁移）、Lombok、fastjson |

## 包结构

```
com.hnu.highlynewapp/
├── app/             业务接口：人才供需、金融产品/机构、政策、融资需求、技术成果…
├── authentication/  企业 / 高校的注册与审核
├── controller/      水印上传、OSS、隐写回调等
├── service/         服务层（接口 + impl）
├── dao/             Mapper 接口
├── entity/ vo/      实体与视图对象
├── config/          WebConfig（CORS、静态资源）、Swagger2Config、Redis 配置
├── utils/           OssUtil、TextEmbeddingUtils、图片处理等
├── enums/ exception/ handler/  枚举、业务异常与全局异常处理
├── transformation/  对象转换
└── xss/             XSS 过滤
```

共 260 个 Java 文件、40 个 Controller。

## 构建与运行

### Docker（推荐）

在项目根目录 `deploy/` 下用 compose 启动，后端会被一起构建：

```bash
cd ../deploy && docker-compose up -d --build yecheng-app
```

### 本地

```bash
# 1. 本地准备 MySQL 8 与 Redis，导入 ../database/yecheng_app_2604.sql
# 2. 运行（配置项都支持环境变量覆盖）
DB_HOST=localhost DB_PORT=3306 DB_NAME=yecheng_app_2604 \
DB_USERNAME=root DB_PASSWORD=你的密码 \
mvn spring-boot:run
```

打包：

```bash
mvn clean package -DskipTests
# 产物：target/highly-new-app-0.0.1-SNAPSHOT.jar
```

服务默认监听 `10086`，接口文档在 `http://localhost:10086/doc.html`。

## 配置文件

三个 profile，通过 `SPRING_PROFILES_ACTIVE` 切换：

| 文件 | 用途 |
|------|------|
| `application.yml` | 主配置：Redis、水印服务地址、存储路径、OSS、CORS |
| `application-dev.yml` | Docker 部署用，连容器内网的 `mysql` / `redis` |
| `application-local.yml` | 本地开发用，连 `localhost` |

## 环境变量

部署时通过这些变量注入配置，代码里没有硬编码密钥。

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `SPRING_PROFILES_ACTIVE` | `local` | 切换 profile，Docker 下为 `dev` |
| `DB_HOST` / `DB_PORT` / `DB_NAME` | `mysql` / `3306` / `yecheng_app_2604` | 数据库连接 |
| `DB_USERNAME` / `DB_PASSWORD` | `yecheng` / 无 | 数据库账号密码 |
| `REDIS_HOST` / `REDIS_PASSWORD` | `redis` / 无 | Redis 连接 |
| `OSS_ENDPOINT` / `OSS_BUCKET_NAME` | 占位符 | OSS 地域与桶名 |
| `OSS_ACCESS_KEY_ID` / `OSS_ACCESS_KEY_SECRET` | 空 | OSS 凭据，**只走环境变量** |
| `CORS_ALLOWED_ORIGINS` | localhost | 允许跨域的前端来源，逗号分隔 |
| `EMBEDDING_SERVICE_URL` | `http://textembed:5000` | 文本向量服务（未包含在本仓库） |
| `BASE_CACHE_DIR` | `/app/cache` | 图片暂存目录 |
| `STEGANO_SERVICE_URL` | `http://imgstegano:5001` | 水印服务地址 |

## 关于 OSS 的两点注意

1. **凭据只从环境变量读。** `OssUtil` 用 `@Value` 注入 `oss.access-key-id` 等属性，
   历史上这些值是硬编码在类里的——如果你在旧分支上看到硬编码，那是历史遗留，请勿回退。
2. **`oss.bucket-domain` 必须与你的桶一致。** 它由 `oss.bucket-name` + `oss.endpoint` 拼接，
   业务代码（`TalentNeedController` 等）用它判断一个图片 URL 是否指向本桶。
   配错的后果是上传成功的图片被当成失效链接，被替换成 `/static/defaultImage/1.png`。

## 依赖的外部服务

| 服务 | 是否包含在本仓库 | 不部署的后果 |
|------|------------------|--------------|
| MySQL 8 | ✅ compose 内有 | — |
| Redis | ✅ compose 内有 | 缓存与验证码不可用 |
| `imgstegano` 水印服务 | ✅ 仓库内有（LSB 版本） | 图片上传的水印流程不可用 |
| 文本向量服务 | ❌ 需自行部署 | 语义搜索/推荐降级或返回空 |
| 阿里云 OSS | ❌ 需自己的账号 | 图片上传接口报错 |
| RuoYi 后台管理 | ❌ 不在本仓库 | `sys_*` 表与管理员账号无服务使用 |
