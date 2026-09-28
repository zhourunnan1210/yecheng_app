package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author zhourunnan
 * @Date 2021/1/7
 */
@ApiModel("检索金融机构参数，不填默认获取全部")
@Data
public class FinancialInstitutionSearchVo {
    @ApiModelProperty("投资领域")
    private String investField;

    @ApiModelProperty("投资金额")
    private String investMoney;
}
