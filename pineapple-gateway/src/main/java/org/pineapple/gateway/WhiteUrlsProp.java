package org.pineapple.gateway;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>白名单URL配置类</p>
 *
 * @author guocq
 * @since 2023/2/16
 */
@Configuration
@RefreshScope
@ConfigurationProperties("pineapple.gateway.white")
public class WhiteUrlsProp {
    /**
     * 放行URL配置
     */
    @Setter
    @Getter
    private List<String> urls = new ArrayList<>();
}
