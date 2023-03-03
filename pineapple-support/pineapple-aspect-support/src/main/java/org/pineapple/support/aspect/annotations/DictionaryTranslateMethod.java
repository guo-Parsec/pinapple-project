package org.pineapple.support.aspect.annotations;

import java.lang.annotation.*;

/**
 * <p>数据字典翻译方法注解</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD})
public @interface DictionaryTranslateMethod {
    /**
     * <p>转义使用的上下文名称</p>
     *
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/2/8 15:08
     */
    String context() default "";
}
