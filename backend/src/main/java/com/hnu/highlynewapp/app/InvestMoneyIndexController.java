package com.hnu.highlynewapp.app;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.hnu.highlynewapp.entity.InvestFieldIndexEntity;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.hnu.highlynewapp.entity.InvestMoneyIndexEntity;
import com.hnu.highlynewapp.service.InvestMoneyIndexService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import springfox.documentation.annotations.ApiIgnore;


/**
 * 投资金额检索
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-04 22:01:47
 */
@Api(tags = "检索字段api管理")
@RestController
@RequestMapping("/investmoneyindex")
public class InvestMoneyIndexController {
    @Autowired
    private InvestMoneyIndexService investMoneyIndexService;

    /**
     * 获取投资金额字段
     */
    @ApiOperation("获取投资金额字段")
    @GetMapping("/getlist")
    public R getList(){
        List<InvestMoneyIndexEntity> list = investMoneyIndexService.list();

        return R.ok().put("data", list);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    //@RequiresPermissions("highlynewapp:investmoneyindex:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = investMoneyIndexService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("highlynewapp:investmoneyindex:info")
    public R info(@PathVariable("id") Long id){
		InvestMoneyIndexEntity investMoneyIndex = investMoneyIndexService.getById(id);

        return R.ok().put("investMoneyIndex", investMoneyIndex);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    //@RequiresPermissions("highlynewapp:investmoneyindex:save")
    public R save(@RequestBody InvestMoneyIndexEntity investMoneyIndex){
		investMoneyIndexService.save(investMoneyIndex);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("highlynewapp:investmoneyindex:update")
    public R update(@RequestBody InvestMoneyIndexEntity investMoneyIndex){
		investMoneyIndexService.updateById(investMoneyIndex);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:investmoneyindex:delete")
    public R delete(@RequestBody Long[] ids){
		investMoneyIndexService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
