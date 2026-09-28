package com.hnu.highlynewapp.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

@Data
@TableName("invest_financial_project")
@ApiModel("投融资项目")
public class InvestFinancialProjectEntity {

  @TableId
  @ApiModelProperty("投融资项目id")
  private Long projectId;
  @ApiModelProperty("项目名")
  private String projectName;
  @ApiModelProperty("联系人姓名")
  private String contactName;
  @ApiModelProperty("联系人电话")
  private String contactPhone;
  @ApiModelProperty("投资需求id")
  private long investingNeedId;
  @ApiModelProperty("融资需求id")
  private long financialNeedId;
  @ApiModelProperty("审核结果(audit result)，（0-正在审核中，1-通过，2-不通过）")
  private long auditResult;
  @ApiModelProperty("项目备案号")
  private long projectRecordNumber;
  @ApiModelProperty("项目状态(success_flag)（0-成功，1-进行中,2-失败）")
  private long successFlag;
  @ApiModelProperty("项目进度描述")
  private String progressDescription;
  @ApiModelProperty("项目开始日期")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
  private java.sql.Timestamp startDate;
  @ApiModelProperty("项目结束日期")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss" , timezone = "GMT+8")
  private java.sql.Timestamp endDate;
  @ApiModelProperty("项目备注")
  private String notes;

  @ApiModelProperty("项目概念图")
  private String projectImage;


  public Long getProjectId() {
    return projectId;
  }

  public void setProjectId(Long projectId) {
    this.projectId = projectId;
  }


  public String getProjectName() {
    return projectName;
  }

  public void setProjectName(String projectName) {
    this.projectName = projectName;
  }


  public String getContactName() {
    return contactName;
  }

  public void setContactName(String contactName) {
    this.contactName = contactName;
  }


  public String getContactPhone() {
    return contactPhone;
  }

  public void setContactPhone(String contactPhone) {
    this.contactPhone = contactPhone;
  }


  public long getInvestingNeedId() {
    return investingNeedId;
  }

  public void setInvestingNeedId(long investingNeedId) {
    this.investingNeedId = investingNeedId;
  }


  public long getFinancialNeedId() {
    return financialNeedId;
  }

  public void setFinancialNeedId(long financialNeedId) {
    this.financialNeedId = financialNeedId;
  }


  public long getAuditResult() {
    return auditResult;
  }

  public void setAuditResult(long auditResult) {
    this.auditResult = auditResult;
  }


  public long getProjectRecordNumber() {
    return projectRecordNumber;
  }

  public void setProjectRecordNumber(long projectRecordNumber) {
    this.projectRecordNumber = projectRecordNumber;
  }


  public long getSuccessFlag() {
    return successFlag;
  }

  public void setSuccessFlag(long successFlag) {
    this.successFlag = successFlag;
  }


  public String getProgressDescription() {
    return progressDescription;
  }

  public void setProgressDescription(String progressDescription) {
    this.progressDescription = progressDescription;
  }


  public java.sql.Timestamp getStartDate() {
    return startDate;
  }

  public void setStartDate(java.sql.Timestamp startDate) {
    this.startDate = startDate;
  }


  public java.sql.Timestamp getEndDate() {
    return endDate;
  }

  public void setEndDate(java.sql.Timestamp endDate) {
    this.endDate = endDate;
  }


  public String getNotes() {
    return notes;
  }

  public void setNotes(String notes) {
    this.notes = notes;
  }

}
