package com.hnu.highlynewapp.vo;

import io.swagger.annotations.ApiModel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@ApiModel("高校认证")
@Data
public class SchoolInfoVo {
    private Long schoolId;

    @NotBlank(message = "学校名称不能为空")
    private String name;

    /**
     * 网址
     */
    @NotBlank(message = "学校网址不能为空")
    private String website;

    /**
     * 位置（省市县）
     */
    @NotBlank(message = "位置（省市县）不能为空")
    private String location;

    /**
     * 详细地址
     */
    @NotBlank(message = "详细地址不能为空")
    private String address;

    /**
     * 统一社会信用代码
     */
    @NotBlank(message = "统一社会信用代码不能为空")
    private String code;

    /**
     * 固定电话
     */
    @NotBlank(message = "固定电话不能为空")
    private String telephone;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 公司图片
     */
    @NotBlank(message = "学校图片不能为空")
    private String imageUrl;

    /**
     * 审核所需资料
     */
    @NotBlank(message = "审核所需资料图片不能为空")
    private String examineImage;

    /**
     * 主要研究领域
     */
    private String researchField;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 姓名
     */
    @NotBlank(message = "联系人姓名不能为空")
    private String contactName;

    /**
     * 电话
     */
    @NotBlank(message = "联系人电话不能为空")
    private String contactPhone;

    /**
     * 邮箱
     */
    @NotBlank(message = "联系人邮箱不能为空")
    private String contactEmail;

    /**
     * 地址
     */
    private String contactAddress;

    /**
     * 单位
     */
    private String contactPosition;
}
