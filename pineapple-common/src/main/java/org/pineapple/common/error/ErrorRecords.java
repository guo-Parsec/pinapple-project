package org.pineapple.common.error;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.StrUtil;
import org.pineapple.common.exceptions.SystemException;
import org.pineapple.common.exceptions.SystemRuntimeException;
import org.pineapple.common.exceptions.UnauthorizedException;
import org.pineapple.common.exceptions.ValidException;
import org.slf4j.Logger;

/**
 * <p>错误记录集合</p>
 *
 * @author guocq
 * @since 2023/2/2
 */
@SuppressWarnings("all")
public class ErrorRecords {
    /**
     * 默认错误 {@link SystemRuntimeException}
     */
    public static final ErrorRecord<SystemRuntimeException> error;

    /**
     * 系统错误 {@link SystemException}
     */
    public static final ErrorRecord<SystemException> system;

    /**
     * 验证错误 {@link ValidException}
     */
    public static final ErrorRecord<ValidException> valid;

    /**
     * 未授权错误 {@link UnauthorizedException}
     */
    public static final ErrorRecord<UnauthorizedException> unauthorized;

    /**
     * 未授权错误 {@link UnauthorizedException}
     */
    public static final ErrorRecord<UnsupportedOperationException> unsupported;

    static {
        error = (log, cause, model, format, args) -> {
            String messageText = getMessageText(format, args);
            return recordAndIfCauseNull(log, cause, messageText) ? new SystemRuntimeException(messageText, model) : new SystemRuntimeException(messageText, cause, model);
        };
        system = (log, cause, model, format, args) -> {
            String messageText = getMessageText(format, args);
            return recordAndIfCauseNull(log, cause, messageText) ? new SystemException(messageText, model) : new SystemException(messageText, cause, model);
        };
        valid = (log, cause, model, format, args) -> {
            String messageText = getMessageText(format, args);
            return recordAndIfCauseNull(log, cause, messageText) ? new ValidException(messageText) : new ValidException(messageText, cause);
        };
        unauthorized = (log, cause, model, format, args) -> {
            String messageText = getMessageText(format, args);
            return recordAndIfCauseNull(log, cause, messageText) ? new UnauthorizedException(messageText) : new UnauthorizedException(messageText, cause);
        };
        unsupported = (log, cause, model, format, args) -> {
            String messageText = getMessageText(format, args);
            return recordAndIfCauseNull(log, cause, messageText) ? new UnsupportedOperationException(messageText) : new UnsupportedOperationException(messageText, cause);
        };
    }

    /**
     * <p>记录错误信息并判断{@code cause}是否为空</p>
     *
     * @param log         记录日志对象
     * @param cause       原异常信息
     * @param messageText 错误记录文本
     * @return {@link boolean }
     * @author guocq
     * @date 2023/2/2 14:44
     */
    private static boolean recordAndIfCauseNull(Logger log, Throwable cause, String messageText) {
        Assert.notNull(log, "日志对象不可为null");
        if (cause == null) {
            log.error(messageText);
            return true;
        }
        log.error(messageText, cause);
        return false;
    }

    /**
     * <p>根据错误记录文本{@code format}和待格式化的错误记录文本填充参数{@code args}获取最终的错误记录信息文本</p>
     *
     * @param format 错误记录文本
     * @param args   待格式化的错误记录文本填充参数
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/2/2 14:16
     */
    private static String getMessageText(String format, Object... args) {
        return ArrayUtil.isEmpty(args) ? format : StrUtil.format(format, args);
    }
}
