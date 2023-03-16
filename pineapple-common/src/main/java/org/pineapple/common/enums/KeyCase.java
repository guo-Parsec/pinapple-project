package org.pineapple.common.enums;

import java.util.Locale;

/**
 * <p>键类型</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
public enum KeyCase implements EnumModel {
    /**
     * 原生类型: 对key不进行任何变化
     */
    RAW,

    /**
     * 大写类型: 对key转换为大写，使用{@link String#toUpperCase(Locale)}
     */
    UPPER,

    /**
     * 小写类型: 对key转换为小写，使用{@link String#toLowerCase(Locale)}
     */
    LOWER
}
