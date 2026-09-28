package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 咨询
 * 
 * @author zhourunnan
 * @email 13513595808@163.com
 * @date 2021-04-08 20:12:22
 */
@Data
@TableName("consultation")
public class ConsultationEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@TableId
	private Long id;
	/**
	 * 用户id
	 */
	private Long userId;
	/**
	 * 咨询内容类型
	 */
	private String category;
	/**
	 * 咨询内容
	 */
	private String content;
	/**
	 * 邮箱
	 */
	private String email;
	/**
	 * 联系电话
	 */
	private String phone;
	/**
	 * 回复对应的咨询消息id
	 */
	private Long parentId;
	/**
	 * 发布时间
	 */
	private Date publishTime;
	/**
	 * 是否已读
	 */
	private Integer isRead;
}
