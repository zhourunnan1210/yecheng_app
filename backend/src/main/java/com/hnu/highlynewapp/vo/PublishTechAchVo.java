package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.URL;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @author zhourunnan
 * @Date 2021/1/6
 */
@ApiModel("发布技术成果请求参数")
@Data
public class PublishTechAchVo {
    /**
     * 标题
     */
    @ApiModelProperty(required = true, value = "标题")
    @NotBlank(message = "标题不能为空")
    private String title;

    /**
     * 分类
     */
    @ApiModelProperty(required = true, value = "分类")
    @NotBlank(message = "分类不能为空")
    private String category;

    /**
     * 网址
     */
    @ApiModelProperty(value = "网址")
    @URL(message = "网址不合法")
    private String website;

    /**
     * 描述
     */
    @ApiModelProperty(required = true, value = "描述")
    @NotBlank(message = "描述不能为空")
    private String description;

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
     * 发布者类型 [1：高新企业，3：学校]
     */
    @ApiModelProperty(required = true, value = "发布者类型 [1：高新企业，3：学校]")
    @NotNull(message = "发布者类型")
    private Integer publisherType;

    /**
     * 企业或者学校id，根据发布者类型判断
     */
    @ApiModelProperty(required = true, value = "企业或者学校id，根据发布者类型判断")
    @NotNull(message = "企业或者学校id不能为空")
    private Long publisherId;

    /**
     * 联系人姓名
     */
    @ApiModelProperty(required = true, value = "联系人姓名")
    @NotBlank(message = "联系人姓名不能为空")
    private String name;

    /**
     * 电话
     */
    @ApiModelProperty(required = true, value = "联系人电话")
    @NotBlank(message = "联系人电话不能为空")
    private String phone;

    /**
     * 邮箱
     */
    @ApiModelProperty(required = true, value = "联系人邮箱")
    @Email(message = "邮箱格式不正确")
    @NotBlank(message = "联系人邮箱不能为空")
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
