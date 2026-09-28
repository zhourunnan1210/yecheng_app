package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

/**
 * 政策
 * 
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Data
@TableName("policy")
public class PolicyEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * id
	 */
	@TableId
	private Long policyId;
	/**
	 * 标题
	 */
	private String title;
	/**
	 * 发布时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
	private Date publishTime;
	/**
	 * 文号
	 */
	private String number;
	/**
	 * 分类
	 */
	private String category;
	/**
	 * 内容
	 */
	private String content;
	/**
	 * 链接
	 */
	private String link;
	/**
	 * 详情图片
	 */
	private String image;
	/**
	 * 附件
	 */
	private String addition;
	/**
	 * userid
	 */
	private Long userId;
	private Date gmtCreate;
	private Date gmtModified;
	private Integer deleted;
}
