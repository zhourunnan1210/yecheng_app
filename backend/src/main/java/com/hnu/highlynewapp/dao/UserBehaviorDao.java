package com.hnu.highlynewapp.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hnu.highlynewapp.entity.UserBehaviorEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

/**
 * 用户行为
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Mapper
public interface UserBehaviorDao extends BaseMapper<UserBehaviorEntity> {

    /**
     * 获取用户喜欢的标签统计
     * @param userId 用户ID
     * @param targetType 目标类型 [1:岗位, 2:简历]
     * @return 标签及其权重
     */
    @Select("SELECT " +
            "CASE WHEN ub.target_type = 1 THEN tn.position " +
            "     WHEN ub.target_type = 2 THEN ts.job " +
            "END as tag, " +
            "CASE WHEN ub.target_type = 1 THEN 'position' " +
            "     WHEN ub.target_type = 2 THEN 'job' " +
            "END as tag_type, " +
            "COUNT(*) as weight " +
            "FROM user_behavior ub " +
            "LEFT JOIN talent_need tn ON ub.target_id = tn.talent_need_id AND ub.target_type = 1 " +
            "LEFT JOIN talent_supply ts ON ub.target_id = ts.talent_supply_id AND ub.target_type = 2 " +
            "WHERE ub.user_id = #{userId} AND ub.target_type = #{targetType} AND ub.action_type = 1 " +
            "GROUP BY tag, tag_type " +
            "ORDER BY weight DESC")
    List<Map<String, Object>> getUserLikeTags(@Param("userId") Long userId, @Param("targetType") Integer targetType);

    /**
     * 获取用户喜欢的多维度标签统计
     * @param userId 用户ID
     * @param targetType 目标类型 [1:岗位, 2:简历]
     * @return 多维度标签及其权重
     */
    @Select("SELECT " +
            "CASE WHEN ub.target_type = 1 THEN tn.position " +
            "     WHEN ub.target_type = 2 THEN ts.job " +
            "END as position_tag, " +
            "CASE WHEN ub.target_type = 1 THEN tn.location " +
            "     WHEN ub.target_type = 2 THEN NULL " +
            "END as location_tag, " +
            "CASE WHEN ub.target_type = 1 THEN tn.degree " +
            "     WHEN ub.target_type = 2 THEN ts.degree " +
            "END as degree_tag, " +
            "CASE WHEN ub.target_type = 1 THEN CONCAT(tn.salary_min, '-', tn.salary_max) " +
            "     WHEN ub.target_type = 2 THEN CONCAT(ts.salary_min, '-', ts.salary_max) " +
            "END as salary_tag, " +
            "CASE WHEN ub.target_type = 1 THEN tn.title1 " +
            "     WHEN ub.target_type = 2 THEN ts.quality " +
            "END as feature_tag, " +
            "COUNT(*) as weight " +
            "FROM user_behavior ub " +
            "LEFT JOIN talent_need tn ON ub.target_id = tn.talent_need_id AND ub.target_type = 1 " +
            "LEFT JOIN talent_supply ts ON ub.target_id = ts.talent_supply_id AND ub.target_type = 2 " +
            "WHERE ub.user_id = #{userId} AND ub.target_type = #{targetType} AND ub.action_type = 1 " +
            "GROUP BY position_tag, location_tag, degree_tag, salary_tag, feature_tag " +
            "ORDER BY weight DESC")
    List<Map<String, Object>> getUserMultiDimensionalTags(@Param("userId") Long userId, @Param("targetType") Integer targetType);

    /**
     * 获取用户不喜欢的多维度标签统计
     * @param userId 用户ID
     * @param targetType 目标类型 [1:岗位, 2:简历]
     * @return 多维度标签及其权重（负权重表示不喜欢）
     */
    @Select("SELECT " +
            "CASE WHEN ub.target_type = 1 THEN tn.position " +
            "     WHEN ub.target_type = 2 THEN ts.job " +
            "END as position_tag, " +
            "CASE WHEN ub.target_type = 1 THEN tn.location " +
            "     WHEN ub.target_type = 2 THEN NULL " +
            "END as location_tag, " +
            "CASE WHEN ub.target_type = 1 THEN tn.degree " +
            "     WHEN ub.target_type = 2 THEN ts.degree " +
            "END as degree_tag, " +
            "CASE WHEN ub.target_type = 1 THEN CONCAT(tn.salary_min, '-', tn.salary_max) " +
            "     WHEN ub.target_type = 2 THEN CONCAT(ts.salary_min, '-', ts.salary_max) " +
            "END as salary_tag, " +
            "CASE WHEN ub.target_type = 1 THEN tn.title1 " +
            "     WHEN ub.target_type = 2 THEN ts.quality " +
            "END as feature_tag, " +
            "-COUNT(*) as weight " +
            "FROM user_behavior ub " +
            "LEFT JOIN talent_need tn ON ub.target_id = tn.talent_need_id AND ub.target_type = 1 " +
            "LEFT JOIN talent_supply ts ON ub.target_id = ts.talent_supply_id AND ub.target_type = 2 " +
            "WHERE ub.user_id = #{userId} AND ub.target_type = #{targetType} AND ub.action_type = 2 " +
            "GROUP BY position_tag, location_tag, degree_tag, salary_tag, feature_tag " +
            "ORDER BY weight ASC")
    List<Map<String, Object>> getUserDislikeMultiDimensionalTags(@Param("userId") Long userId, @Param("targetType") Integer targetType);

    /**
     * 检查用户是否已经对某个目标进行过操作
     * @param userId 用户ID
     * @param targetType 目标类型
     * @param targetId 目标ID
     * @return 操作记录数量
     */
    @Select("SELECT COUNT(*) FROM user_behavior " +
            "WHERE user_id = #{userId} AND target_type = #{targetType} AND target_id = #{targetId}")
    int checkUserBehavior(@Param("userId") Long userId, @Param("targetType") Integer targetType, @Param("targetId") Long targetId);

    /**
     * 获取用户喜欢的列表
     * @param userId 用户ID
     * @param targetType 目标类型 [1:岗位, 2:简历]
     * @return 喜欢的项目列表
     */
    @Select("SELECT " +
            "CASE WHEN ub.target_type = 1 THEN tn.talent_need_id " +
            "     WHEN ub.target_type = 2 THEN ts.talent_supply_id " +
            "END as id, " +
            "CASE WHEN ub.target_type = 1 THEN tn.position " +
            "     WHEN ub.target_type = 2 THEN ts.name " +
            "END as title, " +
            "CASE WHEN ub.target_type = 1 THEN tn.position " +
            "     WHEN ub.target_type = 2 THEN ts.profession " +
            "END as job, " +
            "CASE WHEN ub.target_type = 1 THEN tn.image " +
            "     WHEN ub.target_type = 2 THEN ts.image " +
            "END as image, " +
            "CASE WHEN ub.target_type = 1 THEN tn.degree " +
            "     WHEN ub.target_type = 2 THEN ts.degree " +
            "END as degree, " +
            "CASE WHEN ub.target_type = 1 THEN CONCAT(tn.salary_min, 'k-', tn.salary_max, 'k') " +
            "     WHEN ub.target_type = 2 THEN CONCAT(ts.salary_min, 'k-', ts.salary_max, 'k') " +
            "END as salary, " +
            "CASE WHEN ub.target_type = 1 THEN tn.publish_time " +
            "     WHEN ub.target_type = 2 THEN ts.publish_time " +
            "END as publish_time " +
            "FROM user_behavior ub " +
            "LEFT JOIN talent_need tn ON ub.target_id = tn.talent_need_id AND ub.target_type = 1 " +
            "LEFT JOIN talent_supply ts ON ub.target_id = ts.talent_supply_id AND ub.target_type = 2 " +
            "WHERE ub.user_id = #{userId} AND ub.target_type = #{targetType} AND ub.action_type = 1 " +
            "ORDER BY ub.create_time DESC")
    List<Map<String, Object>> getLikedItems(@Param("userId") Long userId, @Param("targetType") Integer targetType);

    /**
     * 获取用户不喜欢的列表
     * @param userId 用户ID
     * @param targetType 目标类型 [1:岗位, 2:简历]
     * @return 不喜欢的项目列表
     */
    @Select("SELECT " +
            "CASE WHEN ub.target_type = 1 THEN tn.talent_need_id " +
            "     WHEN ub.target_type = 2 THEN ts.talent_supply_id " +
            "END as id, " +
            "CASE WHEN ub.target_type = 1 THEN tn.position " +
            "     WHEN ub.target_type = 2 THEN ts.name " +
            "END as title, " +
            "CASE WHEN ub.target_type = 1 THEN tn.position " +
            "     WHEN ub.target_type = 2 THEN ts.profession " +
            "END as job, " +
            "CASE WHEN ub.target_type = 1 THEN tn.image " +
            "     WHEN ub.target_type = 2 THEN ts.image " +
            "END as image, " +
            "CASE WHEN ub.target_type = 1 THEN tn.degree " +
            "     WHEN ub.target_type = 2 THEN ts.degree " +
            "END as degree, " +
            "CASE WHEN ub.target_type = 1 THEN CONCAT(tn.salary_min, 'k-', tn.salary_max, 'k') " +
            "     WHEN ub.target_type = 2 THEN CONCAT(ts.salary_min, 'k-', ts.salary_max, 'k') " +
            "END as salary, " +
            "CASE WHEN ub.target_type = 1 THEN tn.publish_time " +
            "     WHEN ub.target_type = 2 THEN ts.publish_time " +
            "END as publish_time " +
            "FROM user_behavior ub " +
            "LEFT JOIN talent_need tn ON ub.target_id = tn.talent_need_id AND ub.target_type = 1 " +
            "LEFT JOIN talent_supply ts ON ub.target_id = ts.talent_supply_id AND ub.target_type = 2 " +
            "WHERE ub.user_id = #{userId} AND ub.target_type = #{targetType} AND ub.action_type = 2 " +
            "ORDER BY ub.create_time DESC")
    List<Map<String, Object>> getDislikedItems(@Param("userId") Long userId, @Param("targetType") Integer targetType);
    
    /**
     * 清理重复的用户行为记录，保留最新的记录
     * @param userId 用户ID
     * @param targetType 目标类型
     * @param targetId 目标ID
     * @return 删除的记录数量
     */
    @Select("DELETE FROM user_behavior " +
            "WHERE user_id = #{userId} AND target_type = #{targetType} AND target_id = #{targetId} " +
            "AND behavior_id != (" +
            "  SELECT behavior_id FROM user_behavior " +
            "  WHERE user_id = #{userId} AND target_type = #{targetType} AND target_id = #{targetId} " +
            "  ORDER BY create_time DESC LIMIT 1" +
            ")")
    int cleanDuplicateRecords(@Param("userId") Long userId, @Param("targetType") Integer targetType, @Param("targetId") Long targetId);
} 