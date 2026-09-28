package com.hnu.highlynewapp.transformation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.transformation.mapper.TechAchMapper;
import com.hnu.highlynewapp.entity.TechnologyAchievementEntity;
import com.hnu.highlynewapp.transformation.service.TechAchService;
import com.hnu.highlynewapp.transformation.vo.FindTechAchVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("techAchService")
public class TechAchServiceImpl extends ServiceImpl<TechAchMapper, TechnologyAchievementEntity> implements TechAchService {
    @Autowired
    private TechAchMapper techAchMapper;

    /**
     * 根据技术成果id查找技术成果
     *
     * @param technologyAchievementId
     * @return
     */
    public FindTechAchVo findOneByTechAchId(Long technologyAchievementId) {
        return techAchMapper.findOneByTechAchId(technologyAchievementId);
    }

    //    /**
//     * 根据参数查询分页
//     *
//     * @param params        分页参数：limit和page
//     * @param publisherType 发布者类型 [1：高新企业，3：学校]
//     * @param publisherId   企业或者学校id，根据发布者类型判断
//     * @return
//     */
//    @Override
//    public PageUtils queryPageByPublisher(Map<String, Object> params, Integer publisherType, Integer publisherId) {
//        QueryWrapper<TechnologyAchievementEntity> queryWrapper = new QueryWrapper<>();
//        IPage<TechnologyAchievementEntity> page = this.page(
//                new Query<TechnologyAchievementEntity>().getPage(params),
//                new QueryWrapper<>()
//        );
//
//        return new PageUtils(techAchMapper.findAllPagesByPublisher(page, publisherType, publisherId));
//    }
}
