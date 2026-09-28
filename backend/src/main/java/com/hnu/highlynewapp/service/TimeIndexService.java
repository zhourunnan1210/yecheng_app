package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.entity.TimeIndexEntity;

import java.util.Map;

/**
 * 时间检索
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-04 22:01:46
 */
public interface TimeIndexService extends IService<TimeIndexEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

