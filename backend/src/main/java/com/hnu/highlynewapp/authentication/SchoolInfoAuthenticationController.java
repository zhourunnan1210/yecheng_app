package com.hnu.highlynewapp.authentication;

import com.hnu.highlynewapp.entity.ContactEntity;
import com.hnu.highlynewapp.entity.SchoolInfoEntity;
import com.hnu.highlynewapp.enums.StatusEnum;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.service.ContactService;
import com.hnu.highlynewapp.service.SchoolInfoService;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.vo.SchoolInfoVo;
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

@Api("学校认证api")
@RestController
@RequestMapping("/schoolinfoauthentication")
public class SchoolInfoAuthenticationController {
    @Autowired
    private SchoolInfoService schoolInfoService;
    @Autowired
    private ContactService contactService;
    @ApiOperation("保存学校认证信息")
    @PostMapping(value = "/save")
    //@RequiresPermissions("highlynewapp:schoolinfo:save")
    public R save(@Validated @RequestBody SchoolInfoVo schoolInfoVo, BindingResult result) {
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
            schoolInfoService.auth(schoolInfoVo);

            return R.ok();
        }
    }
    @ApiOperation("显示所有还未认证的学校信息")
    @PostMapping(value="/nocheck")
    public R nocheck()
    {
        List<SchoolInfoEntity> schoolInfoEntityList=schoolInfoService.getNoCheckList();

        List<SchoolInfoVo> schoolInfoVoList = new ArrayList<SchoolInfoVo>() {//这个大括号 就相当于我们  new 接口
            {//这个大括号 就是 构造代码块 会在构造函数前 调用


                int i;

                for(i=0;i<schoolInfoEntityList.size();i++)
                {
                    SchoolInfoVo schoolInfoVo=new SchoolInfoVo();
                    ContactEntity contactEntity=contactService.getById(schoolInfoEntityList.get(i).getContactId());
                    System.out.println(contactEntity);
                    BeanUtils.copyProperties(schoolInfoEntityList.get(i),schoolInfoVo);

                    schoolInfoVo.setContactAddress(contactEntity.getAddress());
                    schoolInfoVo.setContactEmail(contactEntity.getEmail());
                    schoolInfoVo.setContactName(contactEntity.getName());

                    schoolInfoVo.setContactPhone(contactEntity.getPhone());
                    schoolInfoVo.setContactPosition(contactEntity.getPosition());
                    add(schoolInfoVo);
                }

            }
        };
        return R.ok().put("data",schoolInfoVoList);
    }
    @ApiOperation("通过schoolId来通过认证")
    @PostMapping("/passcheck/{schoolId}")
    public R passcheck(@PathVariable("schoolId") Long schoolId)
    {
        schoolInfoService.passCheck(schoolId);

        return R.ok();
    }
    @ApiOperation("通过schoolId来拒绝通过认证")
    @PostMapping("/failcheck/{schoolId}")
    public R failcheck(@PathVariable("schoolId") Long schoolId)
    {
        schoolInfoService.failCheck(schoolId);

        return R.ok();
    }
}
