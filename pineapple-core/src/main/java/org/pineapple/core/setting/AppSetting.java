package org.pineapple.core.setting;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.extra.spring.SpringUtil;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import org.pineapple.common.constant.BeanNameDefineConstant;
import org.pineapple.common.utils.RedisUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.Set;

import static org.pineapple.core.constant.AppSettingProviderName.FEIGN_SECRET_SETTING_PROVIDER;

/**
 * <p>应用配置类</p>
 *
 * @author guocq
 * @since 2023/3/24
 */
@Component(BeanNameDefineConstant.APP_SETTING)
public class AppSetting implements ApplicationRunner, DisposableBean, InitializingBean {
    private static final Logger log = LoggerFactory.getLogger(AppSetting.class);

    static Set<String> destroyRecorder = Sets.newConcurrentHashSet();

    private static Map<String, AppSettingProvider<?>> providerMap;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        String appName = SpringUtil.getApplicationName();
        log.debug("应用[appName={}]正在启动并配置应用设置信息", appName);
        providerMap.forEach((providerName, provider) -> {
            log.debug("配置器[provider={}]正在启动", providerName);
            provider.init(appName);
        });
    }

    /**
     * <p>根据应用名和提供者获取应用配置内容,应用配置内容为空时使用默认值</p>
     *
     * @param appName      应用名
     * @param providerName 提供者名称
     * @param defaultVal   默认值
     * @return {@link T }
     * @author guocq
     * @date 2023/3/24 16:46
     */
    public <T> T get(String appName, String providerName, T defaultVal) {
        @SuppressWarnings("unchecked")
        AppSettingProvider<T> provider = (AppSettingProvider<T>) providerMap.get(providerName);
        if (provider == null) {
            log.warn("找不到名字为[{}]的提供者", providerName);
            return defaultVal;
        }
        return provider.get(appName, defaultVal);
    }

    /**
     * <p>根据应用名和提供者获取应用配置内容,应用配置内容为空时使用null</p>
     *
     * @param appName      应用名
     * @param providerName 提供者名称
     * @return {@link T }
     * @author guocq
     * @date 2023/3/24 16:46
     */
    public <T> T get(String appName, String providerName) {
        return get(appName, providerName, null);
    }

    @Override
    public void destroy() throws Exception {
        String appName = SpringUtil.getApplicationName();
        log.debug("应用[appName={}]正在关闭并销毁应用设置信息", appName);
        if (CollUtil.isEmpty(destroyRecorder)) {
            log.debug("应用[appName={}]的销毁记录器中未记录任何需要销毁的配置", appName);
            return;
        }
        log.info("应用[appName={}]待销毁的配置共{}条", appName, destroyRecorder.size());
        destroyRecorder.forEach(key -> {
            RedisUtil.getInstance().delete(key);
        });
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        providerMap = providerMap == null ? Maps.newConcurrentMap() : providerMap;
        providerMap.put(FEIGN_SECRET_SETTING_PROVIDER, SpringUtil.getBean(FEIGN_SECRET_SETTING_PROVIDER, AppSettingProvider.class));
    }
}
