package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author LengKuBaiCai
 * @Date
 */
@ApiModel("金融机构")
@Data
@TableName("financial_institution")
public class FinancialInstitutionEntity implements Serializable {
    @ApiModelProperty("企业id")
    @TableId(type = IdType.AUTO)
    private Long financialInstitutionId;

    @ApiModelProperty("法人id")
    private Long legalPersonId;

    @ApiModelProperty("法人姓名")
    private String legalPersonName;

    @ApiModelProperty("企业地址（省市区）")
    private String briefAddress;

    @ApiModelProperty("企业地址（详细地址）")
    private String detailedAddress;

    @ApiModelProperty("经营范围")
    private String businessScope;

    @ApiModelProperty("简介")
    private String briefIntroduction;

    @ApiModelProperty("企业成立日期")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date establishmentDay;

    @ApiModelProperty("企业经营限期")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date timeLimit;

    @ApiModelProperty("金融机构网站")
    private String website;

    @ApiModelProperty("邮箱")
    private String email;

    @ApiModelProperty("注册资本")
    private String registeredCapital;

    @ApiModelProperty("统一社会信用代码")
    private String unifiedSocialCreditCode;

    @ApiModelProperty("登记机关")
    private String registrationAuthority;

    @ApiModelProperty("核准日期")
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
