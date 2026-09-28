package com.hnu.highlynewapp.dao;

import com.hnu.highlynewapp.entity.UserEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * 用户
 * 
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:57
 */
@Mapper
public interface UserDao extends BaseMapper<UserEntity> {
	
}
