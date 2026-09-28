package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.entity.InvestFieldIndexEntity;

import java.util.Map;

/**
 * 投资领域检索
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-04 22:01:47
 */
public interface InvestFieldIndexService extends IService<InvestFieldIndexEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

