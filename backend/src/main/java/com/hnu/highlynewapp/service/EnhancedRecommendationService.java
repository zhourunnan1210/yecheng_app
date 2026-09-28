package com.hnu.highlynewapp.service;

import com.hnu.highlynewapp.entity.TalentNeedEntity;
import com.hnu.highlynewapp.entity.TalentSupplyEntity;

import java.util.List;

/**
 * 增强版推荐服务接口
 */
public interface EnhancedRecommendationService {

    /**
     * 增强版岗位推荐
     *
     * @param userId 用户ID
     * @return 推荐岗位列表
     */
    List<TalentNeedEntity> recommendJobsEnhanced(Long userId);

    /**
     * 增强版简历推荐
     *
     * @param userId 用户ID
     * @return 推荐简历列表
     */
    List<TalentSupplyEntity> recommendTalentsEnhanced(Long userId);
}
