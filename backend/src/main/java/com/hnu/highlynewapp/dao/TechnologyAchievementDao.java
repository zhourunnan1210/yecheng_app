package com.hnu.highlynewapp.dao;

import com.hnu.highlynewapp.entity.TechnologyAchievementEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 技术成果
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Mapper
@Repository
public interface TechnologyAchievementDao extends BaseMapper<TechnologyAchievementEntity> {
    @Select("select * from technology_achievement where TO_DAYS(NOW()) - TO_DAYS(publish_time) <= #{duration} order by publish_time Desc")
    List<TechnologyAchievementEntity> listByDuration(Integer duration);

    @Select("select * from technology_achievement where field = #{field} order by publish_time Desc")
    List<TechnologyAchievementEntity> listByField(String field);

    @Select("select * from technology_achievement where TO_DAYS(NOW()) - TO_DAYS(publish_time) <= #{duration} and field = #{field} order by publish_time Desc")
    List<TechnologyAchievementEntity> listByBoth(@Param("duration") Integer duration, @Param("field") String field);
}
