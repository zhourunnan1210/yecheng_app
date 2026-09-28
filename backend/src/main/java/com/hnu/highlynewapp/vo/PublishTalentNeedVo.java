package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.*;
import java.util.Date;

/**
 * @author zhourunnan
 * @Date 2021/1/6
 */
@ApiModel("发布人才需求请求参数")
@Data
public class PublishTalentNeedVo {
    /**
     * 用户id
     */
    @ApiModelProperty(required = true, value = "用户id")
    @NotNull(message = "用户id不能为空")
    private Long userId;

    /**
     * 企业名称
     */
    @ApiModelProperty(required = true, value = "企业名称")
    @NotBlank(message = "企业名称不能为空")
    private String businessName;

    /**
     * 联系人姓名
     */
    @ApiModelProperty(required = true, value = "联系人姓名")
    @NotBlank(message = "联系人姓名不能为空")
    private String contactName;

    /**
     * 职位
     */
    @ApiModelProperty(required = true, value = "职位")
    @NotBlank(message = "职位不能为空")
    private String businessPosition;

    /**
     * 位置（省市县）
     */
    @ApiModelProperty(required = true, value = "位置（省市县）")
    @NotBlank(message = "位置不能为空")
    private String location;

    /**
     * 详细地址
     */
    @ApiModelProperty(required = true, value = "详细地址")
    @NotBlank(message = "详细地址不能为空")
    private String businessAddress;

    /**
     * 工作内容
     */
    @ApiModelProperty(required = true, value = "工作内容")
    @NotBlank(message = "工作内容不能为空")
    private String job;

    /**
     * 职位要求
     */
    @ApiModelProperty(required = true, value = "职位要求")
    @NotBlank(message = "职位要求不能为空")
    private String demand;

    /**
     * 详情图片
     */
    @ApiModelProperty(value = "详情图片")
    private String image;

    /**
     * 最低学历 [1：博士研究生，2：硕士研究生，3：本科，4：大专，5：中专，6：高中]
     */
    @ApiModelProperty(required = true, value = "最低学历 [1：博士研究生，2：硕士研究生，3：本科，4：大专，5：中专，6：高中]")
    @NotNull(message = "最低学历不能为空")
    @Range(max = 6, message = "请输入正确最低学历", min = 1)
    private Integer degree;

    /**
     * 联系人电话
     */
    @ApiModelProperty(required = true, value = "联系人电话")
    @NotBlank(message = "联系人电话不能为空")
    private String phone;

    /**
     * 企业网址
     */
    @ApiModelProperty("企业网址")
    private String website;

    /**
     * 企业邮箱
     */
    @ApiModelProperty(required = true, value = "企业邮箱")
    @Email(message = "邮箱格式不正确")
    @NotBlank(message = "企业邮箱不能为空")
    private String businessEmail;

    /**
     * 联系人邮箱
     */
    @ApiModelProperty(required = true, value = "联系人邮箱")
    @Email(message = "邮箱格式不正确")
    @NotBlank(message = "联系人邮箱不能为空")
    private String contactEmail;

    /**
     * 最低薪资
     */
    @ApiModelProperty("最低薪资")
    private Double salaryMin;

    /**
     * 最高薪资
     */
    @ApiModelProperty("最高薪资")
    private Double salaryMax;

    @ApiModelProperty("标题1")
    private String title1;

    @ApiModelProperty("标题2")
    private String title2;

    @ApiModelProperty("标题3")
    private String title3;
}
