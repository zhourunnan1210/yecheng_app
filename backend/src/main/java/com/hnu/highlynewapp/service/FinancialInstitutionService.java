package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.entity.FinancialInstitutionEntity;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.vo.PublishFinancialInstitutionVo;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * @author LengKuBaiCai
 * @Date
 */
public interface FinancialInstitutionService extends IService<FinancialInstitutionEntity> {
    PageUtils queryPage(Map<String, Object> params);

    int request(PublishFinancialInstitutionVo publishFinancialInstitutionVo);

    //int request(PublishFinancialInstitutionVo publishFinancialInstitutionVo, MultipartFile financialInstitutionImage);

    Map<String, String> request(PublishFinancialInstitutionVo publishFinancialInstitutionVo, MultipartFile multipartFile, String callbackUrl);

    List<FinancialInstitutionEntity> getListById(long financial_institution_id);

    List<FinancialInstitutionEntity> getByFinancialInstitutionName(String financial_institution_name);

    int updateFinancialInstitution(FinancialInstitutionEntity financialInstitutionEntity);

    String getResultByFinancialInstitutionId(long financial_institution_id);

    List<FinancialInstitutionEntity> getCreditMaterialsByFinancialInstitutionName(String financial_institution_name);
}
