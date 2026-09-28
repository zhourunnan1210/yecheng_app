package com.hnu.highlynewapp.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hnu.highlynewapp.entity.TechnologyNeedEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 技术需求
 * 
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Mapper
@Repository
public interface TechnologyNeedDao extends BaseMapper<TechnologyNeedEntity> {
    @Select("select * from technology_need where TO_DAYS(NOW()) - TO_DAYS(publish_time) <= #{duration} order by publish_time Desc")
    List<TechnologyNeedEntity> listByDuration(Integer duration);

    @Select("select * from technology_need where field = #{field} order by publish_time Desc")
    List<TechnologyNeedEntity> listByField(String field);

    @Select("select * from technology_need where TO_DAYS(NOW()) - TO_DAYS(publish_time) <= #{duration} and field = #{field} order by publish_time Desc")
    List<TechnologyNeedEntity> listByBoth(@Param("duration") Integer duration, @Param("field") String field);
}
