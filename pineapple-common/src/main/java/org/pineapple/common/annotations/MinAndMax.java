package org.pineapple.common.annotations;

import org.pineapple.common.enums.MinAndMaxType;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.*;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * <p>最小值校验</p>
 *
 * @author guocq
 * @since 2023/3/13
 */
@Documented
@Target({METHOD, FIELD, ANNOTATION_TYPE, CONSTRUCTOR, PARAMETER, TYPE_USE})
@Retention(RUNTIME)
public @interface MinAndMax {
    /**
     * <p>指定字段(使用el表达式)</p>
     *
     * @return {@link String }
     * @author guocq
     * @date 2023/3/13 16:03
     */
    String value();

    /**
     * <p>允许的最小值，当值大于或等于该值时允许通过，否则不允许通过</p>
     *
     * @return {@link int }
     * @author guocq
     * @date 2023/3/13 16:06
     */
    int min();

    /**
     * <p>允许的最大值，当值小于或等于该值时允许通过，否则不允许通过</p>
     *
     * @return {@link int }
     * @author guocq
     * @date 2023/3/13 16:06
     */
    int max();

    /**
     * <p>校验类型</p>
     *
     * @return {@link org.pineapple.common.enums.MinAndMaxType }
     * @author guocq
     * @date 2023/3/13 16:09
     */
    MinAndMaxType type() default MinAndMaxType.MIN_AND_MAX;

    /**
     * <p>校验失败错误信息说明</p>
     *
     * @return {@link String }
     * @author guocq
     * @date 2023/3/13 16:03
     */
    String message();
}
