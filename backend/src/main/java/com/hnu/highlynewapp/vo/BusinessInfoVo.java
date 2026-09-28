package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.Email;
import javax.validation.constraints.Max;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

@ApiModel("高新技术企业认证")
@Data
public class BusinessInfoVo {
    @ApiModelProperty(required = true, value = "公司名称")
    @NotBlank(message = "公司名称不能为空")
    private String name;

    /**
     * 法人
     */
    @ApiModelProperty(required = true, value = "法人")
    @NotBlank(message = "法人不能为空")
    private String legalPerson;

    /**
     * 类型 [1：有效期高企，2：培育库入库企业，3：当年申报企业]
     */
    @NotNull(message = "企业类型不能为空")
    @Range(max = 3, message = "类型 [1：有效期高企，2：培育库入库企业，3：当年申报企业]", min = 1)
    private Integer type;

    /**
     * 经营范围
     */
    @ApiModelProperty(value = "经营范围")
    private String manegeScope;

    /**
     * 简介
     */
    @ApiModelProperty(value = "简介")
    private String introduction;

    /**
     * 成立日期
     */
    @ApiModelProperty(value = "成立日期")
    @NotNull(message = "成立日期不能为空")
    private Date foundDate;

    /**
     * 经营期限
     */
    @ApiModelProperty(value = "经营期限")
    @NotNull(message = "经营期限不能为空")
    private Date manegeDeadline;

    /**
     * 网址
     */
    @ApiModelProperty(value = "网址")
    private String website;

    /**
     * 邮箱
     */
    @ApiModelProperty(value = "邮箱")
    @Email(message = "邮箱格式不正确")
    private String email;

    /**
     * 注册资本
     */
    @ApiModelProperty(value = "注册资本")
    private String capital;

    /**
     * 位置（省市县）
     */
    @ApiModelProperty(required = true, value = "位置（省市县）")
    @NotBlank(message = "位置（省市县）不能为空")
    private String location;

    /**
     * 详细地址
     */
    @ApiModelProperty(required = true, value = "详细地址")
    @NotBlank(message = "详细地址不能为空")
    private String address;

    /**
     * 统一社会信用代码
     */
    @ApiModelProperty(required = true, value = "统一社会信用代码")
    @NotBlank(message = "统一社会信用代码不能为空")
    private String unifiedSocialCode;

    /**
     * 固定电话
     */
    @ApiModelProperty(required = true, value = "固定电话")
    @NotBlank(message = "固定电话不能为空")
    private String telephone;

    /**
     * 登记机关
     */
    @ApiModelProperty(required = true, value = "登记机关")
    @NotBlank(message = "登记机关不能为空")
    private String regOffice;

    /**
     * 核准日期
     */
    @ApiModelProperty(value = "核准日期")
    private Date examineDate;

    /**
     * 公司图片
     */
    @ApiModelProperty(required = true, value = "公司图片")
    @NotBlank(message = "公司图片不能为空")
    private String imageUrl;

    @NotBlank(message = "审核所需资料不能为空")
    @ApiModelProperty(required = true, value = "审核所需资料")
    private String examineImage;

    /**
     * 用户id
     */
    @ApiModelProperty(value = "用户id")
    private Long userId;

    /**
     * 姓名
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
    @NotBlank(message = "联系人邮箱不能为空")
    private String contactEmail;

    /**
     * 地址
     */
    @ApiModelProperty(value = "联系人地址")
    private String contactAddress;

    /**
     * 单位
     */
    @ApiModelProperty(value = "联系人单位")
    private String contactPosition;
}
