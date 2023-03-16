package org.pineapple.auth.core.service.impl;

import org.pineapple.auth.core.service.LoginService;
import org.pineapple.support.security.SecurityService;
import org.pineapple.support.security.entity.SecuritySignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * <p>登录业务实现类</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
@Service(value = "loginService")
public class LoginServiceImpl implements LoginService {
    private final static Logger log = LoggerFactory.getLogger(LoginServiceImpl.class);

    private final SecurityService securityService;

    public LoginServiceImpl(SecurityService securityService) {
        this.securityService = securityService;
    }

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
    @Override
    public SecuritySignature login(String loginId, String password, String verifyCode) {
        log.debug("用户[loginId={}]尝试登录系统,使用登陆密码[password={}],验证码为[verifyCode={}]", loginId, password, verifyCode);
        return securityService.login(loginId, password);
    }
}
