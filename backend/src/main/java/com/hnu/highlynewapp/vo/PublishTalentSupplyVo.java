package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Range;
import org.hibernate.validator.constraints.URL;

import javax.validation.constraints.Email;
import javax.validation.constraints.Max;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @author zhourunnan
 * @Date 2021/1/5
 */
@ApiModel("发布人才供应请求参数")
@Data
public class PublishTalentSupplyVo {
    @ApiModelProperty(required = true, value = "用户id")
    @NotNull(message = "用户id不能为空")
    private Long userId;

    /**
     * 姓名
     */
    @ApiModelProperty(required = true, value = "姓名")
    @NotBlank(message = "姓名不能为空")
    private String name;

    /**
     * 照片
     */
    @ApiModelProperty(required = true, value = "照片")
    @NotBlank(message = "照片不能为空")
    @URL(message = "照片url不合法")
    private String image;

    /**
     * 性别 [1：男，2：女]
     */
    @ApiModelProperty(required = true, value = "性别 [1：男，2：女]")
    @NotNull(message = "性别不能为空")
    @Range(max = 2, message = "请输入正确性别", min = 1)
    private Integer gender;

    /**
     * 年龄
     */
    @ApiModelProperty(required = true, value = "年龄")
    @NotNull(message = "年龄不能为空")
    @Range(max = 60, message = "年龄应该在18到60岁内", min = 18)
    private Integer age;

    /**
     * 学历 [1：博士研究生，2：硕士研究生，3：本科，4：大专]
     */
    @ApiModelProperty(required = true, value = "学历 [1：博士研究生，2：硕士研究生，3：本科，4：大专]")
    @NotNull(message = "学历不能为空")
    @Range(max = 4, message = "请输入正确学历 [1：博士研究生，2：硕士研究生，3：本科，4：大专]", min = 1)
    private Integer degree;

    /**
     * 专业
     */
    @ApiModelProperty(required = true, value = "专业")
    @NotBlank(message = "专业不能为空")
    private String profession;

    /**
     * 学校
     */
    @ApiModelProperty(required = true, value = "学校")
    @NotNull(message = "学校不能为空")
    private String school;

    /**
     * 求职意向
     */
    @ApiModelProperty(required = true, value = "求职意向")
    @NotBlank(message = "求职意向不能为空")
    private String job;

    /**
     * 专业技能
     */
    @ApiModelProperty(required = true, value = "专业技能")
    @NotBlank(message = "专业技能不能为空")
    private String skill;

    /**
     * 个人经历
     */
    @ApiModelProperty("个人经历")
    private String experience;

    /**
     * 简历上传
     */
    @ApiModelProperty("上传简历")
    @URL(message = "简历url不合法")
    private String resumeUrl;

    /**
     * 期望最低薪资
     */
    @ApiModelProperty("期望最低薪资")
    private Double salaryMin;

    /**
     * 期望最高薪资
     */
    @ApiModelProperty("期望最高薪资")
    private Double salaryMax;

    /**
     * 工作性质
     */
    @ApiModelProperty("工作性质")
    private String jobNature;

    /**
     * 求职状态
     */
    @ApiModelProperty("求职状态")
    private String jobStatus;

    /**
     * 性格品质
     */
    @ApiModelProperty("性格品质")
    private String quality;

    /**
     * 联系人电话
     */
    @ApiModelProperty(required = true, value = "联系人电话")
    @NotBlank(message = "联系人电话不能为空")
    private String phone;

    /**
     * 联系人邮箱
     */
    @ApiModelProperty(required = true, value = "联系人邮箱")
    @Email(message = "邮箱格式不正确")
    @NotBlank(message = "联系人邮箱不能为空")
    private String email;

    /**
     * 联系人地址
     */
    @ApiModelProperty("联系人地址")
    private String address;

    /**
     * 联系人单位
     */
    @ApiModelProperty("联系人单位")
    private String position;

    /**
     * 审核状态 [0：未审核，1：正在审核，2：审核通过，3：审核失败]
     */
    @ApiModelProperty("审核状态 [0：未审核，1：正在审核，2：审核通过，3：审核失败]")
    private Integer status;
}
