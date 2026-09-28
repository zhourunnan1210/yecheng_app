package com.hnu.highlynewapp.vo;

import com.hnu.highlynewapp.entity.BusinessInfoEntity;
import com.hnu.highlynewapp.entity.ContactEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("检索人才需求信息，不填默认获取全部")
@Data
public class TalentNeedSearchVo {
    @ApiModelProperty("人才需求ID")
    private Long talentNeedId;

    @ApiModelProperty("企业实体类")
    private BusinessInfoEntity businessInfoEntity;

    @ApiModelProperty("联系人实体类")
    private ContactEntity contactEntity;

    @ApiModelProperty("职位工作")
    private String position;

    @ApiModelProperty("位置（省市县）")
    private String location;

    @ApiModelProperty("详细地址")
    private String address;

    @ApiModelProperty("工作内容")
    private String job;

    @ApiModelProperty("职位要求")
    private String demand;

    @ApiModelProperty("详情图片")
    private String image;

    @ApiModelProperty("最低学历 [1：博士研究生，2：硕士研究生，3：本科，4：大专，5：中专，6：高中]")
    private Integer degree;

    @ApiModelProperty("最低薪资")
    private Double salaryMin;

    @ApiModelProperty("最高薪资")
    private Double salaryMax;

    @ApiModelProperty("标题1")
    private String title1;

    @ApiModelProperty("标题2")
    private String title2;

    @ApiModelProperty("标题3")
    private String title3;

    @ApiModelProperty("审核状态 [0：未审核，1：正在审核，2：审核通过，3：审核失败]")
    private String status;
}
