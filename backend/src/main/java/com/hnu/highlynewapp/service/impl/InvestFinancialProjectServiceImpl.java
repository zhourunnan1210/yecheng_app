package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.dao.InvestFinancialProjectDao;
import com.hnu.highlynewapp.entity.InvestFinancialProjectEntity;
import com.hnu.highlynewapp.entity.InvestingNeedEntity;
import com.hnu.highlynewapp.service.InvestFinancialProjectService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;

@Service("investFinancialProjectService")
public class InvestFinancialProjectServiceImpl extends ServiceImpl<InvestFinancialProjectDao, InvestFinancialProjectEntity> implements InvestFinancialProjectService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<InvestFinancialProjectEntity> page = this.page(
                new Query<InvestFinancialProjectEntity>().getPage(params),
                new QueryWrapper<InvestFinancialProjectEntity>()
        );
        return new PageUtils(page);
    }

    @Override
    public List<InvestFinancialProjectEntity> getListByParma() {
        return null;
    }

    @Override
    public void publish(InvestFinancialProjectEntity investFinancialProjectEntity) {
        baseMapper.insert(investFinancialProjectEntity);

    }

    @Override
    public List<InvestFinancialProjectEntity> getListByNameOrRecordNum(String param) {
        QueryWrapper<InvestFinancialProjectEntity> wrapper = new QueryWrapper<>();
        if(!StringUtils.isEmpty(param)&&!"全部".equals(param)){
            if(param.matches("[0-9]{4,}")){
                wrapper.like("project_record_number",param);
            }
            else{
                wrapper.like("project_name",param);
            }
        }

        wrapper.orderByDesc("project_id");
        List<InvestFinancialProjectEntity> list = baseMapper.selectList(wrapper);
        return list;
    }
    @Override
    public List<InvestFinancialProjectEntity> getProgressDescriptionByProjectName(String projectName){
        QueryWrapper<InvestFinancialProjectEntity> wrapper = new QueryWrapper<>();
        wrapper.like("project_name",projectName);
        List<InvestFinancialProjectEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

    @Override
    public List<InvestFinancialProjectEntity> getSuccessList1(){
        QueryWrapper<InvestFinancialProjectEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("success_flag",1).eq("audit_result",1).isNotNull("investing_need_id");
        List<InvestFinancialProjectEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

    @Override
    public List<InvestFinancialProjectEntity> getSuccessList2(){
        QueryWrapper<InvestFinancialProjectEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("success_flag",1).eq("audit_result",1).isNotNull("investing_need_id").orderByDesc("start_date").last("limit 4");
        List<InvestFinancialProjectEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

    @Override
    public List<InvestFinancialProjectEntity> getSuccessList3(){
        QueryWrapper<InvestFinancialProjectEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("success_flag",1).eq("audit_result",1).isNotNull("financial_need_id");
        List<InvestFinancialProjectEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

    @Override
    public List<InvestFinancialProjectEntity> getSuccessList4(){
        QueryWrapper<InvestFinancialProjectEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("success_flag",1).eq("audit_result",1).isNotNull("financial_need_id").orderByDesc("start_date").last("limit 4");
        List<InvestFinancialProjectEntity> list = baseMapper.selectList(wrapper);
        return list;
    }

    @Override
    public List<InvestFinancialProjectEntity> getBySimpleProjectName(String projectName){
        QueryWrapper<InvestFinancialProjectEntity> wrapper = new QueryWrapper<>();
        wrapper.like("project_name",projectName);
        List<InvestFinancialProjectEntity> list = baseMapper.selectList(wrapper);
        return list;
    }
}
