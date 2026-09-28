# ImgStegano 图像隐写服务使用教程（详细版）

## 一、系统架构

ImgStegano 是一个基于 **Flask + Redis + SteganoGAN** 的异步图像隐写系统，采用生产者-消费者模式：

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Client    │────▶│ Flask Server│────▶│Redis Queue  │
│  (curl/API) │◀────│  (5001端口) │     │(任务队列)   │
└─────────────┘     └─────────────┘     └──────┬──────┘
                                                │
                                                ▼
                                       ┌─────────────┐
                                       │   Worker    │
                                       │(SteganoGAN) │
                                       │ 异步编码处理 │
                                       └──────┬──────┘
                                              │
                                              ▼
                                       ┌─────────────┐
                                       │encoded_pics │
                                       └─────────────┘
```

**核心组件说明：**

| 组件 | 文件 | 作用 |
|------|------|------|
| Flask 服务 | `ImgStegano.py` | 提供 HTTP API（编码入队、结果查询、解码） |
| 任务队列 | Redis (db=0) | 存储待处理的编码任务 |
| Worker | `worker_encode.py` | 从 Redis 取任务，调用 SteganoGAN 编码 |
| 隐写模型 | SteganoGAN (dense) | 基于深度学习的图像隐写算法 |

---

## 二、目录结构

代码部署在 WSL Ubuntu 的 `/home/master/ImgStegano/` 目录下：

```
/home/master/ImgStegano/
├── ImgStegano.py              # Flask 主服务
├── worker_encode.py           # 编码工作进程
├── cache/                     # 缓存目录
│   ├── input_pictures/        # 待隐写的原始图像
│   │   └── origion_img.jpg    # 示例输入图
│   ├── encoded_pictures/      # 编码后的输出图像
│   │   └── 2026-05-19 01/     # 按时间分文件夹
│   │       └── origion_img.png
│   └── decoded_pictures/      # 待解码的图像（解码前需把png拷贝至此）
│       └── origion_img.png
├── img_stegano.log            # Flask 运行日志
├── worker_encode.log          # Worker 运行日志
└── conda_env requirements.txt # 环境依赖清单
```

**日志文件（系统级）：**
- `/tmp/flask_server.log` — Flask 服务启动日志
- `/tmp/worker_encode.log` — Worker 处理日志

---

## 三、环境依赖

### 3.1 运行环境

- **系统**：WSL2 Ubuntu
- **Conda 环境**：`steganogan_env`
- **Conda 路径**：`/home/master/miniforge3/`
- **Python 版本**：3.7（由 steganogan==0.1.3 决定）
- **Redis**：本地运行，端口 6379

### 3.2 关键 Python 包

```
Flask==2.2.5
steganogan==0.1.3
torch==1.0.0
torchvision==0.2.1
redis==5.0.8
Pillow==6.2.2
numpy==1.21.6
```

### 3.3 检查环境命令

```bash
# 检查 Redis 是否运行
conda run -n steganogan_env redis-cli ping
# 预期输出: PONG

# 检查 conda 环境
conda env list | grep steganogan_env
```

---

## 四、服务启动

### 4.1 进入工作目录

```bash
cd /home/master/ImgStegano
```

### 4.2 清理旧日志（可选）

```bash
> /tmp/flask_server.log
> /tmp/worker_encode.log
```

### 4.3 启动 Flask 服务

**推荐方式（使用 nohup + 环境绝对路径）：**

```bash
nohup /home/master/miniforge3/envs/steganogan_env/bin/python ImgStegano.py > /tmp/flask_server.log 2>&1 &
echo "Flask PID: $!"
```

**服务信息：**
- 监听地址：`0.0.0.0`
- 监听端口：`5001`
- 本地访问：`http://localhost:5001`

### 4.4 启动 Worker 进程

```bash
nohup /home/master/miniforge3/envs/steganogan_env/bin/python worker_encode.py > /tmp/worker_encode.log 2>&1 &
echo "Worker PID: $!"
```

**Worker 配置（worker_encode.py 内）：**
- 队列名：`imgstegano:encode:queue`
- 最大重试次数：`3`
- 单个任务超时：`60` 秒
- 结果过期时间：`3600` 秒（1小时）
- 图片最大像素：`2250000`（超限自动缩放）

### 4.5 验证启动

```bash
# 检查进程
ps aux | grep -E 'ImgStegano.py|worker_encode.py' | grep -v grep

# 查看 Flask 日志
tail -20 /tmp/flask_server.log
# 应看到: "Running on http://127.0.0.1:5001"

# 查看 Worker 日志（首次启动模型加载慢，可能空白几十秒）
tail -20 /tmp/worker_encode.log
```

