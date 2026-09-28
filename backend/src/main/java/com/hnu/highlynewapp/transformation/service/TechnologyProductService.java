package com.hnu.highlynewapp.transformation.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.transformation.pojo.TechnologyProductEntity;
import com.hnu.highlynewapp.transformation.vo.TechProductQueryVo;

import java.util.List;

public interface TechnologyProductService extends IService<TechnologyProductEntity> {

    List<TechnologyProductEntity> listByConditions(TechProductQueryVo vo);

    TechnologyProductEntity listByProductId(Long technologyProductId);
}
