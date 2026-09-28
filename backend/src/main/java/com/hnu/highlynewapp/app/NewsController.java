package com.hnu.highlynewapp.app;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hnu.highlynewapp.entity.NewsEntity;
import com.hnu.highlynewapp.entity.ParkEntity;
import com.hnu.highlynewapp.entity.TechnologyAchievementEntity;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.service.NewsService;
import com.hnu.highlynewapp.utils.R;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author zhourunnan
 * @Date 2022/1/1 1:40
 */
@RestController
@RequestMapping("/news")
public class NewsController {

    @Autowired
    private NewsService newsService;

    @ApiOperation("获取新闻列表")
    @GetMapping("/getlist")
    public R list() {
        List<NewsEntity> list = newsService.list(new QueryWrapper<NewsEntity>().orderByDesc("publish_time"));
        return R.ok().put("data", list);
    }

    @ApiOperation("根据id获取新闻")
    @GetMapping("/get/{parkId}")
    public R getById(@PathVariable("parkId") Long parkId) {
        NewsEntity newsEntity = newsService.getById(parkId);
        if (newsEntity == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        return R.ok().put("data", newsEntity);
    }
    @ApiOperation("根据id获取新闻")
    @GetMapping("/search/{keyword}")
    public R search(@ApiParam(required = true, value = "关键词") @PathVariable("keyword") String keyword) {
        List<NewsEntity> list = newsService.search(keyword);
        if (list == null || list.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("search", list);
    }
}
