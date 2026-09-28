package com.hnu.highlynewapp.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;

import com.hnu.highlynewapp.dao.InvestMoneyIndexDao;
import com.hnu.highlynewapp.entity.InvestMoneyIndexEntity;
import com.hnu.highlynewapp.service.InvestMoneyIndexService;


@Service("investMoneyIndexService")
public class InvestMoneyIndexServiceImpl extends ServiceImpl<InvestMoneyIndexDao, InvestMoneyIndexEntity> implements InvestMoneyIndexService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<InvestMoneyIndexEntity> page = this.page(
                new Query<InvestMoneyIndexEntity>().getPage(params),
                new QueryWrapper<InvestMoneyIndexEntity>()
        );

        return new PageUtils(page);
    }

}