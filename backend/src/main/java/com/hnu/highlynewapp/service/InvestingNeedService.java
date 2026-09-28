package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.entity.FinancialInstitutionEntity;
import com.hnu.highlynewapp.entity.InvestFinancialProjectEntity;
import com.hnu.highlynewapp.entity.InvestingNeedEntity;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.vo.InvestFinanceAuditVo;
import com.hnu.highlynewapp.vo.InvestingNeedSearchVo;
import com.hnu.highlynewapp.vo.InvestingSearchByParamVo;

import java.util.List;
import java.util.Map;

/**
 *
 * @author LengKuBaiCai
 * @Date
 */


public interface InvestingNeedService extends IService<InvestingNeedEntity> {

    PageUtils queryPage(Map<String, Object> params);


    //getListByParma
    List<InvestingNeedEntity> getListByParma(InvestingSearchByParamVo vo);

    void publish(InvestingNeedEntity investingNeedEntity);

    List<InvestingNeedEntity> getByFinancialInstitutionId(long financial_institution_id);

    // 审核页面的查询
    List<InvestingNeedEntity> getAuditList(InvestFinanceAuditVo auditVo);

    InvestingNeedEntity getByInvestNeedId(Long investNeedId);

    List<InvestingNeedEntity> getSuccessList();

    List<InvestingNeedEntity> getSuccessList2();

    // 根据名字模糊查询
    List<InvestingNeedEntity> getListByCompanyName(String companyName);

    //查找所有投资项目
    List<InvestingNeedEntity> getList();
}