> **注意**：SteganoGAN 模型首次加载需要较长时间（CPU 模式下约 1~3 分钟），期间 Worker 日志可能为空，属于正常现象。

---

## 五、API 接口详解

### 5.1 编码任务入队 — `POST /encode`

将隐写任务放入 Redis 队列，由 Worker 异步处理。

**请求参数：**

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `file_name` | string | 是 | 原始图像文件名（需已存在于 `input_pictures/`） |
| `message` | string | 是 | 要隐写的文本信息 |
| `callback_url` | string | 否 | 可选，任务完成后主动回调的 URL |

**请求示例：**

```bash
curl -s http://localhost:5001/encode -X POST \
  -H "Content-Type: application/json" \
  -d '{
    "file_name": "origion_img.jpg",
    "message": "HNU@yecheng_app_0519"
  }'
```

**成功响应：**

```json
{
  "status": "queued",
  "task_id": "54cb99c3-80ed-43d6-b480-e9c83b4ed89a"
}
```

**错误响应：**

```json
{"error": "需要提供file_name和message"}   // 400
{"error": "具体异常信息"}                  // 500
```

---

### 5.2 查询编码结果 — `GET /encode/result`

根据 `task_id` 轮询查询任务执行结果。

**请求参数：**

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `task_id` | string | 是 | 编码接口返回的任务 ID |

**请求示例：**

```bash
curl -s "http://localhost:5001/encode/result?task_id=54cb99c3-80ed-43d6-b480-e9c83b4ed89a"
```

**处理中响应：**

```json
{
  "status": "pending"
}
```

**成功完成响应：**

```json
{
  "task_id": "54cb99c3-80ed-43d6-b480-e9c83b4ed89a",
  "result": {
    "success": true,
    "encoded_image_name": "2026-05-19 01/origion_img.png"
  }
}
```

**失败响应：**

```json
{
  "result": {
    "success": false,
    "error": "输入图片不存在: /home/master/ImgStegano/cache/input_pictures/xxx.jpg"
  }
}
```

> **轮询建议**：首次查询建议等待 30~90 秒（模型加载 + 编码耗时），之后每隔 5~10 秒查询一次。

---

### 5.3 解码提取 — `POST /decode`

从已隐写的 PNG 图像中提取隐藏的消息。

**⚠️ 前置条件**：必须先将 `encoded_pictures/` 下生成的 `.png` 文件**手动拷贝**到 `decoded_pictures/` 目录下，且文件名保持一致。

**请求参数：**

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `file_name` | string | 是 | 待解码的 PNG 文件名 |

**工作流示例（拷贝 + 解码）：**

```bash
# 1. 拷贝编码后的图片到 decoded_pictures（假设输出为 2026-05-19 01/origion_img.png）
cp "/home/master/ImgStegano/cache/encoded_pictures/2026-05-19 01/origion_img.png" \
   /home/master/ImgStegano/cache/decoded_pictures/origion_img.png

# 2. 调用解码接口
curl -s http://localhost:5001/decode -X POST \
  -H "Content-Type: application/json" \
  -d '{
    "file_name": "origion_img.png"
  }'
```

**成功响应：**

```json
{
  "success": true,
  "message": "HNU@yecheng_app_0519"
}
```

**错误响应：**

```json
{"error": "需要提供file_name"}     // 400
{"error": "输入图片不存在"}          // 404（文件未放入 decoded_pictures）
```

---

## 六、完整工作流示例

以下是从零到完成的端到端测试流程：

### Step 1 — 准备输入图片

将待隐写的图片放入 `input_pictures/`：

```bash
# 确认图片存在
ls /home/master/ImgStegano/cache/input_pictures/
# 输出: origion_img.jpg
```

### Step 2 — 启动服务（若未启动）

```bash
cd /home/master/ImgStegano

# 启动 Flask
nohup /home/master/miniforge3/envs/steganogan_env/bin/python ImgStegano.py \
  > /tmp/flask_server.log 2>&1 &

# 启动 Worker
nohup /home/master/miniforge3/envs/steganogan_env/bin/python worker_encode.py \
  > /tmp/worker_encode.log 2>&1 &

# 等待服务就绪
sleep 5
```

### Step 3 — 发送编码请求

