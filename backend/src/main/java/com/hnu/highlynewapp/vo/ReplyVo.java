package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * @author zhourunnan
 * @Date 2021/4/19 16:26
 */
@ApiModel("回复咨询问题请求参数")
@Data
public class ReplyVo {
    @ApiModelProperty("用户id")
    @NotNull(message = "用户id不能为空")
    private Long userId;

    @ApiModelProperty("回复内容")
    @NotBlank(message = "回复内容不能为空")
    private String content;

    @ApiModelProperty("父问题id")
    @NotNull(message = "父问题id不能为空")
    private Long parentId;
}
