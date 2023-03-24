package org.pineapple.system.core.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.pineapple.system.api.SystemWebApiDefineConstant;
import org.pineapple.system.api.vo.SysUserVo;
import org.pineapple.system.core.service.SysUserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>系统用户管理</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
@Api(tags = "系统用户管理")
@RestController
@RequestMapping(SystemWebApiDefineConstant.WEB_API_USER_PREFIX)
public class SysUserController {
    private final SysUserService service;

    public SysUserController(SysUserService service) {
        this.service = service;
    }

    @ApiOperation(value = "加载用户信息")
    @GetMapping("/load-user")
    public SysUserVo loadUser(@RequestParam("loginId") String loginId) {
        return service.loadUser(loginId);
    }
}
