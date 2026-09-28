package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.util.Date;

/**
 * @author zhourunnan
 * @Date 2021/9/19 1:46
 */
@Data
@TableName("all_index")
public class IndexEntity {

    @TableId
    private Long id;

    private String type;

    private String name;

    private Integer sort;

    private Long parentId;

    @TableField(fill = FieldFill.INSERT)
    private Date gmtCreate;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date gmtModified;

    @TableLogic
    @TableField(fill = FieldFill.INSERT)
    private Integer deleted;
}
