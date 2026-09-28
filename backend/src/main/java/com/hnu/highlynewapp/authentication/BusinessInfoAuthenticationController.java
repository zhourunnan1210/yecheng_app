package com.hnu.highlynewapp.authentication;

import com.hnu.highlynewapp.entity.BusinessInfoEntity;
import com.hnu.highlynewapp.entity.ContactEntity;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.service.BusinessInfoService;
import com.hnu.highlynewapp.service.ContactService;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.vo.BusinessInfoVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Api("高新技术企业认证api")
@RestController
@RequestMapping("/businessinfoauthentication")
public class BusinessInfoAuthenticationController {
    @Autowired
    BusinessInfoService businessInfoService;
    @Autowired
    ContactService contactService;

    @ApiOperation("保存高新技术企业认证信息")
    @PostMapping(value = "/save")
    //@RequiresPermissions("highlynewapp:businessinfo:save")
    public R save(@Validated  @RequestBody BusinessInfoVo businessInfoVo, BindingResult result) {
        Map<String, String> map = new HashMap<>();

        if (result.hasErrors()) {
            //获取效验错误结果
            result.getFieldErrors().forEach((item) -> {
                //获取到错误提示
                String message = item.getDefaultMessage();
                //获取错误的属性的名字
                String field = item.getField();
                map.put(field, message);
            });
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data", map);
        } else {
            businessInfoService.auth(businessInfoVo);

            return R.ok();
        }
    }
    @ApiOperation("返回所有未认证的高新技术企业信息")
    @PostMapping(value="/nocheck")
    public R nocheck()
    {
        List<BusinessInfoEntity> businessInfoEntityList=businessInfoService.getNoCheckList();

        List<BusinessInfoVo> businessInfoVoList = new ArrayList<BusinessInfoVo>() {//这个大括号 就相当于我们  new 接口
            {//这个大括号 就是 构造代码块 会在构造函数前 调用


             int i;

             for(i=0;i<businessInfoEntityList.size();i++)
            {
                BusinessInfoVo businessInfoVo =new BusinessInfoVo();
                    ContactEntity contactEntity=contactService.getById(businessInfoEntityList.get(i).getContactId());
                        System.out.println(contactEntity);
                     BeanUtils.copyProperties(businessInfoEntityList.get(i), businessInfoVo);

                    businessInfoVo.setContactAddress(contactEntity.getAddress());
                     businessInfoVo.setContactEmail(contactEntity.getEmail());
                    businessInfoVo.setContactName(contactEntity.getName());

                     businessInfoVo.setContactPhone(contactEntity.getPhone());
                     businessInfoVo.setContactPosition(contactEntity.getPosition());
                        add(businessInfoVo);
                 }

            }
        };
        return R.ok().put("data", businessInfoVoList);
    }
    @ApiOperation("根据Id通过认证")
    @PostMapping("/passcheck/{businessId}")
    public R passcheck(@PathVariable("businessId") Long businessId)
    {
        businessInfoService.passCheck(businessId);

        return R.ok();
    }
    @ApiOperation("根据Id拒绝通过认证")
    @PostMapping("/failcheck/{businessId}")
    public R failcheck(@PathVariable("businessId") Long businessId)
    {
        businessInfoService.failCheck(businessId);
        return R.ok();
    }
}
