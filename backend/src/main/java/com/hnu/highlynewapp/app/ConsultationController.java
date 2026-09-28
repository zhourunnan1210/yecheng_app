package com.hnu.highlynewapp.app;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hnu.highlynewapp.entity.ConsultationEntity;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.service.ConsultationService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.utils.ValidationUtils;
import com.hnu.highlynewapp.vo.ConsultationResVo;
import com.hnu.highlynewapp.vo.PublishConsultationVo;
import com.hnu.highlynewapp.vo.ReplyVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;


/**
 * 咨询
 *
 * @author zhourunnan
 * @email 13513595808@163.com
 * @date 2021-04-08 20:12:22
 */
@Api(tags = "咨询api管理")
@RestController
@RequestMapping("/consultation")
public class ConsultationController {
    @Autowired
    private ConsultationService consultationService;

    /**
     * 发布咨询
     */
    @ApiOperation("发布咨询")
    @PostMapping("/publish")
    public R publish(@Validated @RequestBody PublishConsultationVo vo, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(result);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data",map);
        } else {
            consultationService.publish(vo);
            return R.ok();
        }
    }

    /**
     * 返回所有咨询信息，并组装好回复
     * @return
     */
    @ApiOperation("科技主管部门咨询信息列表")
    @GetMapping("/list/combine")
    public R listCombine(@RequestParam(value = "category", required = false) String category) {
        List<ConsultationResVo> list = consultationService.listCombine(category);
        return R.ok().put("data", list);
    }

    /**
     * 根据用户id查询咨询信息并整合回复
     */
    @ApiOperation("高企获取自己的咨询信息列表")
    @GetMapping("/list/{userId}")
    public R listByUserId(@PathVariable("userId") Long userId) {
        List<ConsultationResVo> list = consultationService.listByUserId(userId);
        return R.ok().put("data", list);
    }

    /**
     * 回复
     */
    @ApiOperation("科技部门回复咨询问题")
    @PostMapping("/reply")
    public R reply(@Validated @RequestBody ReplyVo vo, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(result);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data",map);
        } else {
            consultationService.reply(vo);
            return R.ok();
        }
    }

    /**
     * 未读数量
     */
    @ApiOperation("未读消息数量")
    @GetMapping("/countNoReply")
    public R countNoReply() {
        int count = consultationService.count(new QueryWrapper<ConsultationEntity>().eq("is_read", 0).eq("parent_id", 0));
        return R.ok().put("count", count);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    //@RequiresPermissions("shangkela:consultation:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = consultationService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("shangkela:consultation:info")
    public R info(@PathVariable("id") Long id){
		ConsultationEntity consultation = consultationService.getById(id);

        return R.ok().put("consultation", consultation);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    //@RequiresPermissions("shangkela:consultation:save")
    public R save(@RequestBody ConsultationEntity consultation){
		consultationService.save(consultation);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("shangkela:consultation:update")
    public R update(@RequestBody ConsultationEntity consultation){
		consultationService.updateById(consultation);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("shangkela:consultation:delete")
    public R delete(@RequestBody Long[] ids){
		consultationService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
