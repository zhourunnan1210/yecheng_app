package com.hnu.highlynewapp.transformation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.transformation.mapper.TechAchEvaluationReportVoMapper;
import com.hnu.highlynewapp.enums.StatusEnum;
import com.hnu.highlynewapp.transformation.enums.EvaluationStatusEnum;
import com.hnu.highlynewapp.transformation.service.TechAchEvaluationReportVoService;
import com.hnu.highlynewapp.transformation.vo.FindTechAchEvaluationReportVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("techAchEvaluationReportVoService")
public class TechAchEvaluationReportVoServiceImpl extends ServiceImpl<TechAchEvaluationReportVoMapper, FindTechAchEvaluationReportVo> implements TechAchEvaluationReportVoService {
    @Autowired
    private TechAchEvaluationReportVoMapper techAchEvaluationReportVoMapper;

    /**
     * 根据条件查找技术成果评估报告
     *
     * @param duration          时间
     * @param applicationStatus 审核状态
     * @param evaluationStatus  评估状态
     * @return
     */
    @Override
    public List<FindTechAchEvaluationReportVo> listByCondition(String duration, String applicationStatus, String evaluationStatus) {
        int i;
        switch (duration) {
            case "一个月内":
                i = 30;
                break;
            case "三个月内":
                i = 90;
                break;
            case "六个月内":
                i = 180;
                break;
            case "一年内":
                i = 365;
                break;
            default:
                i = -1;
                break;
        }
        List<FindTechAchEvaluationReportVo> result;
        if ("全部".equals(duration) && "全部".equals(applicationStatus) && "全部".equals(evaluationStatus)) {
            result = this.getBaseMapper().listByCondition(null, null, null);
        } else if (!"全部".equals(duration) && "全部".equals(applicationStatus) && "全部".equals(evaluationStatus))
            result = this.getBaseMapper().listByCondition(i, null, null);
        else if ("全部".equals(duration)) {
            Integer application_status = StatusEnum.findCodeByMsg(applicationStatus);
            Integer evaluation_status = EvaluationStatusEnum.findCodeByMsg(evaluationStatus);
            result = this.getBaseMapper().listByCondition(null, application_status, evaluation_status);
        } else {
            Integer application_status = StatusEnum.findCodeByMsg(applicationStatus);
            Integer evaluation_status = EvaluationStatusEnum.findCodeByMsg(evaluationStatus);
            result = this.getBaseMapper().listByCondition(i, application_status, evaluation_status);
        }
        return result;
    }

    /**
     * 根据用户id查找技术成果评估报告
     *
     * @param userId
     * @return
     */
    @Override
    public List<FindTechAchEvaluationReportVo> listByUserId(Long userId) {
        return techAchEvaluationReportVoMapper.listByUserId(userId);
    }
}
