package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * @author zhourunnan
 * @Date 2021/1/6
 */
@Data
@ApiModel("发布政策请求参数")
public class PublishPolicyVo {
    /**
     * 标题
     */
    @ApiModelProperty(value = "政策标题",required = true)
    private String title;
    /**
     * 文号
     */
    @ApiModelProperty(value = "文号",required = true)
    private String number;
    /**
     * 分类
     */
    @NotBlank(message = "分类不能为空")
    @ApiModelProperty(value = "分类",required = true)
    private String category;
    /**
     * 内容
     */
    @NotBlank(message = "内容不能为空")
    @ApiModelProperty(value = "内容")
    private String content;
    /**
     * 链接
     */
    @ApiModelProperty(value = "链接")
    private String link;
    /**
     * 详情图片
     */
    @ApiModelProperty(value = "详情图片")
    private String image;
    /**
     * 附件
     */
    @ApiModelProperty(value = "附件")
    private String addition;
    /**
     * userid
     */
    @NotNull(message = "userid不能为空")
    @ApiModelProperty(value = "userid",required = true)
    private Long userId;
}
