package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("用户注册信息")
public class RegisterVo {
    @ApiModelProperty(value = "手机号",required = true)
    private String phone;
    @ApiModelProperty(value = "密码",required = true)
    private String password;
    @ApiModelProperty(value = "确认密码",required = true)
    private String confirmedPassword;
}
