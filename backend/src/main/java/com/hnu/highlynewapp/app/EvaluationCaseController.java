package com.hnu.highlynewapp.app;

import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.transformation.pojo.EvaluationCase;
import com.hnu.highlynewapp.transformation.service.EvaluationCaseService;
import com.hnu.highlynewapp.transformation.service.EvaluationCaseVoService;
import com.hnu.highlynewapp.transformation.vo.FindEvaluationCaseVo;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.utils.ValidationUtils;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import java.util.Arrays;
import java.util.Map;

/**
 * 评估案例
 */
@Api(tags = "评估案例api管理")
@CrossOrigin
@RequestMapping("/evaluationCase")
@RestController
public class EvaluationCaseController {
    @Autowired
    private EvaluationCaseService evaluationCaseService;

    @Autowired
    private EvaluationCaseVoService evaluationCaseVoService;

    /**
     * 返回评估案例的分页
     */
    @ApiOperation("返回评估案例的分页")
    @PostMapping("/list")
    public R list(@ApiParam(value = "根据需要可以通过JSON传递两个分页参数，分别是：limit和page") @RequestBody Map<String, Object> params) {
        PageUtils page = evaluationCaseVoService.queryPage(params);
        return R.ok().put("page", page);
    }

    /**
     * 发布评估案例
     *
     * @param bindingResult
     * @param evaluationCase
     * @return
     */
    @ApiOperation("发布评估案例")
    @ApiResponses({
            @ApiResponse(code = 9999, message = "输入的信息有误"),
            @ApiResponse(code = 0, message = "success", response = EvaluationCase.class)
    })
    @PostMapping("/publish")
    public R publish(@RequestBody @Validated EvaluationCase evaluationCase, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(bindingResult);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data", map);
        } else {
            evaluationCaseService.publish(evaluationCase);
            return R.ok();
        }
    }

    /**
     * 根据评估案例id返回评估案例的详细信息
     *
     * @param evaluationCaseId
     * @return
     */
    @ApiOperation("根据评估案例id返回评估案例的详细信息")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = FindEvaluationCaseVo.class)
    })
    @GetMapping("/details/{evaluationCaseId}")
    public R details(@ApiParam(required = true, value = "评估案例id") @PathVariable("evaluationCaseId") Long evaluationCaseId) {
        FindEvaluationCaseVo findEvaluationCaseVo = evaluationCaseService.findOneByEvalCaseId(evaluationCaseId);
        if (findEvaluationCaseVo == null)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("evaluationCase", findEvaluationCaseVo);
    }

    /**
     * 根据评估案例id更新评估案例的信息
     *
     * @param evaluationCase
     * @return
     */
    @ApiIgnore
    @PutMapping("/update")
    public R update(@RequestBody EvaluationCase evaluationCase) {
        int result = evaluationCaseService.updateEvaluationCaseById(evaluationCase);
        if (result == 1)
            return R.ok();
        else
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage());
    }

    /**
     * 根据多个评估案例id删除多个评估案例
     *
     * @param evaluationCaseIds
     * @return
     */
    @ApiIgnore
    @DeleteMapping("/delete")
    public R delete(@RequestBody Long[] evaluationCaseIds) {
        int result = evaluationCaseService.deleteEvaluationCasesByIds(evaluationCaseIds);
        if (result == Arrays.asList(evaluationCaseIds).size())
            return R.ok();
        else
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("result", "删除部分失败！成功删除了 " + result + " 条数据");
    }
}
