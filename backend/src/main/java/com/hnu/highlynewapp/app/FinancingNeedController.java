package com.hnu.highlynewapp.app;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.utils.ValidationUtils;
import com.hnu.highlynewapp.vo.DurationFieldVo;
import com.hnu.highlynewapp.vo.FinancialNeedSearchVo;
import com.hnu.highlynewapp.vo.PublishFinancialNeedVo;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import com.hnu.highlynewapp.entity.FinancingNeedEntity;
import com.hnu.highlynewapp.service.FinancingNeedService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import springfox.documentation.annotations.ApiIgnore;


/**
 * 融资需求
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@RestController
@RequestMapping("/financingneed")
@Api(value = "融资需求api管理",tags = "融资需求api管理")
public class FinancingNeedController {
    @Autowired
    private FinancingNeedService financingNeedService;

    /**
     * 发布融资需求
     */
    @ApiOperation("发布融资需求")
    @PostMapping("/publish")
    public R publish(@Validated @RequestBody PublishFinancialNeedVo vo, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(result);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data",map);
        } else {
            financingNeedService.publish(vo);
            return R.ok();
        }
    }

    /**
     * 根据id获取融资需求
     * @return
     */
    @ApiOperation("根据id获取融资需求")
    @GetMapping("/get/{financingId}")
    public R getById(@PathVariable("financingId") Long financingId) {
        FinancingNeedEntity financingNeedEntity = financingNeedService.getById(financingId);
        if (financingNeedEntity == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        return R.ok().put("data", financingNeedEntity);
    }

    /**
     * 根据角色id获取自己发布的融资需求
     * @return
     */
    @ApiOperation("根据角色id获取自己发布的融资需求")
    @GetMapping("/getDetailList/{roleId}")
    public R getListByRoleId(@ApiParam(value = "角色id",required = true) @PathVariable("roleId") Long roleId) {
        List<FinancingNeedEntity> list = financingNeedService.list(new QueryWrapper<FinancingNeedEntity>().eq("business_id",roleId).orderByDesc("publish_time"));
        return R.ok().put("data", list);
    }

    /**
     * 根据检索条件获取对应的金融产品列表
     * @author tianzhuo
     */
    @ApiOperation("根据 时间段、行业领域、融资金额 检索获取对应的融资需求列表")
    @PostMapping("/getList")
    public R getList(@RequestBody FinancialNeedSearchVo vo){
        List<FinancingNeedEntity> list = financingNeedService.getListByParma(vo);
        return R.ok().put("data", list);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    //@RequiresPermissions("highlynewapp:financingneed:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = financingNeedService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{financingNeedId}")
    //@RequiresPermissions("highlynewapp:financingneed:info")
    public R info(@PathVariable("financingNeedId") Long financingNeedId){
		FinancingNeedEntity financingNeed = financingNeedService.getById(financingNeedId);

        return R.ok().put("financingNeed", financingNeed);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    //@RequiresPermissions("highlynewapp:financingneed:save")
    public R save(@RequestBody FinancingNeedEntity financingNeed){
		financingNeedService.save(financingNeed);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("highlynewapp:financingneed:update")
    public R update(@RequestBody FinancingNeedEntity financingNeed){
		financingNeedService.updateById(financingNeed);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:financingneed:delete")
    public R delete(@RequestBody Long[] financingNeedIds){
		financingNeedService.removeByIds(Arrays.asList(financingNeedIds));

        return R.ok();
    }

    /**
     * 根据时间和行业领域检索
     * @param vo
     * @return
     */
    @PostMapping("/listByCondition")
    @ApiOperation("根据时间和行业领域检索融资需求")
    @ApiResponses({
            @ApiResponse(code = 0,message = "success",response = FinancingNeedEntity.class)
    })
    public R listByCondition(@RequestBody DurationFieldVo vo) {
        return R.ok().put("data",financingNeedService.listByCondition(vo.getDuration(), vo.getField()));
    }

    /**
     * 获取融资成功案例  success_flag 项目状态（0-成功，1-进行中,2-失败）
     */
    @ApiOperation("获取融资成功案例")
    @PostMapping("/getSuccessList")
    public R getSuccessList(){
        List<FinancingNeedEntity> list = financingNeedService.getSuccessList();
        return R.ok().put("data", list);

    }

    /**
     * 获取最新的4个融资成功案例用于展示  success_flag 项目状态（0-成功，1-进行中,2-失败）
     */
    @ApiOperation("获取最新的4个融资成功案例用于展示")
    @PostMapping("/getSuccessList2")
    public R getSuccessList2(){
        List<FinancingNeedEntity> list = financingNeedService.getSuccessList2();
        return R.ok().put("data", list);
    }

    /**
     * 根据名字模糊查询
     * @param title
     * @return
     */
    @ApiOperation("根据 名字模糊查询融资需求列表")
    @PostMapping("/getListByTitle/{title}")
    public R getListByTitle(@PathVariable("title") String title){
        List<FinancingNeedEntity> list = financingNeedService.getListByTitle(title);
        return R.ok().put("data", list);
    }

    @ApiOperation("查询所有融资项目")
    @RequestMapping("/getFList")
    public R getFList(){
        List<FinancingNeedEntity> list = financingNeedService.getFList();
        return R.ok().put("data", list);
    }


}
