package com.hnu.highlynewapp.app;

import com.hnu.highlynewapp.entity.ContactEntity;
import com.hnu.highlynewapp.service.ContactService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import java.util.Arrays;
import java.util.Map;


/**
 * 联系人
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:55
 */
@RestController
@RequestMapping("/contact")
public class ContactController {
    @Autowired
    private ContactService contactService;

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    //@RequiresPermissions("highlynewapp:contact:list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = contactService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{contactId}")
    //@RequiresPermissions("highlynewapp:contact:info")
    public R info(@PathVariable("contactId") Long contactId){
		ContactEntity contact = contactService.getById(contactId);

        return R.ok().put("contact", contact);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    //@RequiresPermissions("highlynewapp:contact:save")
    public R save(@RequestBody ContactEntity contact){
		contactService.save(contact);

        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("highlynewapp:contact:update")
    public R update(@RequestBody ContactEntity contact){
		contactService.updateById(contact);

        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:contact:delete")
    public R delete(@RequestBody Long[] contactIds){
		contactService.removeByIds(Arrays.asList(contactIds));

        return R.ok();
    }

}
