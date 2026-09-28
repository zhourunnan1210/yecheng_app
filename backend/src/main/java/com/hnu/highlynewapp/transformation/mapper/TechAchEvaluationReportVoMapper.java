package com.hnu.highlynewapp.transformation.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hnu.highlynewapp.transformation.vo.FindTechAchEvaluationReportVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 技术成果评估报告扩展
 */
@Mapper
@Repository
public interface TechAchEvaluationReportVoMapper extends BaseMapper<FindTechAchEvaluationReportVo> {
    /**
     * 根据条件查找技术成果评估报告列表
     *
     * @param duration          时间
     * @param applicationStatus 审核状态
     * @param evaluationStatus  评估状态
     * @return
     */
    List<FindTechAchEvaluationReportVo> listByCondition(@Param("duration") Integer duration, @Param("applicationStatus") Integer applicationStatus, @Param("evaluationStatus") Integer evaluationStatus);

    /**
     * 根据用户id查找技术成果评估报告列表
     *
     * @param userId
     * @return
     */
    List<FindTechAchEvaluationReportVo> listByUserId(Long userId);
}
