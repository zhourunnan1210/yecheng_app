package com.hnu.highlynewapp.transformation.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.entity.TechnologyAchievementEntity;
import com.hnu.highlynewapp.transformation.vo.FindTechAchVo;

/**
 * 技术成果
 */
public interface TechAchService extends IService<TechnologyAchievementEntity> {
    FindTechAchVo findOneByTechAchId(Long technologyAchievementId);

//    PageUtils queryPageByPublisher(Map<String, Object> params, Integer publisherType, Integer publisherId);
}
