package com.hnu.highlynewapp.app;

import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.transformation.pojo.Area;
import com.hnu.highlynewapp.transformation.service.AreaService;
import com.hnu.highlynewapp.utils.R;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 省/市/区/地址
 */
@Api(tags = "地址api管理")
@CrossOrigin
@RequestMapping("/address")
@RestController
public class AreaController {
    @Autowired
    private AreaService areaService;

    /**
     * 返回省的信息
     *
     * @return
     */
    @ApiOperation("返回省的信息")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success", response = Area.class)
    })
    @GetMapping("/province")
    public R findAllProvinces() {
        return R.ok().put("provinces", areaService.findAllProvinces());
    }

    /**
     * 根据Pid返回市的信息
     *
     * @param Pid
     * @return
     */
    @ApiOperation("根据Pid返回市的信息")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = Area.class)
    })
    @GetMapping("/city/{Pid}")
    public R findCitiesByPid(@ApiParam(value = "市Pid", required = true) @PathVariable("Pid") Integer Pid) {
        List<Area> cities = areaService.findAreasByPid(Pid);
        if (cities == null || cities.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("cities", cities);
    }

    /**
     * 根据Pid返回区的信息
     *
     * @param Pid
     * @return
     */
    @ApiOperation("根据Pid返回区的信息")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = Area.class)
    })
    @GetMapping("/area/{Pid}")
    public R findAreasByPid(@ApiParam(value = "区Pid", required = true) @PathVariable("Pid") Integer Pid) {
        List<Area> areas = areaService.findAreasByPid(Pid);
        if (areas == null || areas.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("areas", areas);
    }
}
