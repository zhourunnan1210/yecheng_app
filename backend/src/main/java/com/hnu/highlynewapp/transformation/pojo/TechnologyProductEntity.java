package com.hnu.highlynewapp.transformation.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@ApiModel("科技产品")
@Data
@TableName("technology_product")
public class TechnologyProductEntity extends Model<TechnologyProductEntity> {

    private static final Long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long technologyProductId;

    @ApiModelProperty("产品名称")
    private String title;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ApiModelProperty("开始时间")
    private Date startTime;

    @ApiModelProperty("技术领域")
    private String field;

    @ApiModelProperty("研发进度")
    private String progress;

    @ApiModelProperty("图片")
    private String image;

    @ApiModelProperty("产品简介")
    private String introduction;
}
