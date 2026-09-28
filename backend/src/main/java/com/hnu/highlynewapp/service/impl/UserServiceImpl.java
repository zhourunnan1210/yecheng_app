package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.dao.UserDao;
import com.hnu.highlynewapp.entity.UserEntity;
import com.hnu.highlynewapp.enums.StatusEnum;
import com.hnu.highlynewapp.exception.RegisterFailException;
import com.hnu.highlynewapp.service.UserService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;
import com.hnu.highlynewapp.vo.LoginVo;
import com.hnu.highlynewapp.vo.RegisterVo;
import com.hnu.highlynewapp.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import java.util.Date;
import java.util.Map;
import java.util.UUID;

@Service("userService")
public class UserServiceImpl extends ServiceImpl<UserDao, UserEntity> implements UserService {
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<UserEntity> page = this.page(
                new Query<UserEntity>().getPage(params),
                new QueryWrapper<>()
        );
        return new PageUtils(page);
    }

    @Override
    public void register(RegisterVo registerVo) throws RegisterFailException {
        if (registerVo.getPhone().length() != 11) {
            throw new RegisterFailException("请输入正确的电话号码");
        }
        QueryWrapper<UserEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("phone", registerVo.getPhone());
        UserEntity user = this.getOne(wrapper);
        if (user != null) {
            throw new RegisterFailException("此电话号已注册");
        }
        if (registerVo.getPassword().length() < 6 || registerVo.getPassword().length() > 20) {
            throw new RegisterFailException("请输入6-20位密码");
        }
        if (!registerVo.getPassword().equals(registerVo.getConfirmedPassword())) {
            throw new RegisterFailException("密码和确认密码不匹配");
        }
        UserEntity userEntity = new UserEntity();
        userEntity.setPhone(registerVo.getPhone());
        userEntity.setPassword(DigestUtils.md5DigestAsHex(registerVo.getPassword().getBytes()));
        userEntity.setGmtCreate(new Date());
        userEntity.setGmtModified(userEntity.getGmtCreate());
        // 默认设置用户类型为未认定的普通用户
        userEntity.setType(0);
        userEntity.setStatus(StatusEnum.STATUS_ONE.getCode());
        this.save(userEntity);
    }

    @Override
    public UserVo login(LoginVo loginVo) {
        QueryWrapper<UserEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("phone", loginVo.getPhone())
                .eq("password", DigestUtils.md5DigestAsHex(loginVo.getPassword().getBytes()));
        return getUserVo(wrapper);
    }

    @Override
    public UserVo loginByToken(String token) {
        QueryWrapper<UserEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("token", token);
        return getUserVo(wrapper);
    }

    private UserVo getUserVo(QueryWrapper<UserEntity> wrapper) {
        UserEntity one = this.baseMapper.selectOne(wrapper);
        if (one == null) {
            return null;
        }
        String newToken = UUID.randomUUID().toString().replace("-", "");
        one.setToken(newToken);
        this.baseMapper.updateById(one);
        UserVo vo = new UserVo();
        vo.setUid(one.getUserId());
        vo.setToken(newToken);
        vo.setType(one.getType());
        vo.setPhone(one.getPhone());
        vo.setEmail(one.getEmail());
        return vo;
    }
}