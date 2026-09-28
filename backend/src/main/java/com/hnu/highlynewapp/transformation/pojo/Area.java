package com.hnu.highlynewapp.transformation.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import lombok.*;

import java.io.Serializable;

/**
 * 地区
 */
@ApiModel("地区")
@Data
@TableName("china")
public class Area implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * Id
     */
    @TableId(value = "Id")
    private Long Id;

    /**
     * 名称
     */
    @TableField("Name")
    private String Name;

    /**
     * Pid
     */
    @TableField("Pid")
    private Long Pid;
}
