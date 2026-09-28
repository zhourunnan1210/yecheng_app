package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;


import java.io.Serializable;

@ApiModel("登录成功返回信息")
@Data
public class UserVo implements Serializable {
    @ApiModelProperty("用户ID")
    private long uid;

    @ApiModelProperty("使用uuid生成的token")
    private String token;

    @ApiModelProperty("此用户认证的类型 [0：未认定用户，1：高新企业，2：科技主管部门，3：学校，4：金融机构，5：服务机构]")
    private Integer type;

    @ApiModelProperty("手机号")
    private String phone;

    @ApiModelProperty("邮箱")
    private String email;
}
