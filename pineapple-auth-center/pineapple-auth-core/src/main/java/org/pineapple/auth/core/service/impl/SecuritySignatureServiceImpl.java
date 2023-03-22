package org.pineapple.auth.core.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.spring.SpringUtil;
import com.google.common.collect.Maps;
import org.pineapple.auth.core.SecurityResultEnum;
import org.pineapple.common.constant.BeanNameDefineConstant;
import org.pineapple.common.error.ErrorRecords;
import org.pineapple.common.strategy.CryptoStrategy;
import org.pineapple.common.strategy.Md5SaltCrypto;
import org.pineapple.common.uniforms.UniformResultTool;
import org.pineapple.engine.basequery.entity.SystemParamEntity;
import org.pineapple.engine.basequery.facade.SystemParamFacade;
import org.pineapple.engine.security.api.SecuritySignatureService;
import org.pineapple.engine.security.contant.SystemParamConstant;
import org.pineapple.engine.security.entity.SecuritySignature;
import org.pineapple.system.api.SysMenuClient;
import org.pineapple.system.api.SysRoleClient;
import org.pineapple.system.api.SysUserClient;
import org.pineapple.system.api.vo.SysUserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.Map;
import java.util.Set;

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

    @Resource
    private SysRoleClient sysRoleClient;

    @Resource
    private SysMenuClient sysMenuClient;

    private SystemParamFacade systemParamFacade;

    private CryptoStrategy defaultCryptoStrategy;

    @Autowired
    public void setSystemParamFacade(SystemParamFacade systemParamFacade) {
        this.systemParamFacade = systemParamFacade;
    }

    /**
     * <p>获取密码加解密策略器</p>
     *
     * @author guocq
     * @date 2023/3/16 14:53
     */
    @PostConstruct
    public void findCryptoStrategy() {
        SystemParamEntity systemParamEntity = systemParamFacade.findParamByParamCode(SystemParamConstant.PARAM_CODE_USER_PASSWORD_CRYPTO_STRATEGY);
        if (systemParamEntity == null || StrUtil.isBlank(systemParamEntity.getParamValue())) {
            log.debug("加解密策略采用[cryptoStrategy={}]", defaultCryptoStrategy.name());
            this.defaultCryptoStrategy = SpringUtil.getBean(BeanNameDefineConstant.MD5_SALT_CRYPTO, CryptoStrategy.class);
            return;
        }
        this.defaultCryptoStrategy = SpringUtil.getBean(systemParamEntity.getParamValue(), CryptoStrategy.class);
        log.debug("加解密策略采用[cryptoStrategy={}]", this.defaultCryptoStrategy.name());
    }

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
        Map<String, Object> optionMap = Maps.newHashMap();
        optionMap.put(Md5SaltCrypto.OPTION_KEY_SALT, loginId);
        if (!this.defaultCryptoStrategy.match(rawPassword, sysUserVo.getLoginPassword(), optionMap)) {
            throw ErrorRecords.unauthorized.record(log, SecurityResultEnum.PASSWORD_ERROR, "根据登录凭证[loginId={}]认证失败用户名密码错误", loginId);
        }
        SecuritySignature signature = new SecuritySignature();
        signature.setId(sysUserVo.getId());
        signature.setLoginId(sysUserVo.getLoginId());
        signature.setDetails(sysUserVo);
        Set<String> roleCodes = UniformResultTool.grabDataNoException(sysRoleClient.findRoleCodeByUserId(Long.valueOf(sysUserVo.getId())));
        signature.setRoles(roleCodes);
        if (CollUtil.isNotEmpty(roleCodes)) {
            Set<String> menuCodes = UniformResultTool.grabDataNoException(sysMenuClient.findMenuCodeByRoleCode(roleCodes));
            signature.setPermissions(menuCodes);
        }
        log.debug("根据登录凭证[loginId={}]加载签名信息完成,签名信息为[signature={}]", loginId, signature);
        return signature;
    }
}
