package com.hnu.highlynewapp.app;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.hnu.highlynewapp.entity.EnsureMoneyIndexEntity;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.hnu.highlynewapp.entity.LoanDeadlineIndexEntity;
import com.hnu.highlynewapp.service.LoanDeadlineIndexService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import springfox.documentation.annotations.ApiIgnore;


/**
 * 贷款期限检索
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-04 22:01:47
 */
@Api(tags = "检索字段api管理")
@RestController
@RequestMapping("/loandeadlineindex")
public class LoanDeadlineIndexController {
    @Autowired
    private LoanDeadlineIndexService loanDeadlineIndexService;

    /**
     * 获取贷款期限字段
     */
    @ApiOperation("获取贷款期限字段")
    @GetMapping("/getlist")
    public R getList(){
        List<LoanDeadlineIndexEntity> list = loanDeadlineIndexService.list();

        return R.ok().put("data", list);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    //@RequiresPermissions("highlynewapp:loandeadlineindex:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = loanDeadlineIndexService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("highlynewapp:loandeadlineindex:info")
    public R info(@PathVariable("id") Long id){
		LoanDeadlineIndexEntity loanDeadlineIndex = loanDeadlineIndexService.getById(id);

        return R.ok().put("loanDeadlineIndex", loanDeadlineIndex);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    //@RequiresPermissions("highlynewapp:loandeadlineindex:save")
    public R save(@RequestBody LoanDeadlineIndexEntity loanDeadlineIndex){
		loanDeadlineIndexService.save(loanDeadlineIndex);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("highlynewapp:loandeadlineindex:update")
    public R update(@RequestBody LoanDeadlineIndexEntity loanDeadlineIndex){
		loanDeadlineIndexService.updateById(loanDeadlineIndex);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:loandeadlineindex:delete")
    public R delete(@RequestBody Long[] ids){
		loanDeadlineIndexService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
