package org.pineapple.auth.core.service;

import org.pineapple.auth.core.pojo.vo.LoginResultVo;

/**
 * <p>登录业务类</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
public interface LoginService {
    /**
     * <p>登录操作</p>
     *
     * @param loginId    账户信息
     * @param password   密码信息
     * @param verifyCode 验证码信息
     * @return {@link LoginResultVo}
     * @author guocq
     * @date 2022/12/28 15:25
     */
    LoginResultVo login(String loginId, String password, String verifyCode);
}
