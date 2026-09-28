package com.hnu.highlynewapp.controller;

import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.service.FinancialInstitutionService;
import com.hnu.highlynewapp.entity.FinancialInstitutionEntity;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.List;

/**
 * 隐写服务回调接收Controller
 * 接收Python隐写服务处理完成后的回调通知
 */
@Api(tags = "隐写服务回调接收")
@RequestMapping("/stegano/callback")
@RestController
@Slf4j
public class SteganoCallbackController {
    // 内存中缓存回调结果，实际项目中可以考虑使用Redis或数据库
    private static final Map<String, Map<String, Object>> callbackResults = new ConcurrentHashMap<>();

    @Autowired
    private FinancialInstitutionService financialInstitutionService;

    @Autowired
    private com.hnu.highlynewapp.utils.OssUtil ossUtil;

    @Value("${stegano.output-dir}")
    private String steganoOutputDir;

    /**
     * 接收隐写处理完成的回调通知
     *
     * @param callbackData 回调数据，包含task_id和result
     * @return 响应结果
     */
    @ApiOperation("接收隐写处理回调通知")
    @PostMapping("/encode/result")
    public R receiveEncodeCallback(@RequestBody Map<String, Object> callbackData) {
        try {
            String taskId = (String) callbackData.get("task_id");
            Map<String, Object> result = (Map<String, Object>) callbackData.get("result");

            if (taskId == null || result == null) {
                log.warn("回调数据格式错误：{}", callbackData);
                return R.error(400, "回调数据格式错误");
            }

            // 缓存回调结果
            callbackResults.put(taskId, result);

            // 记录日志
            Boolean success = (Boolean) result.get("success");
            if (Boolean.TRUE.equals(success)) {
                String encodedImageName = (String) result.get("encoded_image_name");
                log.info("隐写任务 {} 处理成功，生成图片：{}", taskId, encodedImageName);

                // 更新数据库中的隐写状态为成功
                updateDatabaseStatus(taskId, 2); // 2：隐写成功
            } else {
                String error = (String) result.get("error");
                log.error("隐写任务 {} 处理失败，错误信息：{}", taskId, error);

                // 更新数据库中的隐写状态为失败
                updateDatabaseStatus(taskId, 3); // 3：隐写失败
            }

            // TODO: 这里可以添加更多业务逻辑，比如：
            // 1. 更新数据库中的任务状态
            // 2. 通过WebSocket通知前端
            // 3. 发送邮件或短信通知
            // 4. 触发其他业务流程

            return R.ok("回调接收成功");
        } catch (Exception e) {
            log.error("处理回调通知时发生异常", e);
            return R.error(500, "处理回调通知失败：" + e.getMessage());
        }
    }

    /**
     * 查询回调结果
     * 提供给前端查询特定任务的回调结果
     *
     * @param taskId 任务ID
     * @return 回调结果
     */
    @ApiOperation("查询任务回调结果")
    @GetMapping("/result/{taskId}")
    public R getCallbackResult(@PathVariable("taskId") String taskId) {
        Map<String, Object> result = callbackResults.get(taskId);
        if (result != null) {
            return R.ok().put("data", result);
        } else {
            return R.error(404, "未找到该任务的回调结果");
        }
    }

    /**
     * 清理过期的回调结果
     * 可以定期调用来清理内存中的缓存
     */
    @ApiOperation("清理回调结果缓存")
    @DeleteMapping("/clear")
    public R clearCallbackResults() {
        int clearedCount = callbackResults.size();
        callbackResults.clear();
        log.info("清理了 {} 个回调结果缓存", clearedCount);
        return R.ok("清理完成，共清理 " + clearedCount + " 个缓存项");
    }

    /**
     * 获取当前缓存的回调结果数量
     */
    @ApiOperation("获取回调结果缓存统计")
    @GetMapping("/stats")
    public R getCallbackStats() {
        return R.ok().put("cached_results_count", callbackResults.size());
    }

    /**
     * 根据taskId更新数据库中的隐写状态
     *
     * @param taskId 任务ID
     * @param status 隐写状态 (2：隐写成功，3：隐写失败)
     */
    private void updateDatabaseStatus(String taskId, Integer status) {
        try {
            // 根据taskId查找对应的记录
            QueryWrapper<FinancialInstitutionEntity> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("task_id", taskId);
            List<FinancialInstitutionEntity> entities = financialInstitutionService.list(queryWrapper);

            if (entities.isEmpty()) {
                log.warn("未找到taskId为 {} 的记录", taskId);
                return;
            }

            if (entities.size() > 1) {
                log.warn("发现多条taskId为 {} 的记录，将更新第一条", taskId);
            }

            // 更新隐写状态
            FinancialInstitutionEntity entity = entities.get(0);
            entity.setImgStegaStatus(status);

            // 如果隐写成功，上传处理后的图片到OSS
            if (status == 2) {
                Map<String, Object> result = callbackResults.get(taskId);
                if (result != null) {
                    String encodedImageName = (String) result.get("encoded_image_name");
                    if (encodedImageName != null) {
                        try {
                            // 获取编码方式
                            String method = (String) result.get("method");
                            if (method == null) method = "steganogan";

                            // 构建处理后图片的完整路径（优先从共享路径读取）
                            String encodedImagePath = steganoOutputDir + "/"
                                    + method + "/" + taskId + "/" + taskId + ".png";
                            File encodedImageFile = new File(encodedImagePath);
                            if (!encodedImageFile.exists()) {
                                // 回退到旧路径（兼容）
                                encodedImagePath = "./cache/encoded_pictures/" + encodedImageName;
                            }

                            // 上传处理后的图片到OSS
                            String ossUrl = ossUtil.uploadFromLocalPath(encodedImagePath, "stegano");
                            entity.setFinancialInstitutionImage(ossUrl);

                            log.info("成功上传隐写后的图片到OSS，taskId: {}, url: {}", taskId, ossUrl);
                        } catch (Exception e) {
                            log.error("上传隐写后的图片到OSS失败，taskId: {}", taskId, e);
                            // 即使上传失败，也要更新状态为成功，因为隐写本身是成功的
                        }
                    }
                }
            }

            boolean updateResult = financialInstitutionService.updateById(entity);

            if (updateResult) {
                log.info("成功更新taskId {} 对应记录的隐写状态为 {}", taskId, status);

                // 数据库更新成功后，清除内存中的回调结果缓存
                Map<String, Object> removedResult = callbackResults.remove(taskId);
                if (removedResult != null) {
                    log.info("成功清除taskId {} 的回调结果缓存", taskId);
                } else {
                    log.warn("未找到taskId {} 的回调结果缓存", taskId);
                }
            } else {
                log.error("更新taskId {} 对应记录的隐写状态失败", taskId);
            }
        } catch (Exception e) {
            log.error("更新数据库隐写状态时发生异常，taskId: {}, status: {}", taskId, status, e);
        }
    }
}
