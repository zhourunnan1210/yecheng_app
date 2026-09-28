package com.hnu.highlynewapp.transformation.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.transformation.vo.FindTechAchEvaluationReportVo;

import java.util.List;

/**
 * 技术成果评估报告扩展
 */
public interface TechAchEvaluationReportVoService extends IService<FindTechAchEvaluationReportVo> {
    List<FindTechAchEvaluationReportVo> listByCondition(String duration, String applicationStatus, String evaluationStatus);

    List<FindTechAchEvaluationReportVo> listByUserId(Long userId);
}
