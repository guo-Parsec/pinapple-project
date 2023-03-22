package org.pineapple.system.api;

import org.pineapple.common.uniforms.UniformResultDefinition;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Set;

/**
 * <p>系统角色客户端</p>
 *
 * @author guocq
 * @since 2023/3/21
 */
@FeignClient(value = SystemWebApiDefineConstant.FEIGN_API_ROLE_PREFIX, contextId = "sysRoleClient")
public interface SysRoleClient {

    /**
     * <p>根据用户id获取角色信息</p>
     *
     * @param userId 用户id
     * @return {@link org.pineapple.common.uniforms.UniformResultDefinition<java.util.Set<java.lang.String>> }
     * @author guocq
     * @date 2023/3/21 10:49
     */
    @GetMapping("/find-role-code/by/user-id")
    UniformResultDefinition<Set<String>> findRoleCodeByUserId(@RequestParam("userId") Long userId);
}
