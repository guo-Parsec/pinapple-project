package org.pineapple.support.security;

import org.pineapple.common.utils.ErrorUtil;
import org.pineapple.support.security.entity.SecuritySignature;
import org.pineapple.support.security.utils.SecurityUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * <p>基础安全上下文</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
@Component(value = "basicSecurityContext")
public class BasicSecurityContext implements SecurityContext {
    private static final Logger log = LoggerFactory.getLogger(BasicSecurityContext.class);

    private static final ThreadLocal<SecuritySignature> contextCore = ThreadLocal.withInitial(() -> null);

    private final SecurityService securityService;

    public BasicSecurityContext(SecurityService securityService) {
        this.securityService = securityService;
    }

    /**
     * <p>销毁上下文</p>
     *
     * @author guocq
     * @date 2023/3/14 15:42
     */
    @Override
    public void destroy() {
        log.info("安全上下文[{}]开始销毁核心组件[contextCore={}]", this.name(), contextCore);
        contextCore.remove();
    }

    /**
     * <p>获取当前用户的安全签名</p>
     *
     * @return {@link SecuritySignature }
     * @author guocq
     * @date 2023/3/14 15:39
     */
    @Override
    public SecuritySignature get() {
        log.info("安全上下文[{}]开始获取核心组件", this.name());
        SecuritySignature securitySignature = contextCore.get();
        if (SecurityUtil.isSecuritySignatureEmpty(securitySignature)) {
            log.debug("安全上下文[{}]获取到的安全签名为空", this.name());
            try {
                log.debug("安全上下文[{}]开始使用安全引擎重新获取安全签名", this.name());
                securitySignature = securityService.findSignature();
                log.debug("安全上下文[{}]使用安全引擎重新获取安全签名成功, 安全签名为[securitySignature={}]", this.name(), securitySignature);
                contextCore.set(securitySignature);
            } catch (Exception e) {
                securitySignature = null;
                contextCore.remove();
                log.error("安全上下文[{}]使用安全引擎重新获取安全签名失败,原因：{}", this.name(), ErrorUtil.optimizeStackTrace(e));
            }
        }
        log.debug("安全上下文[{}]获取到的安全签名为[securitySignature={}]", this.name(), securitySignature);
        return securitySignature;
    }

    /**
     * <p>安全上下文初始化</p>
     *
     * @return {@link SecuritySignature }
     * @author guocq
     * @date 2023/3/14 15:39
     */
    @Override
    public SecuritySignature init() {
        log.info("安全上下文[{}]开始初始化核心组件", this.name());
        SecuritySignature signature = contextCore.get();
        if (SecurityUtil.isSecuritySignatureEmpty(signature)) {
            log.debug("安全上下文[{}]初始化前安全签名为空", this.name());
            try {
                log.debug("安全上下文[{}]开始使用安全引擎获取安全签名", this.name());
                signature = securityService.findSignature();
                contextCore.set(signature);
                log.debug("安全上下文[{}]使用安全引擎获取安全签名成功, 安全签名为[securitySignature={}]", this.name(), signature);
            } catch (Exception e) {
                log.error("安全上下文[{}]使用安全引擎获取安全签名失败,原因：{}", this.name(), ErrorUtil.optimizeStackTrace(e));
                return signature;
            }
        }
        return signature;
    }

    /**
     * <p>安全签名设置</p>
     *
     * @param signature 安全签名
     * @author guocq
     * @date 2023/3/14 15:40
     */
    @Override
    public void put(SecuritySignature signature) {
        log.debug("安全上下文[{}]设置安全签名", this.name());
        contextCore.set(signature);
    }
}
