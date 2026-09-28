package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("根据时间和学历领域检索")
public class DurationEducationVo {
    @ApiModelProperty(value = "发布时间: 选择框:全部、一个月内、三个月内、六个月内、一年内",required = true)
    private String duration;
    @ApiModelProperty(value = "学历: 选择框:博士、硕士、本科、专科",required = true)
    private String Education;
}
