package org.pineapple.common.exceptions;

import cn.hutool.core.util.StrUtil;
import lombok.Getter;
import org.pineapple.common.enums.UniformResultEnum;
import org.pineapple.common.enums.ResultEnumModel;

/**
 * <p>系统运行时异常</p>
 *
 * @author guocq
 * @since 2023/1/31
 */
public class SystemRuntimeException extends RuntimeException implements ExceptionModel {
    private static final long serialVersionUID = -5652067716198074962L;

    /**
     * 结果枚举模型
     */
    @Getter
    protected ResultEnumModel resultEnumModel;

    /**
     * 自定义说明
     */
    @Getter
    protected String customInstructions;

    protected static ResultEnumModel defaultRem = UniformResultEnum.ERROR;

    public SystemRuntimeException() {
        this(defaultRem);
    }

    public SystemRuntimeException(String customInstructions) {
        this(customInstructions, defaultRem);
    }

    public SystemRuntimeException(ResultEnumModel resultEnumModel) {
        this(StrUtil.EMPTY, resultEnumModel);
    }

    public SystemRuntimeException(String customInstructions, ResultEnumModel resultEnumModel) {
        super(customInstructions);
        this.resultEnumModel = resultEnumModel;
        this.customInstructions = customInstructions;
    }

    public SystemRuntimeException(Throwable cause) {
        this(StrUtil.EMPTY, cause, defaultRem);
    }

    public SystemRuntimeException(Throwable cause, ResultEnumModel resultEnumModel) {
        this(StrUtil.EMPTY, cause, resultEnumModel);
    }

    public SystemRuntimeException(String customInstructions, Throwable cause) {
        this(customInstructions, cause, defaultRem);
    }

    public SystemRuntimeException(String customInstructions, Throwable cause, ResultEnumModel resultEnumModel) {
        super(customInstructions, cause);
        this.resultEnumModel = resultEnumModel;
        this.customInstructions = customInstructions;
    }

    /**
     * <p>目标错误转化为{@link SystemRuntimeException}</p>
     *
     * @param cause 目标错误
     * @return {@link SystemRuntimeException}
     * @author guocq
     * @date 2023/2/1 9:16
     */
    public static SystemRuntimeException toModel(Throwable cause) {
        return new SystemRuntimeException(cause);
    }
}
