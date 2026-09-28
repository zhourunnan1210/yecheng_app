package com.hnu.highlynewapp.transformation.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

@ApiModel("根据企业信息获取企业技术需求")
@Data
public class BusinessNeedVo {
    /**
     * 名称
     */
    @ApiModelProperty(required = true, value = "名称")
    @NotBlank(message = "企业名称不能为空")
    private String name;

    /**
     * 统一社会信用代码
     */
    @ApiModelProperty(required = true, value = "统一社会信用代码")
    @NotBlank(message = "统一社会信用代码不能为空")
    private String code;
}
