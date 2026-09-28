package com.hnu.highlynewapp.controller;

import com.hnu.highlynewapp.entity.TalentNeedEntity;
import com.hnu.highlynewapp.entity.TalentSupplyEntity;
import com.hnu.highlynewapp.service.EnhancedRecommendationService;
import com.hnu.highlynewapp.utils.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 增强推荐API控制器
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2025-01-03 10:35:56
 */
@Api(tags = "增强推荐管理")
@CrossOrigin
@RequestMapping("/api/recommendation")
@RestController
public class EnhancedRecommendationController {
    @Autowired
    private EnhancedRecommendationService enhancedRecommendationService;

    /**
     * 增强版岗位推荐
     */
    @GetMapping("/enhanced/jobs/{userId}")
    @ApiOperation("增强版岗位推荐")
    public R recommendJobsEnhanced(
            @ApiParam("用户ID") @PathVariable Long userId) {

        try {
            if (userId == null || userId <= 0) {
                return R.error("用户ID无效");
            }

            List<TalentNeedEntity> recommendedJobs = enhancedRecommendationService.recommendJobsEnhanced(userId);

            if (recommendedJobs == null) {
                return R.error("推荐失败");
            }

            return R.ok().put("data", recommendedJobs);
        } catch (Exception e) {
            System.err.println("增强版岗位推荐失败: " + e.getMessage());
            e.printStackTrace();
            return R.error("推荐服务异常: " + e.getMessage());
        }
    }

    /**
     * 增强版简历推荐
     */
    @GetMapping("/enhanced/talents/{userId}")
    @ApiOperation("增强版简历推荐")
    public R recommendTalentsEnhanced(
            @ApiParam("用户ID") @PathVariable Long userId) {

        try {
            if (userId == null || userId <= 0) {
                return R.error("用户ID无效");
            }

            List<TalentSupplyEntity> recommendedTalents = enhancedRecommendationService.recommendTalentsEnhanced(userId);

            if (recommendedTalents == null) {
                return R.error("推荐失败");
            }

            return R.ok().put("data", recommendedTalents);
        } catch (Exception e) {
            System.err.println("增强版简历推荐失败: " + e.getMessage());
            e.printStackTrace();
            return R.error("推荐服务异常: " + e.getMessage());
        }
    }
}
