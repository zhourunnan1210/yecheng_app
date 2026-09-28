# 隐写服务回调功能使用说明

## 概述

隐写服务现在支持异步回调机制，当Python隐写服务处理完成后，会自动向指定的回调地址发送处理结果。

## 功能特性

1. **自动回调**：隐写处理完成后自动通知
2. **默认回调URL**：如果未指定回调地址，系统会自动构建默认回调URL
3. **结果缓存**：回调结果会在内存中缓存，便于查询
4. **错误处理**：处理失败时也会发送回调通知

## API接口

### 1. 隐写编码接口（带回调）

#### OssController - 上传水印文件
```
POST /oss/upload/stega
Content-Type: multipart/form-data

参数：
- multipartFile: 图片文件（必需）
- message: 要隐藏的信息（必需）
- callbackUrl: 回调地址（可选）
```

#### ImgSteganoController - 深度隐写编码
```
POST /imgStegano/encode
Content-Type: multipart/form-data

参数：
- file: 图片文件（必需）
- message: 要隐藏的信息（必需）
- callbackUrl: 回调地址（可选）
```

### 2. 回调接收接口

#### 接收回调通知
```
POST /stegano/callback/encode/result
Content-Type: application/json

请求体：
{
    "task_id": "任务ID",
    "result": {
        "success": true/false,
        "encoded_image_name": "相对路径/文件名.png",  // 成功时
        "error": "错误信息"  // 失败时
    }
}
```

#### 查询回调结果
```
GET /stegano/callback/result/{taskId}

响应：
{
    "code": 0,
    "msg": "success",
    "data": {
        "success": true,
        "encoded_image_name": "2024-01-15 10/abc123.png"
    }
}
```

#### 清理缓存
```
DELETE /stegano/callback/clear

响应：
{
    "code": 0,
    "msg": "清理完成，共清理 X 个缓存项"
}
```

#### 获取缓存统计
```
GET /stegano/callback/stats

响应：
{
    "code": 0,
    "msg": "success",
    "cached_results_count": 5
}
```

## 使用方式

### 方式1：使用默认回调（推荐）

不传递`callbackUrl`参数，系统会自动构建回调URL：

```javascript
// 前端调用示例
const formData = new FormData();
formData.append('multipartFile', file);
formData.append('message', '要隐藏的信息');
// 不传递callbackUrl，使用默认回调

fetch('/oss/upload/stega', {
    method: 'POST',
    body: formData
});
```

### 方式2：指定自定义回调URL

```javascript
// 前端调用示例
const formData = new FormData();
formData.append('multipartFile', file);
formData.append('message', '要隐藏的信息');
formData.append('callbackUrl', 'https://your-domain.com/your-callback-endpoint');

fetch('/oss/upload/stega', {
    method: 'POST',
    body: formData
});
```

### 方式3：查询回调结果

```javascript
// 获取任务ID后，定期查询回调结果
function checkCallbackResult(taskId) {
    fetch(`/stegano/callback/result/${taskId}`)
        .then(response => response.json())
        .then(data => {
            if (data.code === 0) {
                console.log('回调结果:', data.data);
                if (data.data.success) {
                    console.log('处理成功，图片路径:', data.data.encoded_image_name);
                } else {
                    console.log('处理失败，错误:', data.data.error);
                }
            } else {
                console.log('暂无回调结果');
            }
        });
}
```

## 回调数据格式

### 成功回调
```json
{
    "task_id": "12345678-1234-1234-1234-123456789012",
    "result": {
        "success": true,
        "encoded_image_name": "2024-01-15 10/processed_image.png"
    }
}
```

### 失败回调
```json
{
    "task_id": "12345678-1234-1234-1234-123456789012",
    "result": {
        "success": false,
        "error": "文件不存在或处理超时"
    }
}
```

## 注意事项

1. **缓存管理**：当前回调结果存储在内存中，服务重启会丢失。生产环境建议使用Redis或数据库。

2. **超时处理**：如果回调通知失败，Python服务会在日志中记录错误，但不会重试。

3. **默认回调URL构建规则**：
   - HTTP协议默认端口80不显示端口号
   - HTTPS协议默认端口443不显示端口号
   - 其他端口会显示在URL中

4. **并发安全**：使用了`ConcurrentHashMap`确保多线程安全。

5. **日志记录**：所有回调处理都有详细的日志记录，便于调试和监控。

## 扩展建议

在实际生产环境中，可以考虑以下扩展：

1. **持久化存储**：将回调结果存储到Redis或数据库中
2. **WebSocket通知**：通过WebSocket实时通知前端
3. **重试机制**：为回调失败的情况添加重试逻辑
4. **认证机制**：为回调接口添加认证和授权
5. **监控告警**：监控回调成功率和处理时间 