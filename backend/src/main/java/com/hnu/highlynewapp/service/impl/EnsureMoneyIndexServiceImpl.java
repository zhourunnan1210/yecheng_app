package com.hnu.highlynewapp.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;

import com.hnu.highlynewapp.dao.EnsureMoneyIndexDao;
import com.hnu.highlynewapp.entity.EnsureMoneyIndexEntity;
import com.hnu.highlynewapp.service.EnsureMoneyIndexService;


@Service("ensureMoneyIndexService")
public class EnsureMoneyIndexServiceImpl extends ServiceImpl<EnsureMoneyIndexDao, EnsureMoneyIndexEntity> implements EnsureMoneyIndexService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<EnsureMoneyIndexEntity> page = this.page(
                new Query<EnsureMoneyIndexEntity>().getPage(params),
                new QueryWrapper<EnsureMoneyIndexEntity>()
        );

        return new PageUtils(page);
    }

}