package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 各岗位人才需求统计
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Data
@TableName("people_require_each_position")
public class PeopleRequireEachPositionEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 岗位名称
     */
    private String position;

    /**
     * 需求数量
     */
    private Integer requireCount;

    /**
     * 地区
     */
    private String location;

    /**
     * 行业
     */
    private String industry;

    /**
     * 薪资范围
     */
    private String salaryRange;

    /**
     * 学历要求
     */
    private String educationRequirement;

    /**
     * 经验要求
     */
    private String experienceRequirement;

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
     * 逻辑删除标志
     */
    @TableLogic
    private Integer deleted;

    /**
     * 无参构造函数
     */
    public PeopleRequireEachPositionEntity() {
    }

    /**
     * 带参构造函数
     * @param position 岗位名称
     * @param requireCount 需求数量
     */
    public PeopleRequireEachPositionEntity(String position, Integer requireCount) {
        this.position = position;
        this.requireCount = requireCount;
    }
}
