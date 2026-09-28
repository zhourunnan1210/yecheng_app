package com.hnu.highlynewapp.app;

import com.hnu.highlynewapp.entity.UserEntity;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.exception.RegisterFailException;
import com.hnu.highlynewapp.service.UserService;
import com.hnu.highlynewapp.utils.PageUtils;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.vo.LoginVo;
import com.hnu.highlynewapp.vo.RegisterVo;
import com.hnu.highlynewapp.vo.UserVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import java.util.Arrays;
import java.util.Map;

/**
 * 用户
 *
 * @author hnu_worker
 * @email 13513595808@163.com
 * @date 2021-01-03 10:35:57
 */
@Api(value = "用户api管理", tags = "用户api管理")
@RequestMapping("/user")
@RestController
public class UserController {
    @Autowired
    private UserService userService;

    /**
     * 列表
     */
    @ApiIgnore
    @RequestMapping("/list")
    //@RequiresPermissions("highlynewapp:user:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = userService.queryPage(params);
        return R.ok().put("page", page);
    }

    /**
     * 信息
     */
    @ApiIgnore
    @RequestMapping("/info/{userId}")
    //@RequiresPermissions("highlynewapp:user:info")
    public R info(@PathVariable("userId") Long userId) {
        UserEntity user = userService.getById(userId);
        return R.ok().put("user", user);
    }

    /**
     * 保存
     */
    @ApiIgnore
    @RequestMapping("/save")
    //@RequiresPermissions("highlynewapp:user:save")
    public R save(@RequestBody UserEntity user) {
        userService.save(user);
        return R.ok();
    }

    /**
     * 修改
     */
    @ApiIgnore
    @RequestMapping("/update")
    //@RequiresPermissions("highlynewapp:user:update")
    public R update(@RequestBody UserEntity user) {
        userService.updateById(user);
        return R.ok();
    }

    /**
     * 删除
     */
    @ApiIgnore
    @RequestMapping("/delete")
    //@RequiresPermissions("highlynewapp:user:delete")
    public R delete(@RequestBody Long[] userIds) {
        userService.removeByIds(Arrays.asList(userIds));
        return R.ok();
    }

    /**
     * 用户注册
     *
     * @param registerVo
     * @return
     */
    @PostMapping("/register")
    @ApiOperation("用户注册")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success", response = R.class),
            @ApiResponse(code = 721, message = "请输入正确的电话号码/此电话号已注册/请输入6-20位密码/密码和确认密码不匹配")
    })
    public R register(@RequestBody RegisterVo registerVo) {
        try {
            userService.register(registerVo);
        } catch (RegisterFailException e) {
            e.printStackTrace();
            return R.error(e.getCode(), e.getMessage());
        }
        return R.ok();
    }

    /**
     * 登录
     */
    @ApiOperation("用户登录")
    @ApiResponses({
            @ApiResponse(code = 0, message = "success", response = UserVo.class),
            @ApiResponse(code = 10001, message = "用户名或密码错误")
    })
    @PostMapping("/login")
    public R login(@RequestBody LoginVo loginVo) {
        UserVo vo = userService.login(loginVo);
        if (vo != null)
            return R.ok().put("data", vo);
        else
            return R.error(BizCodeEnum.USERNAME_PASSWORD_INVALID_EXCEPTION.getCode(), BizCodeEnum.USERNAME_PASSWORD_INVALID_EXCEPTION.getMessage());
    }

    @PostMapping("/token/login")
    public R loginByToken(@RequestParam("token") String token) {
        UserVo vo = userService.loginByToken(token);
        return R.ok().put("data", vo);
    }
}
