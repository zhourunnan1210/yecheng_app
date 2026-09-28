package com.hnu.highlynewapp.service.impl;

import com.hnu.highlynewapp.entity.ContactEntity;
import com.hnu.highlynewapp.service.ContactService;
import com.hnu.highlynewapp.vo.PublishServiceProductVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;

import com.hnu.highlynewapp.dao.ServiceProductDao;
import com.hnu.highlynewapp.entity.ServiceProductEntity;
import com.hnu.highlynewapp.service.ServiceProductService;
import org.springframework.util.StringUtils;


@Service("serviceProductService")
public class ServiceProductServiceImpl extends ServiceImpl<ServiceProductDao, ServiceProductEntity> implements ServiceProductService {

    @Autowired
    private ContactService contactService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<ServiceProductEntity> page = this.page(
                new Query<ServiceProductEntity>().getPage(params),
                new QueryWrapper<ServiceProductEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public void publish(PublishServiceProductVo vo) {
        ContactEntity contactEntity = new ContactEntity();
        BeanUtils.copyProperties(vo,contactEntity);
        Long contactId = contactService.saveAndCheckExist(contactEntity);

        ServiceProductEntity serviceProductEntity = new ServiceProductEntity();
        BeanUtils.copyProperties(vo,serviceProductEntity);
        serviceProductEntity.setPublishTime(new Date());
        serviceProductEntity.setContactId(contactId);
        baseMapper.insert(serviceProductEntity);
    }

    @Override
    public List<ServiceProductEntity> getListByParma(String serviceType) {
        QueryWrapper<ServiceProductEntity> wrapper = new QueryWrapper<>();
        if (!StringUtils.isEmpty(serviceType)) {
            wrapper.eq("service_type", serviceType);
        }
        wrapper.orderByDesc("publish_time");

        List<ServiceProductEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

}