package com.hnu.highlynewapp.controller;

import com.hnu.highlynewapp.entity.NewsEntity;
import com.hnu.highlynewapp.entity.ParkEntity;
import com.hnu.highlynewapp.service.NewsService;
import com.hnu.highlynewapp.service.ParkService;
import com.hnu.highlynewapp.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zhourunnan
 * @Date 2022/1/17 13:10
 */
@RestController
public class DynamicInfoController {
    public static final String DYNAMIC_INFO_KEY = "index:dynamic:info";

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private ParkService parkService;

    @Autowired
    private NewsService newsService;

    @PostMapping("/index/dynamic/info")
    public R getIndexInfo() {
        //Map<String, List> entries = redisTemplate.boundHashOps(DYNAMIC_INFO_KEY).entries();

        Map<String, List> entries = new HashMap<>();
        R r = new R();
        //TODO 后期删掉true 加上能够操作缓存的接口
        if (entries == null || entries.size() == 0 || true) {
            Map<String, List> hashMap = new HashMap<>();
            List<ParkEntity> parks = parkService.getLastTwo();
            List<NewsEntity> news = newsService.getLastTwo();
            hashMap.put("news", news);
            hashMap.put("park", parks);
            //redisTemplate.boundHashOps(DYNAMIC_INFO_KEY).putAll(hashMap);
            r.put("dynamicInfo", hashMap);
        } else {
            r.put("dynamicInfo", entries);
        }

        return r;
    }
}
