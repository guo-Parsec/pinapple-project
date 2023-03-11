package org.pineapple.system;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;

/**
 * <p>系统模块启动类</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
@ComponentScan({
        "org.pineapple.common",
        "org.pineapple.support",
        "org.pineapple.core",
        "org.pineapple.system"
})
@EnableFeignClients(basePackages = {"org.pineapple.**.api"})
@EnableDiscoveryClient
@SpringBootApplication
public class SystemApplication {
    public static void main(String[] args) {
        SpringApplication.run(SystemApplication.class, args);
    }
}
