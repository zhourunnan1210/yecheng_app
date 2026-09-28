package com.hnu.highlynewapp.transformation.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.hnu.highlynewapp.transformation.pojo.Area;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 省/市/区/地址
 */
@Mapper
@Repository
public interface AreaMapper extends BaseMapper<Area> {
    /**
     * 根据Pid查找市或区
     *
     * @param Pid
     * @return
     */
    @Select("<script>" +
            "SELECT * FROM china" +
            "<where>" +
            "<if test='Pid != null'>Pid = #{Pid}</if>" +
            "</where>" +
            "</script>")
    List<Area> findAreasByPid(Integer Pid);
}
