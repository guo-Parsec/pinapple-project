package org.pineapple.auth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;

/**
 * <p>认证中心应用入口</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
@ComponentScan({
        "org.pineapple.common",
        "org.pineapple.support",
        "org.pineapple.core",
        "org.pineapple.auth",
        "org.pineapple.engine"
})
@EnableFeignClients(basePackages = {"org.pineapple.**.api"})
@EnableDiscoveryClient
@SpringBootApplication
public class AuthApplication {
    public static void main(String[] args) {
        SpringApplication.run(AuthApplication.class, args);
    }
}
