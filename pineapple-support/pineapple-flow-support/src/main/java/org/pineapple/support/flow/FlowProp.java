package org.pineapple.support.flow;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * <p>流程属性类</p>
 *
 * @author guocq
 * @since 2022/12/13
 */
@Getter
@Setter
@Component
@ConfigurationProperties(prefix = "flow")
public class FlowProp {

    /**
     * jdbc - url
     */
    private String url;

    /**
     * 用户名
     */
    private String username;

    /**
     * 密码
     */
    private String password;

    /**
     * 驱动类名称
     */
    private String driverClassName;

    /**
     * 使用库的名称
     */
    private String schema;

    /**
     * 策略
     */
    private FlowDbSchemaType dbSchemaType;

    /**
     * 流程字体
     */
    private String activityFontName;

    /**
     * 标签字体
     */
    private String labelFontName;

    /**
     * annotation字体
     */
    private String annotationFontName;
}
