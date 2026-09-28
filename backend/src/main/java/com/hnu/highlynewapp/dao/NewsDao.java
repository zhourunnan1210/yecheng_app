package com.hnu.highlynewapp.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hnu.highlynewapp.entity.NewsEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author zhourunnan
 * @Date 2022/1/1 1:38
 */
@Mapper
public interface NewsDao extends BaseMapper<NewsEntity> {
}
