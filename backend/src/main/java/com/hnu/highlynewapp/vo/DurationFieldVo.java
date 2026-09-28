package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("根据时间以及行业领域检索")
@Data
public class DurationFieldVo {
    @ApiModelProperty(required = true, value = "发布时间（选择框）：全部、一个月内、三个月内、六个月内、一年内")
    private String duration;

    @ApiModelProperty(required = true, value = "行业领域（选择框）：领域暂定")
    private String field;
}
