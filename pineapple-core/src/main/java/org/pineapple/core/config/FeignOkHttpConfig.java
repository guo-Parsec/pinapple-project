package org.pineapple.core.config;

import feign.Feign;
import okhttp3.ConnectionPool;
import okhttp3.OkHttpClient;
import org.pineapple.core.FeignOkHttpConfigProp;
import org.springframework.boot.autoconfigure.AutoConfigureBefore;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.cloud.openfeign.FeignAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.TimeUnit;

/**
 * <p>OkHttp配置</p>
 *
 * @author guocq
 * @since 2023/2/9
 */
@Configuration
@ConditionalOnClass(Feign.class)
@AutoConfigureBefore(FeignAutoConfiguration.class)
public class FeignOkHttpConfig {
    FeignOkHttpConfigProp prop;

    public FeignOkHttpConfig(FeignOkHttpConfigProp prop) {
        this.prop = prop;
    }

    /**
     * 连接池配置
     *
     * @return 连接池
     */
    @Bean
    public ConnectionPool pool() {
        // 最大连接数、连接存活时间、存活时间单位（分钟）
        Integer maxIdleConnections = prop.getPool().getMaxIdleConnections();
        Long keepAliveDuration = prop.getPool().getKeepAliveDuration();
        return new ConnectionPool(maxIdleConnections, keepAliveDuration, TimeUnit.MINUTES);
    }

    /**
     * <p>okHttpClient配置</p>
     *
     * @return {@link okhttp3.OkHttpClient }
     * @author guocq
     * @date 2023/2/9 11:07
     */
    @Bean
    public OkHttpClient okHttpClient() {
        return new OkHttpClient.Builder()
                // 设置连接超时
                .connectTimeout(prop.getConnectTimeout())
                // 设置读超时
                .readTimeout(prop.getReadTimeout())
                // 设置写超时
                .writeTimeout(prop.getWriteTimeout())
                //是否自动重连
                .retryOnConnectionFailure(prop.getRetryOnConnectionFailure())
                .connectionPool(pool())
                //构建OkHttpClient对象
                .build();
    }
}
