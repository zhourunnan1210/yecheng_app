package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.entity.InterviewApplicationEntity;

import java.util.List;
import java.util.Map;

/**
 * 面试申请服务接口
 *
 * @author interview_system
 * @date 2024
 */
public interface InterviewApplicationService extends IService<InterviewApplicationEntity> {

    /**
     * 提交面试申请
     *
     * @param userId 用户ID
     * @param talentNeedId 岗位ID
     * @return 是否成功
     */
    boolean submitApplication(Long userId, Long talentNeedId);

    /**
     * 获取用户申请列表
     *
     * @param userId 用户ID
     * @param status 状态（null表示全部）
     * @return 申请列表
     */
    List<Map<String, Object>> getUserApplications(Long userId, Integer status);

    /**
     * 获取企业申请列表
     *
     * @param companyId 企业ID
     * @param status 状态（null表示全部）
     * @return 申请列表
     */
    List<Map<String, Object>> getCompanyApplications(Long companyId, Integer status);

    /**
     * 处理申请（同意或拒绝）
     *
     * @param applicationId 申请ID
     * @param status 状态：1-已同意，2-已拒绝
     * @param processUserId 处理人ID
     * @param remarks 备注
     * @return 是否成功
     */
    boolean processApplication(Long applicationId, Integer status, Long processUserId, String remarks);

    /**
     * 检查申请状态
     *
     * @param userId 用户ID
     * @param talentNeedId 岗位ID
     * @return 状态：null-未申请，0-已申请，1-已同意，2-已拒绝
     */
    Integer checkApplicationStatus(Long userId, Long talentNeedId);

    /**
     * 检查是否可以申请
     *
     * @param userId 用户ID
     * @param talentNeedId 岗位ID
     * @return 是否可以申请
     */
    boolean canApply(Long userId, Long talentNeedId);
}