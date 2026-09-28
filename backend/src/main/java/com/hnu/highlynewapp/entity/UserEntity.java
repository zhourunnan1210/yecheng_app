package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 用户
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:57
 */
@Data
@TableName("user")
public class UserEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 用户id
	 */
	@TableId(type = IdType.AUTO)
	private Long userId;

	/**
	 * 昵称
	 */
	private String username;

	/**
	 * 密码
	 */
	private String password;

	/**
	 * 真实姓名
	 */
	private String realName;

	/**
	 * 性别 [1：男，2：女]
	 */
	private Integer gender;

	/**
	 * 位置（省市县）
	 */
	private String location;

	/**
	 * 地址
	 */
	private String address;

	/**
	 * 手机号
	 */
	private String phone;

	/**
	 * 电子邮箱
	 */
	private String email;

	/**
	 * 用户类型 [0：未认定用户，1：高新企业，2：科技主管部门，3：学校，4：金融机构，5：服务机构]
	 */
	private Integer type;

	/**
	 * 审核状态 [0：未审核，1：正在审核，2：审核通过，3：审核失败]
	 */
	private Integer status;

	private String token;

	@TableField(fill = FieldFill.INSERT)
	private Date gmtCreate;

	@TableField(fill = FieldFill.INSERT_UPDATE)
	private Date gmtModified;

	@TableField(fill = FieldFill.INSERT)
	private Integer deleted;
}
