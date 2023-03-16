package org.pineapple.support.security;

/**
 * <p>安全上下文</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
public interface SecurityContext {
    /**
     * <p>上下文名称</p>
     *
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/14 15:44
     */
    default String name() {
        return this.getClass().getSimpleName();
    }

    /**
     * <p>销毁上下文</p>
     *
     * @author guocq
     * @date 2023/3/14 15:42
     */
    void destroy();

    /**
     * <p>获取当前用户的安全签名</p>
     *
     * @return {@link SecuritySignature }
     * @author guocq
     * @date 2023/3/14 15:39
     */
    SecuritySignature get();

    /**
     * <p>安全上下文初始化</p>
     *
     * @return {@link org.pineapple.support.security.SecuritySignature }
     * @author guocq
     * @date 2023/3/14 15:39
     */
    SecuritySignature init();

    /**
     * <p>安全签名设置</p>
     *
     * @author guocq
     * @date 2023/3/14 15:40
     */
    void put(SecuritySignature signature);
}
