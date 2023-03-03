package org.pineapple.gateway;

import cn.hutool.extra.spring.SpringUtil;
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
@SpringBootApplication
@Import({SpringUtil.class})
public class GatewayApplication {
    public static void main(String[] args) {
        SpringApplication.run(GatewayApplication.class, args);
    }
}
