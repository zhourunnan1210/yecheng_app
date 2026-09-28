package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @author zhourunnan
 * @Date 2021/4/8 20:25
 */
@ApiModel("发布咨询请求参数")
@Data
public class PublishConsultationVo {
    @NotNull(message = "用户id不能为空")
    @ApiModelProperty(value = "用户id",required = true)
    private Long userId;
    /**
     * 咨询内容类型
     */
    @ApiModelProperty(value = "咨询类型",required = true)
    private String category;
    /**
     * 咨询内容
     */
    @NotBlank(message = "咨询内容不能为空")
    @ApiModelProperty(value = "咨询内容",required = true)
    private String content;
    /**
     * 邮箱
     */
    @ApiModelProperty(value = "联系人邮箱")
    private String email;
    /**
     * 联系电话
     */
    @ApiModelProperty(value = "联系人电话",required = true)
    private String phone;
}
