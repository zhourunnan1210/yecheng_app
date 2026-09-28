package com.hnu.highlynewapp.transformation.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.hnu.highlynewapp.transformation.vo.FindEvaluationCaseVo;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.Map;

/**
 * 评估案例扩展
 */
@Mapper
@Repository
public interface EvaluationCaseVoMapper extends BaseMapper<FindEvaluationCaseVo> {
    /**
     * 根据分页参数查找全部分页
     *
     * @param page
     * @return
     */
    IPage<FindEvaluationCaseVo> findAllPages(IPage<FindEvaluationCaseVo> page);
}
