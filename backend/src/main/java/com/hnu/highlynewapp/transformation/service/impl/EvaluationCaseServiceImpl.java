package com.hnu.highlynewapp.transformation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.transformation.mapper.EvaluationCaseMapper;
import com.hnu.highlynewapp.transformation.pojo.EvaluationCase;
import com.hnu.highlynewapp.transformation.service.EvaluationCaseService;
import com.hnu.highlynewapp.transformation.vo.FindEvaluationCaseVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Date;

@Service("evaluationCaseService")
public class EvaluationCaseServiceImpl extends ServiceImpl<EvaluationCaseMapper, EvaluationCase> implements EvaluationCaseService {
    @Autowired
    private EvaluationCaseMapper evaluationCaseMapper;

    /**
     * 发布评估案例
     *
     * @param evaluationCase
     */
    @Override
    public void publish(EvaluationCase evaluationCase) {
        evaluationCase.setCompleteTime(new Date());
        baseMapper.insert(evaluationCase);
    }

    /**
     * 根据评估案例id查找评估案例的详细信息
     *
     * @param evaluationCaseId
     * @return
     */
    @Override
    public FindEvaluationCaseVo findOneByEvalCaseId(Long evaluationCaseId) {
        return evaluationCaseMapper.findOneByEvalCaseId(evaluationCaseId);
    }

    /**
     * 根据评估案例id更新评估案例的信息
     *
     * @param evaluationCase
     * @return
     */
    @Override
    public int updateEvaluationCaseById(EvaluationCase evaluationCase) {
        evaluationCase.setCompleteTime(new Date());
        return evaluationCaseMapper.updateById(evaluationCase);
    }

    /**
     * 根据多个评估案例id删除多个评估案例
     *
     * @param evaluationCaseIds
     * @return
     */
    @Override
    public int deleteEvaluationCasesByIds(Long[] evaluationCaseIds) {
        return evaluationCaseMapper.deleteBatchIds(Arrays.asList(evaluationCaseIds));
    }
}
