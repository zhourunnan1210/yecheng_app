package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

/**
 * 企业信息
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:57
 */
@Data
@TableName("business_info")
public class BusinessInfoEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId
    private Long businessId;

    /**
     * 名称
     */
    private String name;

    /**
     * 法人
     */
    private String legalPerson;

    /**
     * 类型 [1：有效期高企，2：培育库入库企业，3：当年申报企业]
     */
    private Integer type;

    /**
     * 经营范围
     */
    private String manegeScope;

    /**
     * 简介
     */
    private String introduction;

    /**
     * 成立日期
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date foundDate;

    /**
     * 经营期限
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date manegeDeadline;

    /**
     * 网站
     */
    private String website;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 注册资本
     */
    private String capital;

    /**
     * 位置（省市县）
     */
    private String location;

    /**
     * 详细地址
     */
    private String address;

    /**
     * 统一社会信用代码
     */
    private String unifiedSocialCode;

    /**
     * 固定电话
     */
    private String telephone;

    /**
     * 联系人id
     */
    private Long contactId;

    /**
     * 登记机关
     */
    private String regOffice;

    /**
     * 核准日期
     */
    private Date examineDate;

    /**
     * 公司图片
     */
    private String imageUrl;

    /**
     * 审核所需资料
     */
    private String examineImage;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 审核状态 [0：未审核，1：正在审核，2：审核通过，3：审核失败]
     */
    private Integer status;
}
