package org.pineapple.common.constant;

/**
 * <p>服务名称定义常量</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
public class ServerNameDefineConstant {
    /**
     * 系统服务名称定义
     */
    public static final String NAME_SYSTEM = "pineapple-system";

    /**
     * 认证中心服务名称定义
     */
    public static final String NAME_AUTH_CENTER = "pineapple-auth-center";

    /**
     * 系统服务feign客户端定义
     */
    public static final String FEIGN_NAME_SYSTEM = NAME_SYSTEM + "/system";

    /**
     * 认证中心服务feign客户端定义
     */
    public static final String FEIGN_NAME_AUTH_CENTER = NAME_AUTH_CENTER + "/auth-center";
}
