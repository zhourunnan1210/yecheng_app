package com.hnu.highlynewapp.app;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hnu.highlynewapp.entity.FinancialProductEntity;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.utils.ValidationUtils;
import com.hnu.highlynewapp.vo.FinancialProSearchVo;
import com.hnu.highlynewapp.vo.PublishServiceProductVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import com.hnu.highlynewapp.entity.ServiceProductEntity;
import com.hnu.highlynewapp.service.ServiceProductService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import springfox.documentation.annotations.ApiIgnore;


/**
 * 服务产品
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Api(tags = "金融服务产品api管理")
@RestController
@RequestMapping("/serviceproduct")
public class ServiceProductController {
    @Autowired
    private ServiceProductService serviceProductService;

    /**
     * 发布服务产品
     */
    @ApiOperation("发布服务产品")
    @PostMapping("/publish")
    public R publish(@Validated @RequestBody PublishServiceProductVo vo, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(result);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data",map);
        } else {
            serviceProductService.publish(vo);
            return R.ok();
        }
    }



    /**
     * 根据检索条件获取对应的服务产品列表
     */
    @ApiOperation("根据检索条件获取对应的服务产品列表")
    @PostMapping("/getlist")
    public R getList(@ApiParam("服务类型") @RequestParam("serviceType") String serviceType){
        List<ServiceProductEntity> list = serviceProductService.getListByParma(serviceType);
        return R.ok().put("data", list);
    }

    /**
     * 根据id获取服务产品
     */
    @ApiOperation("根据id获取服务产品")
    @GetMapping("/get/{serviceProductId}")
    public R getById(@PathVariable("serviceProductId") Long serviceProductId){
        ServiceProductEntity serviceProductEntity = serviceProductService.getById(serviceProductId);
        if (serviceProductEntity == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        return R.ok().put("data", serviceProductEntity);
    }

    /**
     * 根据角色id获取自己发布的服务产品
     * @return
     */
    @ApiOperation("根据角色id获取自己发布的服务产品")
    @GetMapping("/getlist/{role_id}")
    public R getListByRoleId(@ApiParam(value = "角色id",required = true) @PathVariable("role_id") Long role_id) {
        List<ServiceProductEntity> list = serviceProductService.list(new QueryWrapper<ServiceProductEntity>().eq("service_institution_id", role_id).orderByDesc("publish_time"));
        return R.ok().put("data", list);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = serviceProductService.queryPage(params);

        return R.ok().put("page", page);
    }

    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{serviceProductId}")
    public R info(@PathVariable("serviceProductId") Long serviceProductId){
		ServiceProductEntity serviceProduct = serviceProductService.getById(serviceProductId);

        return R.ok().put("serviceProduct", serviceProduct);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    public R save(@RequestBody ServiceProductEntity serviceProduct){
		serviceProductService.save(serviceProduct);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("highlynewapp:serviceproduct:update")
    public R update(@RequestBody ServiceProductEntity serviceProduct){
		serviceProductService.updateById(serviceProduct);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:serviceproduct:delete")
    public R delete(@RequestBody Long[] serviceProductIds){
		serviceProductService.removeByIds(Arrays.asList(serviceProductIds));

        return R.ok();
    }

}
