package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("高校审核")
public class SchoolCheckVo {
    @ApiModelProperty(value = "审核Id:已审核:1;未审核:2,required = true")
    private Integer checkId;
}
