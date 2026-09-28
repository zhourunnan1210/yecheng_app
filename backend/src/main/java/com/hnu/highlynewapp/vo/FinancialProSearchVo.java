package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author zhourunnan
 * @Date 2021/1/8
 */
@Data
@ApiModel("检索金融产品参数，不填默认获取全部")
public class FinancialProSearchVo {
    @ApiModelProperty("担保方式")
    private String ensureMethod;
    @ApiModelProperty("投资期限")
    private String loanDeadline;
    @ApiModelProperty("投资金额")
    private String loanMoney;
    @ApiModelProperty("贷款类型")
    private String loanType;

}
