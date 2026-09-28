package com.hnu.highlynewapp.service.impl;

import com.hnu.highlynewapp.entity.ContactEntity;
import com.hnu.highlynewapp.service.ContactService;
import com.hnu.highlynewapp.vo.FinancialNeedSearchVo;
import com.hnu.highlynewapp.vo.InvestFinanceAuditVo;
import com.hnu.highlynewapp.vo.PublishFinancialNeedVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;

import com.hnu.highlynewapp.dao.FinancingNeedDao;
import com.hnu.highlynewapp.entity.FinancingNeedEntity;
import com.hnu.highlynewapp.service.FinancingNeedService;
import org.springframework.util.StringUtils;


@Service("financingNeedService")
public class FinancingNeedServiceImpl extends ServiceImpl<FinancingNeedDao, FinancingNeedEntity> implements FinancingNeedService {

    @Autowired
    private ContactService contactService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<FinancingNeedEntity> page = this.page(
                new Query<FinancingNeedEntity>().getPage(params),
                new QueryWrapper<FinancingNeedEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public List<FinancingNeedEntity> listByCondition(String duration, String field) {
        List<FinancingNeedEntity> byDuration = new ArrayList<>();
        List<FinancingNeedEntity> byField = new ArrayList<>();
        QueryWrapper<FinancingNeedEntity> wrapper= new QueryWrapper<>();
        wrapper.eq("audit_flag",1);
        int i = 0;
        switch (duration) {
            case "一个月内":
                i = 30;
                break;
            case "三个月内":
                i = 90;
                break;
            case "六个月内":
                i = 180;
                break;
            case "一年内":
                i = 365;
                break;
            default:
                i = -1;
                break;
        }
        List<FinancingNeedEntity> result = new ArrayList<>();
        if ("全部".equals(duration)&&"全部".equals(field)) {
            wrapper.orderByDesc("publish_time");
            result = this.list(wrapper);
        } else if (!"全部".equals(duration)&&"全部".equals(field)){
            result = this.getBaseMapper().listByDuration(i);
        } else if ("全部".equals(duration)&&!"全部".equals(field)) {
            result = this.getBaseMapper().listByField(field);
        } else {
            result = this.getBaseMapper().listByBoth(i,field);
        }
        return result;
    }

    @Override
    public void publish(PublishFinancialNeedVo vo) {
        ContactEntity contactEntity = new ContactEntity();
        BeanUtils.copyProperties(vo,contactEntity);
        Long contactId = contactService.saveAndCheckExist(contactEntity);

        FinancingNeedEntity financingNeedEntity = new FinancingNeedEntity();
        BeanUtils.copyProperties(vo,financingNeedEntity);
        financingNeedEntity.setPublishTime(new Date());
        financingNeedEntity.setContactId(contactId);
        baseMapper.insert(financingNeedEntity);
    }


    /**
     * 根据企业ID查询所有的融资需求
     * @param businessID
     * @return
     */
    @Override
    public List<FinancingNeedEntity> listByBusinessID(long businessID) {
        QueryWrapper<FinancingNeedEntity> wrapper = new QueryWrapper();
        wrapper.eq("business_id",businessID).orderByDesc("publish_time");
        List<FinancingNeedEntity> list = this.list(wrapper);
        return list;
    }

    /**
     * 根据 FinancingneedSearchVo查询所有的融资需求
     * @param vo
     * @return
     */
    @Override
    public List<FinancingNeedEntity> getListByParma(FinancialNeedSearchVo vo) {
        int i = 0;
        if(!StringUtils.isEmpty(vo.getDuration())){
            switch (vo.getDuration()) {
                case "一个月内":
                    i = 30;
                    break;
                case "三个月内":
                    i = 90;
                    break;
                case "六个月内":
                    i = 180;
                    break;
                case "一年内":
                    i = 365;
                    break;
                default:
                    i = -1;
                    break;
            }
        }
        LocalDate startdate = LocalDate.now().minusDays(i);
        System.out.println("--------------开始日期为："+startdate);

        QueryWrapper<FinancingNeedEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("audit_flag",1);


            if (!StringUtils.isEmpty(vo.getField())&&!"全部".equals(vo.getField())) {
                wrapper.eq("field", vo.getField());
            }
            if (!StringUtils.isEmpty(vo.getFinancingMoney())&&!"全部".equals(vo.getFinancingMoney())) {
                wrapper.eq("financing_money", vo.getFinancingMoney());
            }
            if (!StringUtils.isEmpty(vo.getDuration()) &&!"全部".equals(vo.getDuration())) {
                wrapper.apply("date_format(publish_time,'%Y-%m-%d') >= date_format('" + startdate + "','%Y-%m-%d')");
            }

        wrapper.orderByDesc("publish_time");
        List<FinancingNeedEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

    /**
     * 根据 InvestFinanceAuditVo查询 符合审核进度的 融资需求
     * @param auditVo
     * @return
     */
    @Override
    public List<FinancingNeedEntity> getAuditList(InvestFinanceAuditVo auditVo) {
        int i = 0;
        if(!StringUtils.isEmpty(auditVo.getReleaseTime())){
            switch (auditVo.getReleaseTime()) {
                case "一个月内":
                    i = 30;
                    break;
                case "三个月内":
                    i = 90;
                    break;
                case "六个月内":
                    i = 180;
                    break;
                case "一年内":
                    i = 365;
                    break;
                default:
                    i = -1;
                    break;
            }
        }
        LocalDate startdate = LocalDate.now().minusDays(i);
        System.out.println("--------------开始日期为："+startdate);

        QueryWrapper<FinancingNeedEntity> wrapper = new QueryWrapper<>();

        if (!StringUtils.isEmpty(auditVo.getAuditFlag())&&!"全部".equals(auditVo.getAuditFlag())) {
            wrapper.eq("audit_flag", auditVo.getAuditFlag());
        }
        if(!StringUtils.isEmpty(auditVo.getIndustryField())&&!"全部".equals(auditVo.getIndustryField())){
            wrapper.eq("field", auditVo.getIndustryField());
        }
        if(!StringUtils.isEmpty(auditVo.getReleaseTime())&&!"全部".equals(auditVo.getReleaseTime())){
            wrapper.apply("date_format(publish_time,'%Y-%m-%d') >= date_format('" + startdate + "','%Y-%m-%d')");
        }

        wrapper.orderByDesc("publish_time");
        List<FinancingNeedEntity> list = baseMapper.selectList(wrapper);
        return list;
    }
    @Override
    public List<FinancingNeedEntity> getSuccessList(){
        QueryWrapper<FinancingNeedEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("success_flag",0);
        List<FinancingNeedEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

    @Override
    public List<FinancingNeedEntity> getSuccessList2(){
        QueryWrapper<FinancingNeedEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("success_flag",0).orderByDesc("publish_time").last("limit 4");
        List<FinancingNeedEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

    @Override
    public List<FinancingNeedEntity> getListByTitle(String title) {
        QueryWrapper<FinancingNeedEntity> wrapper = new QueryWrapper<>();
        wrapper.like("title",title);
        wrapper.orderByDesc("publish_time");
        List<FinancingNeedEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

    //查询所有融资条目
    @Override
    public List<FinancingNeedEntity> getFList() {
        QueryWrapper<FinancingNeedEntity> wrapper = new QueryWrapper<>();
        wrapper.orderByDesc("publish_time");
        return baseMapper.selectList(wrapper);
    }
}