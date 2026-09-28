package com.hnu.highlynewapp.app;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.hnu.highlynewapp.entity.InvestFieldIndexEntity;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.hnu.highlynewapp.entity.ServiceTypeIndexEntity;
import com.hnu.highlynewapp.service.ServiceTypeIndexService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import springfox.documentation.annotations.ApiIgnore;


/**
 * 服务类型检索
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-04 22:01:47
 */
@Api(tags = "检索字段api管理")
@RestController
@RequestMapping("/servicetypeindex")
public class ServiceTypeIndexController {
    @Autowired
    private ServiceTypeIndexService serviceTypeIndexService;

    /**
     * 获取服务类型字段
     */
    @ApiOperation("获取服务类型字段")
    @GetMapping("/getlist")
    public R getList(){
        List<ServiceTypeIndexEntity> list = serviceTypeIndexService.list();

        return R.ok().put("data", list);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    //@RequiresPermissions("highlynewapp:servicetypeindex:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = serviceTypeIndexService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("highlynewapp:servicetypeindex:info")
    public R info(@PathVariable("id") Long id){
		ServiceTypeIndexEntity serviceTypeIndex = serviceTypeIndexService.getById(id);

        return R.ok().put("serviceTypeIndex", serviceTypeIndex);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    //@RequiresPermissions("highlynewapp:servicetypeindex:save")
    public R save(@RequestBody ServiceTypeIndexEntity serviceTypeIndex){
		serviceTypeIndexService.save(serviceTypeIndex);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("highlynewapp:servicetypeindex:update")
    public R update(@RequestBody ServiceTypeIndexEntity serviceTypeIndex){
		serviceTypeIndexService.updateById(serviceTypeIndex);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:servicetypeindex:delete")
    public R delete(@RequestBody Long[] ids){
		serviceTypeIndexService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
