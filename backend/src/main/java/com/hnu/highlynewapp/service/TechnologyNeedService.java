package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.transformation.vo.BusinessNeedVo;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.entity.TechnologyNeedEntity;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.vo.PublishTechNeedVo;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 技术需求
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
public interface TechnologyNeedService extends IService<TechnologyNeedEntity> {
    PageUtils queryPage(Map<String, Object> params);

    void publish(PublishTechNeedVo vo);

    List<TechnologyNeedEntity> listByCondition(String duration, String field);

    List<TechnologyNeedEntity> listByBusinessID(long businessID);

    List<TechnologyNeedEntity> search(String keyword);

    int deleteTechnologyNeed(Long[] technologyNeedIds);

    int updateTechnologyNeed(PublishTechNeedVo vo);

    R listAllTechnologyNeed(Integer pageNo, Integer pageSize);

    List<String> getNeedTitle(BusinessNeedVo vo);

    TechnologyNeedEntity getNeedDetail(BusinessNeedVo vo, String title);

    void businessNeedMap(BusinessNeedVo vo, String title);

    Set<String> getFieldsList();
}

