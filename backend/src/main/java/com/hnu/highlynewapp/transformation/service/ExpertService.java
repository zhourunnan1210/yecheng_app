package com.hnu.highlynewapp.transformation.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.transformation.pojo.Expert;
import com.hnu.highlynewapp.utils.PageUtils;

import java.util.Map;

/**
 * 专家
 */
public interface ExpertService extends IService<Expert> {
    PageUtils queryPage(Map<String, Object> params);

    Expert findOneByExpertId(Long expertId);

    int deleteExpertsByIds(Long[] expertIds);
}
