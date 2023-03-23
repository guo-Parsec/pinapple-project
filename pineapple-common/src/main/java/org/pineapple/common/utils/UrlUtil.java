package org.pineapple.common.utils;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.text.AntPathMatcher;
import cn.hutool.core.util.StrUtil;
import org.pineapple.common.constant.CommonConstant;

import java.util.Collection;

/**
 * <p>url相关工具类</p>
 *
 * @author guocq
 * @since 2023/3/23
 */
public class UrlUtil {
    /**
     * <p>判断url是否与规则配置:</p>
     * <p>? 表示单个字符;</p>
     * <p>* 表示一层路径内的任意字符串，不可跨层级;</p>
     * <p>** 表示任意层路径;</p>
     *
     * @param pattern 匹配规则
     * @param url     需要匹配的url
     * @return 是否匹配
     * @author guocq
     * @date 2023/3/23 9:25
     */
    public static boolean isMatch(String pattern, String url) {
        AntPathMatcher matcher = new AntPathMatcher();
        return matcher.match(pattern, url);
    }

    /**
     * <p>判断url是否与规则集合中的任意一个配置:</p>
     * <p>? 表示单个字符;</p>
     * <p>* 表示一层路径内的任意字符串，不可跨层级;</p>
     * <p>** 表示任意层路径;</p>
     *
     * @param url               需要匹配的url
     * @param patternCollection 匹配规则集合
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/23 9:26
     */
    public static boolean matches(String url, Collection<String> patternCollection) {
        if (StrUtil.isBlank(url) || CollUtil.isEmpty(patternCollection)) {
            return false;
        }
        return patternCollection.stream().anyMatch(pattern -> isMatch(pattern, url));
    }

    /**
     * <p>自动填充请求根路径</p>
     *
     * @param rawPath 原始路径
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/23 9:27
     */
    public static String autoPopulateRequestRootPath(String rawPath) {
        if (StrUtil.isBlank(rawPath)) {
            return rawPath;
        }
        return rawPath.startsWith(CommonConstant.LEFT_SLASH) ? rawPath : CommonConstant.LEFT_SLASH + rawPath;
    }

    /**
     * <p>自动完善路径规则</p>
     *
     * @param rawPath 原始路径
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/23 9:28
     */
    public static String autoCompletePath(String rawPath) {
        if (StrUtil.isBlank(rawPath)) {
            return rawPath;
        }
        String path = autoPopulateRequestRootPath(rawPath);
        if (path.endsWith(CommonConstant.LEFT_SLASH)) {
            return path.substring(0, path.lastIndexOf(CommonConstant.LEFT_SLASH));
        }
        return path;
    }
}
