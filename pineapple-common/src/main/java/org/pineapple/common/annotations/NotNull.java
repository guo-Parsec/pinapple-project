package org.pineapple.common.annotations;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * <p>非null校验</p>
 *
 * @author guocq
 * @since 2023/3/13
 */
@Documented
@Target({METHOD, FIELD, ANNOTATION_TYPE, CONSTRUCTOR, PARAMETER, TYPE_USE})
@Retention(RUNTIME)
public @interface NotNull {
    /**
     * <p>指定字段(使用el表达式)</p>
     *
     * @return {@link String }
     * @author guocq
     * @date 2023/3/13 16:03
     */
    String value();

    /**
     * <p>校验失败错误信息说明</p>
     *
     * @return {@link String }
     * @author guocq
     * @date 2023/3/13 16:03
     */
    String message();
}
