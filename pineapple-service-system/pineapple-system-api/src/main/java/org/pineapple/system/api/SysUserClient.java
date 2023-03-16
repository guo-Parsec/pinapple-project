package org.pineapple.system.api;

import org.pineapple.common.uniforms.UniformResultDefinition;
import org.pineapple.system.api.vo.SysUserVo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * <p>系统用户客户端</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
@FeignClient(value = SystemWebApiDefineConstant.FEIGN_API_USER_PREFIX, contextId = "sysUserClient")
public interface SysUserClient {
    /**
     * <p>加载用户信息</p>
     *
     * @param loginId     登录id
     * @return {@link org.pineapple.common.uniforms.UniformResultDefinition<org.pineapple.system.api.vo.SysUserVo> }
     * @author guocq
     * @date 2023/3/14 11:38
     */
    @GetMapping("/load-user")
    UniformResultDefinition<SysUserVo> loadUser(@RequestParam("loginId") String loginId);
}
