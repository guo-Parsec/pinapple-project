package org.pineapple.engine.security.contant;

/**
 * <p>安全通用常量类</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
public class SecurityCommonConstant {
    /**
     * 令牌存储在请求头的key名
     */
    public static final String TOKEN_IN_HEAD_KEY = "Authorization";

    /**
     * 有效令牌文本前缀
     */
    public static final String EFFECTIVE_TOKEN_PREFIX = "Bearer ";

    /**
     * redis安全业务类前缀
     */
    public static final String REDIS_BIZ_SECURITY_KEY_PREFIX = "biz_security";

    /**
     * redis安全业务类存储用户信息key
     */
    public static final String REDIS_BIZ_KEY_FOR_USER = "user";

    /**
     * redis安全业务类存储令牌信息key
     */
    public static final String REDIS_BIZ_KEY_FOR_TOKEN = "token";


    /**
     * redis安全业务类存储资源实体集合信息key
     */
    public static final String REDIS_BIZ_KEY_FOR_RESOURCE_ENTITY_SET = "res_entity_set";

    /**
     * 超级管理员角色码
     */
    public static final String ROLE_ADMIN_CODE = "ROLE_ADMIN";

    /**
     * 安全签名key
     */
    public static final String SECURITY_SIGNATURE_KEY = "securitySignature";

    /**
     * 令牌信息key
     */
    public static final String TOKEN_DETAILS_KEY = "tokenDetails";

    /**
     * details详情key
     */
    public static final String DETAILS_KEY = "details";

    /**
     * 权限key
     */
    public static final String PERMISSIONS_KEY = "permissions";

    /**
     * 角色key
     */
    public static final String ROLES_KEY = "roles";

    /**
     * 资源实体信息集合key
     */
    public static final String RES_ENTITY_SET_KEY = "resEntitySet";
}
