package org.pineapple.auth.core.service.impl;

import cn.hutool.core.collection.CollUtil;
import org.pineapple.auth.core.pojo.vo.LoginResultVo;
import org.pineapple.auth.core.service.LoginService;
import org.pineapple.engine.security.SecurityService;
import org.pineapple.engine.security.entity.SecuritySignature;
import org.pineapple.system.api.client.SysMenuClient;
import org.pineapple.system.api.vo.SysUserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * <p>登录业务实现类</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
@Service(value = "loginService")
public class LoginServiceImpl implements LoginService {
    private final static Logger log = LoggerFactory.getLogger(LoginServiceImpl.class);
    @Resource
    private SysMenuClient sysMenuClient;

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
     * @return {@link LoginResultVo}
     * @author guocq
     * @date 2022/12/28 15:25
     */
    @Override
    public LoginResultVo login(String loginId, String password, String verifyCode) {
        log.debug("用户[loginId={}]尝试登录系统,使用登陆密码[password={}],验证码为[verifyCode={}]", loginId, password, verifyCode);
        SecuritySignature signature = securityService.login(loginId, password);
        Object details = signature.getDetails();
        // 关闭密码显示
        if (details instanceof SysUserVo) {
            SysUserVo sysUserVo = (SysUserVo) details;
            sysUserVo.setLoginPassword(null);
            signature.setDetails(sysUserVo);
        }
        LoginResultVo loginResultVo = new LoginResultVo();
        loginResultVo.setSignature(signature);
        if (CollUtil.isNotEmpty(signature.getPermissions())) {
            loginResultVo.setMenuVos(sysMenuClient.findSysMenuByPermissions(signature.getPermissions()));
        }
        return loginResultVo;
    }
}
