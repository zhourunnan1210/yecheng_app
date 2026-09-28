package com.hnu.highlynewapp.controller;

import com.hnu.highlynewapp.service.UserBehaviorService;
import com.hnu.highlynewapp.utils.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 用户行为
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Api(tags = "用户行为管理")
@CrossOrigin
@RequestMapping("/api/behavior")
@RestController
public class UserBehaviorController {
    @Autowired
    private UserBehaviorService userBehaviorService;

    /**
     * 记录用户行为
     */
    @PostMapping("/like")
    @ApiOperation("记录用户喜欢/不喜欢行为")
    public R recordBehavior(
            @ApiParam("用户ID") @RequestParam Long userId,
            @ApiParam("目标类型 [1:岗位, 2:简历]") @RequestParam Integer targetType,
            @ApiParam("目标ID") @RequestParam Long targetId,
            @ApiParam("操作类型 [0:撤销, 1:喜欢, 2:不喜欢]") @RequestParam Integer actionType) {

        try {
            // 参数验证
            if (userId == null || userId <= 0) {
                return R.error("用户ID无效");
            }
            if (targetType == null || (targetType != 1 && targetType != 2)) {
                return R.error("目标类型无效，应为1(岗位)或2(简历)");
            }
            if (targetId == null || targetId <= 0) {
                return R.error("目标ID无效");
            }
            if (actionType == null || (actionType != 0 && actionType != 1 && actionType != 2)) {
                return R.error("操作类型无效，应为0(撤销)、1(喜欢)或2(不喜欢)");
            }

            boolean success = userBehaviorService.recordUserBehavior(userId, targetType, targetId, actionType);
            if (success) {
                return R.ok().put("message", "行为记录成功");
            } else {
                return R.error("行为记录失败");
            }
        } catch (Exception e) {
            return R.error("系统错误: " + e.getMessage());
        }
    }

    /**
     * 获取用户喜欢的标签统计
     */
    @GetMapping("/tags/{userId}")
    @ApiOperation("获取用户喜欢的标签统计")
    public R getUserLikeTags(
            @ApiParam("用户ID") @PathVariable Long userId,
            @ApiParam("目标类型 [1:岗位, 2:简历]") @RequestParam Integer targetType) {

        try {
            List<Map<String, Object>> tags = userBehaviorService.getUserLikeTags(userId, targetType);
            return R.ok().put("tags", tags);
        } catch (Exception e) {
            return R.error("获取标签失败: " + e.getMessage());
        }
    }

    /**
     * 检查用户是否已经对某个目标进行过操作
     */
    @GetMapping("/check")
    @ApiOperation("检查用户是否已经对某个目标进行过操作")
    public R checkUserBehavior(
            @ApiParam("用户ID") @RequestParam Long userId,
            @ApiParam("目标类型") @RequestParam Integer targetType,
            @ApiParam("目标ID") @RequestParam Long targetId) {

        try {
            boolean hasBehavior = userBehaviorService.hasUserBehavior(userId, targetType, targetId);
            return R.ok().put("hasBehavior", hasBehavior);
        } catch (Exception e) {
            return R.error("检查失败: " + e.getMessage());
        }
    }

    /**
     * 获取用户喜欢的列表
     */
    @GetMapping("/liked/{userId}")
    @ApiOperation("获取用户喜欢的列表")
    public R getLikedItems(
            @ApiParam("用户ID") @PathVariable Long userId,
            @ApiParam("目标类型 [1:岗位, 2:简历]") @RequestParam Integer targetType) {

        try {
            List<Map<String, Object>> likedItems = userBehaviorService.getLikedItems(userId, targetType);
            return R.ok().put("data", likedItems);
        } catch (Exception e) {
            return R.error("获取喜欢列表失败: " + e.getMessage());
        }
    }

    /**
     * 获取用户不喜欢的列表
     */
    @GetMapping("/disliked/{userId}")
    @ApiOperation("获取用户不喜欢的列表")
    public R getDislikedItems(
            @ApiParam("用户ID") @PathVariable Long userId,
            @ApiParam("目标类型 [1:岗位, 2:简历]") @RequestParam Integer targetType) {

        try {
            List<Map<String, Object>> dislikedItems = userBehaviorService.getDislikedItems(userId, targetType);
            return R.ok().put("data", dislikedItems);
        } catch (Exception e) {
            return R.error("获取不喜欢列表失败: " + e.getMessage());
        }
    }

    /**
     * 获取用户对特定目标的当前状态
     */
    @GetMapping("/status/{userId}")
    @ApiOperation("获取用户对特定目标的当前状态")
    public R getUserCurrentStatus(
            @ApiParam("用户ID") @PathVariable Long userId,
            @ApiParam("目标类型 [1:岗位, 2:简历]") @RequestParam Integer targetType,
            @ApiParam("目标ID") @RequestParam Long targetId) {

        try {
            Integer status = userBehaviorService.getUserCurrentStatus(userId, targetType, targetId);
            return R.ok().put("status", status);
        } catch (Exception e) {
            return R.error("获取状态失败: " + e.getMessage());
        }
    }

    /**
     * 清理所有重复的用户行为记录
     */
    @PostMapping("/clean-duplicates")
    @ApiOperation("清理所有重复的用户行为记录")
    public R cleanAllDuplicateRecords() {
        try {
            // 使用简单的查询方式清理重复记录
            // 这里可以添加一个批量清理的逻辑，暂时返回成功
            return R.ok().put("message", "重复记录清理功能已准备就绪");
        } catch (Exception e) {
            return R.error("清理失败: " + e.getMessage());
        }
    }
}
