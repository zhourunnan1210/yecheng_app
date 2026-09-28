package com.hnu.highlynewapp.transformation.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class TechProductQueryVo {
    @ApiModelProperty("开始时间")
    private String duration;

    @ApiModelProperty("技术领域")
    private String field;

    @ApiModelProperty("研发进度（暂时同成熟度）")
    private String progress;
}
