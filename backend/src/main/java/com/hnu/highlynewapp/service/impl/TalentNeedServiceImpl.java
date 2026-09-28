package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.dao.TalentNeedDao;
import com.hnu.highlynewapp.entity.*;
import com.hnu.highlynewapp.enums.StatusEnum;
import com.hnu.highlynewapp.service.*;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;
import com.hnu.highlynewapp.utils.TextEmbeddingUtils;
import com.hnu.highlynewapp.vo.PublishTalentNeedVo;
import com.hnu.highlynewapp.vo.TalentNeedSearchVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service("talentNeedService")
public class TalentNeedServiceImpl extends ServiceImpl<TalentNeedDao, TalentNeedEntity> implements TalentNeedService {
    @Autowired
    private BusinessInfoService businessInfoService;

    @Autowired
    private ContactService contactService;

    @Autowired
    private TalentSupplyService talentSupplyService;

    @Autowired
    private TextEmbeddingUtils textEmbeddingUtils;

    @Autowired
    private UserBehaviorService userBehaviorService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<TalentNeedEntity> page = this.page(
                new Query<TalentNeedEntity>().getPage(params),
                new QueryWrapper<>()
        );
        return new PageUtils(page);
    }

    @Override
    @Transactional
    public void publish(PublishTalentNeedVo vo) {
        BusinessInfoEntity businessInfoEntity = new BusinessInfoEntity();
        BeanUtils.copyProperties(vo, businessInfoEntity);
        businessInfoEntity.setName(vo.getBusinessName());
        businessInfoEntity.setEmail(vo.getBusinessEmail());
        Long businessId = businessInfoService.saveAndCheckExist(businessInfoEntity);
        ContactEntity contactEntity = new ContactEntity();
        BeanUtils.copyProperties(vo, contactEntity);
        contactEntity.setName(vo.getContactName());
        contactEntity.setEmail(vo.getContactEmail());
        Long contactId = contactService.saveAndCheckExist(contactEntity);
        TalentNeedEntity talentNeedEntity = new TalentNeedEntity();
        BeanUtils.copyProperties(vo, talentNeedEntity);
        talentNeedEntity.setBusinessId(businessId);
        talentNeedEntity.setContactId(contactId);
        talentNeedEntity.setPublishTime(new Date());
        talentNeedEntity.setPosition(vo.getBusinessPosition());
        talentNeedEntity.setAddress(vo.getBusinessAddress());
        talentNeedEntity.setStatus(StatusEnum.STATUS_ONE.getCode());
        baseMapper.insert(talentNeedEntity);
    }

    @Override
    public List<TalentNeedEntity> getListByParma() {
        QueryWrapper<TalentNeedEntity> wrapper = new QueryWrapper<>();
        wrapper.orderByDesc("publish_time");
        return baseMapper.selectList(wrapper);
    }

    @Override
    public List<TalentNeedEntity> listByCondition(String duration, String degree) {
        int i = 0;
        switch (duration) {
            case "一个月内":
                i = 30;
                break;
            case "三个月内":
                i = 90;
                break;
            case "六个月内":
                i = 180;
                break;
            case "一年内":
                i = 365;
                break;
            default:
                i = -1;
                break;
        }
        List<TalentNeedEntity> result;
        if ("全部".equals(duration) && "全部".equals(degree)) {
            QueryWrapper<TalentNeedEntity> wrapper = new QueryWrapper<>();
            wrapper.orderByDesc("publish_time");
            result = this.list(wrapper);
        } else if (!"全部".equals(duration) && "全部".equals(degree)) {
            result = this.getBaseMapper().listByDuration(i);
        } else if ("全部".equals(duration)) {
            result = this.getBaseMapper().listByField(degree);
        } else {
            result = this.getBaseMapper().listByBoth(i, degree);
        }
        return result;
    }

    @Override
    public List<TalentNeedEntity> listByCheckId(Integer check) {
        return this.getBaseMapper().listCheckId(check);
    }

    @Override
    public List<TalentNeedEntity> getConditionList(String condition) {
        return this.getBaseMapper().listByCondition(condition);
    }

    @Override
    public List<PeopleRequireEachPositionEntity> getNumberOfPeopleRequiredEachPosition() {
        List<PeopleRequireEachPositionEntity> result = new ArrayList<>();
        // 获得list链表
        QueryWrapper<TalentNeedEntity> wrapper = new QueryWrapper<>();
        wrapper.orderByDesc("publish_time");
        List<TalentNeedEntity> list = baseMapper.selectList(wrapper);
        // 使用hash对list进行计数
        HashMap<String, Integer> map = new HashMap<>();
        for (TalentNeedEntity talentNeedEntity : list) {
            String pos = talentNeedEntity.getPosition();
            map.merge(pos, 1, Integer::sum);
        }
        map.forEach((key, value) -> {
            result.add(new PeopleRequireEachPositionEntity(key, value));
        });
        return result;
    }

    @Override
    public TalentNeedSearchVo getByUserId(String userId) {
        QueryWrapper<TalentNeedEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        TalentNeedEntity one = this.baseMapper.selectOne(queryWrapper);
        if (one == null) {
            return null;
        }
        TalentNeedSearchVo talentNeedSearchVo = new TalentNeedSearchVo();
        BeanUtils.copyProperties(one, talentNeedSearchVo);
        // 设置vo中的setBusinessInfoEntity
        BusinessInfoEntity businessInfoEntity = businessInfoService.getByBusinessId(one.getBusinessId());
        talentNeedSearchVo.setBusinessInfoEntity(businessInfoEntity);
        // 设置vo中的ContactEntity
        ContactEntity contactEntity = contactService.getByContactId(one.getContactId());
        talentNeedSearchVo.setContactEntity(contactEntity);
        return talentNeedSearchVo;
    }

    @Override
    public TalentNeedSearchVo getByTalentNeedId(String talentNeedId) {
        QueryWrapper<TalentNeedEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("talent_need_id", talentNeedId);
        TalentNeedEntity one = this.baseMapper.selectOne(queryWrapper);
        if (one == null) {
            return null;
        }
        TalentNeedSearchVo talentNeedSearchVo = new TalentNeedSearchVo();
        BeanUtils.copyProperties(one, talentNeedSearchVo);
        // 设置vo中的setBusinessInfoEntity
        BusinessInfoEntity businessInfoEntity = businessInfoService.getByBusinessId(one.getBusinessId());
        talentNeedSearchVo.setBusinessInfoEntity(businessInfoEntity);
        // 设置vo中的ContactEntity
        ContactEntity contactEntity = contactService.getByContactId(one.getContactId());
        talentNeedSearchVo.setContactEntity(contactEntity);
        return talentNeedSearchVo;
    }

    @Override
    public int saveCombinedEmbedding(Long talentNeedId, String position, String job, String demand) {
        String combinedText = buildCombinedText(position, job, demand);
        return textEmbeddingUtils.saveCombinedEmbedding(
                talentNeedId,
                combinedText,
                this.baseMapper,
                id -> new QueryWrapper<TalentNeedEntity>().eq("talent_need_id", id),
                TalentNeedEntity::setCombinedEmbedding
        );
    }

    @Override
    public int batchSaveCombinedEmbeddings() {
        return textEmbeddingUtils.batchSaveCombinedEmbeddings(
                this.baseMapper,
                "combined_embedding",
                "position", "job", "demand",
                entity -> buildCombinedText(entity.getPosition(), entity.getJob(), entity.getDemand()),
                TalentNeedEntity::setCombinedEmbedding
        );
    }

    private String buildCombinedText(String position, String job, String demand) {
        StringBuilder sb = new StringBuilder();
        if (position != null && !position.trim().isEmpty()) {
            String trimmedPosition = position.trim();
            sb.append("职位：").append(trimmedPosition);
            if (!trimmedPosition.endsWith("。")) {
                sb.append("。");
            }
        }
        if (job != null && !job.trim().isEmpty()) {
            String trimmedJob = job.trim();
            sb.append("工作内容：").append(trimmedJob);
            if (!trimmedJob.endsWith("。")) {
                sb.append("。");
            }
        }
        if (demand != null && !demand.trim().isEmpty()) {
            String trimmedDemand = demand.trim();
            sb.append("职位要求：").append(trimmedDemand);
            if (!trimmedDemand.endsWith("。")) {
                sb.append("。");
            }
        }
        return sb.toString().trim();
    }

    /*@Override
    public List<TalentSupplyEntity> recommendTalents(TalentNeedEntity position) {
        List<TalentSupplyEntity> recommendedTalents = new ArrayList<>();
        // 获取所有人才供给
        List<TalentSupplyEntity> talents = talentSupplyService.list();
        // 对每个人才供给计算推荐分数
        for (TalentSupplyEntity talent : talents) {
            // 1. 向量相似度
            double jobSimilarity = textEmbeddingUtils.calculateCosineSimilarity(position.getJobEmbedding(), talent.getJobEmbedding());
            double skillSimilarity = textEmbeddingUtils.calculateCosineSimilarity(position.getDemandEmbedding(), talent.getSkillEmbedding());
            // 2. 薪资匹配度
            double salaryMatch = textEmbeddingUtils.calculateSalaryMatch(talent.getSalaryMin(), talent.getSalaryMax(), position.getSalaryMin(), position.getSalaryMax());
            // 3. 综合评分 (权重可以调整)
            double matchScore = (jobSimilarity + skillSimilarity) * 0.4 + salaryMatch * 0.2;
            // 保存推荐结果
            if (matchScore > 0.5) { //阈值
                talent.setMatchScore(matchScore);
                recommendedTalents.add(talent);
            }
        }
        // 按总评分降序排序
        recommendedTalents.sort((t1, t2) -> Double.compare(t2.getMatchScore(), t1.getMatchScore()));
        return recommendedTalents;
    }*/

    @Override
    public List<TalentNeedEntity> searchByLM(String prompt) {
        // 使用新的Qwen3模型搜索方法
        return searchByQwen3(prompt);
    }

    /**
     * 基于Qwen3模型的搜索：使用组合向量 + Reranker重排序
     *
     * @param prompt 用户输入的搜索内容
     * @return 匹配的人才需求列表
     */
    public List<TalentNeedEntity> searchByQwen3(String prompt) {
        return textEmbeddingUtils.searchByQwen3(
                prompt,
                this.baseMapper,
                "combined_embedding",
                entity -> buildCombinedText(entity.getPosition(), entity.getJob(), entity.getDemand()),
                TalentNeedEntity::getCombinedEmbedding,
                TalentNeedEntity::setMatchScore
        );
    }


    @Override
    public List<TalentSupplyEntity> recommendTalentsByUserId(Long userId) {
        // 获取用户喜欢的简历标签统计
        List<Map<String, Object>> likeTags = userBehaviorService.getUserLikeTags(userId, 2);

        // 获取所有简历
        List<TalentSupplyEntity> allTalents = talentSupplyService.list();

        // 如果没有行为数据，直接返回最新简历
        if (likeTags.isEmpty()) {
            QueryWrapper<TalentSupplyEntity> wrapper = new QueryWrapper<>();
            wrapper.orderByDesc("publish_time");
            List<TalentSupplyEntity> latestTalents = talentSupplyService.list(wrapper);

            // 为所有简历设置默认匹配分数
            for (TalentSupplyEntity talent : latestTalents) {
                talent.setMatchScore(0.6); // 设置一个较高的默认分数
            }

            return latestTalents;
        }

        // 混合推荐策略：结合个性化推荐和最新简历
        List<TalentSupplyEntity> recommendedTalents = new ArrayList<>();
        List<TalentSupplyEntity> latestTalents = new ArrayList<>();

        // 计算每个简历的匹配分数
        for (TalentSupplyEntity talent : allTalents) {
            double score = 0.0;
            for (Map<String, Object> tag : likeTags) {
                String tagName = (String) tag.get("tag");
                Long weight = (Long) tag.get("weight");

                // 计算标签匹配度
                if (tagName != null && talent.getJob() != null && talent.getJob().contains(tagName)) {
                    score += weight;
                }
                if (tagName != null && talent.getSkill() != null && talent.getSkill().contains(tagName)) {
                    score += weight;
                }
            }

            talent.setMatchScore(score);

            // 有匹配分数的简历加入推荐列表
            if (score > 0) {
                recommendedTalents.add(talent);
            } else {
                // 没有匹配分数的简历加入最新简历列表
                latestTalents.add(talent);
            }
        }

        // 按匹配分数降序排序推荐简历
        recommendedTalents.sort((t1, t2) -> Double.compare(t2.getMatchScore(), t1.getMatchScore()));

        // 按发布时间降序排序最新简历
        latestTalents.sort((t1, t2) -> {
            if (t1.getPublishTime() == null && t2.getPublishTime() == null) return 0;
            if (t1.getPublishTime() == null) return 1;
            if (t2.getPublishTime() == null) return -1;
            return t2.getPublishTime().compareTo(t1.getPublishTime());
        });

        // 混合推荐：70%个性化推荐 + 30%最新简历
        List<TalentSupplyEntity> finalRecommendations = new ArrayList<>();

        // 添加个性化推荐简历（最多70%）
        int recommendedCount = Math.min(recommendedTalents.size(), (int) (allTalents.size() * 0.7));
        finalRecommendations.addAll(recommendedTalents.subList(0, Math.min(recommendedCount, recommendedTalents.size())));

        // 添加最新简历（最多30%）
        int latestCount = Math.min(latestTalents.size(), (int) (allTalents.size() * 0.3));
        finalRecommendations.addAll(latestTalents.subList(0, Math.min(latestCount, latestTalents.size())));

        // 如果推荐结果太少，补充最新简历
        if (finalRecommendations.size() < allTalents.size() * 0.5) {
            int remainingCount = (int) (allTalents.size() * 0.5) - finalRecommendations.size();
            int startIndex = finalRecommendations.size();
            int endIndex = Math.min(startIndex + remainingCount, latestTalents.size());
            if (startIndex < latestTalents.size()) {
                finalRecommendations.addAll(latestTalents.subList(startIndex, endIndex));
            }
        }

        return finalRecommendations;
    }
}
