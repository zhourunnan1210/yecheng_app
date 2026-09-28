package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.hnu.highlynewapp.entity.base.ContactEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 技术需求
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@ApiModel("技术需求")
@Data
@TableName("technology_need")
public class TechnologyNeedEntity extends ContactEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @ApiModelProperty("科技需求id")
    @TableId(type = IdType.AUTO)
    private Long technologyNeedId;

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
     * 描述
     */
    @ApiModelProperty("描述")
    private String description;

    /**
     * 分类
     */
    @ApiModelProperty("分类")
    private String category;

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
     * 企业id
     */
    @ApiModelProperty("企业id")
    private Long businessId;

    /**
     * 更新时间
     */
    @ApiModelProperty("更新时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;

    /**
     * 匹配成功的技术成果ids
     */
    @ApiModelProperty("匹配成功的技术成果ids")
    private String technologyAchievementIds;
}
