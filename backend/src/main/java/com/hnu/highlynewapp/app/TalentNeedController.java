package com.hnu.highlynewapp.app;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.hnu.highlynewapp.entity.PeopleRequireEachPositionEntity;
import com.hnu.highlynewapp.entity.TalentNeedEntity;
import com.hnu.highlynewapp.entity.TalentSupplyEntity;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.service.TalentNeedService;
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

import java.util.*;

/**
 * 人才需求
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Api(tags = "人才供需api管理")
@RequestMapping("/talentNeed")
@RestController
public class TalentNeedController {
    @Value("${oss.bucket-domain:}")
    private String ossBucketDomain;
    @Autowired
    private TalentNeedService talentNeedService;

    /**
     * 发布人才需求
     */
    @ApiOperation("发布人才需求")
    @PostMapping("/publish")
    public R publish(@Validated @RequestBody PublishTalentNeedVo vo, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, String> map = ValidationUtils.getErrors(result);
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage()).put("data", map);
        } else {
            talentNeedService.publish(vo);
            return R.ok();
        }
    }

    /**
     * 根据检索条件获取对应的人才需求列表
     */
    @ApiOperation("根据检索条件获取对应的人才需求列表")
    @GetMapping("/getList")
    public R getList() {
        List<TalentNeedEntity> list = talentNeedService.getListByParma();
        return R.ok().put("data", list);
    }

    /**
     * 根据id获取人才需求信息
     */
    @ApiOperation("根据id获取人才需求信息")
    @GetMapping("/get/{talentNeedId}")
    public R getById(@PathVariable("talentNeedId") Long talentNeedId) {
        TalentNeedSearchVo tNeedVo = talentNeedService.getByTalentNeedId(String.valueOf(talentNeedId));
        if (tNeedVo == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        // 拦截过期 OSS 图片
        if (tNeedVo.getImage() == null || tNeedVo.getImage().contains(ossBucketDomain)
                || tNeedVo.getImage().trim().isEmpty()) {
            tNeedVo.setImage("/static/defaultImage/1.png");
        }
        return R.ok().put("data", tNeedVo);
    }

    /**
     * 根据公司id获取自己发布的人才需求信息
     *
     * @return
     */
    @ApiOperation("根据公司id获取自己发布的人才需求信息")
    @GetMapping("/getlist/{role_id}")
    public R getListByRoleId(@ApiParam(value = "角色id", required = true) @PathVariable("role_id") Long role_id) {
        List<TalentNeedEntity> list = talentNeedService.list(new QueryWrapper<TalentNeedEntity>().eq("business_id", role_id).orderByDesc("publish_time"));
        return R.ok().put("data", list);
    }

    /**
     * 根据发布时间降序获取人才信息
     *
     * @return
     */
    @ApiOperation("根据发布时间降序获取需求信息")
    @GetMapping("/list_timeDesc")
    public R getListByPublishTimeDesc() {
        List<TalentNeedEntity> list = talentNeedService.list(new QueryWrapper<TalentNeedEntity>().orderByDesc("publish_time"));
        return R.ok().put("data", list);
    }

    /**
     * 根据发布时间升序获取人才信息
     *
     * @return
     */
    @ApiOperation("根据发布时间升序获取需求信息")
    @GetMapping("/list_timeAes")
    public R getListByPublishTimeAsc() {
        List<TalentNeedEntity> list = talentNeedService.list(new QueryWrapper<TalentNeedEntity>().orderByAsc("publish_time"));
        return R.ok().put("data", list);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @GetMapping("/list")
    //@RequiresPermissions("highlynewapp:talentneed:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = talentNeedService.queryPage(params);

        return R.ok().put("page", page);
    }

    /**
     * 信息
     */
    @ApiIgnore
    @GetMapping("/info/{talentNeedId}")
    //@RequiresPermissions("highlynewapp:talentneed:info")
    public R info(@PathVariable("talentNeedId") Long talentNeedId) {
        TalentNeedEntity talentNeed = talentNeedService.getById(talentNeedId);
        return R.ok().put("talentNeed", talentNeed);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @PostMapping("/save")
    //@RequiresPermissions("highlynewapp:talentneed:save")
    public R save(@RequestBody TalentNeedEntity talentNeed) {
        talentNeedService.save(talentNeed);
        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @PutMapping("/update")
    //@RequiresPermissions("highlynewapp:talentneed:update")
    public R update(@RequestBody TalentNeedEntity talentNeed) {
        talentNeedService.updateById(talentNeed);
        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @DeleteMapping("/delete")
    //@RequiresPermissions("highlynewapp:talentneed:delete")
    public R delete(@RequestBody Long[] talentNeedIds) {
        talentNeedService.removeByIds(Arrays.asList(talentNeedIds));
        return R.ok();
    }

    /**
     * 根据时间和最低学历检索
     *
     * @param vo
     * @return
     */
    @ApiOperation("根据时间和学历领域检索")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success", response = TalentNeedEntity.class)
    })
    @PostMapping("/listByDurationDegree")
    public R listByCondition(@RequestBody DurationDegreeVo vo) {
        return R.ok().put("data", talentNeedService.listByCondition(vo.getDuration(), vo.getDegree()));
    }

    /**
     * 高校审核简历列表
     *
     * @param vo
     * @return
     */
    @ApiOperation("高校审核简历列表")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success", response = TalentNeedEntity.class)
    })
    @PostMapping("/listByCheck")
    public R listByCheckId(@RequestBody SchoolCheckVo vo) {
        return R.ok().put("data", talentNeedService.listByCheckId(vo.getCheckId()));
    }

    /**
     * 高校审核简历列表
     *
     * @param vo
     * @return
     */
    @ApiOperation("名字和技能搜索框查询")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success", response = TalentNeedEntity.class)
    })
    @PostMapping("/listByCondition")
    public R listByCheckId(@RequestBody QueryListVo vo) {
        return R.ok().put("data", talentNeedService.getConditionList(vo.getCondition()));
    }

    /**
     * 获取公司数据饼图
     */
    @ApiOperation("根据检索条件获取公司数据饼图")
    @GetMapping("/getCompanySizeDataList")
    @ResponseBody
    public R getCompanySizeDataList() {
        List<PeopleRequireEachPositionEntity> numberOfPeopleRequiredEachPosition = talentNeedService.getNumberOfPeopleRequiredEachPosition();
        return R.ok().put("data", numberOfPeopleRequiredEachPosition);
    }

    /**
     * 根据用户id获取发布的人才需求
     *
     * @param userId
     * @return
     */
    @ApiOperation(("根据用户id获取发布的人才需求"))
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = TalentNeedEntity.class)
    })
    @GetMapping("/getByUserId/{userId}")
    public R getByUserId(@PathVariable("userId") Long userId) {
        TalentNeedSearchVo talentNeedSearchVo = talentNeedService.getByUserId(String.valueOf(userId));
        if (talentNeedSearchVo == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        return R.ok().put("talentNeeds", talentNeedSearchVo);
    }

    @ApiOperation("根据id计算并保存组合向量")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 9999, message = "数据不合法"),
            @ApiResponse(code = 0, message = "success")
    })
    @GetMapping("/saveCombinedEmbedding/{talentNeedId}")
    public R saveCombinedEmbedding(@PathVariable("talentNeedId") Long talentNeedId) {
        TalentNeedEntity talentNeedEntity = talentNeedService.getById(talentNeedId);
        if (talentNeedEntity == null)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());

        if (talentNeedService.saveCombinedEmbedding(talentNeedId,
                talentNeedEntity.getPosition(),
                talentNeedEntity.getJob(),
                talentNeedEntity.getDemand()) == 0)
            return R.error(BizCodeEnum.INPUT_INVALID.getCode(), BizCodeEnum.INPUT_INVALID.getMessage());
        return R.ok();
    }

    @ApiOperation("批量生成组合向量")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success")
    })
    @PostMapping("/batchSaveCombinedEmbeddings")
    public R batchSaveCombinedEmbeddings() {
        int updateCount = talentNeedService.batchSaveCombinedEmbeddings();
        return R.ok().put("updateCount", updateCount).put("message", "成功更新 " + updateCount + " 条记录的组合向量");
    }

    /*@ApiOperation("根据用户id推荐人才需求")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = TalentSupplyEntity.class)
    })
    @GetMapping("/recommendTalents/{userId}")
    public R recommendTalents(@PathVariable("userId") Long userId) {
        List<TalentNeedEntity> myNeeds = talentNeedService.list(new QueryWrapper<TalentNeedEntity>().eq("user_id", userId));
        LinkedHashSet<TalentSupplyEntity> linkedHashSet = new LinkedHashSet<>();
        for (TalentNeedEntity myNeed : myNeeds) {
            linkedHashSet.addAll(talentNeedService.recommendTalents(myNeed));
        }
        List<TalentSupplyEntity> recommendedTalents = new ArrayList<>(linkedHashSet);
        if (recommendedTalents.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("recommendedJobs", recommendedTalents);
    }*/

    /**
     * 基于文本模型的岗位搜索
     *
     * @param requestBody 搜索提示词
     * @return 匹配的人才需求列表
     */
    @ApiOperation("基于文本模型的岗位搜索")
    @ApiResponses({
            @ApiResponse(code = 0, message = "搜索成功", response = TalentNeedEntity.class),
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
            List<TalentNeedEntity> searchResults = talentNeedService.searchByLM(prompt.trim());

            if (searchResults.isEmpty()) {
                return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(),
                        "未找到匹配的岗位需求，请尝试其他关键词");
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
     * 根据用户ID推荐简历（基于用户行为）
     */
    @ApiOperation("根据用户ID推荐简历（基于用户行为）")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success", response = TalentSupplyEntity.class)
    })
    @GetMapping("/recommendTalentsByUserId/{userId}")
    public R recommendTalentsByUserId(@PathVariable("userId") Long userId) {
        List<TalentSupplyEntity> recommendedTalents = talentNeedService.recommendTalentsByUserId(userId);
        return R.ok().put("recommendedTalents", recommendedTalents);
    }
}
