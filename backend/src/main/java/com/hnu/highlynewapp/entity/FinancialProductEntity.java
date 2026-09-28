package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 金融产品
 * 
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Data
@TableName("financial_product")
public class FinancialProductEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * id
	 */
	@TableId
	private Long financialProductId;
	/**
	 * 产品名称
	 */
	private String title;
	/**
	 * 发布时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
	private Date publishTime;
	/**
	 * 产品描述
	 */
	private String description;
	/**
	 * 详情图片
	 */
	private String image;
	/**
	 * 利率范围 （1%-2%）
	 */
	private String rate;
	/**
	 * 担保额度
	 */
	private String loanMoney;
	/**
	 * 担保方式
	 */
	private String ensureMethod;
	/**
	 * 贷款期限
	 */
	private String loanDeadline;
	/**
	 * 申请条件
	 */
	private String applyCondition;
	/**
	 * 联系人id
	 */
	private Long contactId;
	/**
	 * 金融机构id
	 */
	private Long financialInstitutionId;
	/**
	 * 贷款类型
	 */

	private String loanType;

	@ApiModelProperty("审核结果(audit result)，（0-正在审核中，1-通过，2-不通过）")
	private Long auditFlag;

}
