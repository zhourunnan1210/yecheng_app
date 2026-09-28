package com.hnu.highlynewapp.transformation.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * 专家
 */
@ApiModel("专家")
@Data
@TableName("expert")
public class Expert implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 专家编号
     */
    @ApiModelProperty("专家编号")
    @TableId(type = IdType.AUTO, value = "expert_id")
    private Long expertId;

    /**
     * 专家姓名
     */
    @ApiModelProperty("专家姓名")
    @NotBlank(message = "专家姓名不能为空")
    private String name;

    /**
     * 照片
     */
    @ApiModelProperty("照片")
    private String image;

    /**
     * 性别
     */
    @ApiModelProperty("性别")
    private String gender;

    /**
     * 学历
     */
    @ApiModelProperty("学历")
    @NotBlank(message = "学历不能为空")
    private String degree;

    /**
     * 从事专业
     */
    @ApiModelProperty("从事专业")
    @NotBlank(message = "从事专业不能为空")
    private String profession;

    /**
     * 职称
     */
    @ApiModelProperty("职称")
    private String title;

    /**
     * 工作单位
     */
    @ApiModelProperty("工作单位")
    private String company;

    /**
     * 省或直辖市
     */
    @ApiModelProperty("省或直辖市")
    private String province;

    /**
     * 市或直辖市的区
     */
    @ApiModelProperty("市或直辖市的区")
    private String city;

    /**
     * 区（直辖市非必填）
     */
    @ApiModelProperty("区（直辖市非必填）")
    private String area;

    /**
     * 详细地址
     */
    @ApiModelProperty("详细地址")
    private String address;

    /**
     * 主要成就
     */
    @ApiModelProperty("主要成就")
    @NotBlank(message = "主要成就不能为空")
    private String achievement;

    /**
     * 专家简介
     */
    @ApiModelProperty("专家简介")
    @NotBlank(message = "专家简介不能为空")
    private String introduction;

    /**
     * 联系电话
     */
    @ApiModelProperty("联系电话")
    private String telephone;

    /**
     * 电子邮件
     */
    @ApiModelProperty("电子邮件")
    private String email;
}
