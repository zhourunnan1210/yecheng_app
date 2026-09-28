package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.dao.TalentSupplyDao;
import com.hnu.highlynewapp.entity.ContactEntity;
import com.hnu.highlynewapp.entity.PeopleRequireEachPositionEntity;
import com.hnu.highlynewapp.entity.TalentNeedEntity;
import com.hnu.highlynewapp.entity.TalentSupplyEntity;
import com.hnu.highlynewapp.enums.StatusEnum;
import com.hnu.highlynewapp.service.ContactService;
import com.hnu.highlynewapp.service.TalentNeedService;
import com.hnu.highlynewapp.service.TalentSupplyService;
import com.hnu.highlynewapp.service.UserBehaviorService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;
import com.hnu.highlynewapp.utils.TextEmbeddingUtils;
import com.hnu.highlynewapp.vo.PublishTalentSupplyVo;
import com.hnu.highlynewapp.vo.TalentSupplySearchVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service("talentSupplyService")
public class TalentSupplyServiceImpl extends ServiceImpl<TalentSupplyDao, TalentSupplyEntity> implements TalentSupplyService {
    @Autowired
    private ContactService contactService;

    @Autowired
    private TalentNeedService talentNeedService;

    @Autowired
    private TextEmbeddingUtils textEmbeddingUtils;

