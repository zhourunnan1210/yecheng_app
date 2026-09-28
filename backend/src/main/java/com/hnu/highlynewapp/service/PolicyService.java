package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.entity.NewsEntity;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.entity.PolicyEntity;
import com.hnu.highlynewapp.vo.PublishPolicyVo;

import java.util.List;
import java.util.Map;

/**
 * 政策
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
public interface PolicyService extends IService<PolicyEntity> {

    PageUtils queryPage(Map<String, Object> params);

    List<PolicyEntity> listByCondition(String category);

    /**
     * 保存政策
     * @param vo
     */
    void savePolicy(PublishPolicyVo vo);

    List<PolicyEntity> listByCategory(String category);
    List<PolicyEntity> search(String keyword);
}

