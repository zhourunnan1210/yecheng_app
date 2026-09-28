package com.hnu.highlynewapp.service.impl;

import org.springframework.stereotype.Service;

import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;

import com.hnu.highlynewapp.dao.ContactDao;
import com.hnu.highlynewapp.entity.ContactEntity;
import com.hnu.highlynewapp.service.ContactService;

@Service("contactService")
public class ContactServiceImpl extends ServiceImpl<ContactDao, ContactEntity> implements ContactService {
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<ContactEntity> page = this.page(
                new Query<ContactEntity>().getPage(params),
                new QueryWrapper<>()
        );
        return new PageUtils(page);
    }

    @Override
    public Long saveAndCheckExist(ContactEntity contactEntity) {
        ContactEntity contactEntity1 = baseMapper.selectOne(new QueryWrapper<ContactEntity>().eq("phone", contactEntity.getPhone()));
        if (contactEntity1 == null) {
            baseMapper.insert(contactEntity);
            contactEntity1 = baseMapper.selectOne(new QueryWrapper<ContactEntity>().eq("phone", contactEntity.getPhone()));
        }
        return contactEntity1.getContactId();
    }

    @Override
    public ContactEntity getByContactId(Long contactId) {
        ContactEntity contactEntity = this.baseMapper.selectOne(new QueryWrapper<ContactEntity>().eq("contact_id", contactId));
        return contactEntity;
    }
}
