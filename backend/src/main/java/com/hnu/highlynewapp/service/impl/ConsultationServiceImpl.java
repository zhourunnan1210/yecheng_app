package com.hnu.highlynewapp.service.impl;

import com.hnu.highlynewapp.dao.ConsultationDao;
import com.hnu.highlynewapp.entity.ConsultationEntity;
import com.hnu.highlynewapp.entity.UserEntity;
import com.hnu.highlynewapp.service.ConsultationService;
import com.hnu.highlynewapp.service.UserService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.Query;
import com.hnu.highlynewapp.vo.ConsultationResVo;
import com.hnu.highlynewapp.vo.PublishConsultationVo;
import com.hnu.highlynewapp.vo.ReplyVo;
import org.apache.commons.lang.StringUtils;
import org.jsoup.helper.StringUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;


@Service("consultationService")
public class ConsultationServiceImpl extends ServiceImpl<ConsultationDao, ConsultationEntity> implements ConsultationService {

    @Autowired
    private UserService userService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<ConsultationEntity> page = this.page(
                new Query<ConsultationEntity>().getPage(params),
                new QueryWrapper<ConsultationEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public void publish(PublishConsultationVo vo) {
        ConsultationEntity consultationEntity = new ConsultationEntity();
        BeanUtils.copyProperties(vo,consultationEntity);
        this.save(consultationEntity);
    }

    /**
     * 查询所有咨询问题并整合对应的回复
     * @return
     * @param type
     */
    @Override
    public List<ConsultationResVo> listCombine(String category) {
        QueryWrapper<ConsultationEntity> wrapper = new QueryWrapper<>();
        if (category!=null && category.length() >0) {
            wrapper.eq("category", category);
        }
        wrapper.eq("parent_id", 0);
        List<ConsultationEntity> p0 = baseMapper.selectList(wrapper);
        List<ConsultationEntity> p1 = baseMapper.selectList(new QueryWrapper<ConsultationEntity>()
                .ne("parent_id", 0));
        List<ConsultationResVo> collect = p0.stream().map(p00 -> {
            ConsultationResVo consultationResVo = new ConsultationResVo();
            BeanUtils.copyProperties(p00, consultationResVo);
            for (ConsultationEntity p11 : p1) {
                if (p00.getId() == p11.getParentId()) {
                    consultationResVo.setChild(p11);
                }
            }
            return consultationResVo;
        }).collect(Collectors.toList());

        return collect;
    }

    @Override
    public List<ConsultationResVo> listByUserId(Long userId) {
        List<ConsultationEntity> consultationEntities = baseMapper.selectList(new QueryWrapper<ConsultationEntity>()
                .eq("user_id", userId));
        List<ConsultationResVo> collect = consultationEntities.stream().map(c -> {
            ConsultationResVo consultationResVo = new ConsultationResVo();
            BeanUtils.copyProperties(c, consultationResVo);
            ConsultationEntity child = baseMapper.selectOne(new QueryWrapper<ConsultationEntity>()
                    .eq("parent_id", c.getId()));
            consultationResVo.setChild(child);
            return consultationResVo;
        }).collect(Collectors.toList());
        return collect;
    }

    @Override
    public void reply(ReplyVo vo) {
        ConsultationEntity consultationEntity = new ConsultationEntity();
        consultationEntity.setContent(vo.getContent());
        consultationEntity.setUserId(vo.getUserId());
//        UserEntity user = userService.getById(vo.getContent());
//        consultationEntity.setPhone(user.getPhone());
//        consultationEntity.setEmail(user.getEmail());
        consultationEntity.setParentId(vo.getParentId());
        this.save(consultationEntity);
    }

}