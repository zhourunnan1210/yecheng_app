package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.entity.EnsureMoneyIndexEntity;

import java.util.Map;

/**
 * 贷款额度检索
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-04 22:01:47
 */
public interface EnsureMoneyIndexService extends IService<EnsureMoneyIndexEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

