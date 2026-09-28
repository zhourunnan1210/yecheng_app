package com.hnu.highlynewapp.transformation.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hnu.highlynewapp.transformation.pojo.EvaluationCase;
import com.hnu.highlynewapp.transformation.vo.FindEvaluationCaseVo;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * 评估案例
 */
@Mapper
@Repository
public interface EvaluationCaseMapper extends BaseMapper<EvaluationCase> {
    /**
     * 根据评估案例id查找评估案例的详细信息
     *
     * @param evaluationCaseId
     * @return
     */
    FindEvaluationCaseVo findOneByEvalCaseId(Long evaluationCaseId);
}
