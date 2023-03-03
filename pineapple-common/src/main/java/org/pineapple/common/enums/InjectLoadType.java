package org.pineapple.common.enums;

/**
 * <p>元组加载类型</p>
 *
 * @author guocq
 * @since 2023/2/2
 */
public enum InjectLoadType implements EnumModel {
    /**
     * 静态加载
     */
    STATIC,
    /**
     * SpringBean 加载
     */
    SPRING;


}
