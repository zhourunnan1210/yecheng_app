package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.transformation.mapper.TechAchEvaluationReportMapper;
import com.hnu.highlynewapp.dao.TechnologyAchievementDao;
import com.hnu.highlynewapp.dao.TechnologyNeedDao;
import com.hnu.highlynewapp.entity.ContactEntity;
import com.hnu.highlynewapp.entity.TechnologyAchievementEntity;
import com.hnu.highlynewapp.entity.TechnologyNeedEntity;
import com.hnu.highlynewapp.service.ContactService;
import com.hnu.highlynewapp.service.TechnologyAchievementService;
import com.hnu.highlynewapp.transformation.enums.LevelEnum;
import com.hnu.highlynewapp.transformation.enums.MaturityEnum;
import com.hnu.highlynewapp.transformation.pojo.TechAchEvaluationReport;
import com.hnu.highlynewapp.utils.DateUtil;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;
import com.hnu.highlynewapp.vo.PublishTechAchVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@Service("technologyAchievementService")
public class TechnologyAchievementServiceImpl extends ServiceImpl<TechnologyAchievementDao, TechnologyAchievementEntity> implements TechnologyAchievementService {
    @Autowired
    private ContactService contactService;

    @Autowired
    private TechAchEvaluationReportMapper techAchEvaluationReportMapper;

    @Autowired
    private TechnologyNeedDao technologyNeedDao;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<TechnologyAchievementEntity> page = this.page(
                new Query<TechnologyAchievementEntity>().getPage(params),
                new QueryWrapper<>()
        );

        return new PageUtils(page);
    }

    @Override
    public void publish(PublishTechAchVo vo) {
        ContactEntity contactEntity = new ContactEntity();
        BeanUtils.copyProperties(vo, contactEntity);
        Long contactId = contactService.saveAndCheckExist(contactEntity);
        TechnologyAchievementEntity technologyAchievementEntity = new TechnologyAchievementEntity();
        BeanUtils.copyProperties(vo, technologyAchievementEntity);
        technologyAchievementEntity.setPublishTime(new Date());
        technologyAchievementEntity.setContactId(contactId);
        baseMapper.insert(technologyAchievementEntity);
    }

    @Override
    public List<TechnologyAchievementEntity> listByPublisherID(long publisherID, Integer publisherType) {
        QueryWrapper<TechnologyAchievementEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("publisher_id", publisherID)
                .eq("publisher_type", publisherType).orderByDesc("publish_time");
        return this.list(wrapper);
    }

    /**
     * 根据条件查找技术成果列表
     *
     * @param duration 时间
     * @param field    行业领域
     * @param level    成果水平
     * @param maturity 成熟度
     * @return
     */
    @Override
    public List<TechnologyAchievementEntity> listByConditions(String duration, String field, String level, String maturity) {
        QueryWrapper<TechnologyAchievementEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("publish_time");
        // 时间
        if (StringUtils.hasText(duration) && !"全部".equals(duration)) {
            queryWrapper.ge("publish_time", DateUtil.getStartDateByTimeIndex(duration));
        }
        // 成果水平
        if (StringUtils.hasText(level) && !"全部".equals(level)) {
            queryWrapper.eq("level", LevelEnum.findCodeByMsg(level));
        }
        // 成熟度
        if (StringUtils.hasText(maturity) && !"全部".equals(maturity)) {
            queryWrapper.eq("maturity", MaturityEnum.findCodeByMsg(maturity));
        }
        // 行业领域，只传一个
        if (StringUtils.hasText(field) && !"全部".equals(field)) {
            List<String> fieldList = Arrays.asList(field.split(","));
            if (fieldList.size() == 1) {
                queryWrapper.apply(fieldList.get(0) != null, "FIND_IN_SET ('" + fieldList.get(0) + "', field)");
            }
        }
        List<TechnologyAchievementEntity> list = baseMapper.selectList(queryWrapper);
        // 过滤行业领域，传多个
        if (Arrays.asList(field.split(",")).size() > 1) {
            List<String> fieldList = Arrays.asList(field.split(","));
            List<TechnologyAchievementEntity> entities = new ArrayList<>();
            for (TechnologyAchievementEntity entity : list) {
                List<String> fields = Arrays.asList(entity.getField().split(","));
                for (String elem : fieldList) {
                    if (fields.contains(elem)) {
                        break;
                    }
                    if (fieldList.indexOf(elem) == fieldList.size() - 1) {
                        entities.add(entity);
                    }
                }
            }
            list.removeAll(entities);
        }
        return list;
    }

    /**
     * 根据关键词模糊查询技术成果
     *
     * @param keyword
     * @return
     */
    @Override
    public List<TechnologyAchievementEntity> search(String keyword) {
        QueryWrapper<TechnologyAchievementEntity> queryWrapper = new QueryWrapper<>();
        if (StringUtils.hasText(keyword)) {
            queryWrapper.like("title", keyword);
        }
        return baseMapper.selectList(queryWrapper);
    }

    /**
     * 查询和技术需求匹配成功的成果
     *
     * @param technologyNeedId
     * @return
     */
    @Override
    public List<TechnologyAchievementEntity> listByTechnologyNeed(Long technologyNeedId) {
        QueryWrapper<TechnologyNeedEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("technology_need_id", technologyNeedId);
        TechnologyNeedEntity technologyNeedEntity = technologyNeedDao.selectOne(queryWrapper);
        if (technologyNeedEntity != null && technologyNeedEntity.getTechnologyAchievementIds() != null) {
            List<String> ids = Arrays.asList(technologyNeedEntity.getTechnologyAchievementIds().split(","));
            return ids.stream().map(
                    id -> {
                        QueryWrapper<TechnologyAchievementEntity> queryWrapper1 = new QueryWrapper<>();
                        queryWrapper1.eq("technology_achievement_id", id);
                        return baseMapper.selectOne(queryWrapper1);
                    }
            ).collect(Collectors.toList());
        } else
            return null;
    }

    /**
     * 根据评估报告id查成果
     *
     * @param techAchEvaluationReportId
     * @return
     */
    @Override
    public TechnologyAchievementEntity findByReportId(Long techAchEvaluationReportId) {
        QueryWrapper<TechAchEvaluationReport> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("tech_ach_evaluation_report_id", techAchEvaluationReportId);
        TechAchEvaluationReport techAchEvaluationReport = techAchEvaluationReportMapper.selectOne(queryWrapper);
        if (techAchEvaluationReport != null && techAchEvaluationReport.getTechnologyAchievementId() != null) {
            QueryWrapper<TechnologyAchievementEntity> queryWrapper1 = new QueryWrapper<>();
            queryWrapper1.eq("technology_achievement_id", techAchEvaluationReport.getTechnologyAchievementId());
            return baseMapper.selectOne(queryWrapper1);
        } else
            return null;
    }
}