package org.pineapple.common.exceptions;

import cn.hutool.core.util.StrUtil;
import org.pineapple.common.enums.UniformResultEnum;

/**
 * <p>未经授权异常</p>
 *
 * @author guocq
 * @since 2023/2/1
 */
public class UnauthorizedException extends SystemRuntimeException {
    private static final long serialVersionUID = -1573928664171791872L;

    static {
        defaultRem = UniformResultEnum.UNAUTHORIZED;
    } 

    public UnauthorizedException() {
        super(defaultRem);
    }

    public UnauthorizedException(String customInstructions) {
        super(customInstructions, defaultRem);
    }

    public UnauthorizedException(Throwable cause) {
        this(StrUtil.EMPTY, cause);
    }

    public UnauthorizedException(String customInstructions, Throwable cause) {
        super(customInstructions, cause, defaultRem);
    }

    /**
     * <p>目标错误转化为{@link UnauthorizedException}</p>
     *
     * @param cause 目标错误
     * @return {@link UnauthorizedException}
     * @author guocq
     * @date 2023/2/1 9:16
     */
    public static UnauthorizedException toModel(Throwable cause) {
        return new UnauthorizedException(cause);
    }
}
