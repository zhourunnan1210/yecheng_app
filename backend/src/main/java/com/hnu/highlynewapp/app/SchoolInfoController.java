package com.hnu.highlynewapp.app;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.hnu.highlynewapp.exception.BizCodeEnum;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.hnu.highlynewapp.entity.SchoolInfoEntity;
import com.hnu.highlynewapp.service.SchoolInfoService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import springfox.documentation.annotations.ApiIgnore;


/**
 * 学校信息
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:56
 */
@Api(tags = "角色api管理")
@RestController
@RequestMapping("/schoolinfo")
public class SchoolInfoController {
    @Autowired
    private SchoolInfoService schoolInfoService;

    /**
     * 获取所有学校和院所
     * @return
     */
    @ApiOperation("获取所有学校和院所")
    @GetMapping("/getlist")
    public R getList() {
        List<SchoolInfoEntity> list = schoolInfoService.list();
        return R.ok().put("data", list);
    }

    /**
     * 根据id获取学校和院所
     * @return
     */
    @ApiOperation("根据id获取学校和院所")
    @GetMapping("/get/{schoolId}")
    public R getById(@PathVariable("schoolId") Long schoolId) {
        SchoolInfoEntity schoolInfoEntity = schoolInfoService.getById(schoolId);
        if (schoolInfoEntity == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        return R.ok().put("data", schoolInfoEntity);
    }

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    //@RequiresPermissions("highlynewapp:schoolinfo:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = schoolInfoService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{schoolId}")
    //@RequiresPermissions("highlynewapp:schoolinfo:info")
    public R info(@PathVariable("schoolId") Long schoolId){
		SchoolInfoEntity schoolInfo = schoolInfoService.getById(schoolId);

        return R.ok().put("schoolInfo", schoolInfo);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    //@RequiresPermissions("highlynewapp:schoolinfo:save")
    public R save(@RequestBody SchoolInfoEntity schoolInfo){
		schoolInfoService.save(schoolInfo);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("highlynewapp:schoolinfo:update")
    public R update(@RequestBody SchoolInfoEntity schoolInfo){
		schoolInfoService.updateById(schoolInfo);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:schoolinfo:delete")
    public R delete(@RequestBody Long[] schoolIds){
		schoolInfoService.removeByIds(Arrays.asList(schoolIds));

        return R.ok();
    }




}
