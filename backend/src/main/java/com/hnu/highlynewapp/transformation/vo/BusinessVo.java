package com.hnu.highlynewapp.transformation.vo;

import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class BusinessVo {
    @NotBlank(message = "公司名称不能为空")
    private String name;

    @NotBlank(message = "统一社会信用代码不能为空")
    private String code;
}
