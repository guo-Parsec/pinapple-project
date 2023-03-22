package org.pineapple.system.api;

import org.pineapple.common.constant.ServerNameDefineConstant;

/**
 * <p>网络API定义常量</p>
 *
 * @author guocq
 * @since 2023/2/9
 */
public class SystemWebApiDefineConstant {
    /**
     * 网络API - 字典模块前缀
     */
    public static final String WEB_API_DICT_PREFIX = "/dict";

    /**
     * 网络API - 用户模块前缀
     */
    public static final String WEB_API_USER_PREFIX = "/user";

    /**
     * 网络API - 角色模块前缀
     */
    public static final String WEB_API_ROLE_PREFIX = "/role";

    /**
     * 网络API - 菜单模块前缀
     */
    public static final String WEB_API_MENU_PREFIX = "/menu";

    /**
     * FeignAPI - 字典模块前缀
     */
    public static final String FEIGN_API_DICT_PREFIX = ServerNameDefineConstant.FEIGN_NAME_SYSTEM + WEB_API_DICT_PREFIX;

    /**
     * FeignAPI - 用户模块前缀
     */
    public static final String FEIGN_API_USER_PREFIX = ServerNameDefineConstant.FEIGN_NAME_SYSTEM + WEB_API_USER_PREFIX;

    /**
     * FeignAPI - 角色模块前缀
     */
    public static final String FEIGN_API_ROLE_PREFIX = ServerNameDefineConstant.FEIGN_NAME_SYSTEM + WEB_API_ROLE_PREFIX;

    /**
     * FeignAPI - 菜单模块前缀
     */
    public static final String FEIGN_API_MENU_PREFIX = ServerNameDefineConstant.FEIGN_NAME_SYSTEM + WEB_API_MENU_PREFIX;

}
