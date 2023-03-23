package org.pineapple.gateway;

import cn.hutool.extra.spring.SpringUtil;
import org.pineapple.common.config.RedisConfig;
import org.pineapple.common.utils.RedisUtil;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.Import;

/**
 * <p>网关启动类</p>
 *
 * @author guocq
 * @since 2023/2/16
 */
@EnableDiscoveryClient
@SpringBootApplication(scanBasePackages = {
        "org.pineapple.gateway",
        "org.pineapple.engine.security"
})
@Import({SpringUtil.class, RedisUtil.class, RedisConfig.class})
public class GatewayApplication {
    public static void main(String[] args) {
        SpringApplication.run(GatewayApplication.class, args);
    }
}
