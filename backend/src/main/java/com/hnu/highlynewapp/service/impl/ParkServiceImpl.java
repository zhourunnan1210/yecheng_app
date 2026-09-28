package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.hnu.highlynewapp.dao.ParkDao;
import com.hnu.highlynewapp.entity.LoanDeadlineIndexEntity;
import com.hnu.highlynewapp.entity.ParkEntity;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.service.ParkService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author astupidcoder
 * @since 2021-01-24
 */
@Service("ParkService")
public class ParkServiceImpl extends ServiceImpl<ParkDao, ParkEntity> implements ParkService {
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<ParkEntity> page = this.page(
                new Query<ParkEntity>().getPage(params),
                new QueryWrapper<ParkEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public List<ParkEntity> getLastTwo() {
        return baseMapper.selectList(new QueryWrapper<ParkEntity>().orderByDesc("park_id").last("limit 0,2"));
    }
}
