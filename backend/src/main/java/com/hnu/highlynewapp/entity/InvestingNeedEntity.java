
package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
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
public class InvestingNeedEntity implements Serializable {

  @TableId
  @ApiModelProperty("投资需求id")
  private Long investNeedId;

  @ApiModelProperty("投资公司id")
  private Long financialInstitutionId;

  @ApiModelProperty("行业领域")
  private String industryField;

  @ApiModelProperty("投资方式")
  private String investWay;

  @ApiModelProperty("投资类型")
  private String investType;

  @ApiModelProperty("投资金额")
  private String investingMoney;

  @ApiModelProperty("联系人姓名")
  private String contactName;

  @ApiModelProperty("联系电话")
  private String contactPhone;

  @ApiModelProperty("发布时间")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
  private java.sql.Date releaseTime;

  @ApiModelProperty("阅读量")
  private long reading;

  @ApiModelProperty("投资意向")
  private String projProposal;

  @ApiModelProperty("投资状态（0-成功，1-进行中）")
  private long successFlag;

  @ApiModelProperty("投资意向审核结果（0-正在审核中，1-通过，2-不通过）")
  private long auditFlag;

  @ApiModelProperty("投资描述说明")
  private String investDescription;

  @ApiModelProperty("公司介绍")
  private String companyIntroduction;

  @ApiModelProperty("成功案例")
  private String successCase;

  @ApiModelProperty("公司名字")
  private String companyName;

  @ApiModelProperty("投资需求图片")
  private String investImag;

  @ApiModelProperty("联系人邮箱")
  private String contactEmail;

  @ApiModelProperty("联系人地址")
  private String contactAddress;

  @ApiModelProperty("联系人单位")
  private String contactCompany;

	/**
	 * 创建时间
	 */
	@ApiModelProperty("创建时间")
	@TableField(fill = FieldFill.INSERT)
	private Date gmtCreate;
	
	/**
	 * 修改时间
	 */
	@ApiModelProperty("修改时间")
	@TableField(fill = FieldFill.INSERT_UPDATE)
	private Date gmtModified;
	
	/**
	 * 删除标记
	 */
	@ApiModelProperty("删除标记")
	@TableField(fill = FieldFill.INSERT)
	@TableLogic
	private Integer deleted;

  public Long getInvestNeedId() {
    return investNeedId;
  }

  public void setInvestNeedId(Long investNeedId) {
    this.investNeedId = investNeedId;
  }
}