    @Autowired
    private UserBehaviorService userBehaviorService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<TalentSupplyEntity> page = this.page(
                new Query<TalentSupplyEntity>().getPage(params),
                new QueryWrapper<>()
        );
        return new PageUtils(page);
    }

    @Override
    @Transactional
    public void publish(PublishTalentSupplyVo vo) {
        ContactEntity contactEntity = new ContactEntity();
        BeanUtils.copyProperties(vo, contactEntity);
        Long contactId = contactService.saveAndCheckExist(contactEntity);
        TalentSupplyEntity talentSupplyEntity = new TalentSupplyEntity();
        BeanUtils.copyProperties(vo, talentSupplyEntity);
        talentSupplyEntity.setContactId(contactId);
        talentSupplyEntity.setPublishTime(new Date());
        talentSupplyEntity.setStatus(StatusEnum.STATUS_ONE.getCode());
        baseMapper.insert(talentSupplyEntity);
    }

    @Override
    public List<TalentSupplyEntity> getListByParma() {
        QueryWrapper<TalentSupplyEntity> wrapper = new QueryWrapper<>();
        wrapper.orderByDesc("publish_time");
        return baseMapper.selectList(wrapper);
    }

    @Override
    public List<TalentSupplyEntity> listByCondition(String duration, String degree) {
        int i;
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
        List<TalentSupplyEntity> result;
        if ("全部".equals(duration) && "全部".equals(degree)) {
            QueryWrapper<TalentSupplyEntity> wrapper = new QueryWrapper<>();
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
    public List<TalentSupplyEntity> listByCheckId(Integer check) {
        return this.getBaseMapper().listCheckId(check);
    }

    @Override
    public List<TalentSupplyEntity> getConditionList(String condition) {
        return this.getBaseMapper().listCondition(condition);
    }

    @Override
    public List<PeopleRequireEachPositionEntity> getTalentDataPieChartList() {
        List<PeopleRequireEachPositionEntity> result = new ArrayList<>();
        // 获得list链表
        QueryWrapper<TalentSupplyEntity> wrapper = new QueryWrapper<>();
        wrapper.orderByDesc("publish_time");
        List<TalentSupplyEntity> list = baseMapper.selectList(wrapper);
        // 使用hash对list进行计数
        HashMap<String, Integer> map = new HashMap<>();
        for (TalentSupplyEntity talentSupplyEntity : list) {
            String pos = talentSupplyEntity.getJob();
            map.merge(pos, 1, Integer::sum);
        }
        map.forEach((key, value) -> {
            result.add(new PeopleRequireEachPositionEntity(key, value));
        });
        return result;
    }

    @Override
    public TalentSupplySearchVo getByUserId(String userId) {
        QueryWrapper<TalentSupplyEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        TalentSupplyEntity one = this.baseMapper.selectOne(queryWrapper);
        if (one == null) {
            return null;
        }
        TalentSupplySearchVo talentSupplySearchVo = new TalentSupplySearchVo();
        BeanUtils.copyProperties(one, talentSupplySearchVo);

        // 手动设置薪资字段，因为BigDecimal到Double的转换可能失败
        if (one.getSalaryMin() != null) {
            talentSupplySearchVo.setSalaryMin(one.getSalaryMin().doubleValue());
        }
        if (one.getSalaryMax() != null) {
            talentSupplySearchVo.setSalaryMax(one.getSalaryMax().doubleValue());
        }

        // 设置vo中的ContactEntity
        ContactEntity contactEntity = contactService.getByContactId(one.getContactId());
        talentSupplySearchVo.setContactEntity(contactEntity);
        return talentSupplySearchVo;
    }

    @Override
    public TalentSupplySearchVo getByTalentSupplyId(Long talentSupplyId) {
        // 直接使用主键查询，更安全和高效
        TalentSupplyEntity one = this.baseMapper.selectById(talentSupplyId);
        if (one == null) {
            return null;
        }
        TalentSupplySearchVo talentSupplySearchVo = new TalentSupplySearchVo();
        BeanUtils.copyProperties(one, talentSupplySearchVo);

        // 手动设置薪资字段，因为BigDecimal到Double的转换可能失败
        if (one.getSalaryMin() != null) {
            talentSupplySearchVo.setSalaryMin(one.getSalaryMin().doubleValue());
        }
        if (one.getSalaryMax() != null) {
            talentSupplySearchVo.setSalaryMax(one.getSalaryMax().doubleValue());
        }

        // 设置vo中的ContactEntity
        ContactEntity contactEntity = contactService.getByContactId(one.getContactId());
        talentSupplySearchVo.setContactEntity(contactEntity);
        return talentSupplySearchVo;
    }

    @Override
    public int saveCombinedEmbedding(Long talentSupplyId, String profession, String job, String skill) {
        String combinedText = buildCombinedText(profession, job, skill);
        return textEmbeddingUtils.saveCombinedEmbedding(
                talentSupplyId,
                combinedText,
                this.baseMapper,
                id -> new QueryWrapper<TalentSupplyEntity>().eq("talent_supply_id", id),
                TalentSupplyEntity::setCombinedEmbedding
        );
    }

    @Override
    public int batchSaveCombinedEmbeddings() {
        return textEmbeddingUtils.batchSaveCombinedEmbeddings(
                this.baseMapper,
                "combined_embedding",
                "profession", "job", "skill",
                entity -> buildCombinedText(entity.getProfession(), entity.getJob(), entity.getSkill()),
                TalentSupplyEntity::setCombinedEmbedding
        );
    }

    private String buildCombinedText(String profession, String job, String skill) {
        StringBuilder sb = new StringBuilder();
        if (profession != null && !profession.trim().isEmpty()) {
            String trimmedProfession = profession.trim();
            sb.append("专业：").append(trimmedProfession);
            if (!trimmedProfession.endsWith("。")) {
                sb.append("。");
            }
        }
        if (job != null && !job.trim().isEmpty()) {
            String trimmedJob = job.trim();
            sb.append("求职意向：").append(trimmedJob);
            if (!trimmedJob.endsWith("。")) {
                sb.append("。");
            }
        }
        if (skill != null && !skill.trim().isEmpty()) {
            String trimmedSkill = skill.trim();
            sb.append("专业技能：").append(trimmedSkill);
            if (!trimmedSkill.endsWith("。")) {
                sb.append("。");
            }
        }
        return sb.toString().trim();
    }

    /*@Override
    public List<TalentNeedEntity> recommendJobs(TalentSupplyEntity resume) {
        List<TalentNeedEntity> recommendedJobs = new ArrayList<>();
        // 从数据库中获取所有岗位
        List<TalentNeedEntity> jobPositions = talentNeedService.list();
        for (TalentNeedEntity job : jobPositions) {
            // 从数据库中获取岗位和用户的向量
            double[] userJobEmbedding = resume.getJobEmbedding();
            double[] userSkillEmbedding = resume.getSkillEmbedding();
            double[] jobTitleEmbedding = job.getJobEmbedding();
            double[] jobDemandEmbedding = job.getDemandEmbedding();
            // 计算向量相似度
            double jobMatch = textEmbeddingUtils.calculateCosineSimilarity(userJobEmbedding, jobTitleEmbedding);
            double skillMatch = textEmbeddingUtils.calculateCosineSimilarity(userSkillEmbedding, jobDemandEmbedding);
            // 计算薪资匹配度
            double salaryMatch = textEmbeddingUtils.calculateSalaryMatch(resume.getSalaryMin(), resume.getSalaryMax(), job.getSalaryMin(), job.getSalaryMax());
            // 综合评分
            double matchScore = (jobMatch + skillMatch) * 0.4 + salaryMatch * 0.2;
            if (matchScore > 0.5) { // 阈值
                job.setMatchScore(matchScore);
                recommendedJobs.add(job);
            }
        }
        // 根据匹配分数排序
        recommendedJobs.sort((j1, j2) -> Double.compare(j2.getMatchScore(), j1.getMatchScore()));
        return recommendedJobs;
    }*/

    @Override
    public List<TalentSupplyEntity> searchByLM(String prompt) {
        // 使用新的Qwen3模型搜索方法
        return searchByQwen3(prompt);
    }

    /**
     * 基于Qwen3模型的搜索：使用组合向量 + Reranker重排序
     *
     * @param prompt 用户输入的搜索内容
     * @return 匹配的人才供应列表
     */
    public List<TalentSupplyEntity> searchByQwen3(String prompt) {
        return textEmbeddingUtils.searchByQwen3(
                prompt,
                this.baseMapper,
                "combined_embedding",
                entity -> buildCombinedText(entity.getProfession(), entity.getJob(), entity.getSkill()),
                TalentSupplyEntity::getCombinedEmbedding,
                TalentSupplyEntity::setMatchScore
        );
    }


    @Override
    public List<TalentNeedEntity> recommendJobsByUserId(Long userId) {
        // 获取用户喜欢的岗位标签统计
        List<Map<String, Object>> likeTags = userBehaviorService.getUserLikeTags(userId, 1);

        // 获取所有岗位
        List<TalentNeedEntity> allJobs = talentNeedService.list();

        // 如果没有行为数据，直接返回最新岗位
        if (likeTags.isEmpty()) {
            QueryWrapper<TalentNeedEntity> wrapper = new QueryWrapper<>();
            wrapper.orderByDesc("publish_time");
            List<TalentNeedEntity> latestJobs = talentNeedService.list(wrapper);

            // 为所有岗位设置默认匹配分数
            for (TalentNeedEntity job : latestJobs) {
                job.setMatchScore(0.6); // 设置一个较高的默认分数
            }

            return latestJobs;
        }

        // 混合推荐策略：结合个性化推荐和最新岗位
        List<TalentNeedEntity> recommendedJobs = new ArrayList<>();
        List<TalentNeedEntity> latestJobs = new ArrayList<>();

        // 计算每个岗位的匹配分数
        for (TalentNeedEntity job : allJobs) {
            double score = 0.0;
            for (Map<String, Object> tag : likeTags) {
                String tagName = (String) tag.get("tag");
                Long weight = (Long) tag.get("weight");

                // 计算标签匹配度
                if (tagName != null && job.getPosition() != null && job.getPosition().contains(tagName)) {
                    score += weight;
                }
                if (tagName != null && job.getJob() != null && job.getJob().contains(tagName)) {
                    score += weight;
                }
                if (tagName != null && job.getDemand() != null && job.getDemand().contains(tagName)) {
                    score += weight;
                }
            }

            job.setMatchScore(score);

            // 有匹配分数的岗位加入推荐列表
            if (score > 0) {
                recommendedJobs.add(job);
            } else {
                // 没有匹配分数的岗位加入最新岗位列表
                latestJobs.add(job);
            }
        }

        // 按匹配分数降序排序推荐岗位
        recommendedJobs.sort((j1, j2) -> Double.compare(j2.getMatchScore(), j1.getMatchScore()));

        // 按发布时间降序排序最新岗位
        latestJobs.sort((j1, j2) -> {
            if (j1.getPublishTime() == null && j2.getPublishTime() == null) return 0;
            if (j1.getPublishTime() == null) return 1;
            if (j2.getPublishTime() == null) return -1;
            return j2.getPublishTime().compareTo(j1.getPublishTime());
        });

        // 混合推荐：70%个性化推荐 + 30%最新岗位
        List<TalentNeedEntity> finalRecommendations = new ArrayList<>();

        // 添加个性化推荐岗位（最多70%）
        int recommendedCount = Math.min(recommendedJobs.size(), (int) (allJobs.size() * 0.7));
        finalRecommendations.addAll(recommendedJobs.subList(0, Math.min(recommendedCount, recommendedJobs.size())));

        // 添加最新岗位（最多30%）
        int latestCount = Math.min(latestJobs.size(), (int) (allJobs.size() * 0.3));
        finalRecommendations.addAll(latestJobs.subList(0, Math.min(latestCount, latestJobs.size())));

        // 如果推荐结果太少，补充最新岗位
        if (finalRecommendations.size() < allJobs.size() * 0.5) {
            int remainingCount = (int) (allJobs.size() * 0.5) - finalRecommendations.size();
            int startIndex = finalRecommendations.size();
            int endIndex = Math.min(startIndex + remainingCount, latestJobs.size());
            if (startIndex < latestJobs.size()) {
                finalRecommendations.addAll(latestJobs.subList(startIndex, endIndex));
            }
        }

        return finalRecommendations;
    }
}
