package com.hnu.highlynewapp.dao;

import com.hnu.highlynewapp.entity.TalentSupplyEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hnu.highlynewapp.entity.TechnologyAchievementEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 人才供应
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Mapper
public interface TalentSupplyDao extends BaseMapper<TalentSupplyEntity> {

    @Select("select * from talent_supply where TO_DAYS(NOW()) - TO_DAYS(publish_time) <= #{duration} order by publish_time Desc")
    List<TalentSupplyEntity> listByDuration(Integer duration);

    @Select("select * from talent_supply where degree = #{degree} order by publish_time Desc")
    List<TalentSupplyEntity> listByField(String degree);

    @Select("select * from talent_supply where TO_DAYS(NOW()) - TO_DAYS(publish_time) <= #{duration} and degree = #{degree} order by publish_time Desc")
    List<TalentSupplyEntity> listByBoth(@Param("duration") Integer duration, @Param("degree") String degree);

    @Select("select * from talent_supply where school_check = #{check} order by publish_time Desc")
    List<TalentSupplyEntity> listCheckId(Integer check);

    @Select("(select * from talent_supply where name like CONCAT('%',#{condition},'%') order by publish_time Desc) union (select * from talent_supply where skill like CONCAT('%',#{condition},'%') order by publish_time Desc)")
    List<TalentSupplyEntity> listCondition(String condition);
}
