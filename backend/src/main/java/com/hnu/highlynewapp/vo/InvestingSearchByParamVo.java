package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("根据条件搜索投资需求")
public class InvestingSearchByParamVo {

    @ApiModelProperty("投资类型")
    private String investType;

    @ApiModelProperty("投资金额")
    private String investingMoney;

    @ApiModelProperty("行业领域")
    private String industryField;
}
