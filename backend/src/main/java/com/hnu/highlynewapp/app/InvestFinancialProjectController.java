package com.hnu.highlynewapp.app;

import com.hnu.highlynewapp.entity.FinancingNeedEntity;
import com.hnu.highlynewapp.entity.InvestFinancialProjectEntity;
import com.hnu.highlynewapp.entity.InvestingNeedEntity;
import com.hnu.highlynewapp.service.FinancingNeedService;
import com.hnu.highlynewapp.service.InvestFinancialProjectService;
import com.hnu.highlynewapp.service.InvestingNeedService;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.vo.InvestFinanceAuditVo;
import com.hnu.highlynewapp.vo.InvestingSearchByParamVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 *
 * @author Tz
 * @Date 2022/08/11
 */
@RestController
@RequestMapping("/investFinancialProj")
@Api(value = "投融资项目管理",tags = "投融资项目管理")
public class InvestFinancialProjectController {
    @Autowired
    private InvestFinancialProjectService investFinancialProjectService;

    @Autowired
    private InvestingNeedService investingNeedService;

    @Autowired
    private FinancingNeedService financingNeedService;

    /**
     * 根据检索条件(投资类型、投资领域、投资金额)获取对应的投资需求列表
     */
    @ApiOperation("根据检索条件获取对应的投融资审核列表")
    @PostMapping("/getAuditList")
    public R getList(@RequestBody InvestFinanceAuditVo auditVo){
        List<InvestingNeedEntity> investList = investingNeedService.getAuditList(auditVo);
        List<FinancingNeedEntity> financeList = financingNeedService.getAuditList(auditVo);

        return R.ok().put("investList", investList).put("financeList", financeList);

    }

    /**
     * 项目搜索界面，根据检索条件(项目名称 or 备案号)获取对应的投融资需求列表
     */
    @ApiOperation("项目搜索界面，根据(项目名称 or 备案号)获取投融资需求列表")
    @GetMapping("/getByNameOrRecordNum/{nameornum}")
    public R getByNameOrRecordNum(@PathVariable("nameornum") String nameornum){
        List<InvestFinancialProjectEntity> investFinancialProjectyList = investFinancialProjectService.getListByNameOrRecordNum(nameornum);

        return R.ok().put("data", investFinancialProjectyList);

    }
    /**
     * 项目进度查询，根据项目名查询项目进度。
     * @return
     */
    @ApiOperation("根据项目名查询进度")
    @GetMapping("/getProgressDescriptionByProjectName/{project_name}")
    public R getProgressDescriptionByProjectName(@PathVariable("project_name") String project_name) {
        List<InvestFinancialProjectEntity> investFinancialProjectyList = investFinancialProjectService.getProgressDescriptionByProjectName(project_name);
        return R.ok().put("data", investFinancialProjectyList);

    }

    /**
     * 获取项目成功案例---投资
     * 项目表：audit_result 审核结果（0-正在审核中，1-通过，2-不通过）
     *          project_image 项目概念图
     * 投融资：success_flag 项目状态（0-成功，1-进行中,2-失败,3-未开始）
     *       investing_need_id / financial_need_id
     */
    @ApiOperation("获取投资成功案例")
    @PostMapping("/getSuccessList1")
    public R getSuccessList(){
        List<InvestFinancialProjectEntity> investFinancialProjectyList = investFinancialProjectService.getSuccessList1();
        return R.ok().put("data", investFinancialProjectyList);

    }

    /**
     * 获取用于展示的(前4个)项目成功案例---投资
     * 项目表：audit_result 审核结果（0-正在审核中，1-通过，2-不通过）
     *         project_image 项目概念图
     * 投融资：success_flag 项目状态（0-成功，1-进行中,2-失败）
     */
    @ApiOperation("获取用于展示的投资成功案例")
    @PostMapping("/getSuccessList2")
    public R getSuccessList2(){
        List<InvestFinancialProjectEntity> investFinancialProjectyList = investFinancialProjectService.getSuccessList2();
        return R.ok().put("data", investFinancialProjectyList);

    }

    /**
     * 获取项目成功案例---融资
     * 项目表：audit_result 审核结果（0-正在审核中，1-通过，2-不通过）
     *          project_image 项目概念图
     * 投融资：success_flag 项目状态（0-成功，1-进行中,2-失败,3-未开始）
     *       investing_need_id / financial_need_id
     */
    @ApiOperation("获取融资成功案例")
    @PostMapping("/getSuccessList3")
    public R getSuccessList3(){
        List<InvestFinancialProjectEntity> investFinancialProjectyList = investFinancialProjectService.getSuccessList3();
        return R.ok().put("data", investFinancialProjectyList);

    }

    /**
     * 获取用于展示的(前4个)项目成功案例---融资
     * 项目表：audit_result 审核结果（0-正在审核中，1-通过，2-不通过）
     *         project_image 项目概念图
     * 投融资：success_flag 项目状态（0-成功，1-进行中,2-失败）
     */
    @ApiOperation("获取用于展示的融资成功案例")
    @PostMapping("/getSuccessList4")
    public R getSuccessList4(){
        List<InvestFinancialProjectEntity> investFinancialProjectyList = investFinancialProjectService.getSuccessList4();
        return R.ok().put("data", investFinancialProjectyList);

    }

    /**
    * 模糊搜索-根据项目名模糊搜索项目列表
     */
    @ApiOperation("根据项目名模糊搜索项目列表")
    @PostMapping("/getBySimpleProjectName/{project_name}")
    public R getBySimpleProjectName(@PathVariable("project_name") String project_name){
        List<InvestFinancialProjectEntity> investFinancialProjectyList = investFinancialProjectService.getBySimpleProjectName(project_name);
        return R.ok().put("data", investFinancialProjectyList);

    }

    /**
     * 发布项目
     */
    @ApiOperation("发布项目")
    @PostMapping("/publish")
    public R publish(@Validated @RequestBody InvestFinancialProjectEntity investFinancialProjectEntity) {
        investFinancialProjectService.publish(investFinancialProjectEntity);
        return R.ok();
    }


}
