# watermark-service — 图像数字水印服务

对上传的图片嵌入不可见水印，用于图片来源溯源。Flask 提供 HTTP 接口，Redis 做任务队列，
隐写算法可选 LSB（最低有效位）或 SteganoGAN（深度学习）。

> ⚠️ **先读这段**：本目录里有**两套版本**，`Dockerfile` 构建的是其中较简单的 LSB-only 版本。
> 完整文档见 [USAGE_GUIDE.md](USAGE_GUIDE.md)，它按完整版（SteganoGAN）编写。

## 目录里的文件

| 文件 | 版本 | 说明 |
|------|------|------|
| `ImgStegano_cloud.py` | **云端 / LSB-only** | Flask 服务，同步编码，不依赖 Redis。**`Dockerfile` 构建的就是它** |
| `worker_encode_cloud.py` | 云端 / LSB | LSB 编码 Worker，**当前镜像未打包**（Dockerfile 没 COPY 它） |
| `ImgStegano.py` | 完整版 | Flask 服务，任务入 Redis 队列，异步处理 |
| `worker_encode.py` | 完整版 | 消费 Redis 队列，调用 SteganoGAN 编码 |
| `threshold_test.py` | 工具 | 隐写容量/阈值测试脚本 |
| `docker-entrypoint.sh` | — | 建好缓存目录后启动 `ImgStegano_cloud.py` |
| `Dockerfile` | — | 只装 `stegano`，不含 PyTorch / SteganoGAN |

### 两个版本的差异

| | LSB-only（当前镜像） | 完整版（需自行构建） |
|---|---|---|
| 隐写算法 | LSB 最低有效位 | LSB + SteganoGAN 深度学习 |
| 依赖 | Pillow、Flask、redis、requests、`stegano` | 另需 PyTorch、SteganoGAN、模型权重 |
| 处理方式 | 同步，请求内完成 | 异步，Redis 队列 + Worker |
| Redis | 不需要 | 必需 |
| 内存 | 512M 起步 | 模型常驻 1~1.5G，建议 4G+ |
| 抗检测性 | 弱（易被察觉/破坏） | 强 |
| 大图成功率 | 高 | 中等，超大图需先压缩 |

## 接口

`ImgStegano_cloud.py`（当前镜像使用的版本）：

| 方法 | 路径 | 说明 |
|------|------|------|
| `GET` | `/health` | 健康检查，返回 `{"status":"healthy","redis":"ok","service":"imgstegano-lsb"}` |
| `POST` | `/encode` | 提交编码任务 |
| `GET` | `/encode/result?task_id=xxx` | 查询编码结果，未完成时返回 `{"status":"pending"}` |
| `POST` | `/decode` | 从图片中解出隐藏信息 |

`ImgStegano.py`（完整版）只有 `/encode`、`/encode/result`、`/decode` 三个接口，
**没有 `/health`**。所以部署完整版时，健康检查命令要走 `/encode/result` 之类的存活探测，
不能照搬 `curl /health`。

## 本地运行

```bash
pip install Pillow Flask redis requests stegano
python ImgStegano_cloud.py        # 监听 5001
curl http://localhost:5001/health
```

## 想启用 SteganoGAN 完整版

需要自己做这几件事（本仓库未提供开箱可用的配置）：

1. 在 `Dockerfile` 里补 PyTorch 与 SteganoGAN 依赖，并把 `ImgStegano.py`、`worker_encode.py`
   一起 `COPY` 进镜像
2. 让 `docker-entrypoint.sh` 同时拉起 Flask 与 Worker 两个进程
   （原部署文档里"`ps aux` 应看到两条 python 进程"就是指这种状态）
3. 准备 SteganoGAN 的预训练权重（`architecture='dense'`），放进镜像或挂载进去
4. 相应调高 `deploy/docker-compose.yml` 里 `imgstegano` 服务的内存上限
   （`deploy/README.md` 里提到的 6G 是给这个方案的）

## 环境变量

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `INPUT_DIR` | `/app/cache/input_pictures` | 待编码图片目录 |
| `ENCODED_DIR` | `/app/cache/encoded_pictures` | 编码结果目录 |
| `DECODED_DIR` | `/app/cache/decoded_pictures` | 解码结果目录 |
| `ENCODER_OUTPUT_DIR` | `/app/cache/watermark/encoder` | 水印输出目录 |
| `REDIS_HOST` / `REDIS_PORT` / `REDIS_PASSWORD` / `REDIS_DB` | `redis` / `6379` / 空 / `0` | 完整版才需要 |
| `FLASK_HOST` / `FLASK_PORT` | `0.0.0.0` / `5001` | 监听地址 |

## 与 Java 后端的协作

Java 后端按图片大小决定隐写方式，把任务提交给本服务，并提供一个回调接口接收编码结果：

- 后端配置项：`stegano.service.url`（默认 `http://imgstegano:5001`）
- 回调说明见 [../docs/stegano-callback-usage.md](../docs/stegano-callback-usage.md)
