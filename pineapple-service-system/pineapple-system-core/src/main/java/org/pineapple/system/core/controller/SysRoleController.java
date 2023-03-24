package org.pineapple.system.core.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.pineapple.system.api.SystemWebApiDefineConstant;
import org.pineapple.system.core.service.SysRoleService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Set;

/**
 * <p>系统角色管理</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
@Api(tags = "系统角色管理")
@RestController
@RequestMapping(SystemWebApiDefineConstant.WEB_API_ROLE_PREFIX)
public class SysRoleController {
    private final SysRoleService service;

    public SysRoleController(SysRoleService service) {
        this.service = service;
    }

    @ApiOperation(value = "根据用户id获取角色信息")
    @GetMapping("/find-role-code/by/user-id")
    public Set<String> findRoleCodeByUserId(@RequestParam("userId") Long userId) {
        return service.findRoleCodeByUserId(userId);
    }
}
