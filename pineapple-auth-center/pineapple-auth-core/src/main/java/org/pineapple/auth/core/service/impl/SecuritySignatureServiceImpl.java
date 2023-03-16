package org.pineapple.auth.core.service.impl;

import cn.hutool.core.util.ObjectUtil;
import org.pineapple.auth.core.SecurityResultEnum;
import org.pineapple.common.error.ErrorRecords;
import org.pineapple.common.uniforms.UniformResultTool;
import org.pineapple.support.security.SecuritySignature;
import org.pineapple.support.security.SecuritySignatureService;
import org.pineapple.system.api.SysUserClient;
import org.pineapple.system.api.vo.SysUserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * <p>安全签名Service实现类</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
@Primary
@Service(value = "securitySignatureService")
public class SecuritySignatureServiceImpl implements SecuritySignatureService {
    private static final Logger log = LoggerFactory.getLogger(SecuritySignatureServiceImpl.class);
    @Resource
    private SysUserClient sysUserClient;

    /**
     * <p>根据登录凭证{@code loginId}加载签名信息</p>
     *
     * @param loginId 登录凭证
     * @return {@link SecuritySignature }
     * @author guocq
     * @date 2023/3/15 15:18
     */
    @Override
    public SecuritySignature loadSignature(String loginId, String rawPassword) {
        log.debug("根据登录凭证[loginId={}]加载签名信息开始", loginId);
        SysUserVo sysUserVo = UniformResultTool.grabDataNoException(sysUserClient.loadUser(loginId));
        if (sysUserVo == null) {
            throw ErrorRecords.unauthorized.record(log, SecurityResultEnum.NOT_FOUND_USER, "根据登录凭证[loginId={}]获取用户失败", loginId);
        }
        // todo 密码加解密
        if (!ObjectUtil.equals(rawPassword, sysUserVo.getLoginPassword())) {
            throw ErrorRecords.unauthorized.record(log, SecurityResultEnum.PASSWORD_ERROR, "根据登录凭证[loginId={}]认证失败用户名密码错误", loginId);
        }
        SecuritySignature signature = new SecuritySignature();
        signature.setId(sysUserVo.getId());
        signature.setLoginId(sysUserVo.getLoginId());
        signature.setDetails(sysUserVo);
        log.debug("根据登录凭证[loginId={}]加载签名信息完成,签名信息为[signature={}]", loginId, signature);
        return signature;
    }
}
