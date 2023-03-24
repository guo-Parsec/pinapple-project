package org.pineapple.common.utils;

import cn.hutool.core.util.StrUtil;
import com.google.common.collect.Maps;
import org.pineapple.common.enums.KeyCase;
import org.pineapple.common.support.error.ErrorRecords;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.Locale;
import java.util.Map;

/**
 * <p>请求工具类</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
public class RequestUtil {
    private static final Logger log = LoggerFactory.getLogger(RequestUtil.class);

    /**
     * <p>获取当前请求</p>
     *
     * @return {@link javax.servlet.http.HttpServletRequest }
     * @author guocq
     * @date 2023/3/15 10:32
     */
    public static HttpServletRequest getHttpServletRequest() {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        if (attributes == null) {
            throw ErrorRecords.error.record(log, "获取RequestAttributes失败");
        }
        return attributes.getRequest();
    }

    /**
     * <p>从当前请求中获取请求头map</p>
     *
     * @return {@link java.util.Map<java.lang.String,java.lang.String> }
     * @author guocq
     * @date 2023/3/15 11:12
     */
    public static Map<String, String> getHeadMap() {
        return getHeadMap(getHttpServletRequest(), KeyCase.RAW);
    }

    /**
     * <p>从请求中获取请求头map</p>
     *
     * @param request 请求
     * @return {@link java.util.Map<java.lang.String,java.lang.String> }
     * @author guocq
     * @date 2023/3/15 11:12
     */
    public static Map<String, String> getHeadMap(HttpServletRequest request) {
        return getHeadMap(request, KeyCase.RAW);
    }

    /**
     * <p>从请求中获取请求头map</p>
     *
     * @param request 请求
     * @param keyCase 键类型
     * @return {@link java.util.Map<java.lang.String,java.lang.String> }
     * @author guocq
     * @date 2023/3/15 11:11
     */
    public static Map<String, String> getHeadMap(HttpServletRequest request, KeyCase keyCase) {
        if (keyCase == null) {
            log.warn("[keyCase]不能为null, 系统将采用[RAW]");
            keyCase = KeyCase.RAW;
        }
        Map<String, String> headMap = Maps.newHashMap();
        Enumeration<String> headerNames = request.getHeaderNames();
        while (headerNames.hasMoreElements()) {
            String headName = headerNames.nextElement();
            if (KeyCase.RAW.equals(keyCase)) {
                headMap.put(headName, request.getHeader(headName));
                continue;
            }
            if (KeyCase.UPPER.equals(keyCase)) {
                headMap.put(headName.toUpperCase(Locale.ROOT), request.getHeader(headName));
                continue;
            }
            headMap.put(headName.toLowerCase(Locale.ROOT), request.getHeader(headName));
        }
        return headMap;
    }

    /**
     * <p>根据名称获取请求头</p>
     *
     * @param name name
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 11:16
     */
    public static String findHeadByName(String name) {
        return findHeadByName(getHttpServletRequest(), name, false);
    }

    /**
     * <p>根据名称获取请求头</p>
     *
     * @param request 请求
     * @param name    name
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 11:16
     */
    public static String findHeadByName(HttpServletRequest request, String name) {
        return findHeadByName(request, name, false);
    }

    /**
     * <p>根据名称获取请求头</p>
     *
     * @param request      请求
     * @param name         name
     * @param isIgnoreCase 是否忽略大小写
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 11:16
     */
    public static String findHeadByName(HttpServletRequest request, String name, boolean isIgnoreCase) {
        String headValue = request.getHeader(name);
        if (StrUtil.isNotBlank(headValue)) {
            return headValue;
        }
        if (!isIgnoreCase) {
            return headValue;
        }
        String lowerName = name.toLowerCase(Locale.ROOT);
        Map<String, String> headMap = getHeadMap(request, KeyCase.LOWER);
        if (headMap.containsKey(lowerName)) {
            return headMap.get(lowerName);
        }
        log.warn("在请求中找不到键为[name={}]的请求头", name);
        return null;
    }

    /**
     * <p>根据名称获取请求头</p>
     *
     * @param name         name
     * @param isIgnoreCase 是否忽略大小写
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 11:16
     */
    public static String findHeadByName(String name, boolean isIgnoreCase) {
        return findHeadByName(getHttpServletRequest(), name, isIgnoreCase);
    }
}
