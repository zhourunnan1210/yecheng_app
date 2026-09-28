package com.hnu.highlynewapp.transformation.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.transformation.mapper.TechnologyProductMapper;
import com.hnu.highlynewapp.transformation.enums.MaturityEnum;
import com.hnu.highlynewapp.transformation.pojo.TechnologyProductEntity;
import com.hnu.highlynewapp.transformation.service.TechnologyProductService;
import com.hnu.highlynewapp.transformation.vo.TechProductQueryVo;
import com.hnu.highlynewapp.utils.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Arrays;
import java.util.List;

@Service
public class TechnologyProductServiceImpl extends ServiceImpl<TechnologyProductMapper, TechnologyProductEntity> implements TechnologyProductService {

    @Autowired
    TechnologyProductMapper technologyProductMapper;


    /**
     * 根据开始时间、研发进度、行业领域查询科技产品
     */
    @Override
    public List<TechnologyProductEntity> listByConditions(TechProductQueryVo vo) {
        QueryWrapper<TechnologyProductEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("start_time");
        // 时间
        if (StringUtils.hasText(vo.getDuration()) && !"全部".equals(vo.getDuration())) {
            queryWrapper.ge("start_time", DateUtil.getStartDateByTimeIndex(vo.getDuration()));
        }
        // 研发进度
        if (StringUtils.hasText(vo.getProgress()) && !"全部".equals(vo.getProgress())) {
            queryWrapper.eq("progress", MaturityEnum.findCodeByMsg(vo.getProgress()));
        }
        // 行业领域
        if (StringUtils.hasText(vo.getField()) && !"全部".equals(vo.getField())) {
            List<String> fieldList = Arrays.asList(vo.getField().split(","));
            if (fieldList.size() == 1) {
                queryWrapper.apply(fieldList.get(0) != null, "FIND_IN_SET ('" + fieldList.get(0) + "', field)");
            }
        }
        return technologyProductMapper.selectList(queryWrapper);
    }



    /**
     * 根据产品id查询
     */
    @Override
    public TechnologyProductEntity listByProductId(Long technologyProductId) {
        if (technologyProductId == null) {
            return null;
        }
        QueryWrapper<TechnologyProductEntity> queryWrapper = new QueryWrapper<>();
        return technologyProductMapper.selectById(technologyProductId);
    }

}
