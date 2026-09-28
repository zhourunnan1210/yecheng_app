package com.hnu.highlynewapp.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;

import com.hnu.highlynewapp.dao.ServiceTypeIndexDao;
import com.hnu.highlynewapp.entity.ServiceTypeIndexEntity;
import com.hnu.highlynewapp.service.ServiceTypeIndexService;


@Service("serviceTypeIndexService")
public class ServiceTypeIndexServiceImpl extends ServiceImpl<ServiceTypeIndexDao, ServiceTypeIndexEntity> implements ServiceTypeIndexService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<ServiceTypeIndexEntity> page = this.page(
                new Query<ServiceTypeIndexEntity>().getPage(params),
                new QueryWrapper<ServiceTypeIndexEntity>()
        );

        return new PageUtils(page);
    }

}