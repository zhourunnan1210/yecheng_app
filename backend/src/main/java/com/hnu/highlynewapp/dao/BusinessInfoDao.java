package com.hnu.highlynewapp.dao;

import com.hnu.highlynewapp.entity.BusinessInfoEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/**
 * 企业信息
 * 
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:57
 */
@Mapper
@Repository
public interface BusinessInfoDao extends BaseMapper<BusinessInfoEntity> {
	
}
