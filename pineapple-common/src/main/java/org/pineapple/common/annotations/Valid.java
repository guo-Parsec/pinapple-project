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
    /**
     * <p>字符内容非空校验</p>
     *
     * @return {@link org.pineapple.common.annotations.NotBlank[] }
     * @author guocq
     * @date 2023/3/13 16:03
     */
    NotBlank[] notBlank() default {};

    /**
     * <p>非null校验</p>
     *
     * @return {@link org.pineapple.common.annotations.NotNull[] }
     * @author guocq
     * @date 2023/3/13 16:10
     */
    NotNull[] notNull() default {};

    /**
     * <p>最小值最大值校验</p>
     *
     * @return {@link org.pineapple.common.annotations.MinAndMax[] }
     * @author guocq
     * @date 2023/3/13 16:10
     */
    MinAndMax[] minAndMax() default {};
}
