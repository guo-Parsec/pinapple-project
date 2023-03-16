package org.pineapple.common;

/**
 * <p>定义名称的接口</p>
 *
 * @author guocq
 * @since 2023/3/16
 */
public interface NameInterface {
    /**
     * <p>获取当前接口名称</p>
     *
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/16 9:34
     */
    default String name() {
        return this.getClass().getSimpleName();
    }
}
