package com.hnu.highlynewapp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.hnu.highlynewapp.entity.IndexEntity;

import java.util.List;
import java.util.Map;

/**
 * @author zhourunnan
 * @Date 2021/9/19 2:02
 */
public interface IndexService extends IService<IndexEntity> {
    /**
     * 返回所有与index有关的索引列表及关键词
     * @param indexName
     * @return
     */
    List<Map<String, Object>> getIndexList(String indexName);

    /**
     * 返回listName的所有key
     * @param listName
     * @return
     */
    List<String> getKeysByListName(String listName);
}
