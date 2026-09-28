package com.hnu.highlynewapp.transformation.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.hnu.highlynewapp.entity.TechnologyAchievementEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@ApiModel("查找技术成果评估报告")
@TableName("tech_ach_evaluation_report")
@Data
public class FindTechAchEvaluationReportVo {
    /**
     * 技术成果评估报告编号
     */
    @ApiModelProperty("技术成果评估报告编号")
    @TableId(type = IdType.AUTO, value = "tech_ach_evaluation_report_id")
    private Long techAchEvaluationReportId;

    /**
     * 发布时间
     */
    @ApiModelProperty(required = true, value = "发布时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date publishTime;

    /**
     * 完成时间
     */
    @ApiModelProperty("完成时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date completeTime;

    /**
     * 评估报告关联的技术成果
     */
    @ApiModelProperty("评估报告关联的技术成果")
    @TableField(exist = false)
    private TechnologyAchievementEntity technologyAchievementEntity;

    /**
     * 评估资料
     */
    @ApiModelProperty(required = true, value = "评估资料")
    private String material;

    /**
     * 审核状态 [0：未审核，1：正在审核，2：审核通过，3：审核失败]
     */
    @ApiModelProperty(required = true, value = "审核状态 [0：未审核，1：正在审核，2：审核通过，3：审核失败]")
    private Integer applicationStatus;

    /**
     * 审核失败的原因
     */
    @ApiModelProperty("审核失败的原因")
    private String failReason;

    /**
     * 评估状态 [0：未评估，1：正在评估，2：评估完成]
     */
    @ApiModelProperty("评估状态 [0：未评估，1：正在评估，2：评估完成]")
    private Integer evaluationStatus;

    /**
     * 评估结果
     */
    @ApiModelProperty("评估结果")
    private String result;

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
     * 用户id
     */
    @ApiModelProperty("用户id")
    private Integer userId;
}
