package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @author zhourunnan
 * @Date 2021/1/6
 */
@ApiModel("发布技术需求请求参数")
@Data
public class PublishTechNeedVo {
    /**
     * 标题
     */
    @ApiModelProperty(required = true, value = "标题")
    @NotBlank(message = "标题不能为空")
    private String title;

    /**
     * 描述
     */
    @ApiModelProperty(required = true, value = "描述")
    @NotBlank(message = "描述不能为空")
    private String description;

    /**
     * 分类
     */
    @ApiModelProperty(required = true, value = "分类")
    @NotBlank(message = "分类不能为空")
    private String category;

    /**
     * 行业领域
     */
    @ApiModelProperty(required = true, value = "行业领域")
    @NotBlank(message = "行业领域不能为空")
    private String field;

    /**
     * 详情图片
     */
    @ApiModelProperty(value = "详情图片")
    private String image;

    /**
     * 企业id
     */
    @ApiModelProperty(required = true, value = "企业id")
    @NotNull(message = "企业id不能为空")
    private Long businessId;

    /**
     * 联系人姓名
     */
    @ApiModelProperty(required = true, value = "联系人姓名")
    @NotBlank(message = "联系人姓名不能为空")
    private String contactName;

    /**
     * 电话
     */
    @ApiModelProperty(required = true, value = "联系人电话")
    @NotBlank(message = "联系人电话不能为空")
    private String contactPhone;

    /**
     * 邮箱
     */
    @ApiModelProperty(required = true, value = "联系人邮箱")
    @Email(message = "邮箱格式不正确")
    @NotBlank(message = "联系人邮箱不能为空")
    private String contactEmail;
}
