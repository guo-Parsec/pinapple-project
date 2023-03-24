package org.pineapple.common.annotations;

import java.lang.annotation.*;

/**
 * <p>不需要统一返回结果包装</p>
 *
 * @author guocq
 * @since 2023/3/24
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD})
public @interface NoneUniformResultWrap {
}
