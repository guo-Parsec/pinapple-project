package org.pineapple.engine.basequery.annotations;

import java.lang.annotation.*;

/**
 * <p>数据字典翻译方法注解</p>
 *
 * @author guocq
 * @since 2023/3/17
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD})
public @interface DictTranslate {
    /**
     * <p>转义使用的上下文名称</p>
     *
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/17 9:59
     */
    String context() default "";
}
