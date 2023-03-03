package org.pineapple.support.durability;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * <p>雪花算法属性类</p>
 *
 * @author guocq
 * @since 2022/12/13
 */
@Component
@ConfigurationProperties(prefix = "id.snowflake")
public class SnowflakeProp {
    /**
     * 数据中心ID
     */
    @Getter
    @Setter
    private long datacenterId = 1L;

    /**
     * 机器ID
     */
    @Getter
    @Setter
    private long machineId = 1L;
}
