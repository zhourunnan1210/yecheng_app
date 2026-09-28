package com.hnu.highlynewapp.transformation.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import java.io.Serializable;
import java.util.Date;

/**
 * 评估案例
 */
@ApiModel("评估案例")
@Data
@TableName("evaluation_case")
public class EvaluationCase implements Serializable {
    private static final long serialVersionUID = 1L;

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
    @NotBlank(message = "案例名称不能为空")
    private String title;

    /**
     *评估完成时间
     */
    @ApiModelProperty("评估完成时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @NotNull(message = "评估完成时间不能为空")
    @Past
    private Date completeTime;

    /**
     * 评估结果
     */
    @ApiModelProperty("评估结果")
    @NotBlank(message = "评估结果不能为空")
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
     * 专家编号
     */
    @ApiModelProperty("专家编号")
    @NotNull(message = "专家编号不能为空")
    private Long expertId;

    /**
     * 技术成果id
     */
    @ApiModelProperty("技术成果id")
    @NotNull(message = "技术成果id不能为空")
    private Long technologyAchievementId;
}
