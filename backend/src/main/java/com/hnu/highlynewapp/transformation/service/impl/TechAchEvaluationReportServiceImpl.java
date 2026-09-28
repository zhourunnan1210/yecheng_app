package com.hnu.highlynewapp.transformation.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.transformation.mapper.TechAchEvaluationReportMapper;
import com.hnu.highlynewapp.transformation.mapper.TechAchMapper;
import com.hnu.highlynewapp.entity.TechnologyAchievementEntity;
import com.hnu.highlynewapp.transformation.pojo.TechAchEvaluationReport;
import com.hnu.highlynewapp.transformation.service.TechAchEvaluationReportService;
import com.hnu.highlynewapp.transformation.vo.FindTechAchEvaluationReportVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("techAchEvaluationReportService")
public class TechAchEvaluationReportServiceImpl extends ServiceImpl<TechAchEvaluationReportMapper, TechAchEvaluationReport> implements TechAchEvaluationReportService {
    @Autowired
    private TechAchEvaluationReportMapper techAchEvaluationReportMapper;

    @Autowired
    private TechAchMapper techAchMapper;

    /**
     * 发布技术成果评估报告
     *
     * @param techAchEvaluationReport
     */
    @Override
    public void publish(TechAchEvaluationReport techAchEvaluationReport) {
        //techAchEvaluationReport.setPublishTime(new Date());
        baseMapper.insert(techAchEvaluationReport);
        // 更新成果表字段
        TechnologyAchievementEntity entity = new TechnologyAchievementEntity();
        entity.setTechnologyAchievementId(techAchEvaluationReport.getTechnologyAchievementId());
        if (techAchEvaluationReport.getLevel() != null)
            entity.setLevel(techAchEvaluationReport.getLevel());
        if (techAchEvaluationReport.getMaturity() != null)
            entity.setMaturity(techAchEvaluationReport.getMaturity());
        techAchMapper.updateById(entity);
    }

    /**
     * 根据技术成果id查找技术成果评估报告的详细信息
     *
     * @param technologyAchievementId
     * @return
     */
    @Override
    public FindTechAchEvaluationReportVo findOneByTechAchId(Long technologyAchievementId) {
        return techAchEvaluationReportMapper.findOneByTechAchId(technologyAchievementId);
    }

    /**
     * 根据技术成果评估报告id查找技术成果评估报告的详细信息
     *
     * @param techAchEvaluationReportId
     * @return
     */
    @Override
    public FindTechAchEvaluationReportVo findOneByTechAchEvalReportId(Long techAchEvaluationReportId) {
        return techAchEvaluationReportMapper.findOneByTechAchEvalReportId(techAchEvaluationReportId);
    }

    /**
     * 根据技术成果id查找评估报告的审核状态
     *
     * @param technologyAchievementId
     * @return
     */
    @Override
    public TechAchEvaluationReport findApplicationStatusByTechAchId(Long technologyAchievementId) {
        QueryWrapper<TechAchEvaluationReport> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("application_status", "fail_reason").eq("technology_achievement_id", technologyAchievementId).last("LIMIT 1");
        return techAchEvaluationReportMapper.selectOne(queryWrapper);
    }

    /**
     * 根据技术成果id更新技术成果评估报告的信息
     *
     * @param techAchEvaluationReport
     * @return
     */
    @Override
    public int updateEvaluationReportById(TechAchEvaluationReport techAchEvaluationReport) {
        return techAchEvaluationReportMapper.updateById(techAchEvaluationReport);
    }
}
