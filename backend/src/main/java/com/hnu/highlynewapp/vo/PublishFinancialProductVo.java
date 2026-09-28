package com.hnu.highlynewapp.vo;

import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * @author zhourunnan
 * @Date 2021/1/5
 */
@Data
@ApiModel("发布金融产品请求参数")
public class PublishFinancialProductVo {
    /**
     * 产品名称
     */
    @NotBlank(message = "产品名称不能为空")
    @ApiModelProperty(value = "产品名称",required = true)
    private String title;
    /**
     * 产品描述
     */
    @NotBlank(message = "产品描述不能为空")
    @ApiModelProperty(value = "产品描述",required = true)
    private String description;
    /**
     * 详情图片
     */
    @ApiModelProperty("详情图片")
    private String image;
    /**
     * 利率范围 （1%-2%）
     */
    @NotBlank(message = "利率范围不能为空")
    @ApiModelProperty(value = "利率范围",required = true)
    private String rate;
    /**
     * 担保额度
     */
    @NotBlank(message = "贷款额度不能为空")
    @ApiModelProperty(value = "贷款额度",required = true)
    private String loanMoney;
    /**
     * 担保方式
     */
    @NotBlank(message = "担保方式不能为空")
    @ApiModelProperty(value = "担保方式",required = true)
    private String ensureMethod;
    /**
     * 贷款期限
     */
    @NotBlank(message = "贷款期限不能为空")
    @ApiModelProperty(value = "贷款期限",required = true)
    private String loanDeadline;
    /**
     * 申请条件
     */
    @NotBlank(message = "申请条件不能为空")
    @ApiModelProperty(value = "申请条件",required = true)
    private String applyCondition;
    /**
     * 金融机构id
     */
    @NotNull(message = "金融机构id不能为空")
    @ApiModelProperty(value = "金融机构id",required = true)
    private Long financialInstitutionId;

    /**
     * 联系人姓名
     */
    @ApiModelProperty(value = "联系人姓名",required = true)
    @NotBlank(message = "联系人姓名不能为空")
    private String contactName;
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
