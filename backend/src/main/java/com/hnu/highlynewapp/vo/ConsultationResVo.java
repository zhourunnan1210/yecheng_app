package com.hnu.highlynewapp.vo;

import com.hnu.highlynewapp.entity.ConsultationEntity;
import lombok.Data;

import java.util.Date;

/**
 * @author zhourunnan
 * @Date 2021/4/19 10:48
 */
@Data
public class ConsultationResVo {
    private Long id;
    /**
     * 用户id
     */
    private Long userId;
    /**
     * 咨询内容类型
     */
    private String category;
    /**
     * 咨询内容
     */
    private String content;
    /**
     * 邮箱
     */
    private String email;
    /**
     * 联系电话
     */
    private String phone;
    /**
     * 发布时间
     */
    private Date publishTime;
    /**
     * 是否已读
     */
    private Integer isRead;
    private ConsultationEntity child;
}
