package com.hnu.highlynewapp.app;

import com.hnu.highlynewapp.entity.ParkEntity;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.service.ParkService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * @author zhourunnan
 * @Date 2021/1/24
 */
@RestController
@RequestMapping("park")
@Api(tags = "园区api管理")
public class ParkController {

    @Autowired
    private ParkService parkService;

    @ApiOperation("获取园区列表")
    @GetMapping("/getlist")
    public R list() {
        List<ParkEntity> list = parkService.list();
        return R.ok().put("data", list);
    }

    @ApiOperation("根据id获取园区列表")
    @GetMapping("/get/{parkId}")
    public R getById(@PathVariable("parkId") Long parkId) {
        ParkEntity parkEntity = parkService.getById(parkId);
        if (parkEntity == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        return R.ok().put("data", parkEntity);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = parkService.queryPage(params);

        return R.ok().put("page", page);
    }

    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{activityId}")
    //@RequiresPermissions("highlynewapp:activity:info")
    public R info(@PathVariable("activityId") Long parkId){
        ParkEntity park = parkService.getById(parkId);

        return R.ok().put("activity", park);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    public R save(@RequestBody ParkEntity parkEntity){
        parkService.save(parkEntity);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    public R update(@RequestBody ParkEntity parkEntity){
        parkService.updateById(parkEntity);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:activity:delete")
    public R delete(@RequestBody Long[] parkIds){
        parkService.removeByIds(Arrays.asList(parkIds));

        return R.ok();
    }
}
