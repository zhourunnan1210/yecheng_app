package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.entity.NewsEntity;
import com.hnu.highlynewapp.entity.TechnologyAchievementEntity;
import com.hnu.highlynewapp.utils.PageUtils;

import java.util.List;
import java.util.Map;

/**
 * @author zhourunnan
 * @Date 2022/1/1 1:36
 */
public interface NewsService extends IService<NewsEntity> {
    PageUtils queryPage(Map<String, Object> params);

    List<NewsEntity> getLastTwo();
    List<NewsEntity> search(String keyword);
}
