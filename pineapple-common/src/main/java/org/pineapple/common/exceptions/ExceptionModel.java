package org.pineapple.common.exceptions;

import cn.hutool.core.util.StrUtil;
import org.pineapple.common.enums.UniformResultEnum;
import org.pineapple.common.enums.ResultEnumModel;

/**
 * <p>异常模型</p>
 *
 * @author guocq
 * @since 2023/1/31
 */
public interface ExceptionModel {
    /**
     * <p>获取结果枚举模型</p>
     *
     * @return {@link ResultEnumModel}
     * @author guocq
     * @date 2023/1/31 15:49
     */
    ResultEnumModel getResultEnumModel();

    /**
     * <p>获取结果码</p>
     *
     * @return java.lang.Integer
     * @author guocq
     * @date 2023/1/31 16:49
     */
    default Integer getCode() {
        ResultEnumModel model = getResultEnumModel();
        return model == null ? UniformResultEnum.ERROR.getCode() : model.getCode();
    }

    /**
     * <p>获取异常message</p>
     *
     * @return java.lang.String
     * @author guocq
     * @date 2023/1/31 16:37
     */
    String getMessage();

    /**
     * <p>获取自定义异常说明信息</p>
     *
     * @return java.lang.String
     * @author guocq
     * @date 2023/1/31 16:36
     */
    String getCustomInstructions();

    /**
     * <p>获取异常说明</p>
     *
     * @return java.lang.String
     * @author guocq
     * @date 2023/1/31 15:50
     */
    default String getDesc() {
        String customInstructions = getCustomInstructions();
        if (StrUtil.isNotBlank(customInstructions)) {
            return customInstructions;
        }
        ResultEnumModel model = getResultEnumModel();
        return model == null ? getMessage() : model.getMessage();
    }

    /**
     * <p>是否为基本异常类</p>
     *
     * @return {@link boolean }
     * @author guocq
     * @date 2023/2/2 13:43
     */
    default boolean isException() {
        return this instanceof Exception;
    }
}
