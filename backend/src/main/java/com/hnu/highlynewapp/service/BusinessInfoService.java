package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.transformation.vo.BusinessNeedVo;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.entity.BusinessInfoEntity;
import com.hnu.highlynewapp.vo.BusinessInfoVo;

import java.util.List;
import java.util.Map;

/**
 * 企业信息
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:57
 */
public interface BusinessInfoService extends IService<BusinessInfoEntity> {
    PageUtils queryPage(Map<String, Object> params);

    List<BusinessInfoEntity> getNoCheckList();

    void passCheck(Long businessId);

    void auth(BusinessInfoVo businessInfoVo);

    void failCheck(Long businessId);

    BusinessInfoEntity getBusinessDetail(BusinessNeedVo vo);

    Long saveAndCheckExist(BusinessInfoEntity businessInfoEntity);

    BusinessInfoEntity getByBusinessId(Long businessId);
    
    BusinessInfoEntity getByUserId(Long userId);
    
    /**
     * 根据用户ID获取企业信息（不限制状态，用于检查企业审核状态）
     *
     * @param userId 用户ID
     * @return 企业信息
     */
    BusinessInfoEntity getByUserIdWithoutStatusFilter(Long userId);
}
