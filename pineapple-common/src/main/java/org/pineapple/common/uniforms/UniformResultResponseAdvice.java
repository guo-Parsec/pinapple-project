package org.pineapple.common.uniforms;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.pineapple.common.annotations.NoneUniformResultWrap;
import org.pineapple.common.support.error.ErrorRecords;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

/**
 * <p>统一结果封装</p>
 *
 * @author guocq
 * @since 2023/3/24
 */
@RestControllerAdvice(basePackages = {"org.pineapple"})
public class UniformResultResponseAdvice implements ResponseBodyAdvice<Object> {
    private static final Logger log = LoggerFactory.getLogger(UniformResultResponseAdvice.class);

    /**
     * <p>判断哪些接口需要进行返回值包装</p>
     *
     * @param returnType    返回值类型
     * @param converterType 选择的转换器类型
     * @return 返回 true 才会执行 {@link #beforeBodyWrite} 返回 false 则不执行;
     * {@code false} otherwise
     */
    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        // 如果接口方法返回 Result 不需要再次包装
        // 如果接口方法使用了 @NoneUniformResultWrap 注解，表示不需要包装
        // 只对成功的请求进行返回包装，异常情况统一放在全局异常中进行处理
        return !(returnType.hasMethodAnnotation(NoneUniformResultWrap.class) || returnType.getParameterType().equals(UniformResultDefinition.class));
    }

    /**
     * <p>进行接口返回值包装</p>
     *
     * @param body                  要写的正文
     * @param returnType            控制器方法的返回类型
     * @param selectedContentType   通过内容协商选择的内容类型
     * @param selectedConverterType 选择写入响应的转换器类型
     * @param request               当前请求
     * @param response              当前响应
     * @return 传入的主体或修改的（可能是新的）实例
     */
    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType,
                                  Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request,
                                  ServerHttpResponse response) {
        log.debug("进行接口统一返回值包装");
        // String 类型不能直接包装，需要进行特殊处理
        if (returnType.getParameterType().equals(String.class)) {
            ObjectMapper objectMapper = new ObjectMapper();
            try {
                //使用 jackson 将返回数据转换为 json
                return objectMapper.writeValueAsString(UniformResultTool.success(body));
            } catch (JsonProcessingException e) {
                //这里会走统一异常处理
                throw ErrorRecords.error.record(log, "String类型返回值包装异常");
            }
        }
        return UniformResultTool.success(body);
    }
}
