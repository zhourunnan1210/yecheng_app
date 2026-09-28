package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.entity.PeopleRequireEachPositionEntity;
import com.hnu.highlynewapp.entity.TalentNeedEntity;
import com.hnu.highlynewapp.entity.TalentSupplyEntity;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.vo.PublishTalentNeedVo;
import com.hnu.highlynewapp.vo.TalentNeedSearchVo;

import java.util.List;
import java.util.Map;

/**
 * 人才需求
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
public interface TalentNeedService extends IService<TalentNeedEntity> {
    PageUtils queryPage(Map<String, Object> params);

    void publish(PublishTalentNeedVo vo);

    List<TalentNeedEntity> getListByParma();

    List<TalentNeedEntity> listByCondition(String duration, String degree);

    List<TalentNeedEntity> listByCheckId(Integer check);

    List<TalentNeedEntity> getConditionList(String condition);

    // 统计每个岗位所需要的人数
    List<PeopleRequireEachPositionEntity> getNumberOfPeopleRequiredEachPosition();

    // 根据userId查询当前用户发布的人才需求
    TalentNeedSearchVo getByUserId(String userId);

    // 根据userId查询当前用户发布的人才需求
    TalentNeedSearchVo getByTalentNeedId(String talentNeedId);

    // 保存组合向量
    int saveCombinedEmbedding(Long talentNeedId, String position, String job, String demand);

    // 批量保存组合向量
    int batchSaveCombinedEmbeddings();

    //List<TalentSupplyEntity> recommendTalents(TalentNeedEntity position);

    // 基于文本模型的搜索（使用新的Qwen3模型）
    List<TalentNeedEntity> searchByLM(String prompt);

    /**
     * 根据用户ID推荐简历
     *
     * @param userId 用户ID
     * @return 推荐的简历列表
     */
    List<TalentSupplyEntity> recommendTalentsByUserId(Long userId);
}
