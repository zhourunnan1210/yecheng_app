package com.hnu.highlynewapp.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.hibernate.validator.constraints.Length;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.Email;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.util.Date;

/**
 * @author LengKuBaiCai
 * @Date
 */
@ApiModel("申请金融机构表认证")
@Data
public class PublishFinancialInstitutionVo {
    @ApiModelProperty("法人id")
    private long legalPersonId;

    @ApiModelProperty(required = true, value = "法人姓名")
    @NotBlank(message = "法人姓名不能为空")
    private String legalPersonName;

    @ApiModelProperty("企业地址（省市区）")
    private String briefAddress;

    @ApiModelProperty("企业地址（详细地址）")
    private String detailedAddress;

    @ApiModelProperty(required = true, value = "经营范围")
    @Length(message = "描述不能少于5个字", min = 5)
    private String businessScope;

    @ApiModelProperty(required = true, value = "简介")
    @Length(message = "描述不能少于5个字", min = 5)
    private String briefIntroduction;

    @ApiModelProperty(required = true, value = "企业成立日期")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @NotNull(message = "企业成立日期不能为空")
    private Date establishmentDay;

    @ApiModelProperty(required = true, value = "企业经营限期")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @NotNull(message = "企业经营期限不能为空")
    private Date timeLimit;

    @ApiModelProperty("金融机构网站")
    private String website;

    @ApiModelProperty("邮箱")
    @Email(message = "邮箱格式不正确")
    private String email;

    @ApiModelProperty("注册资本")
    private String registeredCapital;

    @ApiModelProperty(required = true, value = "统一社会信用代码")
    @NotBlank(message = "统一社会信用代码不能为空")
    @Pattern(message = "统一社会信用代码格式不正确，应为18位数字和大写字母组成", regexp = "^[0-9A-HJ-NPQRTUWXY]{18}$")
    private String unifiedSocialCreditCode;

    @ApiModelProperty("登记机关")
    private String registrationAuthority;

    @ApiModelProperty("核准日期")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date sanctionDay;

    @ApiModelProperty("固定电话")
    private String fixedLineTelephone;

    @ApiModelProperty("金融机构名字")
    private String financialInstitutionName;

    @ApiModelProperty("金融机构图片")
    private String financialInstitutionImage;

    @ApiModelProperty("隐写任务ID")
    private String taskId;

    @ApiModelProperty("隐写状态 [0：未隐写，1：正在隐写，1：隐写成功，2：隐写失败]")
    private Integer imgStegaStatus;

    @ApiModelProperty("企业信用材料")
    private String creditMaterials;

    @ApiModelProperty("审核状态 [0：未审核，1：正在审核，2：审核通过，3：审核失败]")
    private Integer status;
}
