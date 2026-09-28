package com.hnu.highlynewapp.app;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.hnu.highlynewapp.entity.InvestFieldIndexEntity;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.hnu.highlynewapp.entity.EnsureMethodIndexEntity;
import com.hnu.highlynewapp.service.EnsureMethodIndexService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import springfox.documentation.annotations.ApiIgnore;


/**
 * 担保方式检索
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-04 22:01:47
 */
@Api(tags = "检索字段api管理")
@RestController
@RequestMapping("/ensuremethodindex")
public class EnsureMethodIndexController {
    @Autowired
    private EnsureMethodIndexService ensureMethodIndexService;

    /**
     * 获取担保方式字段
     */
    @ApiOperation("获取担保方式字段")
    @GetMapping("/getlist")
    public R getList(){
        List<EnsureMethodIndexEntity> list = ensureMethodIndexService.list();

        return R.ok().put("data", list);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    //@RequiresPermissions("highlynewapp:ensuremethodindex:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = ensureMethodIndexService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("highlynewapp:ensuremethodindex:info")
    public R info(@PathVariable("id") Long id){
		EnsureMethodIndexEntity ensureMethodIndex = ensureMethodIndexService.getById(id);

        return R.ok().put("ensureMethodIndex", ensureMethodIndex);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    //@RequiresPermissions("highlynewapp:ensuremethodindex:save")
    public R save(@RequestBody EnsureMethodIndexEntity ensureMethodIndex){
		ensureMethodIndexService.save(ensureMethodIndex);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("highlynewapp:ensuremethodindex:update")
    public R update(@RequestBody EnsureMethodIndexEntity ensureMethodIndex){
		ensureMethodIndexService.updateById(ensureMethodIndex);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:ensuremethodindex:delete")
    public R delete(@RequestBody Long[] ids){
		ensureMethodIndexService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
