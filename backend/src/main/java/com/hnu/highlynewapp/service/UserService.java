package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.entity.UserEntity;
import com.hnu.highlynewapp.exception.RegisterFailException;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.vo.LoginVo;
import com.hnu.highlynewapp.vo.RegisterVo;
import com.hnu.highlynewapp.vo.UserVo;

import java.util.Map;

/**
 * 用户
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:57
 */
public interface UserService extends IService<UserEntity> {
    PageUtils queryPage(Map<String, Object> params);

    void register(RegisterVo vo) throws RegisterFailException;

    UserVo login(LoginVo loginVo);

    UserVo loginByToken(String token);
}

