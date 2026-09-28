package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hnu.highlynewapp.entity.TalentNeedEntity;
import com.hnu.highlynewapp.entity.TalentSupplyEntity;
import com.hnu.highlynewapp.service.EnhancedRecommendationService;
import com.hnu.highlynewapp.service.TalentNeedService;
import com.hnu.highlynewapp.service.TalentSupplyService;
import com.hnu.highlynewapp.service.UserBehaviorService;
import com.hnu.highlynewapp.utils.SemanticSimilarityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 增强版推荐服务
 * 整合多维度标签和语义相似性
 */
@Service
public class EnhancedRecommendationServiceImpl implements EnhancedRecommendationService {

    @Autowired
    private UserBehaviorService userBehaviorService;

    @Autowired
    private TalentNeedService talentNeedService;

    @Autowired
    private TalentSupplyService talentSupplyService;

    @Autowired
    private SemanticSimilarityUtils semanticSimilarityUtils;

    /**
     * 增强版岗位推荐
     * @param userId 用户ID
     * @return 推荐岗位列表
     */
    public List<TalentNeedEntity> recommendJobsEnhanced(Long userId) {
        try {
            System.out.println("开始增强版岗位推荐，用户ID: " + userId);
            
            // 获取用户所有多维度标签（包括喜欢和不喜欢的）
            List<Map<String, Object>> allUserTags = userBehaviorService.getAllUserMultiDimensionalTags(userId, 1);
            System.out.println("获取到用户所有标签数量: " + allUserTags.size());
            
            // 如果没有行为数据，返回最新岗位并设置默认分数
            if (allUserTags.isEmpty()) {
                System.out.println("用户无行为数据，返回最新岗位");
                QueryWrapper<TalentNeedEntity> wrapper = new QueryWrapper<>();
                wrapper.orderByDesc("publish_time");
                List<TalentNeedEntity> latestJobs = talentNeedService.list(wrapper);
                
                // 为所有岗位设置默认匹配分数
                for (TalentNeedEntity job : latestJobs) {
                    job.setMatchScore(0.5); // 设置一个中等默认分数
                }
                
                // 确保至少返回20个岗位
                int targetCount = Math.max(20, Math.min(50, latestJobs.size()));
                List<TalentNeedEntity> finalJobs = latestJobs.size() > targetCount ? 
                    latestJobs.subList(0, targetCount) : latestJobs;
                
                System.out.println("返回最新岗位数量: " + finalJobs.size());
                return finalJobs;
            }

            // 获取所有岗位
            List<TalentNeedEntity> allJobs = talentNeedService.list();
            System.out.println("获取到所有岗位数量: " + allJobs.size());
            
            // 获取用户不喜欢的具体岗位ID列表
            List<Map<String, Object>> dislikedJobs = userBehaviorService.getDislikedItems(userId, 1);
            Set<Long> dislikedJobIds = new HashSet<>();
            for (Map<String, Object> item : dislikedJobs) {
                Long jobId = safeLong(item.get("id"));
                if (jobId != null && jobId > 0) {
                    dislikedJobIds.add(jobId);
                }
            }
            System.out.println("用户不喜欢的岗位ID数量: " + dislikedJobIds.size());
            
            // 过滤掉用户已经明确不喜欢的岗位
            List<TalentNeedEntity> filteredJobs = new ArrayList<>();
            for (TalentNeedEntity job : allJobs) {
                if (!dislikedJobIds.contains(job.getTalentNeedId())) {
                    filteredJobs.add(job);
                } else {
                    System.out.println("排除用户不喜欢的岗位ID: " + job.getTalentNeedId());
                }
            }
            System.out.println("过滤后岗位数量: " + filteredJobs.size());
            
            // 计算每个岗位的综合匹配分数
            List<TalentNeedEntity> recommendedJobs = new ArrayList<>();
            List<TalentNeedEntity> latestJobs = new ArrayList<>();
            
            for (TalentNeedEntity job : filteredJobs) {
                try {
                    double totalScore = calculateJobMatchScore(job, allUserTags);
                    job.setMatchScore(totalScore);
                    
                    // 降低推荐阈值，让更多岗位被推荐
                    if (totalScore > 0.1) {
                        recommendedJobs.add(job);
                    } else {
                        // 为最新岗位设置一个小的基础分数
                        job.setMatchScore(Math.max(0.05, totalScore));
                        latestJobs.add(job);
                    }
                } catch (Exception e) {
                    System.err.println("计算岗位匹配分数时出错: " + e.getMessage());
                    e.printStackTrace();
                    // 如果计算出错，将岗位添加到最新岗位列表，设置小的基础分数
                    job.setMatchScore(0.05);
                    latestJobs.add(job);
                }
            }
            
            System.out.println("推荐岗位数量: " + recommendedJobs.size());
            System.out.println("最新岗位数量: " + latestJobs.size());
            
            // 排序
            recommendedJobs.sort((j1, j2) -> Double.compare(j2.getMatchScore(), j1.getMatchScore()));
            latestJobs.sort((j1, j2) -> {
                if (j1.getPublishTime() == null && j2.getPublishTime() == null) return 0;
                if (j1.getPublishTime() == null) return 1;
                if (j2.getPublishTime() == null) return -1;
                return j2.getPublishTime().compareTo(j1.getPublishTime());
            });
            
            // 混合推荐结果，确保至少20个
            int targetCount = Math.max(20, allJobs.size() > 0 ? Math.min(50, allJobs.size()) : 20);
            List<TalentNeedEntity> finalRecommendations = createMixedRecommendations(
                recommendedJobs, latestJobs, targetCount
            );
            
            System.out.println("最终推荐岗位数量: " + finalRecommendations.size());
            return finalRecommendations;
            
        } catch (Exception e) {
            System.err.println("增强版岗位推荐失败: " + e.getMessage());
            e.printStackTrace();
            
            // 如果增强推荐失败，返回最新岗位
            try {
                QueryWrapper<TalentNeedEntity> wrapper = new QueryWrapper<>();
                wrapper.orderByDesc("publish_time");
                List<TalentNeedEntity> fallbackJobs = talentNeedService.list(wrapper);
                
                for (TalentNeedEntity job : fallbackJobs) {
                    job.setMatchScore(0.5);
                }
                
                System.out.println("增强推荐失败，返回最新岗位数量: " + fallbackJobs.size());
                return fallbackJobs;
            } catch (Exception fallbackError) {
                System.err.println("备用推荐也失败: " + fallbackError.getMessage());
                return new ArrayList<>();
            }
        }
    }

