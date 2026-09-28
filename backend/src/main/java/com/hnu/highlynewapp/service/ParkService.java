package com.hnu.highlynewapp.service;

import com.hnu.highlynewapp.entity.ParkEntity;
import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.utils.PageUtils;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author astupidcoder
 * @since 2021-01-24
 */
public interface ParkService extends IService<ParkEntity> {
    PageUtils queryPage(Map<String, Object> params);

    List<ParkEntity> getLastTwo();
}
