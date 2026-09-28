package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.entity.PeopleRequireEachPositionEntity;
import com.hnu.highlynewapp.entity.TalentNeedEntity;
import com.hnu.highlynewapp.entity.TalentSupplyEntity;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.vo.PublishTalentSupplyVo;
import com.hnu.highlynewapp.vo.TalentSupplySearchVo;

import java.util.List;
import java.util.Map;

/**
 * 人才供应
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
public interface TalentSupplyService extends IService<TalentSupplyEntity> {
    PageUtils queryPage(Map<String, Object> params);

    void publish(PublishTalentSupplyVo vo);

    List<TalentSupplyEntity> getListByParma();

    List<TalentSupplyEntity> listByCondition(String duration, String degree);

    List<TalentSupplyEntity> listByCheckId(Integer check);

    List<TalentSupplyEntity> getConditionList(String condition);

    List<PeopleRequireEachPositionEntity> getTalentDataPieChartList();

    // 根据userId查询当前用户申请的人才需求
    TalentSupplySearchVo getByUserId(String userId);

    // 根据talentSupplyId查询当前用户申请的人才需求
    TalentSupplySearchVo getByTalentSupplyId(Long talentSupplyId);

    // 保存组合向量
    int saveCombinedEmbedding(Long talentSupplyId, String profession, String job, String skill);

    // 批量保存组合向量
    int batchSaveCombinedEmbeddings();

    //List<TalentNeedEntity> recommendJobs(TalentSupplyEntity resume);

    // 基于文本模型的搜索（使用新的Qwen3模型）
    List<TalentSupplyEntity> searchByLM(String prompt);

    /**
     * 根据用户ID推荐岗位
     *
     * @param userId 用户ID
     * @return 推荐的岗位列表
     */
    List<TalentNeedEntity> recommendJobsByUserId(Long userId);
}
