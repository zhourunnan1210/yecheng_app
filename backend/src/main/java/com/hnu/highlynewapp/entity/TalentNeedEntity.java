package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 人才需求
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Data
@TableName(autoResultMap = true, value = "talent_need")
public class TalentNeedEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId(type = IdType.AUTO)
    private Long talentNeedId;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 企业id
     */
    private Long businessId;

    /**
     * 联系人id
     */
    private Long contactId;

    /**
     * 职位
     */
    private String position;

    /**
     * 发布时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date publishTime;

    /**
     * 位置（省市县）
     */
    private String location;

    /**
     * 详细地址
     */
    private String address;

    /**
     * 工作内容
     */
    private String job;

    /**
     * 职位要求
     */
    private String demand;

    /**
     * 组合向量 ( position + job + demand )
     */
    @TableField(typeHandler = JacksonTypeHandler.class)
    private double[] combinedEmbedding;

    @TableField(exist = false)
    private double matchScore;

    /**
     * 详情图片
     */
    private String image;

    /**
     * 最低学历 [1：博士研究生，2：硕士研究生，3：本科，4：大专，5：中专，6：高中]
     */
    private Integer degree;

    /**
     * 最低薪资
     */
    private BigDecimal salaryMin;

    /**
     * 最高薪资
     */
    private BigDecimal salaryMax;

    /**
     * 标题1
     */
    private String title1;

    /**
     * 标题2
     */
    private String title2;

    /**
     * 标题3
     */
    private String title3;

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
