package com.hnu.highlynewapp.controller;

import com.hnu.highlynewapp.entity.InterviewApplicationEntity;
import com.hnu.highlynewapp.service.InterviewApplicationService;
import com.hnu.highlynewapp.utils.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 面试申请控制器
 *
 * @author interview_system
 * @date 2024
 */
@Api(tags = "面试申请管理")
@CrossOrigin
@RequestMapping("/api/interview")
@RestController
public class InterviewApplicationController {
    @Autowired
    private InterviewApplicationService interviewApplicationService;

    /**
     * 提交面试申请
     */
    @ApiOperation("提交面试申请")
    @PostMapping("/apply")
    public R applyInterview(@ApiParam("用户ID") @RequestParam Long userId,
                            @ApiParam("岗位ID") @RequestParam Long talentNeedId) {
        try {
            boolean success = interviewApplicationService.submitApplication(userId, talentNeedId);
            if (success) {
                return R.ok("申请提交成功");
            } else {
                return R.error("申请失败，可能已申请过或岗位不存在");
            }
        } catch (Exception e) {
            return R.error("申请失败：" + e.getMessage());
        }
    }

    /**
     * 获取用户面试申请列表
     */
    @ApiOperation("获取用户面试申请列表")
    @GetMapping("/applications/{userId}")
    public R getUserApplications(@ApiParam("用户ID") @PathVariable Long userId,
                                 @ApiParam("状态：0-已申请，1-已同意，2-已拒绝") @RequestParam(required = false) Integer status) {
        try {
            List<Map<String, Object>> applications = interviewApplicationService.getUserApplications(userId, status);
            return R.ok().put("data", applications);
        } catch (Exception e) {
            return R.error("获取申请列表失败：" + e.getMessage());
        }
    }

    /**
     * 获取企业收到的面试申请
     */
    @ApiOperation("获取企业收到的面试申请")
    @GetMapping("/company/{companyId}")
    public R getCompanyApplications(@ApiParam("企业ID") @PathVariable Long companyId,
                                    @ApiParam("状态：0-未办理，1-已同意，2-已拒绝") @RequestParam(required = false) Integer status) {
        try {
            List<Map<String, Object>> applications = interviewApplicationService.getCompanyApplications(companyId, status);
            return R.ok().put("data", applications);
        } catch (Exception e) {
            return R.error("获取申请列表失败：" + e.getMessage());
        }
    }

    /**
     * 处理面试申请（同意/拒绝）
     */
    @ApiOperation("处理面试申请")
    @PostMapping("/process")
    public R processApplication(@ApiParam("申请ID") @RequestParam Long applicationId,
                                @ApiParam("状态：1-已同意，2-已拒绝") @RequestParam Integer status,
                                @ApiParam("处理人ID") @RequestParam Long processUserId,
                                @ApiParam("备注信息") @RequestParam(required = false) String remarks) {
        try {
            boolean success = interviewApplicationService.processApplication(applicationId, status, processUserId, remarks);
            if (success) {
                String action = status == 1 ? "同意" : "拒绝";
                return R.ok(action + "申请成功");
            } else {
                return R.error("处理失败，申请可能不存在或已处理");
            }
        } catch (Exception e) {
            return R.error("处理失败：" + e.getMessage());
        }
    }

    /**
     * 检查用户对特定岗位的申请状态
     */
    @ApiOperation("检查申请状态")
    @GetMapping("/status")
    public R checkApplicationStatus(@ApiParam("用户ID") @RequestParam Long userId,
                                    @ApiParam("岗位ID") @RequestParam Long talentNeedId) {
        try {
            Integer status = interviewApplicationService.checkApplicationStatus(userId, talentNeedId);
            return R.ok().put("status", status);
        } catch (Exception e) {
            return R.error("检查状态失败：" + e.getMessage());
        }
    }

    /**
     * 检查是否可以申请
     */
    @ApiOperation("检查是否可以申请")
    @GetMapping("/canApply")
    public R canApply(@ApiParam("用户ID") @RequestParam Long userId,
                      @ApiParam("岗位ID") @RequestParam Long talentNeedId) {
        try {
            boolean canApply = interviewApplicationService.canApply(userId, talentNeedId);
            return R.ok().put("canApply", canApply);
        } catch (Exception e) {
            return R.error("检查失败：" + e.getMessage());
        }
    }

    /**
     * 获取申请详情
     */
    @ApiOperation("获取申请详情")
    @GetMapping("/application/{applicationId}")
    public R getApplicationDetail(@ApiParam("申请ID") @PathVariable Long applicationId) {
        try {
            InterviewApplicationEntity application = interviewApplicationService.getById(applicationId);
            if (application == null) {
                return R.error("申请记录不存在");
            }
            return R.ok().put("data", application);
        } catch (Exception e) {
            return R.error("获取申请详情失败：" + e.getMessage());
        }
    }
}
