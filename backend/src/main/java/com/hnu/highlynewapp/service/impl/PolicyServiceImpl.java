package com.hnu.highlynewapp.service.impl;

import com.google.common.collect.Lists;
import com.hnu.highlynewapp.entity.NewsEntity;
import com.hnu.highlynewapp.service.IndexService;
import com.hnu.highlynewapp.utils.Constant;
import com.hnu.highlynewapp.vo.PublishPolicyVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;

import com.hnu.highlynewapp.dao.PolicyDao;
import com.hnu.highlynewapp.entity.PolicyEntity;
import com.hnu.highlynewapp.service.PolicyService;
import org.springframework.util.StringUtils;


@Service("policyService")
public class PolicyServiceImpl extends ServiceImpl<PolicyDao, PolicyEntity> implements PolicyService {

    @Autowired
    private IndexService indexService;

    public static final String LIST_NAME_POLICY_CATEGORY = "政策分类";

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<PolicyEntity> page = this.page(
                new Query<PolicyEntity>().getPage(params),
                new QueryWrapper<PolicyEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public List<PolicyEntity> listByCondition(String category) {
        QueryWrapper<PolicyEntity> wrapper = new QueryWrapper<>();
        if (!StringUtils.isEmpty(category)) {
            wrapper.eq("category", category);
        }
        wrapper.orderByDesc("publish_time");
        List<PolicyEntity> policyEntities = baseMapper.selectList(wrapper);
        return policyEntities;
    }

    @Override
    public void savePolicy(PublishPolicyVo vo) {
        PolicyEntity policyEntity = new PolicyEntity();
        BeanUtils.copyProperties(vo,policyEntity);
        policyEntity.setGmtCreate(new Date());
        policyEntity.setPublishTime(policyEntity.getGmtCreate());
        policyEntity.setGmtModified(policyEntity.getGmtCreate());
        save(policyEntity);
    }

    @Override
    public List<PolicyEntity> listByCategory(String category) {
        List<String> categories = Lists.newArrayList();
        if (Constant.ALL.equals(category)) {
            categories = indexService.getKeysByListName(LIST_NAME_POLICY_CATEGORY);
        } else {
            categories.add(category);
        }
        QueryWrapper<PolicyEntity> wrapper = new QueryWrapper<>();
        wrapper.in("category", categories);
        wrapper.orderByDesc("publish_time");
        List<PolicyEntity> policyEntities = baseMapper.selectList(wrapper);
        return policyEntities;
    }

    @Override
    public List<PolicyEntity> search(String keyword) {
        QueryWrapper<PolicyEntity> queryWrapper = new QueryWrapper<>();
        if (StringUtils.hasText(keyword)) {
            queryWrapper.eq("category", "项目申报政策").like("title", keyword);
        }
        return baseMapper.selectList(queryWrapper);
    }


}