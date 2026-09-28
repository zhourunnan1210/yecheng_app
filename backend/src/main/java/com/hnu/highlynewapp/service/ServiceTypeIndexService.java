package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.entity.ServiceTypeIndexEntity;

import java.util.Map;

/**
 * 服务类型检索
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-04 22:01:47
 */
public interface ServiceTypeIndexService extends IService<ServiceTypeIndexEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

