package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

/**
 * 人才供应
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Data
@TableName(autoResultMap = true, value = "talent_supply")
public class TalentSupplyEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId(type = IdType.AUTO)
    private Long talentSupplyId;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 联系人id
     */
    private Long contactId;

    /**
     * 发布时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date publishTime;

    /**
     * 姓名
     */
    private String name;

    /**
     * 照片
     */
    private String image;

    /**
     * 性别 [1：男，2：女]
     */
    private Integer gender;

    /**
     * 年龄
     */
    private Integer age;

    /**
     * 学历 [1：博士研究生，2：硕士研究生，3：本科，4：大专，5：中专，6：高中]
     */
    private Integer degree;

    /**
     * 专业
     */
    private String profession;

    /**
     * 学校
     */
    private String school;

    /**
     * 求职意向
     */
    private String job;

    /**
     * 专业技能
     */
    private String skill;

    @TableField(exist = false)
    private double matchScore;

    /**
     * 组合向量 ( profession + job + skill )
     */
    @TableField(typeHandler = JacksonTypeHandler.class)
    private double[] combinedEmbedding;
    /**
     * 个人经历
     */
    private String experience;

    /**
     * 入学时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date enterDate;

    /**
     * 毕业时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date graduateDate;

    /**
     * 简历上传
     */
    private String resumeUrl;

    /**
     * 期望最低薪资
     */
    private BigDecimal salaryMin;

    /**
     * 期望最高薪资
     */
    private BigDecimal salaryMax;

    /**
     * 工作性质
     */
    private String jobNature;

    /**
     * 求职状态
     */
    private String jobStatus;

    /**
     * 性格品质
     */
    private String quality;

    /**
     * 审核状态 [0：未审核，1：正在审核，2：审核通过，3：审核失败]
     */
    private Integer status;

    @TableField(fill = FieldFill.INSERT)
    private Date gmtCreate;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date gmtModified;

    @TableField(fill = FieldFill.INSERT)
    @TableLogic
    private Integer deleted;
}
