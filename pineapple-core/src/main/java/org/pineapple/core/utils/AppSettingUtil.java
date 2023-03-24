package org.pineapple.core.utils;

import org.pineapple.common.constant.CommonConstant;
import org.pineapple.common.support.keyjoin.BasicRedisKeyJoin;
import org.pineapple.common.support.keyjoin.RedisKeyJoin;
import org.pineapple.core.constant.AppSettingConstant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * <p>应用设置工具类</p>
 *
 * @author guocq
 * @since 2023/3/24
 */
public class AppSettingUtil {
    private static final Logger log = LoggerFactory.getLogger(AppSettingUtil.class);

    /**
     * <p>根据应用名获取应用设置key</p>
     *
     * @param appName 应用名
     * @return {@link String }
     * @author guocq
     * @date 2023/3/24 16:05
     */
    private static String generateAppSettingKey(String appName) {
        String appSettingKey = new BasicRedisKeyJoin(false).join(CommonConstant.PROJECT_NAME)
                .join(AppSettingConstant.BIZ_APP_SETTING)
                .join(appName)
                .build();
        log.debug("根据应用名[appName={}]获取应用设置key为[appSettingKey={}]", appName, appSettingKey);
        return appSettingKey;
    }

    /**
     * <p>根据应用名获取应用设置中的feign密钥key</p>
     *
     * @param appName 应用名
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/24 16:14
     */
    public static String generateAppSettingForFeignSecretKey(String appName) {
        String appSettingForFeignSecretKey = new RedisKeyJoin()
                .join(generateAppSettingKey(appName))
                .join(AppSettingConstant.FEIGN_SECRET_KEY)
                .build();
        appSettingForFeignSecretKey = appSettingForFeignSecretKey.replace("-","_");
        log.debug("根据应用名[appName={}]获取应用设置中的feign密钥key为[appSettingKey={}]", appName, appSettingForFeignSecretKey);
        return appSettingForFeignSecretKey;
    }
}
