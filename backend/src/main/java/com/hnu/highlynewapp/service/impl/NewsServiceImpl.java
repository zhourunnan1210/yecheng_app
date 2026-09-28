package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.dao.NewsDao;
import com.hnu.highlynewapp.entity.NewsEntity;
import com.hnu.highlynewapp.entity.ParkEntity;
import com.hnu.highlynewapp.entity.PolicyEntity;
import com.hnu.highlynewapp.entity.TechnologyAchievementEntity;
import com.hnu.highlynewapp.service.NewsService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;

/**
 * @author zhourunnan
 * @Date 2022/1/1 1:37
 */
@Service
public class NewsServiceImpl extends ServiceImpl<NewsDao, NewsEntity> implements NewsService {
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<NewsEntity> page = this.page(
                new Query<NewsEntity>().getPage(params),
                new QueryWrapper<NewsEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public List<NewsEntity> getLastTwo() {
        return baseMapper.selectList(new QueryWrapper<NewsEntity>().orderByDesc("id").last("limit 0,2"));

    }

    @Override
    public List<NewsEntity> search(String keyword) {
        QueryWrapper<NewsEntity> queryWrapper = new QueryWrapper<>();
        if (StringUtils.hasText(keyword)) {
            queryWrapper.like("title", keyword);
        }
        return baseMapper.selectList(queryWrapper);
    }
}
