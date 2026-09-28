package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.entity.FinancingNeedEntity;
import com.hnu.highlynewapp.vo.FinancialNeedSearchVo;
import com.hnu.highlynewapp.vo.InvestFinanceAuditVo;
import com.hnu.highlynewapp.vo.PublishFinancialNeedVo;

import java.util.List;
import java.util.Map;

/**
 * 融资需求
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
public interface FinancingNeedService extends IService<FinancingNeedEntity> {

    PageUtils queryPage(Map<String, Object> params);

    List<FinancingNeedEntity> listByCondition(String duration, String field);

    void publish(PublishFinancialNeedVo vo);

    List<FinancingNeedEntity> listByBusinessID(long businessID);


    List<FinancingNeedEntity> getListByParma(FinancialNeedSearchVo vo);

    // 审核页面的查询
    List<FinancingNeedEntity> getAuditList(InvestFinanceAuditVo auditVo);

    List<FinancingNeedEntity> getSuccessList();

    List<FinancingNeedEntity> getSuccessList2();

    List<FinancingNeedEntity> getListByTitle(String title);

    //查询所有融资条目
    List<FinancingNeedEntity> getFList();
}

