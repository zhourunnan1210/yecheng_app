package com.hnu.highlynewapp.transformation.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("根据时间和状态检索")
@Data
public class DurationStatusVo {
    @ApiModelProperty(required = true, value = "发布时间（选择框）：全部、一个月内、三个月内、六个月内、一年内")
    private String duration;

    @ApiModelProperty(required = true, value = "审核状态 [0：未审核，1：正在审核，2：审核通过，3：审核失败]")
    private String applicationStatus;

    @ApiModelProperty(required = true, value = "评估状态 [0：未评估，1：正在评估，2：评估完成]")
    private String evaluationStatus;
}
