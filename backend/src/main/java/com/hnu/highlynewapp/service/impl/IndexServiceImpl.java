package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.dao.IndexDao;
import com.hnu.highlynewapp.entity.IndexEntity;
import com.hnu.highlynewapp.service.IndexService;
import com.hnu.highlynewapp.utils.DateUtil;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @author zhourunnan
 * @Date 2021/9/19 2:02
 */
@Service("indexService")
public class IndexServiceImpl extends ServiceImpl<IndexDao, IndexEntity> implements IndexService {
    @Override
    public List<Map<String, Object>> getIndexList(String indexName) {
        List<IndexEntity> indexEntities = this.list();
        Long indexId=-1L;
        boolean isNeedTimeIndex = false;
        for (IndexEntity indexEntity : indexEntities) {
            if (indexEntity.getName().equals(indexName)) {
                indexId = indexEntity.getId();
                //特殊定义，index的parentId=0 不需要发布时间索引， =-1需要发布时间索引
                if (indexEntity.getParentId() == -1) {
                    isNeedTimeIndex = true;
                }
                break;
            }
        }
        Long finalIndexId = indexId;
        List<Map<String, Object>> result = indexEntities.stream().filter(o->o.getParentId() == finalIndexId)
                .map(o->{
                    Map<String, Object> map = new HashMap<>();
                    map.put("keys", indexEntities.stream().filter(p -> p.getParentId() == o.getId())
                            .map(IndexEntity::getName).collect(Collectors.toList()));
                    map.put("listName", o.getName());
                    return map;
                }).collect(Collectors.toList());

        if (isNeedTimeIndex) {
            List<String> timeIndex = DateUtil.getTimeIndex();
            Map<String, Object> map = new HashMap<>();
            map.put("keys", timeIndex);
            map.put("listName", "发布时间");
            result.add(map);
        }
        return result;
    }

    public List<String> getKeysByListName(String listName) {
        List<IndexEntity> indexEntities = list();
        Long listId=-1L;
        for (IndexEntity indexEntity : indexEntities) {
            if (indexEntity.getName().equals(listName)) {
                listId = indexEntity.getId();
                break;
            }
        }
        Long finalListId = listId;
        List<String> result = indexEntities.stream().filter(o -> o.getParentId() == finalListId)
                .map(IndexEntity::getName).collect(Collectors.toList());
        return result;
    }

}
