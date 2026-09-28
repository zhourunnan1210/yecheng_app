package com.hnu.highlynewapp.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * @author zhourunnan
 * @Date 2021/1/8
 */

@ApiModel("发布融资需求请求参数")
@Data
public class PublishFinancialNeedVo {

    /**
     * 项目名称
     */
    @ApiModelProperty(value = "项目名称",required = true)
    @NotBlank(message = "项目名称不能为空")
    private String title;
    /**
     * 项目描述
     */
    @ApiModelProperty(value = "项目描述",required = true)
    @NotBlank(message = "项目描述不能为空")
    private String projectDescription;
    /**
     * 行业领域
     */
    @ApiModelProperty(value = "行业领域",required = true)
    @NotBlank(message = "行业领域不能为空")
    private String field;
    /**
     * 项目详情图片
     */
    @ApiModelProperty(value = "项目详情图片",required = true)
    @NotBlank(message = "项目详情图片不能为空")
    private String projectImage;
    /**
     * 团队介绍
     */
    @ApiModelProperty(value = "团队介绍",required = true)
    @NotBlank(message = "团队介绍不能为空")
    private String teamIntroduction;
    /**
     * 融资介绍
     */
    @ApiModelProperty(value = "融资介绍",required = true)
    @NotBlank(message = "融资介绍不能为空")
    private String financingIntroduction;
    /**
     * 融资金额
     */
    @ApiModelProperty(value = "融资金额",required = true)
    @NotBlank(message = "融资金额不能为空")
    private String financingMoney;
    /**
     * 融资方式
     */
    @ApiModelProperty(value = "融资方式",required = true)
    @NotBlank(message = "融资方式不能为空")
    private String financingMethod;
    /**
     * 融资阶段
     */
    @ApiModelProperty(value = "融资阶段",required = true)
    @NotBlank(message = "融资阶段不能为空")
    private String financingPhase;
    /**
     * 企业id
     */
    @ApiModelProperty(value = "企业id",required = true)
    @NotNull(message = "企业id不能为空")
    private Long businessId;

    /**
     * 联系人姓名
     */
    @ApiModelProperty(value = "联系人姓名",required = true)
    @NotBlank(message = "联系人姓名不能为空")
    private String name;
    /**
     * 电话
     */
    @ApiModelProperty(value = "联系人电话",required = true)
    @NotBlank(message = "联系人电话不能为空")
    private String phone;
    /**
     * 邮箱
     */
    @ApiModelProperty(value = "联系人邮箱",required = true)
    @NotBlank(message = "联系人邮箱不能为空")
    @Email(message = "邮箱格式不正确")
    private String email;
    /**
     * 地址
     */
    @ApiModelProperty("联系人地址")
    private String address;
    /**
     * 单位
     */
    @ApiModelProperty("联系人单位")
    private String position;
}
