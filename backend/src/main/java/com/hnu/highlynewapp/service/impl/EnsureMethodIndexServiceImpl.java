package com.hnu.highlynewapp.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;

import com.hnu.highlynewapp.dao.EnsureMethodIndexDao;
import com.hnu.highlynewapp.entity.EnsureMethodIndexEntity;
import com.hnu.highlynewapp.service.EnsureMethodIndexService;


@Service("ensureMethodIndexService")
public class EnsureMethodIndexServiceImpl extends ServiceImpl<EnsureMethodIndexDao, EnsureMethodIndexEntity> implements EnsureMethodIndexService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<EnsureMethodIndexEntity> page = this.page(
                new Query<EnsureMethodIndexEntity>().getPage(params),
                new QueryWrapper<EnsureMethodIndexEntity>()
        );

        return new PageUtils(page);
    }

}