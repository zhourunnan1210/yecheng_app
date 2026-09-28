package com.hnu.highlynewapp.dao;

import com.hnu.highlynewapp.entity.TimeIndexEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 时间检索
 * 
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-04 22:01:46
 */
@Mapper
public interface TimeIndexDao extends BaseMapper<TimeIndexEntity> {
	
}
