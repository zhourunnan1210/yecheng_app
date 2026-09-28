package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author astupidcoder
 * @since 2021-01-24
 */
@Data
@TableName("park")
public class ParkEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 园区id
     */
    @TableId(value = "park_id", type = IdType.AUTO)
    private Integer parkId;

    /**
     * 园区名称
     */
    private String parkName;

    /**
     * 园区图片url
     */
    private String parkImageUrl;

    /**
     * 园区电话
     */
    private String parkPhone;

    /**
     * 园区网址
     */
    private String parkWebsite;

    /**
     * 园区简介
     */
    private String parkIntroduction;

    /**
     * 园区头像
     */
    private String avatar;

    /**
     * 配套设施
     */
    private String parkSupporting;

    /**
     * 优惠政策
     */
    private String favouredPolicy;

    /**
     * 产品定位
     */
    private String productPositioning;

    /**
     * 招商重点
     */
    private String keyPoints;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date gmtCreate;
    
    /**
     * 修改时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date gmtModified;
    
    /**
     * 删除标记
     */
    @TableField(fill = FieldFill.INSERT)
    @TableLogic
    private Integer deleted;

}
