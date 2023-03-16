package org.pineapple.system.core.service;

import org.pineapple.system.api.vo.SysUserVo;

/**
 * <p> 系统用户信息表 服务类 </p>
 *
 * @author guocq
 * @since 2023-03-13
 */
public interface SysUserService {
    /**
     * <p>加载系统用户</p>
     *
     * @param loginId 登录凭证
     * @return {@link org.pineapple.system.api.vo.SysUserVo }
     * @author guocq
     * @date 2023/3/14 11:17
     */
    SysUserVo loadUser(String loginId);
}
