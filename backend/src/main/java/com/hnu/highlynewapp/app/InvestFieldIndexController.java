package com.hnu.highlynewapp.app;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.hnu.highlynewapp.entity.InvestFieldIndexEntity;
import com.hnu.highlynewapp.service.InvestFieldIndexService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import springfox.documentation.annotations.ApiIgnore;


/**
 * 投资领域检索
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-04 22:01:47
 */
@Api(tags = "检索字段api管理")
@RestController
@RequestMapping("/investfieldindex")
public class InvestFieldIndexController {
    @Autowired
    private InvestFieldIndexService investFieldIndexService;

    /**
     * 获取投资领域字段
     */
    @ApiOperation("获取投资领域字段")
    @GetMapping("/getlist")
    //@RequiresPermissions("highlynewapp:investfieldindex:list")
    public R getList(){
        List<InvestFieldIndexEntity> list = investFieldIndexService.list();

        return R.ok().put("data", list);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    //@RequiresPermissions("highlynewapp:investfieldindex:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = investFieldIndexService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("highlynewapp:investfieldindex:info")
    public R info(@PathVariable("id") Long id){
		InvestFieldIndexEntity investFieldIndex = investFieldIndexService.getById(id);

        return R.ok().put("investFieldIndex", investFieldIndex);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    //@RequiresPermissions("highlynewapp:investfieldindex:save")
    public R save(@RequestBody InvestFieldIndexEntity investFieldIndex){
		investFieldIndexService.save(investFieldIndex);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("highlynewapp:investfieldindex:update")
    public R update(@RequestBody InvestFieldIndexEntity investFieldIndex){
		investFieldIndexService.updateById(investFieldIndex);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:investfieldindex:delete")
    public R delete(@RequestBody Long[] ids){
		investFieldIndexService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
