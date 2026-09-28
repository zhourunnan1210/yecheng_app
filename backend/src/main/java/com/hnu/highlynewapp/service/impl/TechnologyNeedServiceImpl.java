package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.dao.ContactDao;
import com.hnu.highlynewapp.dao.TechnologyNeedDao;
import com.hnu.highlynewapp.entity.BusinessInfoEntity;
import com.hnu.highlynewapp.entity.ContactEntity;
import com.hnu.highlynewapp.entity.TechnologyNeedEntity;
import com.hnu.highlynewapp.service.BusinessInfoService;
import com.hnu.highlynewapp.service.ContactService;
import com.hnu.highlynewapp.service.TechnologyNeedService;
import com.hnu.highlynewapp.transformation.constans.Constant;
import com.hnu.highlynewapp.transformation.vo.BusinessNeedVo;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.vo.PublishTechNeedVo;
import org.springframework.util.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service("technologyNeedService")
public class TechnologyNeedServiceImpl extends ServiceImpl<TechnologyNeedDao, TechnologyNeedEntity> implements TechnologyNeedService {
    @Autowired
    private BusinessInfoService businessInfoService;

    @Autowired
    private ContactDao contactDao;

    @Autowired
    private ContactService contactService;

    @Autowired
    private TechnologyNeedDao technologyNeedDao;

