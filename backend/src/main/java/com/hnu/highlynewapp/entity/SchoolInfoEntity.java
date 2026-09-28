package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

/**
 * 学校信息
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Data
@TableName("school_info")
public class SchoolInfoEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId(type = IdType.AUTO)
    private Long schoolId;

    /**
     * 名称
     */
    private String name;

    /**
     * 网址
     */
    private String website;

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
    private String code;

    /**
     * 固定电话
     */
    private String telephone;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 联系人id
     */
    private Long contactId;

    /**
     * 学校图片
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

    /**
     * 主要研究领域
     */
    private String researchField;
}
