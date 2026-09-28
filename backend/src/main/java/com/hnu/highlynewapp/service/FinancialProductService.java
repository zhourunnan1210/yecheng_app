package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.entity.FinancialProductEntity;
import com.hnu.highlynewapp.vo.FinancialProSearchVo;
import com.hnu.highlynewapp.vo.PublishFinancialProductVo;

import java.util.List;
import java.util.Map;

/**
 * 金融产品
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
public interface FinancialProductService extends IService<FinancialProductEntity> {

    PageUtils queryPage(Map<String, Object> params);

    void publish(PublishFinancialProductVo vo);

    List<FinancialProductEntity> getListByParma(FinancialProSearchVo vo);
}

