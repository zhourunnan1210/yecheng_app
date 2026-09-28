package com.hnu.highlynewapp.dao;

import com.hnu.highlynewapp.entity.FinancingNeedEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 融资需求
 * 
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Mapper
public interface FinancingNeedDao extends BaseMapper<FinancingNeedEntity> {
    @Select("select * from financing_need where TO_DAYS(NOW()) - TO_DAYS(publish_time) <= #{duration} order by publish_time Desc")
    List<FinancingNeedEntity> listByDuration(Integer duration);

    @Select("select * from financing_need where field = #{field} order by publish_time Desc")
    List<FinancingNeedEntity> listByField(String field);

    @Select("select * from financing_need where TO_DAYS(NOW()) - TO_DAYS(publish_time) <= #{duration} and field = #{field} order by publish_time Desc")
    List<FinancingNeedEntity> listByBoth(@Param("duration") Integer duration, @Param("field") String field);
}
