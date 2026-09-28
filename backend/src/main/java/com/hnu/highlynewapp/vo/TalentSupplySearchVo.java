package com.hnu.highlynewapp.vo;

import com.hnu.highlynewapp.entity.ContactEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("检索人才供应信息，不填默认获取全部")
@Data
public class TalentSupplySearchVo {
    @ApiModelProperty("联系人实体类")
    private ContactEntity contactEntity;

    @ApiModelProperty("姓名")
    private String name;

    @ApiModelProperty("照片")
    private String image;

    @ApiModelProperty("性别")
    private Integer gender;

    @ApiModelProperty("年龄")
    private Integer age;

    @ApiModelProperty("学历 [1：博士研究生，2：硕士研究生，3：本科，4：大专]")
    private Integer degree;

    @ApiModelProperty("专业")
    private String profession;

    @ApiModelProperty("学校")
    private String school;

    @ApiModelProperty("求职意向")
    private String job;

    @ApiModelProperty("专业技能")
    private String skill;

    @ApiModelProperty("个人经历")
    private String experience;

    @ApiModelProperty("入学时间")
    private String enterDate;

    @ApiModelProperty("毕业时间")
    private String graduateDate;

    @ApiModelProperty("简历上传")
    private String resumeUrl;

    @ApiModelProperty("期望最低薪资")
    private Double salaryMin;

    @ApiModelProperty("期望最高薪资")
    private Double salaryMax;

    @ApiModelProperty("工作性质")
    private Integer jobNature;

    @ApiModelProperty("求职状态")
    private String jobStatus;

    @ApiModelProperty("性格品质")
    private String quality;

    @ApiModelProperty("审核状态 [0：未审核，1：正在审核，2：审核通过，3：审核失败]")
    private String status;
}
