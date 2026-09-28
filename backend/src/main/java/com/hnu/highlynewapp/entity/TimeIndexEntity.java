package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 时间检索
 * 
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-04 22:01:46
 */
@Data
@TableName("time_index")
public class TimeIndexEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@TableId
	private Long id;
	/**
	 * 名称
	 */
	private String name;

}
