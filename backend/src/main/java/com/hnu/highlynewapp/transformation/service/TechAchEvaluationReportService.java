package com.hnu.highlynewapp.transformation.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.transformation.pojo.TechAchEvaluationReport;
import com.hnu.highlynewapp.transformation.vo.FindTechAchEvaluationReportVo;

/**
 * 技术成果评估报告
 */
public interface TechAchEvaluationReportService extends IService<TechAchEvaluationReport> {
    void publish(TechAchEvaluationReport techAchEvaluationReport);

    FindTechAchEvaluationReportVo findOneByTechAchId(Long technologyAchievementId);

    FindTechAchEvaluationReportVo findOneByTechAchEvalReportId(Long techAchEvaluationReportId);

    TechAchEvaluationReport findApplicationStatusByTechAchId(Long technologyAchievementId);

    int updateEvaluationReportById(TechAchEvaluationReport techAchEvaluationReport);
}
