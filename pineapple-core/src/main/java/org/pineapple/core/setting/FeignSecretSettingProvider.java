package org.pineapple.core.setting;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.spring.SpringUtil;
import org.pineapple.common.constant.BeanNameDefineConstant;
import org.pineapple.common.support.strategy.CryptoStrategy;
import org.pineapple.common.utils.RedisUtil;
import org.pineapple.core.constant.AppSettingConstant;
import org.pineapple.core.constant.AppSettingProviderName;
import org.pineapple.core.constant.FeignCommonConstant;
import org.pineapple.core.utils.AppSettingUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

/**
 * <p>Feign密钥设置</p>
 *
 * @author guocq
 * @since 2023/3/24
 */
@Component(AppSettingProviderName.FEIGN_SECRET_SETTING_PROVIDER)
public class FeignSecretSettingProvider implements AppSettingProvider<String> {
    private static final Logger log = LoggerFactory.getLogger(FeignSecretSettingProvider.class);

    private final RedisUtil redisUtil;

    private CryptoStrategy cryptoStrategy;

    public FeignSecretSettingProvider(RedisUtil redisUtil) {
        this.redisUtil = redisUtil;
    }

    /**
     * <p>获取当前接口名称</p>
     *
     * @return {@link String }
     * @author guocq
     * @date 2023/3/16 9:34
     */
    @Override
    public String name() {
        return AppSettingProviderName.FEIGN_SECRET_SETTING_PROVIDER;
    }

    /**
     * <p>当前泛型对象</p>
     *
     * @return {@link Class<String> }
     * @author guocq
     * @date 2023/3/24 16:43
     */
    @Override
    public Class<String> clazz() {
        return String.class;
    }

    /**
     * <p>初始化Feign密钥</p>
     *
     * @author guocq
     * @date 2023/3/24 15:58
     */
    @Override
    public void init(String appName) {
        log.debug("应用设置提供者[{}]系统[{}]开始初始化feign密钥", name(), appName);
        final String appSettingForFeignSecretKey = AppSettingUtil.generateAppSettingForFeignSecretKey(appName);
        final String uuid = IdUtil.fastUUID();
        final String feignSecret = cryptoStrategy.encrypt(uuid);
        log.debug("应用设置提供者[{}]系统[{}]初始化feign密钥为[feignSecret={}]", name(), appName, feignSecret);
        redisUtil.set(appSettingForFeignSecretKey, feignSecret);
        AppSetting.destroyRecorder.add(appSettingForFeignSecretKey);
    }

    /**
     * <p>校验feign是否是安全的</p>
     *
     * @param request 请求
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/24 17:07
     */
    public static boolean checkFeignIsSecurity(HttpServletRequest request) {
        String sourceApp = request.getHeader(FeignCommonConstant.FEIGN_SOURCE_APP_KEY);
        String feignSecret = request.getHeader(AppSettingConstant.FEIGN_SECRET_KEY);
        if (StrUtil.hasBlank(sourceApp, feignSecret)) {
            log.warn("校验feign为非安全的,原因为无法从请求头中获取来源app和feign密钥信息");
            return false;
        }
        AppSetting appSetting = SpringUtil.getBean(AppSetting.class);
        String realFeignSecret = appSetting.get(sourceApp, AppSettingProviderName.FEIGN_SECRET_SETTING_PROVIDER);
        CryptoStrategy cryptoStrategy = SpringUtil.getBean(BeanNameDefineConstant.AES_CRYPTO, CryptoStrategy.class);
        if (cryptoStrategy.match(feignSecret, realFeignSecret)) {
            return true;
        }
        return false;
    }

    /**
     * <p>根据应用名获取当前配置的内容,当配置内容为空时将返回默认值</p>
     *
     * @param appName    应用名
     * @param defaultVal 默认值
     * @return {@link String }
     * @author guocq
     * @date 2023/3/24 16:29
     */
    @Override
    public String get(String appName, String defaultVal) {
        final String appSettingForFeignSecretKey = AppSettingUtil.generateAppSettingForFeignSecretKey(appName);
        String feignSecret = (String) redisUtil.get(appSettingForFeignSecretKey);
        if (StrUtil.isBlank(feignSecret)) {
            return defaultVal;
        }
        return cryptoStrategy.decrypt(feignSecret);
    }

    @Autowired
    public void setCryptoStrategy(@Qualifier(BeanNameDefineConstant.AES_CRYPTO) CryptoStrategy cryptoStrategy) {
        this.cryptoStrategy = cryptoStrategy;
    }
}
