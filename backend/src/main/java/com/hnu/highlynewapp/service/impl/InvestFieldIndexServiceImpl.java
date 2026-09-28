package com.hnu.highlynewapp.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;

import com.hnu.highlynewapp.dao.InvestFieldIndexDao;
import com.hnu.highlynewapp.entity.InvestFieldIndexEntity;
import com.hnu.highlynewapp.service.InvestFieldIndexService;


@Service("investFieldIndexService")
public class InvestFieldIndexServiceImpl extends ServiceImpl<InvestFieldIndexDao, InvestFieldIndexEntity> implements InvestFieldIndexService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<InvestFieldIndexEntity> page = this.page(
                new Query<InvestFieldIndexEntity>().getPage(params),
                new QueryWrapper<InvestFieldIndexEntity>()
        );

        return new PageUtils(page);
    }

}