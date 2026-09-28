package com.hnu.highlynewapp.service.impl;

import com.hnu.highlynewapp.entity.ContactEntity;
import com.hnu.highlynewapp.entity.TalentSupplyEntity;
import com.hnu.highlynewapp.service.ContactService;
import com.hnu.highlynewapp.vo.FinancialProSearchVo;
import com.hnu.highlynewapp.vo.PublishFinancialProductVo;
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

import com.hnu.highlynewapp.dao.FinancialProductDao;
import com.hnu.highlynewapp.entity.FinancialProductEntity;
import com.hnu.highlynewapp.service.FinancialProductService;
import org.springframework.util.StringUtils;


@Service("financialProductService")
public class FinancialProductServiceImpl extends ServiceImpl<FinancialProductDao, FinancialProductEntity> implements FinancialProductService {

    @Autowired
    private ContactService contactService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<FinancialProductEntity> page = this.page(
                new Query<FinancialProductEntity>().getPage(params),
                new QueryWrapper<FinancialProductEntity>()
        );
        return new PageUtils(page);
    }

    @Override
    public void publish(PublishFinancialProductVo vo) {
        ContactEntity contactEntity = new ContactEntity();
        BeanUtils.copyProperties(vo,contactEntity);
        contactEntity.setName(vo.getContactName());
        Long contactId = contactService.saveAndCheckExist(contactEntity);

        FinancialProductEntity financialProductEntity = new FinancialProductEntity();
        BeanUtils.copyProperties(vo,financialProductEntity);
        financialProductEntity.setPublishTime(new Date());
        financialProductEntity.setContactId(contactId);
        baseMapper.insert(financialProductEntity);
    }

    @Override
    public List<FinancialProductEntity> getListByParma(FinancialProSearchVo vo) {

        QueryWrapper<FinancialProductEntity> wrapper = new QueryWrapper<>();

         if (!StringUtils.isEmpty(vo.getEnsureMethod())&&!"全部".equals(vo.getEnsureMethod())) {
                wrapper.eq("ensure_method", vo.getEnsureMethod());}
         if (!StringUtils.isEmpty(vo.getLoanDeadline())&&!"全部".equals(vo.getLoanDeadline())) {
                wrapper.eq("loan_deadline", vo.getLoanDeadline());}
         if (!StringUtils.isEmpty(vo.getLoanMoney())&&!"全部".equals(vo.getLoanMoney())) {
                wrapper.eq("loan_money", vo.getLoanMoney());}
         if (!StringUtils.isEmpty(vo.getLoanType())&&!"全部".equals(vo.getLoanType())){
                wrapper.eq("loan_type", vo.getLoanType());
            }

        wrapper.orderByDesc("publish_time");
        List<FinancialProductEntity> list = baseMapper.selectList(wrapper);;
        return list;
    }


}