    /**
     * 增强版简历推荐
     * @param userId 用户ID
     * @return 推荐简历列表
     */
    public List<TalentSupplyEntity> recommendTalentsEnhanced(Long userId) {
        try {
            System.out.println("开始增强版简历推荐，用户ID: " + userId);
            
            // 获取用户所有多维度标签（包括喜欢和不喜欢的）
            List<Map<String, Object>> allUserTags = userBehaviorService.getAllUserMultiDimensionalTags(userId, 2);
            System.out.println("获取到用户所有标签数量: " + allUserTags.size());
            
            // 如果没有行为数据，返回最新简历并设置默认分数
            if (allUserTags.isEmpty()) {
                System.out.println("用户无行为数据，返回最新简历");
                QueryWrapper<TalentSupplyEntity> wrapper = new QueryWrapper<>();
                wrapper.orderByDesc("publish_time");
                List<TalentSupplyEntity> latestTalents = talentSupplyService.list(wrapper);
                
                // 为所有简历设置默认匹配分数
                for (TalentSupplyEntity talent : latestTalents) {
                    talent.setMatchScore(0.5); // 设置一个中等默认分数
                }
                
                System.out.println("返回最新简历数量: " + latestTalents.size());
                return latestTalents;
            }

            // 获取所有简历
            List<TalentSupplyEntity> allTalents = talentSupplyService.list();
            System.out.println("获取到所有简历数量: " + allTalents.size());
            
            // 获取用户不喜欢的具体简历ID列表
            List<Map<String, Object>> dislikedItems = userBehaviorService.getDislikedItems(userId, 2);
            Set<Long> dislikedTalentIds = new HashSet<>();
            for (Map<String, Object> item : dislikedItems) {
                Long talentId = safeLong(item.get("id"));
                if (talentId != null && talentId > 0) {
                    dislikedTalentIds.add(talentId);
                }
            }
            System.out.println("用户不喜欢的简历ID数量: " + dislikedTalentIds.size());
            
            // 过滤掉用户已经明确不喜欢的简历
            List<TalentSupplyEntity> filteredTalents = new ArrayList<>();
            for (TalentSupplyEntity talent : allTalents) {
                if (!dislikedTalentIds.contains(talent.getTalentSupplyId())) {
                    filteredTalents.add(talent);
                } else {
                    System.out.println("排除用户不喜欢的简历ID: " + talent.getTalentSupplyId());
                }
            }
            System.out.println("过滤后简历数量: " + filteredTalents.size());
            
            // 计算每个简历的综合匹配分数
            List<TalentSupplyEntity> recommendedTalents = new ArrayList<>();
            List<TalentSupplyEntity> latestTalents = new ArrayList<>();
            
            for (TalentSupplyEntity talent : filteredTalents) {
                try {
                    double totalScore = calculateTalentMatchScore(talent, allUserTags);
                    talent.setMatchScore(totalScore);
                    
                    if (totalScore > 0) {
                        recommendedTalents.add(talent);
                    } else {
                        latestTalents.add(talent);
                    }
                } catch (Exception e) {
                    System.err.println("计算简历匹配分数时出错: " + e.getMessage());
                    e.printStackTrace();
                    // 如果计算出错，将简历添加到最新简历列表
                    talent.setMatchScore(0.0);
                    latestTalents.add(talent);
                }
            }
            
            System.out.println("推荐简历数量: " + recommendedTalents.size());
            System.out.println("最新简历数量: " + latestTalents.size());
            
            // 排序
            recommendedTalents.sort((t1, t2) -> Double.compare(t2.getMatchScore(), t1.getMatchScore()));
            latestTalents.sort((t1, t2) -> {
                if (t1.getPublishTime() == null && t2.getPublishTime() == null) return 0;
                if (t1.getPublishTime() == null) return 1;
                if (t2.getPublishTime() == null) return -1;
                return t2.getPublishTime().compareTo(t1.getPublishTime());
            });
            
            // 混合推荐结果
            List<TalentSupplyEntity> finalRecommendations = createMixedTalentRecommendations(
                recommendedTalents, latestTalents, Math.min(20, allTalents.size())
            );
            
            System.out.println("最终推荐简历数量: " + finalRecommendations.size());
            return finalRecommendations;
            
        } catch (Exception e) {
            System.err.println("增强版简历推荐失败: " + e.getMessage());
            e.printStackTrace();
            
            // 如果增强推荐失败，返回最新简历
            try {
                QueryWrapper<TalentSupplyEntity> wrapper = new QueryWrapper<>();
                wrapper.orderByDesc("publish_time");
                List<TalentSupplyEntity> fallbackTalents = talentSupplyService.list(wrapper);
                
                for (TalentSupplyEntity talent : fallbackTalents) {
                    talent.setMatchScore(0.5);
                }
                
                System.out.println("增强推荐失败，返回最新简历数量: " + fallbackTalents.size());
                return fallbackTalents;
            } catch (Exception fallbackError) {
                System.err.println("备用推荐也失败: " + fallbackError.getMessage());
                return new ArrayList<>();
            }
        }
    }

