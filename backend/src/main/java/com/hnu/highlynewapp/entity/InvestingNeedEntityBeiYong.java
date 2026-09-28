package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author LengKuBaiCai
 * @Date
 */
@Data
@TableName("investing_need")
@ApiModel("投资需求")
public class InvestingNeedEntityBeiYong implements Serializable{

        private static final long serialVersionUID = 1L;
        /**
         * id
         */
        @TableId
        @ApiModelProperty("投资需求id")
        private Integer id;
        /**
         * 投资公司id，外键：企业信息表
         */
        @ApiModelProperty("投资公司id，企业信息表")
        private Integer eId;
        /**
         * 行业领域，行业领域表
         */
        @ApiModelProperty("行业领域，行业领域表")
        private String industryField;
        /**
         * 投资方式
         */
        @ApiModelProperty("投资方式")
        private String way;
        /**
         * 投资类型
         */
        @ApiModelProperty("投资类型")
        private String investType;
        /**
         * 投资金额
         */
        @ApiModelProperty("投资金额")
        private String investingMoney;
        /**
         * 联系人姓名
         */
        @ApiModelProperty("联系人姓名")
        private String contactName;
        /**
         * 联系方式
         */
        @ApiModelProperty("联系方式")
        private String contactPhone;
        /**
         * 发布时间
         */
        @ApiModelProperty("发布时间")
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
        private Date releaseTime;
        /**
         * 阅读量
         */
        @ApiModelProperty("阅读量")
        private Integer reading;
        /**
         * 投资意向
         */
        @ApiModelProperty("投资意向")
        private String projProposal;
        /**
         * 投资状态（0-成功，1-进行中）
         */
        @ApiModelProperty("投资状态（0-成功，1-进行中）")
        private Integer successFlag;
        /**
         * 投资意向审核结果（0-正在审核中，1-通过，2-不通过）
         */
        @ApiModelProperty("投资意向审核结果（0-正在审核中，1-通过，2-不通过）")
        private Integer auditFlag;
        /**
         * 投资说明
         */
        @ApiModelProperty("投资说明")
        private String investDescription;
        /**
         * 公司介绍
         */
        @ApiModelProperty("公司介绍")
        private String company_introduction;
        /**
         * 成功案例
         */
        @ApiModelProperty("成功案例")
        private String successCase;

}
