package org.pineapple.common.config;

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONException;
import com.alibaba.fastjson2.JSONObject;
import com.google.common.collect.Sets;
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
import java.lang.reflect.Field;
import java.util.Set;

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
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/23 14:22
     */
    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        return parameter.hasParameterAnnotation(RestParam.class);
    }

    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
        String jsonBody = getRequestBody(webRequest);
        JSONObject jsonObject = JSON.parseObject(jsonBody);
        // 根据@RestParam注解value作为json解析的key
        RestParam restParam = parameter.getParameterAnnotation(RestParam.class);
        if (restParam == null) {
            throw ErrorRecords.error.record(log, "解析错误,无法从参数上获取RestParam注解");
        }
        String key = StrUtil.isNotBlank(restParam.value()) ? restParam.value() : parameter.getParameterName();
        Object val = jsonObject.get(key);
        Class<?> parameterType = parameter.getParameterType();
        if (val != null) {
            // 基本类型
            if (parameterType.isPrimitive()) {
                return parsePrimitive(parameterType.getName(), val);
            }
            // 基本类型包装类
            if (isBasicDataTypes(parameterType)) {
                return parseBasicTypeWrapper(parameterType, val);
            }
            // 字符串类型
            if (parameterType == String.class) {
                return val.toString();
            }
            return JSON.parseObject(val.toString(), parameterType);
        }
        // 解析不到则将整个json串解析为当前参数类型
        if (isBasicDataTypes(parameterType)) {
            if (restParam.required()) {
                throw ErrorRecords.valid.record(log, "参数 {} 不能为空", key);
            }
            return null;
        }
        if (!restParam.parseAllFields()) {
            if (restParam.required()) {
                throw ErrorRecords.valid.record(log, "参数 {} 不能为空", key);
            }
            return null;
        }
        Object result;
        try {
            result = JSON.parseObject(jsonObject.toString(), parameterType);
        } catch (JSONException jsonException) {
            result = null;
        }
        if (restParam.required()) {
            throw ErrorRecords.valid.record(log, "参数 {} 不能为空", key);
        }
        boolean haveValue = false;
        Field[] declaredFields = parameterType.getDeclaredFields();
        for (Field field : declaredFields) {
            field.setAccessible(true);
            if (field.get(result) != null) {
                haveValue = true;
                break;
            }
        }
        if (!haveValue) {
            throw ErrorRecords.valid.record(log, "参数 {} 不能为空", key);
        }
        return result;
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
     * <p>判断是否为基本数据类型包装类</p>
     *
     * @param clazz 类型
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/23 15:20
     */
    private boolean isBasicDataTypes(Class<?> clazz) {
        Set<Class<?>> classSet = Sets.newHashSet();
        classSet.add(Integer.class);
        classSet.add(Long.class);
        classSet.add(Short.class);
        classSet.add(Float.class);
        classSet.add(Double.class);
        classSet.add(Boolean.class);
        classSet.add(Byte.class);
        classSet.add(Character.class);
        return classSet.contains(clazz);
    }

    /**
     * <p>从请求体中获取json字符串</p>
     *
     * @param webRequest 请求
     * @return {@link String }
     * @author guocq
     * @date 2023/3/23 14:32
     */
    private String getRequestBody(NativeWebRequest webRequest) {
        HttpServletRequest servletRequest = webRequest.getNativeRequest(HttpServletRequest.class);
        String jsonBody = (String) webRequest.getAttribute(JSON_BODY_ATTRIBUTE, NativeWebRequest.SCOPE_REQUEST);
        if (StrUtil.isBlank(jsonBody)) {
            try {
                jsonBody = IOUtils.toString(servletRequest.getReader());
                webRequest.setAttribute(JSON_BODY_ATTRIBUTE, jsonBody, NativeWebRequest.SCOPE_REQUEST);
            } catch (IOException e) {
                throw ErrorRecords.error.record(log, e, "从请求中获取JSON字符串失败");
            }
        }
        return jsonBody;
    }
}
