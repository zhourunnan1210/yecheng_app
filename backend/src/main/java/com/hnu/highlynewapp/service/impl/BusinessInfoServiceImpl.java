package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.dao.BusinessInfoDao;
import com.hnu.highlynewapp.entity.BusinessInfoEntity;
import com.hnu.highlynewapp.entity.ContactEntity;
import com.hnu.highlynewapp.entity.UserEntity;
import com.hnu.highlynewapp.enums.StatusEnum;
import com.hnu.highlynewapp.service.BusinessInfoService;
import com.hnu.highlynewapp.service.ContactService;
import com.hnu.highlynewapp.service.UserService;
import com.hnu.highlynewapp.transformation.vo.BusinessNeedVo;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;
import com.hnu.highlynewapp.vo.BusinessInfoVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service("businessInfoService")
public class BusinessInfoServiceImpl extends ServiceImpl<BusinessInfoDao, BusinessInfoEntity> implements BusinessInfoService {
    @Autowired
    private BusinessInfoDao businessInfoDao;

    @Autowired
    private ContactService contactService;

    @Autowired
    private UserService userService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<BusinessInfoEntity> page = this.page(
                new Query<BusinessInfoEntity>().getPage(params),
                new QueryWrapper<>()
        );
        return new PageUtils(page);
    }

    @Override
    public List<BusinessInfoEntity> getNoCheckList() {
        return baseMapper.selectList(new QueryWrapper<BusinessInfoEntity>().eq("status", StatusEnum.STATUS_ONE.getCode()));
    }

    @Override
    @Transactional
    public void passCheck(Long businessId) {
        BusinessInfoEntity businessInfoEntity = this.getById(businessId);
        businessInfoEntity.setStatus(StatusEnum.STATUS_TWO.getCode());
        this.updateById(businessInfoEntity);
        UserEntity userEntity = new UserEntity();
        userEntity.setUserId(businessInfoEntity.getUserId());
        userEntity.setType(1);
        userEntity.setStatus(2);
        userService.updateById(userEntity);
    }

    @Override
    @Transactional
    public void auth(BusinessInfoVo businessInfoVo) {
        BusinessInfoEntity businessInfoEntity = new BusinessInfoEntity();
        ContactEntity contactEntity = new ContactEntity();
        BeanUtils.copyProperties(businessInfoVo, businessInfoEntity);
        BeanUtils.copyProperties(businessInfoVo, contactEntity);
        contactEntity.setAddress(businessInfoVo.getContactAddress());
        contactEntity.setEmail(businessInfoVo.getContactEmail());
        contactEntity.setName(businessInfoVo.getContactName());
        contactEntity.setPosition(businessInfoVo.getContactPosition());
        contactEntity.setPhone(businessInfoVo.getContactPhone());
        Long i = contactService.saveAndCheckExist(contactEntity);
        businessInfoEntity.setContactId(i);
        businessInfoEntity.setStatus(StatusEnum.STATUS_ONE.getCode());
        this.save(businessInfoEntity);
        UserEntity user = new UserEntity();
        user.setUserId(businessInfoVo.getUserId());
        user.setStatus(1);
        userService.updateById(user);
    }

    @Override
    @Transactional
    public void failCheck(Long businessId) {
        BusinessInfoEntity businessInfoEntity = this.getById(businessId);
        businessInfoEntity.setStatus(StatusEnum.STATUS_THREE.getCode());
        this.updateById(businessInfoEntity);
        UserEntity userEntity = new UserEntity();
        userEntity.setUserId(businessInfoEntity.getUserId());
        userEntity.setStatus(0);
        userService.updateById(userEntity);
    }

    /**
     * 获取要进行匹配的企业信息
     *
     * @param vo
     * @return
     */
    @Override
    public BusinessInfoEntity getBusinessDetail(BusinessNeedVo vo) {
        QueryWrapper<BusinessInfoEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("name", vo.getName());
        queryWrapper.eq("code", vo.getCode());
        return businessInfoDao.selectOne(queryWrapper);
    }

    @Override
    public Long saveAndCheckExist(BusinessInfoEntity businessInfoEntity) {
        BusinessInfoEntity businessInfoEntity1 = baseMapper.selectOne(new QueryWrapper<BusinessInfoEntity>().eq("website", businessInfoEntity.getWebsite()));
        if (businessInfoEntity1 == null) {
            baseMapper.insert(businessInfoEntity);
            businessInfoEntity1 = baseMapper.selectOne(new QueryWrapper<BusinessInfoEntity>().eq("website", businessInfoEntity.getWebsite()));
        }
        return businessInfoEntity1.getBusinessId();
    }

    @Override
    public BusinessInfoEntity getByBusinessId(Long businessId) {
        BusinessInfoEntity businessInfoEntity = this.baseMapper.selectOne(new QueryWrapper<BusinessInfoEntity>().eq("business_id", businessId));
        return businessInfoEntity;
    }

    @Override
    public BusinessInfoEntity getByUserId(Long userId) {
        QueryWrapper<BusinessInfoEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        queryWrapper.isNotNull("user_id"); // 确保user_id不为null
        // 只允许审核通过（状态为2）的企业使用面试管理功能
        queryWrapper.eq("status", 2);
        return this.baseMapper.selectOne(queryWrapper);
    }
    
    @Override
    public BusinessInfoEntity getByUserIdWithoutStatusFilter(Long userId) {
        QueryWrapper<BusinessInfoEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        queryWrapper.isNotNull("user_id"); // 确保user_id不为null
        return this.baseMapper.selectOne(queryWrapper);
    }
}
