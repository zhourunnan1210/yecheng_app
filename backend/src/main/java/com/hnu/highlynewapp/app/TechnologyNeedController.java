package com.hnu.highlynewapp.app;

import com.hnu.highlynewapp.entity.TechnologyNeedEntity;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.service.TechnologyNeedService;
import com.hnu.highlynewapp.transformation.vo.BusinessNeedVo;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.utils.ValidationUtils;
import com.hnu.highlynewapp.vo.DurationFieldVo;
import com.hnu.highlynewapp.vo.PublishTechNeedVo;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 技术需求
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Api(tags = "技术api管理")
@CrossOrigin
@RestController
@RequestMapping("/technologyneed")
public class TechnologyNeedController {
    @Autowired
    private TechnologyNeedService technologyNeedService;

    /**
     * 分页查询技术需求
     *
     * @param params
     * @return
     */
    @ApiOperation("分页查询技术需求")
    @PostMapping("/list")
    public R queryPage(@ApiParam(value = "根据需要可以通过JSON传递两个分页参数，分别是：limit和page") @RequestBody Map<String, Object> params) {
        PageUtils page = technologyNeedService.queryPage(params);
        return R.ok().put("page", page);
    }

    /**
     * 发布技术需求
     *
     * @param vo
     * @param result
     * @return
     */
    @ApiOperation("发布技术需求")
    @ApiResponses({
            @ApiResponse(code = 9999, message = "输入的信息有误"),
            @ApiResponse(code = 0, message = "success", response = R.class)
    })
    @PostMapping("/publish")
    public R publish(@Validated @RequestBody PublishTechNeedVo vo, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(result);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data", map);
        } else {
            technologyNeedService.publish(vo);
            return R.ok();
        }
    }

    /**
     * 根据企业ID查询所有的技术需求
     *
     * @param businessID
     * @return
     */
    @ApiOperation("根据企业ID查询所有的技术需求")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = TechnologyNeedEntity.class)
    })
    @GetMapping("/listByBusinessID/{businessID}")
    public R listByBusinessID(@ApiParam(value = "企业id, 即用户登录时获取到的gid", required = true) @PathVariable("businessID") long businessID) {
        List<TechnologyNeedEntity> technologyNeedEntities = technologyNeedService.listByBusinessID(businessID);
        if (technologyNeedEntities == null || technologyNeedEntities.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("data", technologyNeedEntities);
    }

    /**
     * 根据技术需求id显示技术需求详细信息
     *
     * @param technologyNeedId
     * @return
     */
    @ApiOperation("根据技术需求id查询技术需求详细信息")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = TechnologyNeedEntity.class)
    })
    @GetMapping("/details/{technologyNeedId}")
    public R details(@PathVariable("technologyNeedId") @ApiParam(value = "技术需求id", required = true) Long technologyNeedId) {
        TechnologyNeedEntity technologyNeed = technologyNeedService.getById(technologyNeedId);
        if (technologyNeed == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        return R.ok().put("technologyNeed", technologyNeed);
    }

    /**
     * 根据时间和行业领域检索
     *
     * @param vo
     * @return
     */
    @ApiOperation("根据时间和行业领域查询技术需求")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success", response = TechnologyNeedEntity.class)
    })
    @PostMapping("/listByCondition")
    public R listByCondition(@RequestBody DurationFieldVo vo) {
        return R.ok().put("data", technologyNeedService.listByCondition(vo.getDuration(), vo.getField()));
    }

    /**
     * 根据多个技术需求id删除多个技术需求
     *
     * @param technologyNeedIds
     * @return
     */
    @ApiOperation("根据多个技术需求id删除多个技术需求")
    @DeleteMapping("/delete")
    public R deleteTechnologyNeed(@RequestBody Long[] technologyNeedIds) {
        int result = technologyNeedService.deleteTechnologyNeed(technologyNeedIds);
        if (result == Arrays.asList(technologyNeedIds).size())
            return R.ok();
        else
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("result", "删除部分失败！成功删除了 " + result + " 条数据");
    }

    /**
     * 根据技术需求id更新技术需求的信息
     *
     * @param vo
     * @param result
     * @return
     */
    @ApiOperation("根据技术需求id更新技术需求的信息")
    @ApiResponses({
            @ApiResponse(code = 9999, message = "输入的信息有误"),
            @ApiResponse(code = 0, message = "success", response = R.class)
    })
    @PutMapping("/update")
    public R updateTechnologyNeed(@Validated @RequestBody PublishTechNeedVo vo, BindingResult result) {
        int result1 = technologyNeedService.updateTechnologyNeed(vo);
        if (result.hasErrors() || result1 == 0) {
            Map<String, String> map = ValidationUtils.getErrors(result);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data", map);
        } else {
            return R.ok();
        }
    }

    /**
     * 根据关键词模糊搜索
     *
     * @param keyword
     * @return
     */
    @ApiOperation("根据关键词模糊搜索")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = TechnologyNeedEntity.class)
    })
    @GetMapping("/search/{keyword}")
    public R search(@ApiParam(required = true, value = "关键词") @PathVariable("keyword") String keyword) {
        List<TechnologyNeedEntity> list = technologyNeedService.search(keyword);
        if (list == null || list.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("search", list);
    }

    @ApiOperation("根据企业信息获取企业技术需求名称")
    @PostMapping("/getNeedTitle")
    public R getNeedTitle(@RequestBody BusinessNeedVo vo) {
        List<String> title = technologyNeedService.getNeedTitle(vo);
        return R.ok().put("title", title);
    }

    @ApiOperation("接收输入的企业和技术需求信息")
    @PostMapping("/getBusinessNeed")
    public R businessNeedMap(@RequestBody BusinessNeedVo vo, @ApiParam(required = true, value = "技术需求标题") @RequestParam String title) {
        technologyNeedService.businessNeedMap(vo, title);
        return R.ok();
    }

    @ApiOperation("获取需求类型的列表")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = String.class)
    })
    @PostMapping("/getFieldsList")
    public R getFieldsList() {
        Set<String> fields = technologyNeedService.getFieldsList();
        if (fields == null || fields.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("fields", fields);
    }
}
