package org.pineapple.common.config;

import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.ClassUtil;
import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.google.common.collect.Maps;
import org.apache.commons.io.IOUtils;
import org.pineapple.common.annotations.RestParam;
import org.pineapple.common.support.error.ErrorRecords;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Map;

/**
 * <p>{@link RestParam}解析器</p>
 * <p>
 * 解决的问题:
 * <ul>
 * <li>单个字符串等包装类型都要写一个对象才可以用@RequestBody接收；</li>
 * <li>多个对象需要封装到一个对象里才可以用@RequestBody接收。</li>
 * </ul>
 * </p>
 * <p>
 * 主要优势：
 * <ul>
 * <li>支持通过注解的value指定JSON的key来解析对象。</li>
 * <li>支持通过注解无value，直接根据参数名来解析对象。</li>
 * <li>支持基本类型的注入。</li>
 * <li>支持GET和其他请求方式注入。</li>
 * <li>支持通过注解无value且参数名不匹配JSON串key时，根据属性解析对象。</li>
 * <li>支持多余属性(不解析、不报错)、支持参数“共用”（不指定value时，参数名不为JSON串的key）。</li>
 * <li>支持当value和属性名找不到匹配的key时，对象是否匹配所有属性。</li>
 * </ul>
 * </p>
 *
 * @author guocq
 * @since 2023/3/23
 */
public class RestParamArgumentResolver implements HandlerMethodArgumentResolver {
    private static final String JSON_BODY_ATTRIBUTE = "JSON_REQUEST_BODY";

    private static final Logger log = LoggerFactory.getLogger(RestParamArgumentResolver.class);

    /**
     * <p>设置支持的方法参数类型</p>
     *
     * @param parameter 方法参数
     * @return {@link Boolean }
     * @author guocq
     * @date 2023/3/23 14:22
     */
    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        return parameter.hasParameterAnnotation(RestParam.class);
    }

    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
        JSONObject jsonObject = getRequestJsonObject(webRequest);
        // 根据@RestParam注解value作为json解析的key
        RestParam restParam = parameter.getParameterAnnotation(RestParam.class);
        if (restParam == null) {
            throw ErrorRecords.error.record(log, "解析错误,无法从参数上获取RestParam注解");
        }
        String key = StrUtil.isNotBlank(restParam.value()) ? restParam.value() : parameter.getParameterName();
        Object val = jsonObject.get(key);
        if (val == null && restParam.required()) {
            throw ErrorRecords.valid.record(log, "参数[{}]不可为空", key);
        }
        return this.resolveParameterVal(parameter.getParameterType(), val);
    }

    private Object resolveParameterVal(Class<?> parameterType, Object rawVal) {
        if (rawVal == null) {
            return null;
        }
        if (parameterType.isPrimitive()) {
            return parsePrimitive(parameterType.getName(), rawVal);
        }
        if (ClassUtil.isPrimitiveWrapper(parameterType)) {
            return parseBasicTypeWrapper(parameterType, rawVal);
        }
        if (parameterType == String.class) {
            return rawVal.toString();
        }
        return JSON.parseObject(rawVal.toString(), parameterType);
    }

    /**
     * <p>基本类型解析</p>
     *
     * @param parameterTypeName 参数类型名称
     * @param val               参数值
     * @return {@link Object }
     * @author guocq
     * @date 2023/3/23 15:14
     */
    private Object parsePrimitive(String parameterTypeName, Object val) {
        String valStr = val.toString();
        switch (parameterTypeName) {
            case "boolean":
                return Boolean.valueOf(valStr);
            case "int":
                return Integer.valueOf(valStr);
            case "char":
                return valStr.charAt(0);
            case "short":
                return Short.valueOf(valStr);
            case "long":
                return Long.valueOf(valStr);
            case "float":
                return Float.valueOf(valStr);
            case "double":
                return Double.valueOf(valStr);
            case "byte":
                return Byte.valueOf(valStr);
            default:
                return null;
        }
    }

    /**
     * <p>基本包装类型解析</p>
     *
     * @param parameterType 参数类型
     * @param val           参数值
     * @return {@link java.lang.Object }
     * @author guocq
     * @date 2023/3/23 15:19
     */
    private static Object parseBasicTypeWrapper(Class<?> parameterType, Object val) {
        if (Number.class.isAssignableFrom(parameterType)) {
            Number number = (Number) val;
            if (parameterType == Short.class) {
                return number.shortValue();
            } else if (parameterType == Integer.class) {
                return number.intValue();
            } else if (parameterType == Long.class) {
                return number.longValue();
            } else if (parameterType == Float.class) {
                return number.floatValue();
            } else if (parameterType == Double.class) {
                return number.doubleValue();
            } else if (parameterType == Byte.class) {
                return number.byteValue();
            }
        } else if (parameterType == Boolean.class) {
            return Boolean.parseBoolean(val.toString());
        } else if (parameterType == Character.class) {
            return val.toString().charAt(0);
        }
        return null;
    }

    /**
     * <p>从请求体中获取json对象</p>
     *
     * @param webRequest 请求
     * @return {@link JSONObject }
     * @author guocq
     * @date 2023/3/23 14:32
     */
    private JSONObject getRequestJsonObject(NativeWebRequest webRequest) {
        String jsonBody = (String) webRequest.getAttribute(JSON_BODY_ATTRIBUTE, NativeWebRequest.SCOPE_REQUEST);
        HttpServletRequest servletRequest = webRequest.getNativeRequest(HttpServletRequest.class);
        if (servletRequest == null) {
            throw ErrorRecords.error.record(log, "从webRequest中获取HttpServletRequest失败");
        }
        if (StrUtil.isBlank(jsonBody)) {
            try {
                jsonBody = IOUtils.toString(servletRequest.getReader());
                webRequest.setAttribute(JSON_BODY_ATTRIBUTE, jsonBody, NativeWebRequest.SCOPE_REQUEST);
            } catch (IOException e) {
                throw ErrorRecords.error.record(log, e, "从请求中获取JSON字符串失败");
            }
        }
        if (StrUtil.isEmpty(jsonBody)) {
            Map<String, String[]> parameterMap = servletRequest.getParameterMap();
            Map<String, Object> parameters = Maps.newHashMap();
            parameterMap.forEach((key, value) -> {
                if (ArrayUtil.length(value) == 1) {
                    parameters.put(key, value[0]);
                    return;
                }
                parameters.put(key, value);
            });
            jsonBody = JSON.toJSONString(parameters);
            webRequest.setAttribute(JSON_BODY_ATTRIBUTE, jsonBody, NativeWebRequest.SCOPE_REQUEST);
        }
        return JSONObject.parseObject(jsonBody);
    }
}
