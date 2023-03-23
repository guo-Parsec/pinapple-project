package org.pineapple.common.utils;

import cn.hutool.core.util.ClassUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.extra.spring.SpringUtil;
import com.google.common.collect.Sets;
import org.pineapple.common.GlobalExceptionProp;
import org.pineapple.common.support.error.ErrorRecords;

import java.util.Set;

/**
 * <p>错误工具类</p>
 *
 * @author guocq
 * @since 2023/3/13
 */
public class ErrorUtil extends ExceptionUtil {
    /**
     * <p>优化堆栈输出信息</p>
     *
     * @param cause 异常
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/13 15:07
     */
    public static String optimizeStackTrace(Throwable cause) {
        GlobalExceptionProp prop = SpringUtil.getBean(GlobalExceptionProp.class);
        if (prop.isExcludeErrorRecords()) {
            Set<String> excludePackage = prop.getExcludePackage();
            excludePackage.add(ClassUtil.getPackage(ErrorRecords.class));
            prop.setExcludePackage(excludePackage);
        } else {
            prop.setExcludePackage(Sets.newHashSet());
        }
        return optimizeStackTrace(cause, prop.getPrintStackTracePackage(), prop.isEnablePrintStackTrace());
    }

    /**
     * <p>优化堆栈输出信息</p>
     *
     * @param cause         异常
     * @param packagePrefix 包前缀
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/13 14:57
     */
    private static String optimizeStackTrace(Throwable cause, String packagePrefix, boolean enablePrintStackTrace) {
        if (!enablePrintStackTrace) {
            return "" + cause;
        }
        StringBuilder trace = new StringBuilder("\n").append(cause);
        if (packagePrefix == null || ObjectUtil.equals(packagePrefix, "null")) {
            return trace.toString();
        }
        GlobalExceptionProp prop = SpringUtil.getBean(GlobalExceptionProp.class);
        Set<String> excludePackage = prop.getExcludePackage();
        for (StackTraceElement traceElement : cause.getStackTrace()) {
            if (!traceElement.getClassName().startsWith(packagePrefix)) {
                break;
            }
            if (excludePackage.stream().anyMatch(ep -> traceElement.getClassName().startsWith(ep))) {
                continue;
            }
            trace.append("\n\tat ").append(traceElement);
        }
        return trace.toString();
    }
}
