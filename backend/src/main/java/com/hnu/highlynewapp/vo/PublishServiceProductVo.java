package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * @author zhourunnan
 * @Date 2021/1/6
 */
@Data
@ApiModel("发布服务产品请求参数")
public class PublishServiceProductVo {
    /**
     * 产品名称
     */
    @ApiModelProperty(value = "产品名称",required = true)
    @NotBlank(message = "产品名称不能为空")
    private String title;
    /**
     * 产品描述
     */
    @ApiModelProperty(value = "产品描述",required = true)
    @NotBlank(message = "产品描述不能为空")
    private String description;
    /**
     * 服务类型
     */
    @ApiModelProperty(value = "服务类型",required = true)
    @NotBlank(message = "服务类型不能为空")
    private String serviceType;
    /**
     * 详情图片
     */
    @ApiModelProperty(value = "详情图片")
    private String image;
    /**
     * 服务机构id
     */
    @ApiModelProperty(value = "服务机构id",required = true)
    @NotNull(message = "服务机构id不能为空")
    private Long serviceInstitutionId;

    /**
     * 联系人姓名
     */
    @ApiModelProperty(value = "联系人姓名",required = true)
    @NotBlank(message = "联系人姓名不能为空")
    private String name;
    /**
     * 电话
     */
    @ApiModelProperty(value = "联系人电话",required = true)
    @NotBlank(message = "联系人电话不能为空")
    private String phone;
    /**
     * 邮箱
     */
    @ApiModelProperty(value = "联系人邮箱",required = true)
    @NotBlank(message = "联系人邮箱不能为空")
    @Email(message = "邮箱格式不正确")
    private String email;
    /**
     * 地址
     */
    @ApiModelProperty("联系人地址")
    private String address;
    /**
     * 单位
     */
    @ApiModelProperty("联系人单位")
    private String position;
}
