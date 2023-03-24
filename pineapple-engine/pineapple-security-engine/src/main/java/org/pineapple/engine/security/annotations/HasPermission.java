package org.pineapple.engine.security.annotations;

import org.pineapple.engine.security.contant.SecurityCommonConstant;
import org.springframework.core.annotation.AliasFor;

import java.lang.annotation.*;

/**
 * <p>判断当前方法是否拥有权限</p>
 *
 * @author guocq
 * @since 2023/3/24
 */
@Documented
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface HasPermission {
    /**
     * <p>判断当前用户是否拥有指定权限列表中的任意一个,同permissions</p>
     *
     * @return {@link String[] }
     * @author guocq
     * @date 2023/3/24 9:30
     */
    @AliasFor("permissions")
    String[] value() default {};

    /**
     * <p>判断当前用户是否拥有指定权限列表中的任意一个,同value</p>
     *
     * @return {@link String[] }
     * @author guocq
     * @date 2023/3/24 9:30
     */
    @AliasFor("value")
    String[] permissions() default {};

    /**
     * <p>是否拒绝admin用户访问该接口</p>
     *
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/24 9:32
     */
    boolean denyAdmin() default false;

    /**
     * <p>是否支持模糊匹配,默认支持模糊匹配</p>
     * <ul>
     * <li>? 表示单个字符;</li>
     * <li>* 表示一层路径内的任意字符串，不可跨层级;</li>
     * <li>** 表示任意层路径;</li>
     * </ul>
     *
     * @return boolean true - 支持模糊匹配; false - 不支持模糊匹配
     * @author guocq
     * @date 2023/3/24 9:48
     */
    boolean fuzzyMatchSupport() default true;

    /**
     * <p>超级管理员角色码定义,默认为{@code ROLE_ADMIN}</p>
     *
     * @return {@link String }
     * @author guocq
     * @date 2023/3/24 9:58
     */
    String adminRoleName() default SecurityCommonConstant.ROLE_ADMIN_CODE;
}
