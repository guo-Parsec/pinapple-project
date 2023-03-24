package org.pineapple.core.setting;

import cn.hutool.extra.spring.SpringUtil;
import org.pineapple.common.NameInterface;

/**
 * <p>应用配置提供器</p>
 *
 * @author guocq
 * @since 2023/3/24
 */
public interface AppSettingProvider<T> extends NameInterface {
    /**
     * <p>当前泛型对象</p>
     *
     * @return {@link Class<T> }
     * @author guocq
     * @date 2023/3/24 16:43
     */
    Class<T> clazz();

    /**
     * <p>初始化</p>
     *
     * @param appName 应用名称
     * @author guocq
     * @date 2023/3/24 16:26
     */
    void init(String appName);

    /**
     * <p>初始化</p>
     *
     * @author guocq
     * @date 2023/3/24 16:26
     */
    default void init() {
        init(SpringUtil.getApplicationName());
    }

    /**
     * <p>根据应用名获取当前配置的内容,当配置内容为空时将返回默认值</p>
     *
     * @param appName    应用名
     * @param defaultVal 默认值
     * @return {@link T }
     * @author guocq
     * @date 2023/3/24 16:29
     */
    T get(String appName, T defaultVal);

    /**
     * <p>根据应用名获取当前配置的内容,当配置内容为空时将返回null</p>
     *
     * @param appName 应用名
     * @return {@link T }
     * @author guocq
     * @date 2023/3/24 16:29
     */
    default T get(String appName) {
        return get(appName, null);
    }
}
