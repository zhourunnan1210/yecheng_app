package com.hnu.highlynewapp.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hnu.highlynewapp.entity.InterviewApplicationEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * 面试申请DAO
 *
 * @author interview_system
 * @date 2024
 */
@Mapper
public interface InterviewApplicationDao extends BaseMapper<InterviewApplicationEntity> {

    /**
     * 获取用户申请列表（带岗位和企业信息）
     */
    @Select("SELECT ia.application_id as applicationId, ia.user_id as userId, ia.talent_need_id as talentNeedId, " +
            "ia.company_id as companyId, ia.status, ia.apply_time as applyTime, ia.process_time as processTime, " +
            "ia.remarks, tn.position as positionName, tn.salary_min as salaryMin, tn.salary_max as salaryMax, " +
            "bi.name as companyName " +
            "FROM interview_application ia " +
            "LEFT JOIN talent_need tn ON ia.talent_need_id = tn.talent_need_id " +
            "LEFT JOIN business_info bi ON ia.company_id = bi.business_id " +
            "WHERE ia.user_id = #{userId} AND ia.status = #{status} AND ia.deleted = 0 " +
            "ORDER BY ia.apply_time DESC")
    List<Map<String, Object>> getUserApplicationsWithDetails(@Param("userId") Long userId, 
                                                            @Param("status") Integer status);

    /**
     * 获取企业收到的申请列表（带用户和岗位信息）
     */
    @Select("SELECT ia.application_id as applicationId, ia.user_id as userId, ia.talent_need_id as talentNeedId, " +
            "ia.company_id as companyId, ia.status, ia.apply_time as applyTime, ia.process_time as processTime, " +
            "ia.remarks, u.real_name as realName, u.phone, u.email, tn.position as positionName, " +
            "ts.experience as workExperience, ts.degree, ts.skill " +
            "FROM interview_application ia " +
            "LEFT JOIN user u ON ia.user_id = u.user_id " +
            "LEFT JOIN talent_need tn ON ia.talent_need_id = tn.talent_need_id " +
            "LEFT JOIN talent_supply ts ON ia.user_id = ts.user_id " +
            "WHERE ia.company_id = #{companyId} AND ia.status = #{status} AND ia.deleted = 0 " +
            "ORDER BY ia.apply_time DESC")
    List<Map<String, Object>> getCompanyApplicationsWithDetails(@Param("companyId") Long companyId, 
                                                               @Param("status") Integer status);

    /**
     * 检查用户对特定岗位的申请状态
     */
    @Select("SELECT status FROM interview_application " +
            "WHERE user_id = #{userId} AND talent_need_id = #{talentNeedId} AND deleted = 0")
    Integer checkApplicationStatus(@Param("userId") Long userId, 
                                  @Param("talentNeedId") Long talentNeedId);
}