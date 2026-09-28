package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.entity.SchoolInfoEntity;
import com.hnu.highlynewapp.vo.SchoolInfoVo;

import java.util.List;
import java.util.Map;

/**
 * 学校信息
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
public interface SchoolInfoService extends IService<SchoolInfoEntity> {

    PageUtils queryPage(Map<String, Object> params);
    List<SchoolInfoEntity> getNoCheckList();

    void auth(SchoolInfoVo schoolInfoVo);

    void passCheck(Long schoolId);

    void failCheck(Long schoolId);
}

