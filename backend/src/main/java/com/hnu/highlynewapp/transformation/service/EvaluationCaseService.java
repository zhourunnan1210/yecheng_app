package com.hnu.highlynewapp.transformation.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.transformation.pojo.EvaluationCase;
import com.hnu.highlynewapp.transformation.vo.FindEvaluationCaseVo;

/**
 * 评估案例
 */
public interface EvaluationCaseService extends IService<EvaluationCase> {
    void publish(EvaluationCase evaluationCase);

    FindEvaluationCaseVo findOneByEvalCaseId(Long evaluationCaseId);

    int updateEvaluationCaseById(EvaluationCase evaluationCase);

    int deleteEvaluationCasesByIds(Long[] evaluationCaseIds);
}
