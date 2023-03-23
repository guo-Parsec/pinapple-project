package org.pineapple.common.annotations;

import java.lang.annotation.*;

/**
 * <p>请求参数统一封装，可支持多个参数</p>
 *
 * @author guocq
 * @since 2023/3/23
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.PARAMETER})
public @interface RestParam {
    /**
     * <p>解析时用到的JSON的key</p>
     *
     * @return {@link String }
     * @author guocq
     * @date 2023/3/23 14:06
     */
    String value() default "";

    /**
     * <p>参数必须</p>
     *
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/23 14:06
     */
    boolean required() default true;

    /**
     * <p>当value的值或者参数名不匹配时，是否允许解析最外层属性到该对象</p>
     *
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/23 15:25
     */
    boolean parseAllFields() default true;
}
