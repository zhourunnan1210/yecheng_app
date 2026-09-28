package com.hnu.highlynewapp.app;

import java.util.*;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hnu.highlynewapp.entity.NewsEntity;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.utils.ValidationUtils;
import com.hnu.highlynewapp.vo.PublishPolicyVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import com.hnu.highlynewapp.entity.PolicyEntity;
import com.hnu.highlynewapp.service.PolicyService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import springfox.documentation.annotations.ApiIgnore;


/**
 * 政策
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Api(tags = "政策api管理")
@RestController
@RequestMapping("/policy")
public class PolicyController {
    @Autowired
    private PolicyService policyService;

    /**
     * 发布政策
     */
    @ApiOperation("发布政策")
    @PostMapping("/publish")
    public R publish(@Validated @RequestBody PublishPolicyVo vo, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(result);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data",map);
        } else {

            policyService.savePolicy(vo);
            return R.ok();
        }
    }

    /**
     * 获取所有政策（时间降序）
     * @return
     */
    @ApiOperation("根据检索条件获取所有政策")
    @PostMapping("/getlist")
    public R getList(@ApiParam(value = "政策分类") @RequestParam(value = "category", required = false) String category) {
        List<PolicyEntity> list = policyService.listByCondition(category);
        return R.ok().put("data", list);
    }

    /**
     * 获取所有政策（时间降序）
     * @return
     */
    @ApiOperation("根据检索条件获取所有政策")
    @PostMapping("/get/list")
    public R getListByCategory(@ApiParam(value = "政策分类") @RequestParam(value = "category", required = false) String category) {
        List<PolicyEntity> list = policyService.listByCategory(category);
        return R.ok().put("data", list);
    }

    /**
     * 根据id获取政策
     * @return
     */
    @ApiOperation("根据id获取政策")
    @GetMapping("/get/{policyId}")
    public R getById(@PathVariable("policyId") Long policyId) {
        PolicyEntity policyEntity = policyService.getById(policyId);
        if (policyEntity == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        return R.ok().put("data", policyEntity);
    }

    /**
     * 根据角色id获取自己发布的政策
     * @return
     */
    @ApiOperation("根据角色id获取自己发布的政策")
    @GetMapping("/getlist/{role_id}")
    public R getListByRoleId(@ApiParam(value = "角色id",required = true) @PathVariable("role_id") Long role_id) {
        List<PolicyEntity> list = policyService.list(new QueryWrapper<PolicyEntity>().eq("department_id", role_id).orderByDesc("publish_time"));
        return R.ok().put("data", list);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    //@RequiresPermissions("highlynewapp:policy:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = policyService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{policyId}")
    //@RequiresPermissions("highlynewapp:policy:info")
    public R info(@PathVariable("policyId") Long policyId){
		PolicyEntity policy = policyService.getById(policyId);

        return R.ok().put("policy", policy);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    //@RequiresPermissions("highlynewapp:policy:save")
    public R save(@RequestBody PolicyEntity policy){
		policyService.save(policy);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("highlynewapp:policy:update")
    public R update(@RequestBody PolicyEntity policy){
		policyService.updateById(policy);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:policy:delete")
    public R delete(@RequestBody Long[] policyIds){
		policyService.removeByIds(Arrays.asList(policyIds));

        return R.ok();
    }
    @ApiOperation("根据类目搜索政策")
    @GetMapping("/searchByApplication/{keyword}")
    public R search(@ApiParam(required = true, value = "关键词") @PathVariable("keyword") String keyword) {
        List<PolicyEntity> list = policyService.search(keyword);
        if (list == null || list.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("search", list);
    }
}
