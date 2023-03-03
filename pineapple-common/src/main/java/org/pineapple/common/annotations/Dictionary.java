package org.pineapple.common.annotations;

import org.pineapple.common.enums.DictionaryEnum;

import java.lang.annotation.*;

/**
 * <p>数据字典字段标识注解</p>
 *
 * @author guocq
 * @since 2023/2/2
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.FIELD, ElementType.PARAMETER})
public @interface Dictionary {
    /**
     * <p>字典类别码值</p>
     *
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/2/2 14:58
     */
    String code();

    /**
     * <p>字典值来源字段名称</p>
     *
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/2/2 14:58
     */
    String fieldName();

    /**
     * <p>是否为远程查询字典</p>
     *
     * @return {@link boolean }
     * @author guocq
     * @date 2023/2/2 15:00
     */
    boolean remote() default true;

    /**
     * <p>当字典值翻译失败时默认填充的值</p>
     *
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/2/2 15:01
     */
    String defaultVal() default "";

    /**
     * <p>本地枚举类,当且仅当{@code remote=false}时采用</p>
     *
     * @return {@link Class }
     * @author guocq
     * @date 2023/2/2 15:08
     */
    Class<? extends DictionaryEnum> localEnums() default DictionaryEnum.class;
}
