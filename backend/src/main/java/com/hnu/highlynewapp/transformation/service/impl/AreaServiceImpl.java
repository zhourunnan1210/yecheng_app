package com.hnu.highlynewapp.transformation.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.transformation.mapper.AreaMapper;
import com.hnu.highlynewapp.transformation.pojo.Area;
import com.hnu.highlynewapp.transformation.service.AreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("areaService")
public class AreaServiceImpl extends ServiceImpl<AreaMapper, Area> implements AreaService {
    @Autowired
    private AreaMapper areaMapper;

    /**
     * 查找所有省
     *
     * @return
     */
    @Override
    public List<Area> findAllProvinces() {
        QueryWrapper<Area> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("Pid", 0);
        return areaMapper.selectList(queryWrapper);
    }

    /**
     * 根据Pid查找市或区
     *
     * @param Pid
     * @return
     */
    @Override
    public List<Area> findAreasByPid(Integer Pid) {
        return areaMapper.findAreasByPid(Pid);
    }
}
