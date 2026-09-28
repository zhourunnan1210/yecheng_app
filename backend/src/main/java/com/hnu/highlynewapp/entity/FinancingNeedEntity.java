package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 融资需求
 * 
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Data
@TableName("financing_need")
@ApiModel("融资需求")
public class FinancingNeedEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * id
	 */
	@TableId
	@ApiModelProperty("融资需求id")
	private Long financingNeedId;
	/**
	 * 项目名称
	 */
	@ApiModelProperty("项目名称")
	private String title;
	/**
	 * 发布时间
	 */
	@ApiModelProperty("发布时间")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
	private Date publishTime;
	/**
	 * 项目描述
	 */
	@ApiModelProperty("项目描述")
	private String projectDescription;
	/**
	 * 行业领域
	 */
	@ApiModelProperty("行业领域")
	private String field;
	/**
	 * 项目详情图片
	 */
	@ApiModelProperty("项目详情图片")
	private String projectImage;
	/**
	 * 团队介绍
	 */
	@ApiModelProperty("团队介绍")
	private String teamIntroduction;
	/**
	 * 融资介绍
	 */
	@ApiModelProperty("融资介绍")
	private String financingIntroduction;
	/**
	 * 融资金额
	 */
	@ApiModelProperty("融资金额")
	private String financingMoney;
	/**
	 * 融资方式
	 */
	@ApiModelProperty("融资方式")
	private String financingMethod;
	/**
	 * 融资阶段
	 */
	@ApiModelProperty("融资阶段")
	private String financingPhase;
	/**
	 * 联系人id
	 */
	@ApiModelProperty("联系人id")
	private Long contactId;
	/**
	 * 企业id
	 */
	@ApiModelProperty("企业id")
	private Long businessId;

	@ApiModelProperty("投资状态(success_flag)（0-成功，1-进行中,2-失败）")
	private long successFlag;

	@ApiModelProperty("审核结果(audit result)，（0-正在审核中，1-通过，2-不通过）")
	private long auditFlag;

	@ApiModelProperty("联系人姓名")
	private String contactName;

	@ApiModelProperty("联系电话")
	private String contactPhone;

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

}