```bash
ENCODE_RESULT=$(curl -s http://localhost:5001/encode -X POST \
  -H "Content-Type: application/json" \
  -d '{"file_name": "origion_img.jpg", "message": "HNU@yecheng_app_0519"}')

echo "编码响应: $ENCODE_RESULT"
# 示例: {"status": "queued", "task_id": "54cb99c3-80ed-43d6-b480-e9c83b4ed89a"}

TASK_ID=$(echo $ENCODE_RESULT | grep -oP '(?<="task_id": ")[^"]+')
echo "任务ID: $TASK_ID"
```

### Step 4 — 轮询等待结果

```bash
for i in {1..20}; do
  RESULT=$(curl -s "http://localhost:5001/encode/result?task_id=$TASK_ID")
  echo "[$i] $RESULT"
  
  if echo "$RESULT" | grep -q '"success": true'; then
    echo "编码完成！"
    ENCODED_PATH=$(echo $RESULT | grep -oP '(?<="encoded_image_name": ")[^"]+')
    echo "输出文件: $ENCODED_PATH"
    break
  fi
  
  sleep 10
done
```

**预期输出：**

```
[1] {"status": "pending"}
[2] {"status": "pending"}
...
[6] {"task_id": "...", "result": {"success": true, "encoded_image_name": "2026-05-19 01/origion_img.png"}}
编码完成！
输出文件: 2026-05-19 01/origion_img.png
```

### Step 5 — 拷贝到 decoded_pictures

```bash
# 注意：encoded_image_name 包含子文件夹，需要完整路径
cp "/home/master/ImgStegano/cache/encoded_pictures/$ENCODED_PATH" \
   /home/master/ImgStegano/cache/decoded_pictures/origion_img.png

# 确认
ls -la /home/master/ImgStegano/cache/decoded_pictures/origion_img.png
```

### Step 6 — 调用解码

```bash
curl -s http://localhost:5001/decode -X POST \
  -H "Content-Type: application/json" \
  -d '{"file_name": "origion_img.png"}'
```

**预期输出：**

```json
{
  "success": true,
  "message": "HNU@yecheng_app_0519"
}
```

---

## 七、常见问题与排查

### 7.1 Worker 日志为空

**原因**：SteganoGAN 模型首次加载耗时较长（CPU 模式下）。
**解决**：耐心等待 1~3 分钟，可通过 `ps aux | grep worker_encode` 确认进程存活。

### 7.2 编码结果返回 "输入图片不存在"

**原因**：`input_pictures/` 目录下没有对应的原始图片。
**解决**：确认图片已上传至 `cache/input_pictures/`，且 `file_name` 拼写正确（含扩展名）。

### 7.3 解码返回 "输入图片不存在"（404）

**原因**：未将编码后的 `.png` 从 `encoded_pictures/` 拷贝到 `decoded_pictures/`。
**解决**：执行拷贝命令（见 Step 5），且解码请求的 `file_name` 只需传文件名，不含路径。

### 7.4 Redis 连接失败

**排查**：
```bash
conda run -n steganogan_env redis-cli ping
# 若返回错误，启动 Redis：
# redis-server --daemonize yes
```

### 7.5 端口被占用

**排查**：
```bash
lsof -i :5001
# 若被占用，先终止旧进程：
pkill -f 'ImgStegano.py'
pkill -f 'worker_encode.py'
```

---

## 八、进程管理速查

```bash
# 查看所有相关进程
ps aux | grep -E 'ImgStegano|worker_encode|redis' | grep -v grep

# 停止 Flask
pkill -f 'ImgStegano.py'

# 停止 Worker
pkill -f 'worker_encode.py'

# 查看实时日志
tail -f /tmp/flask_server.log
tail -f /tmp/worker_encode.log
tail -f /home/master/ImgStegano/worker_encode.log

# 清空 Redis（慎用）
conda run -n steganogan_env redis-cli flushdb
```

---

## 九、Windows 访问 WSL 中的文件

WSL 文件系统可通过以下路径在 Windows 资源管理器中访问：

```
\\wsl.localhost\Ubuntu\home\master\ImgStegano\cache\
```

例如本次编码输出图片的 Windows 路径：

```
\\wsl.localhost\Ubuntu\home\master\ImgStegano\cache\encoded_pictures\2026-05-19 01\origion_img.png
```

---

## 十、接口速查表

| 接口 | 方法 | URL | 作用 |
|------|------|-----|------|
| 编码入队 | POST | `/encode` | 提交隐写任务到队列 |
| 结果查询 | GET | `/encode/result?task_id=xxx` | 查询任务执行状态 |
| 解码提取 | POST | `/decode` | 从 PNG 中提取隐写信息 |

---

**测试验证通过时间**：2026-05-19  
**测试消息**：`HNU@yecheng_app_0519`  
**测试状态**：编码成功 → 解码一致