    /**
     * 计算岗位匹配分数
     */
    private double calculateJobMatchScore(TalentNeedEntity job, List<Map<String, Object>> userTags) {
        double totalScore = 0.0;
        
        for (Map<String, Object> tagInfo : userTags) {
            String positionTag = safeString(tagInfo.get("position_tag"));
            String locationTag = safeString(tagInfo.get("location_tag"));
            String degreeTag = safeString(tagInfo.get("degree_tag"));
            String salaryTag = safeString(tagInfo.get("salary_tag"));
            String featureTag = safeString(tagInfo.get("feature_tag"));
            Long weight = safeLong(tagInfo.get("weight"));
            
            // 职位匹配分数 (权重: 0.4)
            if (positionTag != null && job.getPosition() != null) {
                double positionScore = semanticSimilarityUtils.calculatePositionSimilarity(positionTag, job.getPosition());
                // 负权重会降低匹配分数，正权重会提高匹配分数
                totalScore += positionScore * weight * 0.4;
            }
            
            // 地点匹配分数 (权重: 0.2)
            if (locationTag != null && job.getLocation() != null) {
                double locationScore = semanticSimilarityUtils.calculateLocationSimilarity(locationTag, job.getLocation());
                totalScore += locationScore * weight * 0.2;
            }
            
            // 学历匹配分数 (权重: 0.1)
            if (degreeTag != null && job.getDegree() != null) {
                double degreeScore = degreeTag.equals(job.getDegree().toString()) ? 1.0 : 0.0;
                totalScore += degreeScore * weight * 0.1;
            }
            
            // 薪资匹配分数 (权重: 0.2)
            if (salaryTag != null && job.getSalaryMin() != null && job.getSalaryMax() != null) {
                String jobSalary = job.getSalaryMin() + "-" + job.getSalaryMax();
                double salaryScore = semanticSimilarityUtils.calculateSalarySimilarity(salaryTag, jobSalary);
                totalScore += salaryScore * weight * 0.2;
            }
            
            // 特色匹配分数 (权重: 0.1)
            if (featureTag != null && job.getTitle1() != null) {
                double featureScore = featureTag.equals(job.getTitle1()) ? 1.0 : 0.0;
                totalScore += featureScore * weight * 0.1;
            }
        }
        
        // 确保分数不为负数，最低为0
        return Math.max(0.0, totalScore);
    }

