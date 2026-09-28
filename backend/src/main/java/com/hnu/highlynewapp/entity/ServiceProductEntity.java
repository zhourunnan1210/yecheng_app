package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

/**
 * 服务产品
 * 
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Data
@TableName("service_product")
public class ServiceProductEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * id
	 */
	@TableId
	private Long serviceProductId;
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
	 * 服务类型
	 */
	private String serviceType;
	/**
	 * 详情图片
	 */
	private String image;
	/**
	 * 联系人id
	 */
	private Long contactId;
	/**
	 * 服务机构id
	 */
	private Long serviceInstitutionId;

	/**
	 * 创建时间
	 */
	@TableField(fill = FieldFill.INSERT)
	private Date gmtCreate;
	
	/**
	 * 修改时间
	 */
	@TableField(fill = FieldFill.INSERT_UPDATE)
	private Date gmtModified;
	
	/**
	 * 删除标记
	 */
	@TableField(fill = FieldFill.INSERT)
	@TableLogic
	private Integer deleted;

}
