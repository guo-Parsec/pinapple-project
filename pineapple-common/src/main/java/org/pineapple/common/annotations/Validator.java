package org.pineapple.common.annotations;

import java.lang.annotation.*;

/**
 * <p>校验器</p>
 *
 * @author guocq
 * @since 2023/3/13
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE})
public @interface Validator {
}
