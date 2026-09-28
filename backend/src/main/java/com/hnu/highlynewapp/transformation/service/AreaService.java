package com.hnu.highlynewapp.transformation.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.transformation.pojo.Area;

import java.util.List;

/**
 * 省/市/区/地址
 */
public interface AreaService extends IService<Area> {
    List<Area> findAllProvinces();

    List<Area> findAreasByPid(Integer Pid);
}
