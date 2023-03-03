package org.pineapple.common.exceptions;

import cn.hutool.core.util.StrUtil;
import org.pineapple.common.enums.UniformResultEnum;

/**
 * <p>校验异常</p>
 *
 * @author guocq
 * @since 2023/1/31
 */
public class ValidException extends SystemRuntimeException {
    private static final long serialVersionUID = -8737661848697353561L;

    static {
        defaultRem = UniformResultEnum.VALID_ERROR;
    }

    public ValidException() {
        super(defaultRem);
    }

    public ValidException(String customInstructions) {
        super(customInstructions, defaultRem);
    }

    public ValidException(Throwable cause) {
        this(StrUtil.EMPTY, cause);
    }

    public ValidException(String customInstructions, Throwable cause) {
        super(customInstructions, cause, defaultRem);
    }

    /**
     * <p>目标错误转化为{@link ValidException}</p>
     *
     * @param cause 目标错误
     * @return {@link ValidException}
     * @author guocq
     * @date 2023/2/1 9:16
     */
    public static ValidException toModel(Throwable cause) {
        return new ValidException(cause);
    }
}
