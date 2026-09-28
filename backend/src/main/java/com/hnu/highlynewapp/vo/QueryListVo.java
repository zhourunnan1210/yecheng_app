package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("搜索框")
public class QueryListVo {
    @ApiModelProperty(value = "condition")
    private String condition;
}
