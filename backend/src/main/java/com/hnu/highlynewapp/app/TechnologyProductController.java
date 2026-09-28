package com.hnu.highlynewapp.app;

import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.transformation.pojo.TechnologyProductEntity;
import com.hnu.highlynewapp.transformation.service.TechnologyProductService;
import com.hnu.highlynewapp.transformation.vo.TechProductQueryVo;
import com.hnu.highlynewapp.utils.R;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 科技产品
 */
@Api(tags = "技术api管理")
@RestController
@RequestMapping("/technologyProduct")
public class TechnologyProductController {
    @Autowired
    private TechnologyProductService technologyProductService;

    /**
     * 根据时间、技术领域、研发进度查询科技产品
     */
    @ApiOperation("根据时间、技术领域、研发进度查询科技产品")
    @ApiResponses({
            @ApiResponse(code = 10003, message = "查询的信息不存在"),
            @ApiResponse(code = 0, message = "success", response = TechnologyProductEntity.class)
    })
    @PostMapping("/listByConditions")
    public R listByConditions(@RequestBody TechProductQueryVo vo) {
        List<TechnologyProductEntity> list = technologyProductService.listByConditions(vo);
        if (list == null || list.size() == 0)
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        return R.ok().put("data", list);
    }

    @ApiOperation("根据产品id查询产品详情")
    @GetMapping("/listByProductId/{technologyProductId}")
    public R listByProductId(@PathVariable Long technologyProductId) {
        TechnologyProductEntity technologyProductEntity = technologyProductService.listByProductId(technologyProductId);
        if (technologyProductEntity == null) {
            return R.error(BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getCode(), BizCodeEnum.INFO_NOT_FOUND_EXCEPTION.getMessage());
        }
        return R.ok().put("technologyProductEntity", technologyProductEntity);
    }
}
