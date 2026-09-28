package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author tianzhuo
 * @Date 2022/6/7
 */
@Data
@ApiModel("检索融资需求列表，不填默认获取全部")
public class FinancialNeedSearchVo {

    @ApiModelProperty("发布时间")
    private String duration;

    @ApiModelProperty("行业领域")
    private String field;

    @ApiModelProperty("融资金额")
    private String financingMoney;

}
