package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author zhourunnan
 * @Date 2022/1/1 1:34
 */
@Data
@TableName("news")
public class NewsEntity implements Serializable {

    @TableId
    private Long id;
    private String title;
    private String content;
    private String link;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
    private Date publishTime;
    private Date gmtCreate;
    private Date gmtModified;
    private Integer deleted;
}
