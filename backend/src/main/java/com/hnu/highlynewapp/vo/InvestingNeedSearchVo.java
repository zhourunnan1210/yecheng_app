package com.hnu.highlynewapp.vo;

import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 *
 * @author LengKuBaiCai
 * @Date
 */

@Data
@ApiModel("检索投资需求列表")
public class InvestingNeedSearchVo {
    @TableId
    @ApiModelProperty("投资需求id")
    private long id;

    @ApiModelProperty("投资公司id")
    private long eId;

    @ApiModelProperty("行业领域")
    private String industryField;

    @ApiModelProperty("投资方式")
    private String investWay;

    @ApiModelProperty("投资类型")
    private String investType;

    @ApiModelProperty("投资金额")
    private String investingMoney;

    @ApiModelProperty("联系人姓名")
    private String contactName;

    @ApiModelProperty("联系电话")
    private String contactPhone;

    @ApiModelProperty("发布时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
    private java.sql.Date releaseTime;

    @ApiModelProperty("阅读量")
    private long reading;

    @ApiModelProperty("投资意向")
    private String projProposal;

    @ApiModelProperty("投资状态（0-成功，1-进行中）")
    private long successFlag;

    @ApiModelProperty("投资意向审核结果（0-正在审核中，1-通过，2-不通过）")
    private long auditFlag;

    @ApiModelProperty("阅读量")
    private String investDescription;

    @ApiModelProperty("公司介绍")
    private String companyIntroduction;

    @ApiModelProperty("成功案例")
    private String successCase;

    @ApiModelProperty("公司名字")
    private String companyName;

    @ApiModelProperty("投资需求图片")
    private String investImag;
}
