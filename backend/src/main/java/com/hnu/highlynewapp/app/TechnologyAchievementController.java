package com.hnu.highlynewapp.app;

import com.hnu.highlynewapp.entity.TechnologyAchievementEntity;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.service.TechnologyAchievementService;
import com.hnu.highlynewapp.transformation.service.TechAchService;
import com.hnu.highlynewapp.transformation.service.TechnologyProductService;
import com.hnu.highlynewapp.transformation.vo.ConditionsVo;
import com.hnu.highlynewapp.transformation.vo.FindTechAchVo;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.utils.ValidationUtils;
import com.hnu.highlynewapp.vo.PublishTechAchVo;
import com.hnu.highlynewapp.vo.TechnologyAchievementVo;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * 技术成果
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Api(tags = "技术api管理")
@RequestMapping("/technologyAchievement")
@RestController
public class TechnologyAchievementController {
    @Autowired
    private TechAchService techAchService;

    @Autowired
    private TechnologyAchievementService technologyAchievementService;

    /**
     * 发布技术成果
     */
    @ApiOperation("发布技术成果")
    @ApiResponses({
            @ApiResponse(code = 9999, message = "输入的信息有误"),
            @ApiResponse(code = 0, message = "success", response = R.class)
    })
    @PostMapping("/publish")
    public R publish(@Validated @RequestBody PublishTechAchVo vo, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(result);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data", map);
        } else {
            technologyAchievementService.publish(vo);
            return R.ok();
        }
    }

    /**
     * 根据发布者id和类型获取全部的技术成果
     *
     * @param technologyAchievementVo
     * @return
     */
    @ApiOperation("根据发布者id和类型查询全部的技术成果")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success", response = TechnologyAchievementEntity.class)
    })
    @PostMapping("/listByPublisherIdType")
    public R listByPublisherID(@RequestBody TechnologyAchievementVo technologyAchievementVo) {
        List<TechnologyAchievementEntity> technologyAchievementEntities = technologyAchievementService.listByPublisherID(technologyAchievementVo.getPublisherId(), technologyAchievementVo.getPublisherType());
        return R.ok().put("result", technologyAchievementEntities);
    }

    /**
     * 根据技术成果id显示技术成果详细信息
     *
     * @param technologyAchievementId
     * @return
     */
    @ApiOperation("根据技术成果id查询技术成果详细信息")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = FindTechAchVo.class)
    })
    @GetMapping("/details/{technologyAchievementId}")
    public R details(@ApiParam(value = "技术成果id", required = true) @PathVariable("technologyAchievementId") Long technologyAchievementId) {
        //TechnologyAchievementEntity technologyAchievementEntity = technologyAchievementService.getById(technologyAchievementId);
        // 对源码做出改动使之可以查出于技术成果关联的评估报告的信息
        FindTechAchVo findTechAchVo = techAchService.findOneByTechAchId(technologyAchievementId);
        if (findTechAchVo == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        return R.ok().put("technologyNeed", findTechAchVo);
    }

    /**
     * 列表
     */
    @ApiOperation("列表")
    @PostMapping("/list")
    //@RequiresPermissions("highlynewapp:technologyachievement:list")
    public R list(@ApiParam(value = "根据需要可以通过JSON传递两个分页参数，分别是：limit和page") @RequestBody Map<String, Object> params) {
        PageUtils page = technologyAchievementService.queryPage(params);
        return R.ok().put("page", page);
    }

    /**
     * 信息
     */
    @ApiIgnore
    @GetMapping("/info/{technologyAchievementId}")
    //@RequiresPermissions("highlynewapp:technologyachievement:info")
    public R info(@PathVariable("technologyAchievementId") Long technologyAchievementId) {
        TechnologyAchievementEntity technologyAchievement = technologyAchievementService.getById(technologyAchievementId);
        return R.ok().put("technologyAchievement", technologyAchievement);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @PostMapping("/save")
    //@RequiresPermissions("highlynewapp:technologyachievement:save")
    public R save(@RequestBody TechnologyAchievementEntity technologyAchievement) {
        technologyAchievementService.save(technologyAchievement);
        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @PutMapping("/update")
    //@RequiresPermissions("highlynewapp:technologyachievement:update")
    public R update(@RequestBody TechnologyAchievementEntity technologyAchievement) {
        technologyAchievementService.updateById(technologyAchievement);
        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @DeleteMapping("/delete")
    //@RequiresPermissions("highlynewapp:technologyachievement:delete")
    public R delete(@RequestBody Long[] technologyAchievementIds) {
        technologyAchievementService.removeByIds(Arrays.asList(technologyAchievementIds));
        return R.ok();
    }

    @ApiOperation("根据评估报告id查询成果")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = TechnologyAchievementEntity.class)
    })
    @GetMapping("/findByReportId/{techAchEvaluationReportId}")
    public R findByReportId(@PathVariable Long techAchEvaluationReportId) {
        TechnologyAchievementEntity technologyAchievementEntity = technologyAchievementService.findByReportId(techAchEvaluationReportId);
        if (technologyAchievementEntity == null)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("one", technologyAchievementEntity);
    }

    /**
     * 根据时间、行业领域、成果水平和成熟度查询技术成果
     *
     * @param vo
     * @return
     */
    @ApiOperation("根据时间、行业领域、成果水平和成熟度查询技术成果")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = TechnologyAchievementEntity.class)
    })
    @PostMapping("/listByConditions")
    public R listByConditions(@ApiParam(value = "根据需要可以传递四个参数，分别是：duration, field, level和maturity" +
            "\n（其中field允许多选，不同值之间通过英文逗号拼接）") @RequestBody ConditionsVo vo) {
        List<TechnologyAchievementEntity> list = technologyAchievementService.listByConditions(vo.getDuration(), vo.getField(), vo.getLevel(), vo.getMaturity());
        if (list == null || list.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("data", list);
    }

    /**
     * 根据关键词模糊搜索
     *
     * @param keyword
     * @return
     */
    @ApiOperation("根据名称关键词模糊搜索")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = TechnologyAchievementEntity.class)
    })
    @GetMapping("/search/{keyword}")
    public R search(@ApiParam(required = true, value = "关键词") @PathVariable("keyword") String keyword) {
        List<TechnologyAchievementEntity> list = technologyAchievementService.search(keyword);
        if (list == null || list.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("search", list);
    }

    @ApiOperation("查询和技术需求匹配成功的成果信息")
    @GetMapping("/listByTechnologyNeed/{technologyNeedId}")
    public R listByTechnologyNeed(@ApiParam(required = true, value = "技术成果id") @PathVariable("technologyNeedId") Long technologyNeedId) {
        List<TechnologyAchievementEntity> list = technologyAchievementService.listByTechnologyNeed(technologyNeedId);
        if (list == null || list.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("list", list);
    }
}
