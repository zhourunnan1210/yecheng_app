package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.entity.UserBehaviorEntity;

import java.util.List;
import java.util.Map;

/**
 * 用户行为
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
public interface UserBehaviorService extends IService<UserBehaviorEntity> {

    /**
     * 记录用户行为
     * @param userId 用户ID
     * @param targetType 目标类型 [1:岗位, 2:简历]
     * @param targetId 目标ID
     * @param actionType 操作类型 [1:喜欢, 2:不喜欢]
     * @return 是否成功
     */
    boolean recordUserBehavior(Long userId, Integer targetType, Long targetId, Integer actionType);

    /**
     * 获取用户喜欢的标签统计
     * @param userId 用户ID
     * @param targetType 目标类型 [1:岗位, 2:简历]
     * @return 标签及其权重
     */
    List<Map<String, Object>> getUserLikeTags(Long userId, Integer targetType);

    /**
     * 获取用户喜欢的多维度标签统计
     * @param userId 用户ID
     * @param targetType 目标类型 [1:岗位, 2:简历]
     * @return 多维度标签及其权重
     */
    List<Map<String, Object>> getUserMultiDimensionalTags(Long userId, Integer targetType);

    /**
     * 获取用户所有多维度标签统计（包括喜欢和不喜欢的）
     * @param userId 用户ID
     * @param targetType 目标类型 [1:岗位, 2:简历]
     * @return 多维度标签及其权重（正权重表示喜欢，负权重表示不喜欢）
     */
    List<Map<String, Object>> getAllUserMultiDimensionalTags(Long userId, Integer targetType);

    /**
     * 检查用户是否已经对某个目标进行过操作
     * @param userId 用户ID
     * @param targetType 目标类型
     * @param targetId 目标ID
     * @return 是否已操作
     */
    boolean hasUserBehavior(Long userId, Integer targetType, Long targetId);

    /**
     * 获取用户喜欢的列表
     * @param userId 用户ID
     * @param targetType 目标类型 [1:岗位, 2:简历]
     * @return 喜欢的项目列表
     */
    List<Map<String, Object>> getLikedItems(Long userId, Integer targetType);

    /**
     * 获取用户不喜欢的列表
     * @param userId 用户ID
     * @param targetType 目标类型 [1:岗位, 2:简历]
     * @return 不喜欢的项目列表
     */
    List<Map<String, Object>> getDislikedItems(Long userId, Integer targetType);
    
    /**
     * 获取用户对特定目标的当前状态
     * @param userId 用户ID
     * @param targetType 目标类型 [1:岗位, 2:简历]
     * @param targetId 目标ID
     * @return 操作类型 [1:喜欢, 2:不喜欢, 0:无操作]
     */
    Integer getUserCurrentStatus(Long userId, Integer targetType, Long targetId);
    
    /**
     * 清理重复的用户行为记录
     * @param userId 用户ID
     * @param targetType 目标类型
     * @param targetId 目标ID
     * @return 删除的记录数量
     */
    int cleanDuplicateRecords(Long userId, Integer targetType, Long targetId);
} 