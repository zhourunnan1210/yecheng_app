package com.hnu.highlynewapp.transformation.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.hnu.highlynewapp.entity.TechnologyAchievementEntity;
import com.hnu.highlynewapp.transformation.pojo.Expert;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@ApiModel("查找评估案例关联的实体类信息")
@Data
@TableName("evaluation_case")
public class FindEvaluationCaseVo {
    /**
     * 评估案例编号
     */
    @ApiModelProperty("评估案例编号")
    @TableId(type = IdType.AUTO, value = "evaluation_case_id")
    private Long evaluationCaseId;

    /**
     * 案例名称
     */
    @ApiModelProperty("案例名称")
    private String title;

    /**
     *评估完成时间
     */
    @ApiModelProperty("评估完成时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date completeTime;

    /**
     * 评估结果
     */
    @ApiModelProperty("评估结果")
    private String result;

    /**
     * 评估模式
     */
    @ApiModelProperty("评估模式")
    private String mode;

    /**
     * 评估服务体系
     */
    @ApiModelProperty("评估服务体系")
    private String system;

    /**
     * 评估案例关联的专家
     */
    @ApiModelProperty("评估案例关联的专家")
    @TableField(exist = false)
    private Expert expert;

    /**
     * 评估案例关联的技术成果
     */
    @ApiModelProperty("评估案例关联的技术成果")
    @TableField(exist = false)
    private TechnologyAchievementEntity technologyAchievementEntity;
}
