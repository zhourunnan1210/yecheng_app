package com.hnu.highlynewapp.app;

import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.transformation.pojo.Expert;
import com.hnu.highlynewapp.transformation.service.ExpertService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.utils.ValidationUtils;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Map;

/**
 * 专家
 */
@Api(tags = "专家api管理")
@CrossOrigin
@RequestMapping("/expert")
@RestController
public class ExpertController {
    @Autowired
    private ExpertService expertService;

    /**
     * 返回专家的分页
     *
     * @param params
     * @return
     */
    @ApiOperation("返回专家的分页")
    @PostMapping("/list")
    public R list(@ApiParam(value = "根据需要可以通过JSON传递两个分页参数，分别是：limit和page") @RequestBody Map<String, Object> params) {
        PageUtils page = expertService.queryPage(params);
        return R.ok().put("page", page);
    }

    /**
     * 根据专家id返回专家的信息
     *
     * @param expertId
     * @return
     */
    @ApiOperation("根据专家id返回专家的信息")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = Expert.class)
    })
    @GetMapping("/info/{expertId}")
    public R info(@PathVariable("expertId") Long expertId) {
        Expert expert = expertService.findOneByExpertId(expertId);
        if (expert == null)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("expert", expert);
    }

    /**
     * 保存专家的信息
     *
     * @param bindingResult
     * @param expert
     * @return
     */
    @ApiOperation("保存专家的信息")
    @ApiResponses({
            @ApiResponse(code = 9999, message = "输入的信息有误"),
            @ApiResponse(code = 0, message = "success", response = R.class)
    })
    @PostMapping("/save")
    public R save(@RequestBody @Validated Expert expert, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(bindingResult);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data", map);
        } else {
            expertService.save(expert);
            return R.ok();
        }
    }

    /**
     * 根据专家id更新专家的信息
     *
     * @param expert
     * @return
     */
    @ApiOperation("根据专家id更新专家的信息")
    @ApiResponses({
            @ApiResponse(code = 9999, message = "输入的信息有误"),
            @ApiResponse(code = 0, message = "success", response = R.class)
    })
    @PutMapping("/update")
    public R update(@RequestBody Expert expert) {
        boolean result = expertService.updateById(expert);
        if (!result)
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage());
        return R.ok();
    }

    /**
     * 根据多个专家id删除多个专家
     *
     * @param expertIds
     * @return
     */
    @ApiOperation("根据多个专家id删除多个专家")
    @ApiResponses({
            @ApiResponse(code = 9999, message = "输入的信息有误"),
            @ApiResponse(code = 0, message = "success", response = R.class)
    })
    @DeleteMapping("/delete")
    public R delete(@RequestBody Long[] expertIds) {
        int result = expertService.deleteExpertsByIds(expertIds);
        if (result == Arrays.asList(expertIds).size())
            return R.ok();
        else
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("result", "删除部分失败！成功删除了 " + result + " 条数据");
    }
}
