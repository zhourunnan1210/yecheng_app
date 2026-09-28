package com.hnu.highlynewapp.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @author zhourunnan
 * @Date 2021/9/23 15:10
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest
public class IndexServiceTest {

    @Resource
    private IndexService indexService;

    @Test
    public void testGetIndexList() {
        String indexName = "科技索引";
        List<Map<String, Object>> indexList = indexService.getIndexList(indexName);
        System.out.println(indexList);
    }

    @Test
    public void testGetKeysByListName() {
        String listName = "政策分类";
        List<String> keysByListName = indexService.getKeysByListName(listName);
        System.out.println(keysByListName);
    }
}
