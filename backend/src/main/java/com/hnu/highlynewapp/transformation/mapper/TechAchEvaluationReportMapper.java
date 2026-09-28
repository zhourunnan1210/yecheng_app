package com.hnu.highlynewapp.transformation.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hnu.highlynewapp.transformation.pojo.TechAchEvaluationReport;
import com.hnu.highlynewapp.transformation.vo.FindTechAchEvaluationReportVo;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * 技术成果评估报告
 */
@Mapper
@Repository
public interface TechAchEvaluationReportMapper extends BaseMapper<TechAchEvaluationReport> {
    /**
     * 根据技术成果id查找技术成果评估报告的详细信息
     *
     * @param technologyAchievementId
     * @return
     */
    FindTechAchEvaluationReportVo findOneByTechAchId(Long technologyAchievementId);

    /**
     * 根据技术成果评估报告id查找技术成果评估报告的详细信息
     *
     * @param techAchEvaluationReportId
     * @return
     */
    FindTechAchEvaluationReportVo findOneByTechAchEvalReportId(Long techAchEvaluationReportId);


}
