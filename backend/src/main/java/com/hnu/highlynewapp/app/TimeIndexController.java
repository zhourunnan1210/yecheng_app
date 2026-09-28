package com.hnu.highlynewapp.app;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.hnu.highlynewapp.entity.TimeIndexEntity;
import com.hnu.highlynewapp.service.TimeIndexService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import springfox.documentation.annotations.ApiIgnore;


/**
 * 时间检索
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-04 22:01:46
 */
@Api(tags = "检索字段api管理")
@RestController
@RequestMapping("/timeindex")
public class TimeIndexController {
    @Autowired
    private TimeIndexService timeIndexService;

    /**
     * 获取时间字段
     */
    @ApiOperation("获取时间字段")
    @GetMapping("/getlist")
    public R getList(){
        List<TimeIndexEntity> list = timeIndexService.list();

        return R.ok().put("data", list);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    //@RequiresPermissions("highlynewapp:timeindex:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = timeIndexService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("highlynewapp:timeindex:info")
    public R info(@PathVariable("id") Long id){
		TimeIndexEntity timeIndex = timeIndexService.getById(id);

        return R.ok().put("timeIndex", timeIndex);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    //@RequiresPermissions("highlynewapp:timeindex:save")
    public R save(@RequestBody TimeIndexEntity timeIndex){
		timeIndexService.save(timeIndex);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("highlynewapp:timeindex:update")
    public R update(@RequestBody TimeIndexEntity timeIndex){
		timeIndexService.updateById(timeIndex);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:timeindex:delete")
    public R delete(@RequestBody Long[] ids){
		timeIndexService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
