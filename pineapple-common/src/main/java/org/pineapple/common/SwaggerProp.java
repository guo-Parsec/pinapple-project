package org.pineapple.common;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * <p>Swagger配置属性</p>
 *
 * @author guocq
 * @since 2023/2/14
 */
@Component
@ConfigurationProperties(prefix = "swagger")
public class SwaggerProp {
    /**
     * 是否开启swagger
     */
    @Setter
    @Getter
    private Boolean enabled;
}
