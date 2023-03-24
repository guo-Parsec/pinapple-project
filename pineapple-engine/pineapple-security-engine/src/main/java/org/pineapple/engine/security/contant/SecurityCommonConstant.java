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
    public static final String REDIS_BIZ_SECURITY_KEY_PREFIX = "biz-security";

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
    public static final String REDIS_BIZ_KEY_FOR_RESOURCE_ENTITY_SET = "res-entity-set";

    /**
     * 超级管理员角色码
     */
    public static final String ROLE_ADMIN_CODE = "ROLE_ADMIN";
}
