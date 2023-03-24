package org.pineapple.engine.security.annotations;

import org.pineapple.engine.security.contant.SecurityCommonConstant;

import java.lang.annotation.*;

/**
 * <p>安全参数</p>
 *
 * @author guocq
 * @since 2023/3/24
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.PARAMETER})
public @interface SecurityParam {
    /**
     * <p>获取安全参数的key</p>
     *
     * @return {@link String }
     * @author guocq
     * @date 2023/3/23 14:06
     */
    String value() default SecurityCommonConstant.SECURITY_SIGNATURE_KEY;
}
