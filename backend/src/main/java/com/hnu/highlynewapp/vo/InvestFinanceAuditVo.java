package com.hnu.highlynewapp.vo;

import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("检索投资需求列表")
public class InvestFinanceAuditVo {
    @TableId
    @ApiModelProperty("投资意向审核结果（0-正在审核中，1-通过，2-不通过）")
    private Long auditFlag;

    @ApiModelProperty("行业领域")
    private String industryField;

    @ApiModelProperty("发布时间")
    private String releaseTime;
}
