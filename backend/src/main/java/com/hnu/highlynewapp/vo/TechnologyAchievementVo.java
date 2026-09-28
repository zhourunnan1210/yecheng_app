package com.hnu.highlynewapp.vo;

import com.hnu.highlynewapp.utils.R;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiParam;
import lombok.Data;

@Data
@ApiModel("双条件检索科技成果")
public class TechnologyAchievementVo {
    @ApiModelProperty(value = "用户登录时获取到的gid(团体id)",required = true)
    private long publisherId;
    @ApiModelProperty(value = "用户登录时获取到的type(认证类型)",required = true)
    private Integer publisherType;
}
