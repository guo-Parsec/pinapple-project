package org.pineapple.system.api;

import org.pineapple.common.uniforms.UniformResultDefinition;
import org.pineapple.system.api.vo.SysMenuVo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Set;

/**
 * <p>系统菜单客户端</p>
 *
 * @author guocq
 * @since 2023/3/21
 */
@FeignClient(value = SystemWebApiDefineConstant.FEIGN_API_MENU_PREFIX, contextId = "sysMenuClient")
public interface SysMenuClient {

    /**
     * <p>根据角色码列表获取菜单码</p>
     *
     * @param roleCodeSet 角色码列表
     * @return {@link UniformResultDefinition< Set< String>> }
     * @author guocq
     * @date 2023/3/21 10:49
     */
    @GetMapping("/find-menu-code/by/role-code")
    UniformResultDefinition<Set<String>> findMenuCodeByRoleCode(@RequestParam("roleCodeSet") Set<String> roleCodeSet);

    /**
     * <p>根据菜单编码列表获取菜单信息</p>
     *
     * @param menuCodeSet 菜单编码列表
     * @return {@link org.pineapple.common.uniforms.UniformResultDefinition<java.util.Set> }
     * @author guocq
     * @date 2023/3/23 9:59
     */
    @GetMapping("find-sys-menu/by/menu-codes")
    UniformResultDefinition<Set<SysMenuVo>> findSysMenuByMenuCodes(@RequestParam("menuCodeSet") Set<String> menuCodeSet);
}
