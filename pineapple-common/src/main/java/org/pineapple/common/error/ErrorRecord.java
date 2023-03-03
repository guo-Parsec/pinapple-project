package org.pineapple.common.error;

import org.pineapple.common.enums.ResultEnumModel;
import org.pineapple.common.enums.UniformResultEnum;
import org.slf4j.Logger;

/**
 * <p>错误记录接口</p>
 *
 * @author guocq
 * @since 2023/2/2
 */
@FunctionalInterface
public interface ErrorRecord<T extends Throwable> {
    /**
     * <p>记录错误日志并返回异常供其他程序抛出异常使用</p>
     *
     * @param log    记录日志对象
     * @param cause  原异常信息
     * @param model  结果枚举模型
     * @param format 错误记录文本
     * @param args   待格式化的错误记录文本填充参数
     * @return {@link T } 抛出的错误类型
     * @author guocq
     * @date 2023/2/2 14:14
     */
    T record(Logger log, Throwable cause, ResultEnumModel model, String format, Object... args);

    /**
     * <p>记录错误日志并返回异常供其他程序抛出异常使用</p>
     *
     * @param log    记录日志对象
     * @param cause  原异常信息
     * @param format 错误记录文本
     * @param args   待格式化的错误记录文本填充参数
     * @return {@link T } 抛出的错误类型
     * @author guocq
     * @date 2023/2/2 14:22
     */
    default T record(Logger log, Throwable cause, String format, Object... args) {
        return record(log, cause, UniformResultEnum.ERROR, format, args);
    }

    /**
     * <p>记录错误日志并返回异常供其他程序抛出异常使用</p>
     *
     * @param log    记录日志对象
     * @param model  结果枚举模型
     * @param format 错误记录文本
     * @param args   待格式化的错误记录文本填充参数
     * @return {@link T } 抛出的错误类型
     * @author guocq
     * @date 2023/2/2 14:19
     */
    default T record(Logger log, ResultEnumModel model, String format, Object... args) {
        return record(log, null, model, format, args);
    }

    /**
     * <p>记录错误日志并返回异常供其他程序抛出异常使用</p>
     *
     * @param log    记录日志对象
     * @param format 错误记录文本
     * @param args   待格式化的错误记录文本填充参数
     * @return {@link T } 抛出的错误类型
     * @author guocq
     * @date 2023/2/2 14:21
     */
    default T record(Logger log, String format, Object... args) {
        return record(log, UniformResultEnum.ERROR, format, args);
    }
}
