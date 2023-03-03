package org.pineapple.common.utils;

import org.pineapple.common.exceptions.*;

import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;

/**
 * <p>异常工具类</p>
 *
 * @author guocq
 * @since 2023/1/31
 */
public class ExceptionUtil {
    private static Map<Class<? extends ExceptionModel>, Function<Throwable, ExceptionModel>> toModelMap;

    static {
        toModelMap = new ConcurrentHashMap<>(16);
        toModelMap.put(SystemException.class, SystemException::toModel);
        toModelMap.put(SystemRuntimeException.class, SystemRuntimeException::toModel);
        toModelMap.put(ValidException.class, ValidException::toModel);
        toModelMap.put(UnauthorizedException.class, UnauthorizedException::toModel);
    }

    /**
     * <p>将Throwable错误转化为{@link ExceptionModel}</p>
     *
     * @param cause 错误
     * @return {@link ExceptionModel}
     * @author guocq
     * @date 2023/1/31 17:41
     */
    public static ExceptionModel toModel(Throwable cause) {
        return Optional.ofNullable(toModelMap.get(cause.getClass()))
                .map(func -> func.apply(cause))
                .orElse(SystemException.toModel(cause));
    }
}
