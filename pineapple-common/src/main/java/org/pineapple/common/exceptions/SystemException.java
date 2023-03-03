package org.pineapple.common.exceptions;

import cn.hutool.core.util.StrUtil;
import lombok.Getter;
import org.pineapple.common.enums.UniformResultEnum;
import org.pineapple.common.enums.ResultEnumModel;

/**
 * <p>系统异常</p>
 *
 * @author guocq
 * @since 2023/1/31
 */
public class SystemException extends Exception implements ExceptionModel {
    private static final long serialVersionUID = -5652067716198074962L;
    
    protected static ResultEnumModel defaultRem = UniformResultEnum.ERROR;

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

    public SystemException() {
        this(defaultRem);
    }

    public SystemException(String customInstructions) {
        this(customInstructions, defaultRem);
    }

    public SystemException(ResultEnumModel resultEnumModel) {
        this(StrUtil.EMPTY, resultEnumModel);
    }

    public SystemException(String customInstructions, ResultEnumModel resultEnumModel) {
        super(customInstructions);
        this.resultEnumModel = resultEnumModel;
        this.customInstructions = customInstructions;
    }

    public SystemException(Throwable cause) {
        this(StrUtil.EMPTY, cause, defaultRem);
    }

    public SystemException(String customInstructions, Throwable cause) {
        this(customInstructions, cause, defaultRem);
    }

    public SystemException(String customInstructions, Throwable cause, ResultEnumModel resultEnumModel) {
        super(customInstructions, cause);
        this.resultEnumModel = resultEnumModel;
        this.customInstructions = customInstructions;
    }

    /**
     * <p>目标错误转化为{@link SystemException}</p>
     *
     * @param cause 目标错误
     * @return {@link SystemException}
     * @author guocq
     * @date 2023/2/1 9:16
     */
    public static SystemException toModel(Throwable cause) {
        return new SystemException(cause);
    }
}
