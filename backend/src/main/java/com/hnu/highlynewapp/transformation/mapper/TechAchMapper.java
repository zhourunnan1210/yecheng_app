package com.hnu.highlynewapp.transformation.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.hnu.highlynewapp.entity.TechnologyAchievementEntity;
import com.hnu.highlynewapp.transformation.vo.FindTechAchVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 技术成果
 */
@Mapper
@Repository
public interface TechAchMapper extends BaseMapper<TechnologyAchievementEntity> {
    /**
     * 根据技术成果id查找技术成果的详细信息
     *
     * @param technologyAchievementId
     * @return
     */
    FindTechAchVo findOneByTechAchId(Long technologyAchievementId);

    /**
     * 根据参数查找全部分页
     *
     * @param page          分页参数
     * @param publisherType 发布者类型 [1：高新企业，3：学校]
     * @param publisherId   企业或者学校id，根据发布者类型判断
     * @return
     */
//    IPage<FindTechAchVo> findAllPagesByPublisher(@Param("page") IPage<FindTechAchVo> page, @Param("publisherType") Integer publisherType, @Param("publisherId") Integer publisherId);
}
