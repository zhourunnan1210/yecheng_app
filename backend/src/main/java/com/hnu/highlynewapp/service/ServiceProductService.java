package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.entity.ServiceProductEntity;
import com.hnu.highlynewapp.vo.PublishServiceProductVo;

import java.util.List;
import java.util.Map;

/**
 * 服务产品
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
public interface ServiceProductService extends IService<ServiceProductEntity> {

    PageUtils queryPage(Map<String, Object> params);

    void publish(PublishServiceProductVo vo);

    List<ServiceProductEntity> getListByParma(String serviceType);
}

