package com.hnu.highlynewapp.app;

import com.hnu.highlynewapp.entity.IndexEntity;
import com.hnu.highlynewapp.service.IndexService;
import com.hnu.highlynewapp.utils.R;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * @author zhourunnan
 * @Date 2021/9/19 1:57
 */
@RestController("/index")
public class IndexController {

    @Autowired
    private IndexService indexService;

    @PostMapping("/list")
    @ApiOperation("查询index123")
    public R getIndexByKeys(@RequestParam("indexName") String indexName) {
        List<Map<String, Object>> r = indexService.getIndexList(indexName);
        return R.ok().put(r);
    }

    @PostMapping("/add/index")
    @ApiOperation("添加index11121111")
    public R addIndex(@RequestBody IndexEntity entity) {
        boolean save = indexService.save(entity);
        if (save) {
            return R.ok();
        } else {
            return R.error("保存失败");
        }
    }
}