    /**
     * 计算简历匹配分数
     */
    private double calculateTalentMatchScore(TalentSupplyEntity talent, List<Map<String, Object>> userTags) {
        double totalScore = 0.0;
        
        for (Map<String, Object> tagInfo : userTags) {
            String positionTag = safeString(tagInfo.get("position_tag"));
            String locationTag = safeString(tagInfo.get("location_tag"));
            String degreeTag = safeString(tagInfo.get("degree_tag"));
            String salaryTag = safeString(tagInfo.get("salary_tag"));
            String featureTag = safeString(tagInfo.get("feature_tag"));
            Long weight = safeLong(tagInfo.get("weight"));
            
            // 求职意向匹配分数 (权重: 0.4)
            if (positionTag != null && talent.getJob() != null) {
                double positionScore = semanticSimilarityUtils.calculatePositionSimilarity(positionTag, talent.getJob());
                // 负权重会降低匹配分数，正权重会提高匹配分数
                totalScore += positionScore * weight * 0.4;
            }
            
            // 地点匹配分数 (权重: 0.2) - 简历没有location字段，暂时跳过
            // if (locationTag != null && talent.getLocation() != null) {
            //     double locationScore = semanticSimilarityUtils.calculateLocationSimilarity(locationTag, talent.getLocation());
            //     totalScore += locationScore * weight * 0.2;
            // }
            
            // 学历匹配分数 (权重: 0.1)
            if (degreeTag != null && talent.getDegree() != null) {
                double degreeScore = degreeTag.equals(talent.getDegree().toString()) ? 1.0 : 0.0;
                totalScore += degreeScore * weight * 0.1;
            }
            
            // 薪资匹配分数 (权重: 0.2)
            if (salaryTag != null && talent.getSalaryMin() != null && talent.getSalaryMax() != null) {
                String talentSalary = talent.getSalaryMin() + "-" + talent.getSalaryMax();
                double salaryScore = semanticSimilarityUtils.calculateSalarySimilarity(salaryTag, talentSalary);
                totalScore += salaryScore * weight * 0.2;
            }
            
            // 品质匹配分数 (权重: 0.1)
            if (featureTag != null && talent.getQuality() != null) {
                double featureScore = featureTag.equals(talent.getQuality()) ? 1.0 : 0.0;
                totalScore += featureScore * weight * 0.1;
            }
        }
        
        // 确保分数不为负数，最低为0
        return Math.max(0.0, totalScore);
    }
    
