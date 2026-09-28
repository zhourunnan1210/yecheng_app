package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户行为
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Data
@TableName("user_behavior")
public class UserBehaviorEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 行为ID
     */
    @TableId(type = IdType.AUTO)
    private Long behaviorId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 目标类型 [1:岗位, 2:简历]
     */
    private Integer targetType;

    /**
     * 目标ID(岗位ID或简历ID)
     */
    private Long targetId;

    /**
     * 操作类型 [0:撤销, 1:喜欢, 2:不喜欢]
     */
    private Integer actionType;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
} 