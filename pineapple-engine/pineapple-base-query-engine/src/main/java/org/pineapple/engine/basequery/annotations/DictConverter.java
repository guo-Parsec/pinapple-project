package org.pineapple.engine.basequery.annotations;

import java.lang.annotation.*;

/**
 * <p>数据字典转换器</p>
 *
 * @author guocq
 * @since 2023/3/17
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE})
public @interface DictConverter {
}
