package com.hnu.highlynewapp.app;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hnu.highlynewapp.entity.*;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.service.InvestingNeedService;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.vo.*;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;


import java.util.List;

/**
 *
 * @author LengKuBaiCai
 * @Date
 */

@RestController
@RequestMapping("/investingneed")
@Api(value = "投资需求api管理",tags = "投资需求api管理")
public class InvestingNeedController {
    @Autowired
    private InvestingNeedService investingNeedService;

    /**
     * 根据id获取查询投资需求详情信息
     */
    @ApiOperation("根据id获取查询投资需求详情信息")
    @GetMapping("/get/{investNeedId}")
    public R getById(@PathVariable("investNeedId") Long investNeedId){
        InvestingNeedEntity investingNeedEntity = investingNeedService.getByInvestNeedId(investNeedId);
        if (investingNeedEntity == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        return R.ok().put("data", investingNeedEntity);
    }

    /**
     * 根据检索条件(投资类型、投资领域、投资金额)获取对应的投资需求列表
     */
    @ApiOperation("根据检索条件获取对应的投资需求列表")
    @PostMapping("/getList")
    public R getList(@RequestBody InvestingSearchByParamVo vo){
        List<InvestingNeedEntity> list = investingNeedService.getListByParma(vo);
        return R.ok().put("data", list);
    }

    /**
     * 发布投资需求
     */
    @ApiOperation("发布投资需求")
    @PostMapping("/publish")
    public R publish(@Validated @RequestBody InvestingNeedEntity investingNeedEntity) {
        investingNeedService.publish(investingNeedEntity);
        return R.ok();
    }


/*    *//**
     * 根据产品名字模糊查询产品信息
     * @return
     *//*
    @ApiOperation("根据产品名字模糊查询产品信息")
    @GetMapping("/getlist/{}")
    public R getListByRoleId(@ApiParam(value = "角色id",required = true) @PathVariable("role_id") Long role_id) {
        List<TalentNeedEntity> list = investingNeedService.selectByName();
        //new QueryWrapper<TalentNeedEntity>().eq("business_id", role_id).orderByDesc("publish_time")
        return R.ok().put("data", list);
    }*/

    /**
     * 获取投资成功案例  success_flag 项目状态（0-成功，1-进行中,2-失败）
     */
    @ApiOperation("获取投资成功案例")
    @PostMapping("/getSuccessList")
    public R getSuccessList(){
        List<InvestingNeedEntity> list = investingNeedService.getSuccessList();
        return R.ok().put("data", list);

    }


    /**
     * 获取最新的4个投资成功案例用于展示  success_flag 项目状态（0-成功，1-进行中,2-失败）
     */
    @ApiOperation("获取最新的4个投资成功案例用于展示")
    @PostMapping("/getSuccessList2")
    public R getSuccessList2(){
        List<InvestingNeedEntity> list = investingNeedService.getSuccessList2();
        return R.ok().put("data", list);

    }

    /**
     * 根据名字模糊查询
     * @param companyName
     * @return
     */
    @ApiOperation("根据 名字模糊查询投资需求列表")
    @PostMapping("/getListByCompanyName/{company_name}")
    public R getListByCompanyName(@PathVariable("company_name") String companyName){
        List<InvestingNeedEntity> list = investingNeedService.getListByCompanyName(companyName);
        return R.ok().put("data", list);
    }
    /**
     * 查询投资列表，返回项目对象
     */
    @ApiOperation("查询投资列表，返回项目对象")
    @RequestMapping("/getList")
    public R getList(){
        List<InvestingNeedEntity> list = investingNeedService.getList();
        return R.ok().put("data", list);
    }



    }



















