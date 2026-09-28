package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 技术成果
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@ApiModel("技术成果")
@Data
@TableName("technology_achievement")
public class TechnologyAchievementEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId(type = IdType.AUTO)
    @ApiModelProperty("技术成果")
    private Long technologyAchievementId;

    /**
     * 标题
     */
    @ApiModelProperty("标题")
    private String title;

    /**
     * 发布时间
     */
    @ApiModelProperty("发布时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date publishTime;

    /**
     * 分类
     */
    @ApiModelProperty("分类")
    private String category;

    /**
     * 网址
     */
    @ApiModelProperty("网址")
    private String website;

    /**
     * 描述
     */
    @ApiModelProperty("描述")
    private String description;

    /**
     * 行业领域
     */
    @ApiModelProperty("行业领域")
    private String field;

    /**
     * 详情图片
     */
    @ApiModelProperty("详情图片")
    private String image;

    /**
     * 联系人id
     */
    @ApiModelProperty("联系人id")
    private Long contactId;

    /**
     * 发布者类型 [1：高新企业，3：学校]
     */
    @ApiModelProperty("发布者类型 [1：高新企业，3：学校]")
    private Integer publisherType;

    /**
     * 企业或者学校id，根据发布者类型判断
     */
    @ApiModelProperty("企业或者学校id，根据发布者类型判断")
    private Long publisherId;

    @ApiModelProperty("联系人姓名")
    private String contactName;

    @ApiModelProperty("联系人电话")
    private String contactPhone;

    @ApiModelProperty("联系人邮箱")
    private String contactEmail;

    /**
     * 成熟度 [1：正在研发，2：已有样品，3：通过小试，4：通过中试，5：可以量产]
     */
    @ApiModelProperty("成熟度 [1：正在研发，2：已有样品，3：通过小试，4：通过中试，5：可以量产]")
    private Integer maturity;

    /**
     * 成果水平 [1：国际领先，2：国际先进，3：国内领先，4：国内先进，5：国内一般，6：未评价]
     */
    @ApiModelProperty("成果水平 [1：国际领先，2：国际先进，3：国内领先，4：国内先进，5：国内一般，6：未评价]")
    private Integer level;
}
