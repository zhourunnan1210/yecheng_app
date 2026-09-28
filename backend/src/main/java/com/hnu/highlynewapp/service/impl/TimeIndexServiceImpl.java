package com.hnu.highlynewapp.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;

import com.hnu.highlynewapp.dao.TimeIndexDao;
import com.hnu.highlynewapp.entity.TimeIndexEntity;
import com.hnu.highlynewapp.service.TimeIndexService;


@Service("timeIndexService")
public class TimeIndexServiceImpl extends ServiceImpl<TimeIndexDao, TimeIndexEntity> implements TimeIndexService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<TimeIndexEntity> page = this.page(
                new Query<TimeIndexEntity>().getPage(params),
                new QueryWrapper<TimeIndexEntity>()
        );

        return new PageUtils(page);
    }

}