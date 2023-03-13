package org.pineapple.common;

import com.google.common.collect.Sets;
import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.Set;

/**
 * <p>全局异常属性值</p>
 *
 * @author guocq
 * @since 2023/3/13
 */
@Component
@ConfigurationProperties(prefix = "error")
public class GlobalExceptionProp {
    /**
     * 是否打印堆栈信息(默认不打印)
     */
    @Setter
    @Getter
    private boolean enablePrintStackTrace = true;

    /**
     * 打印堆栈信息的包
     */
    @Setter
    @Getter
    private String printStackTracePackage;

    /**
     * 是否排除ErrorRecords
     */
    @Setter
    @Getter
    private boolean excludeErrorRecords = true;

    /**
     * 排除的打印堆栈信息的包
     */
    @Setter
    @Getter
    private Set<String> excludePackage = Sets.newHashSet();
}
