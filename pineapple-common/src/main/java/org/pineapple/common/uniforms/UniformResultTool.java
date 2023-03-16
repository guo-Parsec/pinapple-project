package org.pineapple.common.uniforms;

import cn.hutool.core.util.ObjectUtil;
import org.pineapple.common.error.ErrorRecords;
import org.pineapple.common.enums.UniformResultEnum;
import org.pineapple.common.exceptions.ExceptionModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * <p>统一结果工具</p>
 *
 * @author guocq
 * @since 2023/1/31
 */
public class UniformResultTool {
    private static final Logger log = LoggerFactory.getLogger(UniformResultTool.class);

    /**
     * <p>成功结果返回，携带返回数据</p>
     *
     * @param data 返回结果数据
     * @return {@link UniformResultDefinition}
     * @author guocq
     * @date 2023/1/31 17:14
     */
    public static <T> UniformResultDefinition<T> success(T data) {
        return new UniformResultDefinition<>(UniformResultEnum.SUCCESS, data);
    }

    /**
     * <p>成功结果返回，不携带返回数据</p>
     *
     * @return {@link UniformResultDefinition}
     * @author guocq
     * @date 2023/1/31 17:14
     */
    public static <T> UniformResultDefinition<T> success() {
        return new UniformResultDefinition<>(UniformResultEnum.SUCCESS);
    }

    /**
     * <p>失败结果返回，不携带返回数据</p>
     *
     * @return {@link UniformResultDefinition}
     * @author guocq
     * @date 2023/1/31 17:14
     */
    public static <T> UniformResultDefinition<T> failed() {
        return new UniformResultDefinition<>(UniformResultEnum.ERROR);
    }

    /**
     * <p>根据系统异常失败结果返回，不携带返回数据</p>
     *
     * @return {@link UniformResultDefinition}
     * @author guocq
     * @date 2023/1/31 17:14
     */
    public static <T> UniformResultDefinition<T> failed(ExceptionModel exceptionModel) {
        return new UniformResultDefinition<>(exceptionModel);
    }

    /**
     * <p>根据异常失败结果返回，不携带返回数据</p>
     *
     * @return {@link UniformResultDefinition}
     * @author guocq
     * @date 2023/1/31 17:14
     */
    public static <T> UniformResultDefinition<T> failedException(Exception exception) {
        return new UniformResultDefinition<>(exception);
    }

    /**
     * <p>验证失败结果返回，不携带返回数据</p>
     *
     * @param errorMessage 错误信息
     * @return {@link org.pineapple.common.uniforms.UniformResultDefinition<T> }
     * @author guocq
     * @date 2023/2/9 15:12
     */
    public static <T> UniformResultDefinition<T> validFailed(String errorMessage) {
        return new UniformResultDefinition<>(UniformResultEnum.VALID_ERROR, errorMessage);
    }

    /**
     * <p>判断统一结果定义是否请求失败</p>
     *
     * @param definition 统一结果定义
     * @return boolean
     * @author guocq
     * @date 2023/1/31 17:23
     */
    public static <T> boolean isRequestSuccess(UniformResultDefinition<T> definition) {
        return definition != null && !ObjectUtil.isNull(definition.getCode());
    }

    /**
     * <p>判断统一结果定义是否操作失败</p>
     *
     * @param definition 统一结果定义
     * @return boolean
     * @author guocq
     * @date 2023/1/31 17:23
     */
    @SuppressWarnings("all")
    public static <T> boolean isOperateSuccess(UniformResultDefinition<T> definition) {
        if (!isRequestSuccess(definition)) {
            log.debug("[definition={}]因请求失败导致操作失败", definition.simpleToString());
            return false;
        }
        return ObjectUtil.equals(definition.getCode(), UniformResultEnum.SUCCESS.getCode());
    }

    /**
     * <p>抓取返回数据结果，如果数据操作失败则抛出异常</p>
     *
     * @param definition 统一结果定义
     * @return T
     * @author guocq
     * @date 2023/1/31 17:35
     */
    public static <T> T grabData(UniformResultDefinition<T> definition) {
        if (!isOperateSuccess(definition)) {
            throw ErrorRecords.error.record(log, "抓取返回结果数据失败");
        }
        return definition.getData();
    }

    /**
     * <p>抓取返回数据结果, 不抛出异常</p>
     *
     * @param definition 统一结果定义
     * @return T
     * @author guocq
     * @date 2023/1/31 17:35
     */
    public static <T> T grabDataNoException(UniformResultDefinition<T> definition) {
        if (!isOperateSuccess(definition)) {
            log.error("抓取返回数据失败");
            return null;
        }
        return definition.getData();
    }
}
