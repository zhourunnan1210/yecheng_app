package com.hnu.highlynewapp.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hnu.highlynewapp.entity.TalentNeedEntity;
import com.hnu.highlynewapp.entity.TalentSupplyEntity;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 人才需求
 * 
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Mapper
public interface TalentNeedDao extends BaseMapper<TalentNeedEntity> {
    @Select("select * from talent_need where TO_DAYS(NOW()) - TO_DAYS(publish_time) <= #{duration} order by publish_time Desc")
    List<TalentNeedEntity> listByDuration(Integer duration);

    @Select("select * from talent_need where degree = #{degree} order by publish_time Desc")
    List<TalentNeedEntity> listByField(String degree);

    @Select("select * from talent_need where TO_DAYS(NOW()) - TO_DAYS(publish_time) <= #{duration} and degree = #{degree} order by publish_time Desc")
    List<TalentNeedEntity> listByBoth(@Param("duration") Integer duration, @Param("degree") String degree);

    @Select("select * from talent_need where school_check = #{check} order by publish_time Desc")
    List<TalentNeedEntity> listCheckId(Integer check);

    @Select("(select * from talent_need where company_id like CONCAT('%',#{condition},'%') order by publish_time Desc) union (select * from talent_need where position like CONCAT('%',#{condition},'%') order by publish_time Desc)")
    List<TalentNeedEntity> listByCondition(String condition);
	
}
