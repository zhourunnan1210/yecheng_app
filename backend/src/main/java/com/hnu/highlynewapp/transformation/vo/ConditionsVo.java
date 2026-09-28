package com.hnu.highlynewapp.transformation.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("根据时间、行业领域以及成果水平和成熟度检索")
@Data
public class ConditionsVo {
    @ApiModelProperty(required = true, value = "发布时间（选择框）：全部、一个月内、三个月内、六个月内、一年内")
    private String duration;

    @ApiModelProperty(required = true, value = "行业领域（选择框）：领域暂定")
    private String field;

    @ApiModelProperty(required = true, value = "成果水平 [1：国际领先，2：国际先进，3：国内领先，4：国内先进，5：国内一般，6：未评价]")
    private String level;

    @ApiModelProperty(required = true, value = "成熟度 [1：正在研发，2：已有样品，3：通过小试，4：通过中试，5：可以量产]")
    private String maturity;
}
