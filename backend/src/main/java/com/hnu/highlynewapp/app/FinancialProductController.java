package com.hnu.highlynewapp.app;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.vo.FinancialProSearchVo;
import com.hnu.highlynewapp.vo.PublishFinancialProductVo;
import com.hnu.highlynewapp.vo.PublishTalentSupplyVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import com.hnu.highlynewapp.entity.ContactEntity;
import com.hnu.highlynewapp.entity.FinancialProductEntity;
import com.hnu.highlynewapp.service.ContactService;
import com.hnu.highlynewapp.service.FinancialProductService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import springfox.documentation.annotations.ApiIgnore;


/**
 * 金融产品
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Api(tags = "金融服务产品api管理")
@RestController
@RequestMapping("/financialproduct")
public class FinancialProductController {
    @Value("${oss.bucket-domain:}")
    private String ossBucketDomain;
    @Autowired
    private FinancialProductService financialProductService;

    @Autowired
    private ContactService contactService;

    /**
     * 发布金融产品
     */
    @ApiOperation("发布金融产品")
    @PostMapping("/publish")
    public R publish(@Validated @RequestBody PublishFinancialProductVo vo, BindingResult result) {

        Map<String,String> map = new HashMap<>();
        if (result.hasErrors()) {
            //获取效验错误结果
            result.getFieldErrors().forEach((item)-> {
                //获取到错误提示
                String message = item.getDefaultMessage();
                //获取错误的属性的名字
                String field = item.getField();
                map.put(field,message);
            });
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data",map);
        } else {
            financialProductService.publish(vo);
            return R.ok();
        }
    }

    /**
     * 根据检索条件获取对应的金融产品列表
     */
    @ApiOperation("根据检索条件获取对应的金融产品列表")
    @PostMapping("/getlist")
    public R getList(@RequestBody FinancialProSearchVo vo){
        List<FinancialProductEntity> list = financialProductService.getListByParma(vo);
        return R.ok().put("data", list);
    }

    /**
     * 根据id获取金融产品
     */
    @ApiOperation("根据id获取金融产品")
    @GetMapping("/get/{financialProductId}")
    public R getById(@PathVariable("financialProductId") Long financialProductId){
        FinancialProductEntity financialProductEntity = financialProductService.getById(financialProductId);
        if (financialProductEntity == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        Map<String, Object> result = new HashMap<>();
        result.put("financing", financialProductEntity);
        // 查询联系人信息
        if (financialProductEntity.getContactId() != null) {
            ContactEntity contact = contactService.getById(financialProductEntity.getContactId());
            if (contact != null) {
                result.put("contactName", contact.getName() != null ? contact.getName() : "业务经理");
                result.put("contactPhone", contact.getPhone() != null && !contact.getPhone().isEmpty() ? contact.getPhone() : "400-888-8888");
            } else {
                result.put("contactName", "业务经理");
                result.put("contactPhone", "400-888-8888");
            }
        } else {
            result.put("contactName", "业务经理");
            result.put("contactPhone", "400-888-8888");
        }
        // 图片兜底：如果为空或是失效的OSS链接，替换为默认图
        String image = financialProductEntity.getImage();
        if (image == null || image.isEmpty() || image.contains(ossBucketDomain)) {
            financialProductEntity.setImage("/static/defaultImage/1.png");
        }
        return R.ok().put("data", result);
    }

    /**
     * 根据角色id获取自己发布的金融产品
     * @return
     */
    @ApiOperation("根据角色id获取自己发布的金融产品")
    @GetMapping("/getlist/{role_id}")
    public R getListByRoleId(@ApiParam(value = "角色id",required = true) @PathVariable("role_id") Long role_id) {
        List<FinancialProductEntity> list = financialProductService.list(new QueryWrapper<FinancialProductEntity>().eq("financial_institution_id", role_id).orderByDesc("publish_time"));
        return R.ok().put("data", list);
    }

    /**
     * 列表查询

    @ApiOperation("根据查询条件分页查询所有的金融产品")
    @GetMapping("/querylist")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = financialProductService.queryPage(params);

        return R.ok().put("page", page);
    }
    */

    /**
     * 列表

    @ApiIgnore
    @RequestMapping("/list")
    //@RequiresPermissions("highlynewapp:financialproduct:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = financialProductService.queryPage(params);

        return R.ok().put("page", page);
    }
    */

    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{financialProductId}")
    //@RequiresPermissions("highlynewapp:financialproduct:info")
    public R info(@PathVariable("financialProductId") Long financialProductId){
		FinancialProductEntity financialProduct = financialProductService.getById(financialProductId);

        return R.ok().put("financialProduct", financialProduct);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    //@RequiresPermissions("highlynewapp:financialproduct:save")
    public R save(@RequestBody FinancialProductEntity financialProduct){
		financialProductService.save(financialProduct);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("highlynewapp:financialproduct:update")
    public R update(@RequestBody FinancialProductEntity financialProduct){
		financialProductService.updateById(financialProduct);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:financialproduct:delete")
    public R delete(@RequestBody Long[] financialProductIds){
		financialProductService.removeByIds(Arrays.asList(financialProductIds));

        return R.ok();
    }

}
