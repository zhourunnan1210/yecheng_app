package com.hnu.highlynewapp.utils;

import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;
import org.springframework.beans.factory.annotation.Value;

import java.util.HashMap;
import java.util.Map;

@Component
public class ImgSteganoUtil {
    @Value("${stegano.service.url}")
    private String serviceUrl;

    @Value("${stegano.polling.timeout:300}")  // 轮询超时时间，默认5分钟
    private int pollingTimeoutSeconds;

    @Value("${stegano.polling.interval:2}")  // 轮询间隔，默认2秒
    private int pollingIntervalSeconds;

    private final RestTemplate restTemplate = new RestTemplate();

    public Map encode(String fileName, String message, String callbackUrl) {
        return encode(fileName, message, callbackUrl, "steganogan");
    }

    public Map encode(String fileName, String message, String callbackUrl, String method) {
        String url = serviceUrl + "/encode";
        Map<String, String> request = new HashMap<>();
        request.put("file_name", fileName);
        request.put("message", message);
        request.put("method", method != null ? method : "steganogan");
        if (callbackUrl != null) {
            request.put("callback_url", callbackUrl);
        }
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Map<String, String>> entity = new HttpEntity<>(request, headers);
        ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);
        return response.getBody();
    }

    /**
     * 查询隐写处理结果
     *
     * @param taskId 任务ID
     * @return 处理结果
     */
    public Map<String, Object> getEncodeResult(String taskId) {
        String url = serviceUrl + "/encode/result?task_id=" + taskId;
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);
        return response.getBody();
    }

    /**
     * 轮询等待隐写处理完成
     *
     * @param taskId 任务ID
     * @return 处理结果，如果超时返回null
     */
    public Map<String, Object> waitForEncodeCompletion(String taskId) {
        long startTime = System.currentTimeMillis();
        long timeoutMillis = pollingTimeoutSeconds * 1000L;
        while (System.currentTimeMillis() - startTime < timeoutMillis) {
            try {
                Map<String, Object> result = getEncodeResult(taskId);

                if (result != null) {
                    // 检查是否有result字段，表示处理完成
                    if (result.containsKey("result")) {
                        return (Map<String, Object>) result.get("result");
                    }
                    // 检查status是否为pending，继续等待
                    if ("pending".equals(result.get("status"))) {
                        Thread.sleep(pollingIntervalSeconds * 1000L);
                        continue;
                    }
                }
                // 等待间隔
                Thread.sleep(pollingIntervalSeconds * 1000L);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                break;
            } catch (Exception e) {
                // 网络错误等，等待后重试
                try {
                    Thread.sleep(pollingIntervalSeconds * 1000L);
                } catch (InterruptedException ie) {
                    Thread.currentThread().interrupt();
                    break;
                }
            }
        }
        return null; // 超时
    }

    public Map decode(String fileName) {
        return decode(fileName, null);
    }

    public Map decode(String fileName, String method) {
        String url = serviceUrl + "/decode";
        Map<String, String> request = new HashMap<>();
        request.put("file_name", fileName);
        if (method != null) {
            request.put("method", method);
        }
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Map<String, String>> entity = new HttpEntity<>(request, headers);
        ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);
        return response.getBody();
    }
}
