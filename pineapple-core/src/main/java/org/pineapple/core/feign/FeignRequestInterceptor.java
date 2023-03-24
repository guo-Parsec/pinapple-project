package org.pineapple.core.feign;

import cn.hutool.extra.spring.SpringUtil;
import feign.RequestInterceptor;
import feign.RequestTemplate;
import org.pineapple.core.constant.AppSettingConstant;
import org.pineapple.core.constant.FeignCommonConstant;
import org.pineapple.core.setting.AppSetting;
import org.pineapple.engine.security.SecurityContext;
import org.pineapple.engine.security.contant.SecurityCommonConstant;
import org.pineapple.engine.security.utils.SecurityUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import static org.pineapple.core.constant.AppSettingProviderName.FEIGN_SECRET_SETTING_PROVIDER;

/**
 * <p>远程调用拦截器</p>
 *
 * @author guocq
 * @since 2023/3/24
 */
@Component
public class FeignRequestInterceptor implements RequestInterceptor {
    private static final Logger log = LoggerFactory.getLogger(FeignRequestInterceptor.class);

    private final SecurityContext securityContext;

    private final AppSetting appSetting;

    public FeignRequestInterceptor(SecurityContext securityContext, AppSetting appSetting) {
        this.securityContext = securityContext;
        this.appSetting = appSetting;
    }

    @Override
    public void apply(RequestTemplate template) {
        try {
            String currentAppName = SpringUtil.getApplicationName();
            template.header(FeignCommonConstant.FEIGN_SOURCE_APP_KEY, currentAppName);
            log.debug("应用[{}]正在进行远程调用", currentAppName);
            securityContext.init();
            String tokenText = SecurityUtil.findRawTokenInHead();
            template.header(SecurityCommonConstant.TOKEN_IN_HEAD_KEY, tokenText);
            String feignSecret = appSetting.get(currentAppName, FEIGN_SECRET_SETTING_PROVIDER);
            template.header(AppSettingConstant.FEIGN_SECRET_KEY, feignSecret);
        } finally {
            securityContext.destroy();
        }
    }
}
