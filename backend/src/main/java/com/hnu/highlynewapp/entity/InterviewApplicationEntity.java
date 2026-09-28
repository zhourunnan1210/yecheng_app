package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 面试申请实体类
 *
 * @author interview_system
 * @date 2024
 */
@Data
@TableName("interview_application")
public class InterviewApplicationEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 申请ID
     */
    @TableId(type = IdType.AUTO)
    private Long applicationId;

    /**
     * 申请用户ID
     */
    private Long userId;

    /**
     * 岗位ID
     */
    private Long talentNeedId;

    /**
     * 企业ID
     */
    private Long companyId;

    /**
     * 状态：0-未办理，1-已同意，2-已拒绝
     */
    private Integer status;

    /**
     * 申请时间
     */
    private Date applyTime;

    /**
     * 处理时间
     */
    private Date processTime;

    /**
     * 处理人ID
     */
    private Long processUserId;

    /**
     * 备注信息
     */
    private String remarks;

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
     * 删除标记：0-未删除，1-已删除
     */
    @TableLogic
    @TableField(fill = FieldFill.INSERT)
    private Integer deleted;
}