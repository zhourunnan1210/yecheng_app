package com.hnu.highlynewapp.service.impl;

import com.hnu.highlynewapp.entity.ContactEntity;
import com.hnu.highlynewapp.entity.UserEntity;
import com.hnu.highlynewapp.enums.StatusEnum;
import com.hnu.highlynewapp.service.ContactService;
import com.hnu.highlynewapp.service.UserService;
import com.hnu.highlynewapp.vo.SchoolInfoVo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;

import com.hnu.highlynewapp.dao.SchoolInfoDao;
import com.hnu.highlynewapp.entity.SchoolInfoEntity;
import com.hnu.highlynewapp.service.SchoolInfoService;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;


@Service("schoolInfoService")
public class SchoolInfoServiceImpl extends ServiceImpl<SchoolInfoDao, SchoolInfoEntity> implements SchoolInfoService {

    @Resource
    private UserService userService;

    @Resource
    private ContactService contactService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<SchoolInfoEntity> page = this.page(
                new Query<SchoolInfoEntity>().getPage(params),
                new QueryWrapper<SchoolInfoEntity>()
        );

        return new PageUtils(page);
    }
    @Override
    public List<SchoolInfoEntity> getNoCheckList() {
        List<SchoolInfoEntity> list=baseMapper.selectList(new QueryWrapper<SchoolInfoEntity>().eq("status", StatusEnum.STATUS_ONE.getCode()));
        return list;
    }

    @Override
    @Transactional
    public void auth(SchoolInfoVo schoolInfoVo) {
        SchoolInfoEntity schoolInfoEntity = new SchoolInfoEntity();
        System.out.println(schoolInfoVo);
        ContactEntity contactEntity = new ContactEntity();
        BeanUtils.copyProperties(schoolInfoVo, schoolInfoEntity);
        BeanUtils.copyProperties(schoolInfoVo, contactEntity);

        contactEntity.setAddress(schoolInfoVo.getContactAddress());
        contactEntity.setEmail(schoolInfoVo.getContactEmail());
        contactEntity.setName(schoolInfoVo.getContactName());
        contactEntity.setPhone(schoolInfoVo.getContactPhone());
        contactEntity.setPosition(schoolInfoVo.getContactPosition());
        Long i = contactService.saveAndCheckExist(contactEntity);
        schoolInfoEntity.setContactId(i);
        schoolInfoEntity.setStatus(StatusEnum.STATUS_ONE.getCode());
        this.save(schoolInfoEntity);
        UserEntity user = new UserEntity();
        user.setUserId(schoolInfoVo.getUserId());
        user.setStatus(1);
        userService.updateById(user);
    }

    @Override
    @Transactional
    public void passCheck(Long schoolId) {
        SchoolInfoEntity schoolInfoEntity=this.getById(schoolId);
        schoolInfoEntity.setStatus(StatusEnum.STATUS_TWO.getCode());
        this.updateById(schoolInfoEntity);

        UserEntity userEntity = new UserEntity();
        userEntity.setUserId(schoolInfoEntity.getUserId());
        userEntity.setType(3);
        userEntity.setStatus(2);
        userService.updateById(userEntity);
    }

    @Override
    @Transactional
    public void failCheck(Long schoolId) {
        SchoolInfoEntity schoolInfoEntity=this.getById(schoolId);
        schoolInfoEntity.setStatus(StatusEnum.STATUS_THREE.getCode());
        this.updateById(schoolInfoEntity);

        UserEntity userEntity = new UserEntity();
        userEntity.setUserId(schoolInfoEntity.getUserId());
        userEntity.setStatus(0);
        userService.updateById(userEntity);
    }

}