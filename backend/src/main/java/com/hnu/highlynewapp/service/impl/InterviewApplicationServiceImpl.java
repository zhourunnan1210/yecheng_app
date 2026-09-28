package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.dao.InterviewApplicationDao;
import com.hnu.highlynewapp.dao.TalentNeedDao;
import com.hnu.highlynewapp.entity.InterviewApplicationEntity;
import com.hnu.highlynewapp.entity.TalentNeedEntity;
import com.hnu.highlynewapp.service.InterviewApplicationService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 面试申请服务实现类
 *
 * @author interview_system
 * @date 2024
 */
@Service("interviewApplicationService")
public class InterviewApplicationServiceImpl extends ServiceImpl<InterviewApplicationDao, InterviewApplicationEntity> 
        implements InterviewApplicationService {

    @Resource
    private InterviewApplicationDao interviewApplicationDao;
    
    @Resource
    private TalentNeedDao talentNeedDao;

    @Override
    @Transactional
    public boolean submitApplication(Long userId, Long talentNeedId) {
        // 检查是否已申请
        if (!canApply(userId, talentNeedId)) {
            return false;
        }

        // 获取岗位信息，确定企业ID
        TalentNeedEntity talentNeed = talentNeedDao.selectById(talentNeedId);
        if (talentNeed == null) {
            return false;
        }

        // 创建申请记录
        InterviewApplicationEntity application = new InterviewApplicationEntity();
        application.setUserId(userId);
        application.setTalentNeedId(talentNeedId);
        application.setCompanyId(talentNeed.getBusinessId());
        application.setStatus(0); // 0-未办理
        application.setApplyTime(new Date());

        return this.save(application);
    }

    @Override
    public List<Map<String, Object>> getUserApplications(Long userId, Integer status) {
        if (status == null) {
            // 返回所有状态的申请，暂时返回空列表
            // 实际项目中需要实现手动关联查询获取详细信息
            return new ArrayList<>();
        }
        
        return interviewApplicationDao.getUserApplicationsWithDetails(userId, status);
    }

    @Override
    public List<Map<String, Object>> getCompanyApplications(Long companyId, Integer status) {
        if (status == null) {
            // 返回所有状态的申请，暂时返回空列表
            // 实际项目中需要实现手动关联查询获取详细信息
            return new ArrayList<>();
        }
        
        return interviewApplicationDao.getCompanyApplicationsWithDetails(companyId, status);
    }

    @Override
    @Transactional
    public boolean processApplication(Long applicationId, Integer status, Long processUserId, String remarks) {
        // 验证状态值
        if (status == null || (status != 1 && status != 2)) {
            return false;
        }

        InterviewApplicationEntity application = this.getById(applicationId);
        if (application == null || application.getStatus() != 0) {
            // 申请不存在或已处理
            return false;
        }

        // 更新申请状态
        application.setStatus(status);
        application.setProcessTime(new Date());
        application.setProcessUserId(processUserId);
        application.setRemarks(remarks);

        return this.updateById(application);
    }

    @Override
    public Integer checkApplicationStatus(Long userId, Long talentNeedId) {
        return interviewApplicationDao.checkApplicationStatus(userId, talentNeedId);
    }

    @Override
    public boolean canApply(Long userId, Long talentNeedId) {
        Integer status = checkApplicationStatus(userId, talentNeedId);
        // 如果没有申请记录，返回true
        return status == null;
    }
}