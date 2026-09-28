package com.hnu.highlynewapp.app;

import com.hnu.highlynewapp.entity.BusinessInfoEntity;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.service.BusinessInfoService;
import com.hnu.highlynewapp.utils.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 企业信息
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:57
 */
@Api(tags = "角色api管理")
@RestController
@RequestMapping("/businessInfo")
public class BusinessInfoController {
    @Autowired
    private BusinessInfoService businessInfoService;

    /**
     * 获取所有高新企业
     *
     * @return
     */
    @ApiOperation("获取所有高新企业")
    @GetMapping("/getList")
    public R getList() {
        List<BusinessInfoEntity> list = businessInfoService.list();
        return R.ok().put("data", list);
    }

    /**
     * 根据id获取高新企业
     *
     * @return
     */
    @ApiOperation("根据id获取高新企业")
    @GetMapping("/get/{businessInfoId}")
    public R getById(@PathVariable("businessInfoId") Long businessInfoId) {
        BusinessInfoEntity businessInfoEntity = businessInfoService.getById(businessInfoId);
        if (businessInfoEntity == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        return R.ok().put("data", businessInfoEntity);
    }

    /**
     * 根据用户ID获取企业信息
     *
     * @param userId 用户ID
     * @return 企业信息
     */
    @ApiOperation("根据用户ID获取企业信息")
    @GetMapping("/getByUserId/{userId}")
    public R getByUserId(@PathVariable("userId") Long userId) {
        System.out.println("查询用户ID: " + userId + " 的企业信息");
        BusinessInfoEntity businessInfoEntity = businessInfoService.getByUserId(userId);
        System.out.println("查询结果: " + (businessInfoEntity != null ? 
            "找到企业ID: " + businessInfoEntity.getBusinessId() : "未找到企业信息"));
        
        if (businessInfoEntity == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), "该用户没有企业信息");
        }
        return R.ok().put("data", businessInfoEntity);
    }
    
    @ApiOperation("检查用户企业审核状态")
    @GetMapping("/checkStatus/{userId}")
    public R checkUserBusinessStatus(@PathVariable("userId") Long userId) {
        System.out.println("检查用户ID: " + userId + " 的企业审核状态");
        BusinessInfoEntity businessInfoEntity = businessInfoService.getByUserIdWithoutStatusFilter(userId);
        
        if (businessInfoEntity == null) {
            return R.error(404, "该用户没有企业信息");
        }
        
        // 返回企业状态信息
        Map<String, Object> statusInfo = new HashMap<>();
        statusInfo.put("businessId", businessInfoEntity.getBusinessId());
        statusInfo.put("businessName", businessInfoEntity.getName());
        statusInfo.put("status", businessInfoEntity.getStatus());
        
        String statusMsg;
        switch (businessInfoEntity.getStatus()) {
            case 0:
                statusMsg = "等待审核";
                break;
            case 1:
                statusMsg = "正在审核";
                break;
            case 2:
                statusMsg = "审核通过";
                break;
            case 3:
                statusMsg = "审核失败";
                break;
            default:
                statusMsg = "未知状态";
        }
        statusInfo.put("statusMsg", statusMsg);
        
        System.out.println("企业状态: " + businessInfoEntity.getStatus() + " (" + statusMsg + ")");
        return R.ok().put("data", statusInfo);
    }
}
