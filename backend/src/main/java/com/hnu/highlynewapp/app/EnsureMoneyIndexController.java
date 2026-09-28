package com.hnu.highlynewapp.app;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.hnu.highlynewapp.entity.EnsureMethodIndexEntity;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.hnu.highlynewapp.entity.EnsureMoneyIndexEntity;
import com.hnu.highlynewapp.service.EnsureMoneyIndexService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import springfox.documentation.annotations.ApiIgnore;


/**
 * 贷款额度检索
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-04 22:01:47
 */
@Api(tags = "检索字段api管理")
@RestController
@RequestMapping("/ensuremoneyindex")
public class EnsureMoneyIndexController {
    @Autowired
    private EnsureMoneyIndexService ensureMoneyIndexService;

    /**
     * 获取贷款额度字段
     */
    @ApiOperation("获取贷款额度字段")
    @GetMapping("/getlist")
    public R getList(){
        List<EnsureMoneyIndexEntity> list = ensureMoneyIndexService.list();

        return R.ok().put("data", list);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    //@RequiresPermissions("highlynewapp:ensuremoneyindex:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = ensureMoneyIndexService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("highlynewapp:ensuremoneyindex:info")
    public R info(@PathVariable("id") Long id){
		EnsureMoneyIndexEntity ensureMoneyIndex = ensureMoneyIndexService.getById(id);

        return R.ok().put("ensureMoneyIndex", ensureMoneyIndex);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    //@RequiresPermissions("highlynewapp:ensuremoneyindex:save")
    public R save(@RequestBody EnsureMoneyIndexEntity ensureMoneyIndex){
		ensureMoneyIndexService.save(ensureMoneyIndex);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("highlynewapp:ensuremoneyindex:update")
    public R update(@RequestBody EnsureMoneyIndexEntity ensureMoneyIndex){
		ensureMoneyIndexService.updateById(ensureMoneyIndex);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:ensuremoneyindex:delete")
    public R delete(@RequestBody Long[] ids){
		ensureMoneyIndexService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
