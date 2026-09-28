package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.entity.InvestFinancialProjectEntity;
import com.hnu.highlynewapp.utils.PageUtils;

import java.util.List;
import java.util.Map;

/**
 *
 * @author Tz
 * @Date 2022/08/11
 */

public interface InvestFinancialProjectService extends IService<InvestFinancialProjectEntity> {
    PageUtils queryPage(Map<String, Object> params);

    //getListByParma
    List<InvestFinancialProjectEntity> getListByParma();

    void publish(InvestFinancialProjectEntity investFinancialProjectEntity);

    //根据项目名称或备案号查询
    List<InvestFinancialProjectEntity> getListByNameOrRecordNum(String param);

    List<InvestFinancialProjectEntity> getProgressDescriptionByProjectName(String projectName);

    List<InvestFinancialProjectEntity> getSuccessList1();

    List<InvestFinancialProjectEntity> getSuccessList2();
    List<InvestFinancialProjectEntity> getSuccessList3();
    List<InvestFinancialProjectEntity> getSuccessList4();

    List<InvestFinancialProjectEntity> getBySimpleProjectName(String projectName);

}