    /**
     * 安全地转换为字符串
     */
    private String safeString(Object obj) {
        if (obj == null) {
            return null;
        }
        return obj.toString();
    }
    
    /**
     * 安全地转换为Long
     */
    private Long safeLong(Object obj) {
        if (obj == null) {
            return 0L;
        }
        if (obj instanceof Number) {
            return ((Number) obj).longValue();
        }
        try {
            return Long.valueOf(obj.toString());
        } catch (NumberFormatException e) {
            return 0L;
        }
    }

    /**
     * 创建混合岗位推荐，确保至少返回指定数量
     */
    private List<TalentNeedEntity> createMixedRecommendations(List<TalentNeedEntity> recommendedJobs, 
                                                           List<TalentNeedEntity> latestJobs, 
                                                           int totalJobs) {
        List<TalentNeedEntity> finalRecommendations = new ArrayList<>();
        
        System.out.println("开始创建混合推荐，目标数量: " + totalJobs);
        System.out.println("个性化推荐岗位数量: " + recommendedJobs.size());
        System.out.println("最新岗位数量: " + latestJobs.size());
        
        // 优先添加个性化推荐岗位（按分数排序）
        finalRecommendations.addAll(recommendedJobs);
        
        // 添加剩余的最新岗位，避免重复
        Set<Long> addedJobIds = finalRecommendations.stream()
            .map(TalentNeedEntity::getTalentNeedId)
            .collect(Collectors.toSet());
            
        for (TalentNeedEntity job : latestJobs) {
            if (!addedJobIds.contains(job.getTalentNeedId())) {
                // 为最新岗位设置默认分数（稍低于个性化推荐）
                Double currentScore = job.getMatchScore();
                if (currentScore == null || currentScore.doubleValue() == 0.0) {
                    job.setMatchScore(0.1);
                }
                finalRecommendations.add(job);
                addedJobIds.add(job.getTalentNeedId());
            }
        }
        
        // 确保至少有指定数量的岗位
        if (finalRecommendations.size() < totalJobs) {
            System.out.println("当前推荐数量不足 (" + finalRecommendations.size() + "/" + totalJobs + 
                              ")，需要添加更多岗位");
        }
        
        // 按相关度（匹配分数）降序排序
        finalRecommendations.sort((j1, j2) -> {
            Double score1 = j1.getMatchScore();
            Double score2 = j2.getMatchScore();
            double s1 = score1 != null ? score1.doubleValue() : 0.0;
            double s2 = score2 != null ? score2.doubleValue() : 0.0;
            return Double.compare(s2, s1);
        });
        
        System.out.println("最终推荐岗位数量: " + finalRecommendations.size());
        
        return finalRecommendations;
    }

    /**
     * 创建混合简历推荐
     */
    private List<TalentSupplyEntity> createMixedTalentRecommendations(List<TalentSupplyEntity> recommendedTalents, 
                                                                     List<TalentSupplyEntity> latestTalents, 
                                                                     int totalTalents) {
        List<TalentSupplyEntity> finalRecommendations = new ArrayList<>();
        
        // 70%个性化推荐
        int recommendedCount = Math.min(recommendedTalents.size(), (int)(totalTalents * 0.7));
        finalRecommendations.addAll(recommendedTalents.subList(0, Math.min(recommendedCount, recommendedTalents.size())));
        
        // 30%最新简历
        int latestCount = Math.min(latestTalents.size(), (int)(totalTalents * 0.3));
        finalRecommendations.addAll(latestTalents.subList(0, Math.min(latestCount, latestTalents.size())));
        
        // 兜底机制
        if (finalRecommendations.size() < totalTalents * 0.5) {
            int remainingCount = (int)(totalTalents * 0.5) - finalRecommendations.size();
            int startIndex = finalRecommendations.size();
            int endIndex = Math.min(startIndex + remainingCount, latestTalents.size());
            if (startIndex < latestTalents.size()) {
                finalRecommendations.addAll(latestTalents.subList(startIndex, endIndex));
            }
        }
        
        return finalRecommendations;
    }
} 