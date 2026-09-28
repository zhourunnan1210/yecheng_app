package com.hnu.highlynewapp.app;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hnu.highlynewapp.entity.PeopleRequireEachPositionEntity;
import com.hnu.highlynewapp.entity.TalentNeedEntity;
import com.hnu.highlynewapp.entity.TalentSupplyEntity;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.service.TalentSupplyService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.utils.ValidationUtils;
import com.hnu.highlynewapp.vo.*;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * 人才供应
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Api(tags = "人才供需api管理")
@RequestMapping("/talentSupply")
@RestController
public class TalentSupplyController {
    @Value("${oss.bucket-domain:}")
    private String ossBucketDomain;
    @Autowired
    private TalentSupplyService talentSupplyService;

    /**
     * 发布人才供应
     */
    @ApiOperation("发布人才供应")
    @PostMapping("/publish")
    public R publish(@Validated @RequestBody PublishTalentSupplyVo vo, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(result);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data", map);
        } else {
            talentSupplyService.publish(vo);
            return R.ok();
        }
    }

    /**
     * 根据检索条件获取对应的人才供应列表
     */
    @ApiOperation("根据检索条件获取对应的人才供应列表")
    @GetMapping("/getList")
    public R getList() {
        List<TalentSupplyEntity> list = talentSupplyService.getListByParma();
        return R.ok().put("data", list);
    }

    /**
     * 根据id获取人才供应信息
     */
    @ApiOperation("根据id获取人才供应信息")
    @GetMapping("/getById/{talentSupplyId}")
    public R getById(@PathVariable("talentSupplyId") Long talentSupplyId) {
        TalentSupplySearchVo tSupplyVo = talentSupplyService.getByTalentSupplyId(talentSupplyId);
        if (tSupplyVo == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        // 拦截过期 OSS 图片
        if (tSupplyVo.getImage() == null || tSupplyVo.getImage().contains(ossBucketDomain)
                || tSupplyVo.getImage().trim().isEmpty()) {
            tSupplyVo.setImage("/static/defaultImage/1.png");
        }
        return R.ok().put("data", tSupplyVo);
    }

    /**
     * 根据角色id获取自己发布的人才信息
     *
     * @return
     */
    @ApiOperation("根据角色id获取自己发布的人才信息")
    @GetMapping("/getList/{role_id}")
    public R getListByRoleId(@ApiParam(value = "角色id", required = true) @PathVariable("role_id") Long role_id) {
        List<TalentSupplyEntity> list = talentSupplyService.list(new QueryWrapper<TalentSupplyEntity>().eq("school_id", role_id).orderByDesc("publish_time"));
        return R.ok().put("data", list);
    }

    /**
     * 根据发布时间降序获取人才信息
     *
     * @return
     */
    @ApiOperation("根据发布时间降序获取人才信息")
    @GetMapping("/list_timeDesc")
    public R getListByPublishTimeDesc() {
        List<TalentSupplyEntity> list = talentSupplyService.list(new QueryWrapper<TalentSupplyEntity>().orderByDesc("publish_time"));
        return R.ok().put("data", list);
    }

    /**
     * 根据发布时间升序获取人才信息
     *
     * @return
     */
    @ApiOperation("根据发布时间升序获取人才信息")
    @GetMapping("/list_timeAes")
    public R getListByPublishTimeAsc() {
        List<TalentSupplyEntity> list = talentSupplyService.list(new QueryWrapper<TalentSupplyEntity>().orderByAsc("publish_time"));
        return R.ok().put("data", list);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @GetMapping("/list")
    //@RequiresPermissions("highlynewapp:talentsupply:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = talentSupplyService.queryPage(params);
        return R.ok().put("page", page);
    }

    /**
     * 信息
     */
    @ApiIgnore
    @GetMapping("/info/{talentSupplyId}")
    //@RequiresPermissions("highlynewapp:talentsupply:info")
    public R info(@PathVariable("talentSupplyId") Long talentSupplyId) {
        TalentSupplyEntity talentSupply = talentSupplyService.getById(talentSupplyId);
        return R.ok().put("talentSupply", talentSupply);
    }

    /**
     * 保存
     */
    @ApiOperation("保存人才信息")
    @PostMapping("/save")
    //@RequiresPermissions("highlynewapp:talentsupply:save")
    public R save(@RequestBody TalentSupplyEntity talentSupply) {
        talentSupplyService.save(talentSupply);
        return R.ok();
    }

    /**
     * 修改
     */
    @ApiOperation("根据id修改人才信息")
    @PutMapping("/update")
    //@RequiresPermissions("highlynewapp:talentsupply:update")
    public R update(@RequestBody TalentSupplyEntity talentSupply) {
        talentSupplyService.updateById(talentSupply);
        return R.ok();
    }

    /**
     * 删除
     */
    @ApiOperation("根据id删除人才信息")
    @DeleteMapping("/delete")
    //@RequiresPermissions("highlynewapp:talentsupply:delete")
    public R delete(@RequestBody Long[] talentSupplyIds) {
        talentSupplyService.removeByIds(Arrays.asList(talentSupplyIds));
        return R.ok();
    }

    /**
     * 根据时间和行业领域检索
     *
     * @param vo
     * @return
     */
    @ApiOperation("根据时间和学历查询技术成果")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success", response = TalentSupplyEntity.class)
    })
    @PostMapping("/listByDurationDegree")
    public R listByCondition(@RequestBody DurationDegreeVo vo) {
        return R.ok().put("data", talentSupplyService.listByCondition(vo.getDuration(), vo.getDegree()));
    }

    /**
     * 高校审核简历列表
     *
     * @param vo
     * @return
     */
    @ApiOperation("高校审核简历列表")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success", response = TalentSupplyEntity.class)
    })
    @PostMapping("/listByCheck")
    public R listByCheckId(@RequestBody SchoolCheckVo vo) {
        return R.ok().put("data", talentSupplyService.listByCheckId(vo.getCheckId()));
    }

    /**
     * 高校审核简历列表
     *
     * @param vo
     * @return
     */
    @ApiOperation("名字和技能搜索框查询")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success", response = TalentSupplyEntity.class)
    })
    @PostMapping("/listByCondition")
    public R listByCondition(@RequestBody QueryListVo vo) {
        return R.ok().put("data", talentSupplyService.getConditionList(vo.getCondition()));
    }

    /**
     * 获取人才数据饼图
     */
    @ApiOperation("根据检索条件获取人才数据饼图")
    @GetMapping("/getTalentDataPieChartList")
    @ResponseBody
    public R getTalentDataPieChartList() {
        List<PeopleRequireEachPositionEntity> talentDataPieChartList = talentSupplyService.getTalentDataPieChartList();
        return R.ok().put("data", talentDataPieChartList);
    }

    /**
     * 根据用户id获取人才信息
     *
     * @param userId
     * @return
     */
    @ApiOperation(("根据用户id自己申请的人才需求"))
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = TalentSupplyEntity.class)
    })
    @GetMapping("/getByUserId/{userId}")
    public R getByUserId(@PathVariable("userId") Long userId) {
        TalentSupplySearchVo tSupplyByUerId = talentSupplyService.getByUserId(String.valueOf(userId));
        if (tSupplyByUerId == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }

        return R.ok().put("talentSupplies", tSupplyByUerId);
    }

    @ApiOperation("根据id计算并保存组合向量")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 9999, message = "数据不合法"),
            @ApiResponse(code = 0, message = "success")
    })
    @GetMapping("/saveCombinedEmbedding/{talentSupplyId}")
    public R saveCombinedEmbedding(@PathVariable("talentSupplyId") Long talentSupplyId) {
        TalentSupplyEntity talentSupplyEntity = talentSupplyService.getById(talentSupplyId);
        if (talentSupplyEntity == null)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());

        if (talentSupplyService.saveCombinedEmbedding(talentSupplyId,
                talentSupplyEntity.getProfession(),
                talentSupplyEntity.getJob(),
                talentSupplyEntity.getSkill()) == 0)
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage());
        return R.ok();
    }

    @ApiOperation("批量生成组合向量")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success")
    })
    @PostMapping("/batchSaveCombinedEmbeddings")
    public R batchSaveCombinedEmbeddings() {
        int updateCount = talentSupplyService.batchSaveCombinedEmbeddings();
        return R.ok().put("updateCount", updateCount).put("message", "成功更新 " + updateCount + " 条记录的组合向量");
    }

    /*@ApiOperation("根据用户id推荐工作岗位")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = TalentNeedEntity.class)
    })
    @GetMapping("/recommendJobs/{userId}")
    public R recommendJobs(@PathVariable("userId") Long userId) {
        TalentSupplyEntity myResume = talentSupplyService.getOne(new QueryWrapper<TalentSupplyEntity>().eq("user_id", userId));
        List<TalentNeedEntity> recommendedJobs = talentSupplyService.recommendJobs(myResume);
        if (recommendedJobs == null || recommendedJobs.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("recommendedJobs", recommendedJobs);
    }*/

    /**
     * 基于文本模型的人才搜索
     *
     * @param requestBody 搜索提示词
     * @return 匹配的人才需求列表
     */
    @ApiOperation("基于文本模型的人才搜索")
    @ApiResponses({
            @ApiResponse(code = 0, message = "搜索成功", response = TalentSupplyEntity.class),
            @ApiResponse(code = 9999, message = "搜索参数不合法"),
            @ApiResponse(code = 10000, message = "搜索服务异常"),
            @ApiResponse(code = 10003, message = "未找到匹配的人才需求")
    })
    @PostMapping("/searchByLM")
    public R searchByLM(@ApiParam(required = true, value = "搜索提示词，支持职位名称、技能要求等关键词")
                        @RequestBody Map<String, String> requestBody) {
        String prompt = requestBody.get("prompt");

        // 参数验证
        if (prompt == null || prompt.trim().isEmpty()) {
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), "搜索内容不能为空");
        }

        // 限制搜索内容长度
        if (prompt.length() > 200) {
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), "搜索内容过长，请控制在200字符以内");
        }

        try {
            List<TalentSupplyEntity> searchResults = talentSupplyService.searchByLM(prompt.trim());

            if (searchResults.isEmpty()) {
                return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(),
                        "未找到匹配的人才需求，请尝试其他关键词");
            }

            return R.ok()
                    .put("data", searchResults)
                    .put("total", searchResults.size())
                    .put("prompt", prompt.trim());
        } catch (Exception e) {
            // 记录错误日志
            System.err.println("文本模型搜索异常: " + e.getMessage());
            return R.error(BizCodeEnum.SERVER_EXCEPTION.getCode(), "搜索服务暂时不可用，请稍后再试");
        }
    }

    /**
     * 根据用户ID推荐岗位（基于用户行为）
     */
    @ApiOperation("根据用户ID推荐岗位（基于用户行为）")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success", response = TalentNeedEntity.class)
    })
    @GetMapping("/recommendJobsByUserId/{userId}")
    public R recommendJobsByUserId(@PathVariable("userId") Long userId) {
        List<TalentNeedEntity> recommendedJobs = talentSupplyService.recommendJobsByUserId(userId);
        return R.ok().put("recommendedJobs", recommendedJobs);
    }
}
