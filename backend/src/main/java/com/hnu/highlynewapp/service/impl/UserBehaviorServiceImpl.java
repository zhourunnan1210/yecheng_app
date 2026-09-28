package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.dao.UserBehaviorDao;
import com.hnu.highlynewapp.entity.UserBehaviorEntity;
import com.hnu.highlynewapp.service.UserBehaviorService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 用户行为
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Service("userBehaviorService")
public class UserBehaviorServiceImpl extends ServiceImpl<UserBehaviorDao, UserBehaviorEntity> implements UserBehaviorService {

    @Override
    @Transactional
    public boolean recordUserBehavior(Long userId, Integer targetType, Long targetId, Integer actionType) {
        // 检查是否已经存在该用户对该目标的任何操作记录
        QueryWrapper<UserBehaviorEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("user_id", userId)
                .eq("target_type", targetType)
                .eq("target_id", targetId);

        UserBehaviorEntity existingBehavior = this.getOne(wrapper);
        
        if (existingBehavior != null) {
            if (actionType == 0) {
                // 如果操作类型为0（撤销），删除记录
                return this.removeById(existingBehavior.getBehaviorId());
            } else {
                // 如果已存在记录，更新操作类型
                existingBehavior.setActionType(actionType);
                return this.updateById(existingBehavior);
            }
        } else {
            // 如果不存在记录且操作类型不为0，创建新的行为记录
            if (actionType != 0) {
                UserBehaviorEntity behavior = new UserBehaviorEntity();
                behavior.setUserId(userId);
                behavior.setTargetType(targetType);
                behavior.setTargetId(targetId);
                behavior.setActionType(actionType);
                return this.save(behavior);
            } else {
                // 如果不存在记录且操作类型为0，直接返回成功
                return true;
            }
        }
    }

    @Override
    public List<Map<String, Object>> getUserLikeTags(Long userId, Integer targetType) {
        return baseMapper.getUserLikeTags(userId, targetType);
    }

    @Override
    public List<Map<String, Object>> getUserMultiDimensionalTags(Long userId, Integer targetType) {
        return baseMapper.getUserMultiDimensionalTags(userId, targetType);
    }

    @Override
    public List<Map<String, Object>> getAllUserMultiDimensionalTags(Long userId, Integer targetType) {
        // 获取用户喜欢的标签
        List<Map<String, Object>> likeTags = baseMapper.getUserMultiDimensionalTags(userId, targetType);
        // 获取用户不喜欢的标签
        List<Map<String, Object>> dislikeTags = baseMapper.getUserDislikeMultiDimensionalTags(userId, targetType);
        
        // 合并喜欢和不喜欢的标签
        likeTags.addAll(dislikeTags);
        return likeTags;
    }

    @Override
    public boolean hasUserBehavior(Long userId, Integer targetType, Long targetId) {
        int count = baseMapper.checkUserBehavior(userId, targetType, targetId);
        return count > 0;
    }

    @Override
    public List<Map<String, Object>> getLikedItems(Long userId, Integer targetType) {
        return baseMapper.getLikedItems(userId, targetType);
    }

    @Override
    public List<Map<String, Object>> getDislikedItems(Long userId, Integer targetType) {
        return baseMapper.getDislikedItems(userId, targetType);
    }
    
    @Override
    public Integer getUserCurrentStatus(Long userId, Integer targetType, Long targetId) {
        QueryWrapper<UserBehaviorEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("user_id", userId)
                .eq("target_type", targetType)
                .eq("target_id", targetId)
                .orderByDesc("create_time")
                .last("LIMIT 1");
        
        UserBehaviorEntity behavior = this.getOne(wrapper);
        return behavior != null ? behavior.getActionType() : 0;
    }
    
    @Override
    public int cleanDuplicateRecords(Long userId, Integer targetType, Long targetId) {
        // 获取该用户对该目标的所有记录
        QueryWrapper<UserBehaviorEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("user_id", userId)
                .eq("target_type", targetType)
                .eq("target_id", targetId)
                .orderByDesc("create_time");
        
        List<UserBehaviorEntity> behaviors = this.list(wrapper);
        
        if (behaviors.size() <= 1) {
            return 0; // 没有重复记录
        }
        
        // 保留最新的记录，删除其他重复记录
        UserBehaviorEntity latestBehavior = behaviors.get(0);
        behaviors.remove(0);
        
        // 删除重复记录
        for (UserBehaviorEntity behavior : behaviors) {
            this.removeById(behavior.getBehaviorId());
        }
        
        return behaviors.size();
    }
} 