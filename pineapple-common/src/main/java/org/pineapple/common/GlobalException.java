package org.pineapple.common;

import org.pineapple.common.exceptions.SystemException;
import org.pineapple.common.exceptions.SystemRuntimeException;
import org.pineapple.common.uniforms.UniformResultDefinition;
import org.pineapple.common.uniforms.UniformResultTool;
import org.pineapple.common.utils.ExceptionUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.BindException;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * <p>全局异常配置</p>
 *
 * @author guocq
 * @since 2023/2/9
 */
@RestControllerAdvice
public class GlobalException {
    private static final Logger log = LoggerFactory.getLogger(GlobalException.class);

    /**
     * <p>参数校验失败异常</p>
     *
     * @param exception 参数校验异常
     * @return {@link UniformResultDefinition< Void> }
     * @author guocq
     * @date 2023/2/9 15:13
     */
    @ExceptionHandler({MethodArgumentNotValidException.class})
    public UniformResultDefinition<Void> validException(MethodArgumentNotValidException exception) {
        ObjectError objectError = exception.getBindingResult().getAllErrors().get(0);
        log.error("参数校验失败", exception);
        return UniformResultTool.validFailed(objectError.getDefaultMessage());
    }

    /**
     * <p>参数校验失败异常处理</p>
     *
     * @param exception 参数校验失败异常处理
     * @return {@link UniformResultDefinition< Void> }
     * @author guocq
     * @date 2023/2/9 15:13
     */
    @ExceptionHandler({BindException.class})
    public UniformResultDefinition<Void> bindException(BindException exception) {
        ObjectError objectError = exception.getBindingResult().getAllErrors().get(0);
        log.error("参数校验失败", exception);
        return UniformResultTool.validFailed(objectError.getDefaultMessage());
    }

    /**
     * <p>业务异常处理</p>
     *
     * @param exception 业务异常
     * @return {@link org.pineapple.common.uniforms.UniformResultDefinition<Void> }
     * @author guocq
     * @date 2023/2/9 15:16
     */
    @ExceptionHandler({SystemRuntimeException.class})
    public UniformResultDefinition<Void> coreExceptionHandler(SystemRuntimeException exception) {
        log.error("应用执行异常处理[SystemRuntimeException]", exception);
        return UniformResultTool.failed(exception);
    }

    /**
     * <p>业务异常处理</p>
     *
     * @param exception 业务异常
     * @return {@link org.pineapple.common.uniforms.UniformResultDefinition<Void> }
     * @author guocq
     * @date 2023/2/9 15:16
     */
    @ExceptionHandler({SystemException.class})
    public UniformResultDefinition<Void> coreExceptionHandler(SystemException exception) {
        log.error("应用执行异常处理[SystemException]", exception);
        return UniformResultTool.failed(exception);
    }

    /**
     * <p>其他异常处理</p>
     *
     * @param exception 其他异常
     * @return {@link org.pineapple.common.uniforms.UniformResultDefinition<java.lang.Void> }
     * @author guocq
     * @date 2023/2/9 15:17
     */
    @ExceptionHandler({Exception.class})
    public UniformResultDefinition<Void> defaultExceptionHandler(Exception exception) {
        log.error("应用执行异常处理[Exception]", exception);
        return UniformResultTool.failed(ExceptionUtil.toModel(exception));
    }
}