    /**
     * 分页查询技术需求
     *
     * @param params
     * @return
     */
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<TechnologyNeedEntity> page = this.page(
                new Query<TechnologyNeedEntity>().getPage(params),
                new QueryWrapper<>()
        );
        return new PageUtils(page);
    }

    /**
     * 发布技术需求
     *
     * @param vo
     */
    @Override
    public void publish(PublishTechNeedVo vo) {
        ContactEntity contactEntity = new ContactEntity();
        contactEntity.setName(vo.getContactName());
        contactEntity.setPhone(vo.getContactPhone());
        contactEntity.setEmail(vo.getContactEmail());
        Long contactId = contactService.saveAndCheckExist(contactEntity);
        // 如果修改了名字和邮箱，要对contact表进行更新
        contactEntity.setContactId(contactId);
        contactDao.updateById(contactEntity);
        TechnologyNeedEntity technologyNeedEntity = new TechnologyNeedEntity();
        BeanUtils.copyProperties(vo, technologyNeedEntity);
        technologyNeedEntity.setPublishTime(new Date());
        technologyNeedEntity.setContactId(contactId);
        baseMapper.insert(technologyNeedEntity);
    }

    /**
     * 根据条件查询技术需求
     *
     * @param duration
     * @param field
     * @return
     */
    @Override
    public List<TechnologyNeedEntity> listByCondition(String duration, String field) {
        int i;
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
        List<TechnologyNeedEntity> result;
        if ("全部".equals(duration) && "全部".equals(field)) {
            QueryWrapper<TechnologyNeedEntity> wrapper = new QueryWrapper<>();
            wrapper.orderByDesc("publish_time");
            result = this.list(wrapper);
        } else if (!"全部".equals(duration) && "全部".equals(field)) {
            result = this.getBaseMapper().listByDuration(i);
        } else if ("全部".equals(duration) && !"全部".equals(field)) {
            result = this.getBaseMapper().listByField(field);
        } else {
            result = this.getBaseMapper().listByBoth(i, field);
        }
        return result;
    }

    /**
     * 根据企业ID查询所有的技术需求
     *
     * @param businessID
     * @return
     */
    @Override
    public List<TechnologyNeedEntity> listByBusinessID(long businessID) {
        QueryWrapper<TechnologyNeedEntity> wrapper = new QueryWrapper();
        wrapper.eq("business_id", businessID).orderByDesc("publish_time");
        List<TechnologyNeedEntity> list = this.list(wrapper);
        return list;
    }

    /**
     * 根据关键词模糊查询技术需求
     *
     * @param keyword
     * @return
     */
    @Override
    public List<TechnologyNeedEntity> search(String keyword) {
        QueryWrapper<TechnologyNeedEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.like(StringUtils.hasText(keyword), "title", keyword);
        return this.list(queryWrapper);
    }

    /**
     * 根据多个技术需求id删除多个技术需求
     *
     * @param technologyNeedIds
     * @return
     */
    @Override
    public int deleteTechnologyNeed(Long[] technologyNeedIds) {
        return technologyNeedDao.deleteBatchIds(Arrays.asList(technologyNeedIds));
    }

    /**
     * 根据技术需求id更新技术需求的信息
     *
     * @param vo
     * @return
     */
    @Override
    public int updateTechnologyNeed(PublishTechNeedVo vo) {
        ContactEntity contactEntity = new ContactEntity();
        contactEntity.setName(vo.getContactName());
        contactEntity.setPhone(vo.getContactPhone());
        contactEntity.setEmail(vo.getContactEmail());
        Long contactId = contactService.saveAndCheckExist(contactEntity);
        // 如果修改了名字和邮箱，要对contact表进行更新
        contactEntity.setContactId(contactId);
        int result1 = contactDao.updateById(contactEntity);

        TechnologyNeedEntity technologyNeedEntity = new TechnologyNeedEntity();
        BeanUtils.copyProperties(vo, technologyNeedEntity);
        technologyNeedEntity.setUpdateTime(new Date());
        int result2 = technologyNeedDao.updateById(technologyNeedEntity);

        return result1 * result2;
    }

    /**
     * 根据输入的企业信息查询企业技术需求名称，做成单选框
     *
     * @param vo
     * @return
     */
    @Override
    public List<String> getNeedTitle(BusinessNeedVo vo) {
        BusinessInfoEntity businessInfoEntity = businessInfoService.getBusinessDetail(vo);
        List<TechnologyNeedEntity> entities = listByBusinessID(businessInfoEntity.getBusinessId());
        ArrayList<String> titles = new ArrayList<>();
        for (TechnologyNeedEntity entity : entities) {
            titles.add(entity.getTitle());
        }
        return titles;
    }

    /**
     * 获取要匹配的技术需求
     *
     * @param vo
     * @param title
     * @return
     */
    @Override
    public TechnologyNeedEntity getNeedDetail(BusinessNeedVo vo, String title) {
        BusinessInfoEntity businessInfoEntity = businessInfoService.getBusinessDetail(vo);
        Long businessId = businessInfoEntity.getBusinessId();
        QueryWrapper<TechnologyNeedEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("title", title);
        queryWrapper.eq("business_id", businessId);
        return technologyNeedDao.selectOne(queryWrapper);
    }

    /**
     * 获取企业和技术需求信息，用于智能匹配
     *
     * @param vo
     * @param title
     */
    @Override
    public void businessNeedMap(BusinessNeedVo vo, String title) {
        BusinessInfoEntity businessInfoEntity = businessInfoService.getBusinessDetail(vo);
        TechnologyNeedEntity technologyNeedEntity = getNeedDetail(vo, title);
        HashMap<BusinessInfoEntity, TechnologyNeedEntity> map = new HashMap<>();
        map.put(businessInfoEntity, technologyNeedEntity);
        Constant.businessNeedCacheMap = map;
    }

    /**
     * 分页查询所有技术需求
     *
     * @param pageNo
     * @param pageSize
     * @return
     */
    @Override
    public R listAllTechnologyNeed(Integer pageNo, Integer pageSize) {
        QueryWrapper<TechnologyNeedEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("publish_time");

        Page<TechnologyNeedEntity> page = new Page<>(pageNo, pageSize);
        Page<TechnologyNeedEntity> iPage = technologyNeedDao.selectPage(page, queryWrapper);

        List<TechnologyNeedEntity> records = iPage.getRecords();
        List<PublishTechNeedVo> publishTechNeedVos = records.stream().map(
                TechnologyNeedEntity -> {
                    PublishTechNeedVo techNeedVo = new PublishTechNeedVo();
                    BeanUtils.copyProperties(TechnologyNeedEntity, techNeedVo);
                    return techNeedVo;
                }
        ).collect(Collectors.toList());
        PageUtils pageUtils = new PageUtils(publishTechNeedVos, (int) iPage.getTotal(), pageSize, pageNo);
        return R.ok().put("page", pageUtils);
    }

    /**
     * 获取所有技术需求行业领域的列表
     *
     * @return
     */
    @Override
    public Set<String> getFieldsList() {
        QueryWrapper<TechnologyNeedEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("distinct field");
        List<Object> list = technologyNeedDao.selectObjs(queryWrapper);
        Set<String> fields = new HashSet<>();
        for (Object item : list)
            fields.add((String) item);
        fields.remove(null);
        return fields;
    }
}