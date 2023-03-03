package org.pineapple.core;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.time.Duration;

/**
 * <p>feign-okhttp配置属性</p>
 *
 * @author guocq
 * @since 2023/2/9
 */
@Component
@Setter
@Getter
@ConfigurationProperties(prefix = "feign.okhttp.config")
public class FeignOkHttpConfigProp {
    /**
     * 设置连接超时
     */
    private Duration connectTimeout;

    /**
     * 设置读取超时
     */
    private Duration readTimeout;

    /**
     * 设置写入超时
     */
    private Duration writeTimeout;

    /**
     * 是否自动重连
     */
    private Boolean retryOnConnectionFailure = false;

    /**
     * 连接池配置
     */
    private FeignOkHttpPoolConfigProp pool;

    @Setter
    @Getter
    public static class FeignOkHttpPoolConfigProp {
        /**
         * 最大连接数
         */
        private Integer maxIdleConnections = 200;

        /**
         * 连接存活时间(分钟)
         */
        private Long keepAliveDuration = 1L;
    }
}
