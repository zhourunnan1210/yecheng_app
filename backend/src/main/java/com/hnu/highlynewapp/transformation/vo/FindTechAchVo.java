package com.hnu.highlynewapp.transformation.vo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.hnu.highlynewapp.transformation.pojo.TechAchEvaluationReport;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@ApiModel("查找技术成果关联的实体类信息")
@Data
@TableName("technology_achievement")
public class FindTechAchVo {
    /**
     * id
     */
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

    /**
     * 作者的姓名/id
     */
    @ApiModelProperty("作者的姓名/id")
    private String contactName;

    /**
     * 作者的电话
     */
    @ApiModelProperty("作者的电话")
    private String contactPhone;

    /**
     * 作者的邮箱
     */
    @ApiModelProperty("作者的邮箱")
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


    /**
     * 技术成果关联的评估报告
     */
    @ApiModelProperty("技术成果关联的评估报告")
    @TableField(exist = false)
    private TechAchEvaluationReport techAchEvaluationReport;
}
