package org.pineapple.auth.core.service;

import org.pineapple.engine.security.entity.SecuritySignature;

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
     * @return {@link SecuritySignature}
     * @author guocq
     * @date 2022/12/28 15:25
     */
    SecuritySignature login(String loginId, String password, String verifyCode);
}
