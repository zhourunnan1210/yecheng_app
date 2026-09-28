package com.hnu.highlynewapp.app;

import com.hnu.highlynewapp.enums.StatusEnum;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.transformation.pojo.TechAchEvaluationReport;
import com.hnu.highlynewapp.transformation.service.TechAchEvaluationReportService;
import com.hnu.highlynewapp.transformation.service.TechAchEvaluationReportVoService;
import com.hnu.highlynewapp.transformation.service.TechAchService;
import com.hnu.highlynewapp.transformation.vo.DurationStatusVo;
import com.hnu.highlynewapp.transformation.vo.FindTechAchEvaluationReportVo;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.utils.ValidationUtils;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * 技术成果评估报告
 */
@Api(tags = "技术成果评估报告api管理")
@CrossOrigin
@RequestMapping("/techAchEvaluationReport")
@RestController
public class TechAchEvaluationReportController {
    @Autowired
    private TechAchEvaluationReportService techAchEvaluationReportService;

    @Autowired
    private TechAchEvaluationReportVoService techAchEvaluationReportVoService;

    @Autowired
    private TechAchService techAchService;

    /**
     * 发布技术成果评估报告
     *
     * @param bindingResult
     * @param techAchEvaluationReport
     * @return
     */
    @ApiOperation("发布技术成果评估报告")
    @ApiResponses({
            @ApiResponse(code = 9999, message = "输入的信息有误"),
            @ApiResponse(code = 0, message = "success", response = R.class)
    })
    @PostMapping("/publish")
    public R publish(@RequestBody @Validated TechAchEvaluationReport techAchEvaluationReport, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(bindingResult);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data", map);
        } else {
            techAchEvaluationReportService.publish(techAchEvaluationReport);
            return R.ok();
        }
    }

    /**
     * 根据技术成果id返回技术成果评估报告的详细信息
     *
     * @param technologyAchievementId
     * @return
     */
    @ApiOperation("根据技术成果id返回技术成果评估报告的详细信息")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = FindTechAchEvaluationReportVo.class)
    })
    @GetMapping("/details1/{technologyAchievementId}")
    public R details1(@ApiParam(required = true, value = "技术成果id") @PathVariable("technologyAchievementId") Long technologyAchievementId) {
        FindTechAchEvaluationReportVo findTechAchEvaluationReportVo = techAchEvaluationReportService.findOneByTechAchId(technologyAchievementId);
        if (findTechAchEvaluationReportVo == null)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("techAchEvaluationReport", findTechAchEvaluationReportVo);
    }

    /**
     * 根据技术成果评估报告id返回技术成果评估报告的详细信息
     *
     * @param techAchEvaluationReportId
     * @return
     */
    @ApiOperation("根据技术成果评估报告id返回技术成果评估报告的详细信息")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = FindTechAchEvaluationReportVo.class)
    })
    @GetMapping("/details2/{techAchEvaluationReportId}")
    public R details2(@ApiParam(required = true, value = "技术成果评估报告id") @PathVariable("techAchEvaluationReportId") Long techAchEvaluationReportId) {
        FindTechAchEvaluationReportVo findTechAchEvaluationReportVo = techAchEvaluationReportService.findOneByTechAchEvalReportId(techAchEvaluationReportId);
        if (findTechAchEvaluationReportVo == null)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("techAchEvaluationReport", findTechAchEvaluationReportVo);
    }

    /**
     * 根据技术成果id返回审核状态等信息
     *
     * @param technologyAchievementId
     * @return
     */
    @ApiOperation("根据技术成果id返回技术成果评估报告的审核状态相关信息")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success\n" +
                    "查询的信息有一下三种情况：\n" +
                    "1. 返回正在审核的状态信息\n" +
                    "2. 返回审核失败的状态以及失败的原因信息\n" +
                    "3. 返回审核通过的状态信息")
    })
    @GetMapping("/application/{technologyAchievementId}")
    public R application(@ApiParam(required = true, value = "技术成果id") @PathVariable("technologyAchievementId") Long technologyAchievementId) {
        TechAchEvaluationReport techAchEvaluationReport = techAchEvaluationReportService.findApplicationStatusByTechAchId(technologyAchievementId);
        Integer status = techAchEvaluationReport.getApplicationStatus();
        if (status == null)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        else if (status == StatusEnum.STATUS_ONE.getCode())
            return R.ok().put("applicationStatus", StatusEnum.STATUS_ONE.getMessage());
        else if (status == StatusEnum.STATUS_THREE.getCode()) {
            String failReason = techAchEvaluationReport.getFailReason();
            return Objects.requireNonNull(R.ok().put("applicationStatus", StatusEnum.STATUS_THREE.getMessage())).put("failReason", failReason != null ? failReason : "未知审核失败原因，请重新提交评估申请。");
        }
        return R.ok().put("applicationStatus", StatusEnum.STATUS_TWO.getMessage());
    }

    /**
     * 根据技术成果id更新技术成果评估报告的信息
     *
     * @param techAchEvaluationReport
     * @return
     */
    @ApiOperation("根据技术成果id更新技术成果评估报告的信息")
    @PutMapping("/update")
    public R update(@RequestBody TechAchEvaluationReport techAchEvaluationReport) {
        int result = techAchEvaluationReportService.updateEvaluationReportById(techAchEvaluationReport);
        if (result == 1)
            return R.ok();
        else
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage());
    }

    /**
     * 根据时间、审核状态和评估状态返回技术成果评估报告
     *
     * @param durationStatusVo
     * @return
     */
    @ApiOperation("根据时间、审核状态和评估状态返回技术成果评估报告")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = FindTechAchEvaluationReportVo.class)
    })
    @PostMapping("/listByCondition")
    public R listByCondition(@RequestBody DurationStatusVo durationStatusVo) {
        List<FindTechAchEvaluationReportVo> list = techAchEvaluationReportVoService.listByCondition(durationStatusVo.getDuration(), durationStatusVo.getApplicationStatus(), durationStatusVo.getEvaluationStatus());
        if (list == null || list.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("data", list);
    }

//    /**
//     * 根据参数返回技术成果评估报告的分页
//     *
//     * @param params        分页参数：limit和page
//     * @param publisherType 发布者类型 [1：高新企业，3：学校]
//     * @param publisherId   企业或者学校id，根据发布者类型判断
//     * @return
//     */
//    @ApiOperation("根据参数返回技术成果评估报告的分页")
//    @PostMapping("/list1")
//    public R list1(@ApiParam(value = "根据需要可以通过JSON传递两个分页参数，分别是：limit和page") @RequestBody Map<String, Object> params, @ApiParam(required = true, value = "发布者类型 [1：高新企业，3：学校]") @RequestParam Integer publisherType, @ApiParam(required = true, value = "企业或者学校id，根据发布者类型判断") @RequestParam Integer publisherId) {
//        PageUtils page = techAchService.queryPageByPublisher(params, publisherType, publisherId);
//        return R.ok().put("page", page);
//    }

    /**
     * 根据用户id返回技术成果评估报告
     *
     * @param userId
     * @return
     */
    @ApiOperation("根据用户id返回技术成果评估报告")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = FindTechAchEvaluationReportVo.class)
    })
    @GetMapping("/list2/{userId}")
    public R list2(@ApiParam(required = true, value = "用户id") @PathVariable("userId") Long userId) {
        List<FindTechAchEvaluationReportVo> list = techAchEvaluationReportVoService.listByUserId(userId);
        if (list == null || list.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("data", list);
    }
}
