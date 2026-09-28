package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.dao.InvestingNeedDao;
import com.hnu.highlynewapp.entity.*;
import com.hnu.highlynewapp.service.InvestingNeedService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;
import com.hnu.highlynewapp.vo.InvestFinanceAuditVo;
import com.hnu.highlynewapp.vo.InvestingNeedSearchVo;
import com.hnu.highlynewapp.vo.InvestingSearchByParamVo;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@Service("investingNeedService")
public class InvestingNeedServiceImpl extends ServiceImpl<InvestingNeedDao, InvestingNeedEntity> implements InvestingNeedService{


    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<InvestingNeedEntity> page = this.page(
                new Query<InvestingNeedEntity>().getPage(params),
                new QueryWrapper<InvestingNeedEntity>()
        );

        return new PageUtils(page);
    }


    @Override
    public List<InvestingNeedEntity> getListByParma(InvestingSearchByParamVo vo) {

        QueryWrapper<InvestingNeedEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("audit_flag",1);

            if (!StringUtils.isEmpty(vo.getInvestType())&&!"全部".equals(vo.getInvestType())) {
                wrapper.eq("invest_type", vo.getInvestType());
            }
            if (!StringUtils.isEmpty(vo.getIndustryField())&&!"全部".equals(vo.getIndustryField())) {
                wrapper.eq("industry_field", vo.getIndustryField());
            }
            if (!StringUtils.isEmpty(vo.getInvestingMoney())&&!"全部".equals(vo.getInvestingMoney())) {
                wrapper.eq("investing_money", vo.getInvestingMoney());
            }


        wrapper.orderByDesc("release_time");
        List<InvestingNeedEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

    @Override
    public void publish(InvestingNeedEntity investingNeedEntity){
        baseMapper.insert(investingNeedEntity);

    }

    @Override
    public List<InvestingNeedEntity> getByFinancialInstitutionId(long financial_institution_id){
        QueryWrapper<InvestingNeedEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("financial_institution_id",financial_institution_id);
        List<InvestingNeedEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

    /**
     * 根据 InvestFinanceAuditVo查询 符合审核进度的 投资需求
     * @param auditVo
     * @return
     */
    @Override
    public List<InvestingNeedEntity> getAuditList(InvestFinanceAuditVo auditVo) {
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

        QueryWrapper<InvestingNeedEntity> wrapper = new QueryWrapper<>();

        if (!StringUtils.isEmpty(auditVo.getAuditFlag())&&!"全部".equals(auditVo.getAuditFlag())) {
            wrapper.eq("audit_flag", auditVo.getAuditFlag());
        }
        if(!StringUtils.isEmpty(auditVo.getIndustryField())&&!"全部".equals(auditVo.getIndustryField())){
            wrapper.eq("industry_field", auditVo.getIndustryField());
        }
        if(!StringUtils.isEmpty(auditVo.getReleaseTime())&&!"全部".equals(auditVo.getReleaseTime())){
            wrapper.apply("date_format(release_time,'%Y-%m-%d') >= date_format('" + startdate + "','%Y-%m-%d')");
        }

        wrapper.orderByDesc("release_time");
        List<InvestingNeedEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

    public InvestingNeedEntity getByInvestNeedId(Long investNeedId){
        InvestingNeedEntity investingNeedEntity = baseMapper.selectById(investNeedId);
        return investingNeedEntity;
    }


    @Override
    public List<InvestingNeedEntity> getSuccessList(){
        QueryWrapper<InvestingNeedEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("success_flag",0);
        List<InvestingNeedEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

    @Override
    public List<InvestingNeedEntity> getSuccessList2(){
        QueryWrapper<InvestingNeedEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("success_flag",0).orderByDesc("release_time").last("limit 4");
        List<InvestingNeedEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

    @Override
    public List<InvestingNeedEntity> getListByCompanyName(String companyName) {
        QueryWrapper<InvestingNeedEntity> wrapper = new QueryWrapper<>();
        wrapper.like("company_name",companyName);
        wrapper.orderByDesc("release_time");
        List<InvestingNeedEntity> list = baseMapper.selectList(wrapper);
        return list;
    }
    @Override
    public List<InvestingNeedEntity> getList() {
        QueryWrapper<InvestingNeedEntity> wrapper = new QueryWrapper<>();
        wrapper.orderByDesc("release_time");
        return baseMapper.selectList(wrapper);
    }
}
