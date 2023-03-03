package org.pineapple.common.utils;

import cn.hutool.core.util.StrUtil;

/**
 * <p>字符串工具类</p>
 *
 * @author guocq
 * @since 2023/2/17
 */
public class StringUtil extends StrUtil {
    /**
     * <p>如果字符串{@code str}为blank则返回默认值，否则返回原值</p>
     *
     * @param str        字符串
     * @param defaultStr 默认值
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/2/17 13:54
     */
    public static String ifBlankDefault(String str, String defaultStr) {
        return isBlank(str) ? defaultStr : str;
    }
}
