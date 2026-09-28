package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.entity.TechnologyAchievementEntity;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.vo.PublishTechAchVo;

import java.util.List;
import java.util.Map;

/**
 * 技术成果
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
public interface TechnologyAchievementService extends IService<TechnologyAchievementEntity> {
    PageUtils queryPage(Map<String, Object> params);

    void publish(PublishTechAchVo vo);

    List<TechnologyAchievementEntity> listByPublisherID(long publisherID, Integer publisherType);

    List<TechnologyAchievementEntity> listByConditions(String duration, String field, String level, String maturity);

    List<TechnologyAchievementEntity> search(String keyword);

    List<TechnologyAchievementEntity> listByTechnologyNeed(Long technologyNeedId);

    TechnologyAchievementEntity findByReportId(Long techAchEvaluationReportId);
}

