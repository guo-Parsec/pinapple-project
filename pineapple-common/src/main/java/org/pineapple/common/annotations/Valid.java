package org.pineapple.common.annotations;

import java.lang.annotation.*;

/**
 * <p>校验</p>
 *
 * @author guocq
 * @since 2023/3/13
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.PARAMETER})
public @interface Valid {
    String value() default "";

    String message() default "";

    NotBlank[] notBlank() default {};
}
