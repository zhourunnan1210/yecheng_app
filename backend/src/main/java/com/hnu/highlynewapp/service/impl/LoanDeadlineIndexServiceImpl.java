package com.hnu.highlynewapp.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;

import com.hnu.highlynewapp.dao.LoanDeadlineIndexDao;
import com.hnu.highlynewapp.entity.LoanDeadlineIndexEntity;
import com.hnu.highlynewapp.service.LoanDeadlineIndexService;


@Service("loanDeadlineIndexService")
public class LoanDeadlineIndexServiceImpl extends ServiceImpl<LoanDeadlineIndexDao, LoanDeadlineIndexEntity> implements LoanDeadlineIndexService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<LoanDeadlineIndexEntity> page = this.page(
                new Query<LoanDeadlineIndexEntity>().getPage(params),
                new QueryWrapper<LoanDeadlineIndexEntity>()
        );

        return new PageUtils(page);
    }

}