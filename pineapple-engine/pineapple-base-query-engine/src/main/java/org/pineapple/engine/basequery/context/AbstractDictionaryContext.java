package org.pineapple.engine.basequery.context;

import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.ReflectUtil;
import cn.hutool.core.util.StrUtil;
import com.google.common.collect.Sets;
import org.pineapple.common.annotations.Dictionary;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.util.Objects;
import java.util.Set;
import java.util.concurrent.atomic.AtomicReference;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * <p>数据字典上下文抽象类</p>
 *
 * @author guocq
 * @since 2023/2/2
 */
public abstract class AbstractDictionaryContext implements DictionaryContext {
    private static final Logger log = LoggerFactory.getLogger(AbstractDictionaryContext.class);

    /**
     * <p>字段过滤Mapper</p>
     *
     * @return {@link Function< Field,?> }
     * @author guocq
     * @date 2023/2/2 15:41
     */
    public abstract Function<Field, Field> fieldFilterMapper();

    /**
     * <p>获取字典转移后的值</p>
     *
     * @param code       字典类型
     * @param value      字典值
     * @param dictionary 字典注解
     * @return {@link String }
     * @author guocq
     * @date 2023/2/2 15:56
     */
    public abstract String findValueAfterTranslate(String code, String value, Dictionary dictionary);

    /**
     * <p>对目标类中的字段进行数据字典转义</p>
     *
     * @param target 目标类
     * @author guocq
     * @date 2023/2/2 15:23
     */
    @Override
    public void translate(Object target) {
        if (target == null) {
            log.warn("[target]不能为null");
            return;
        }
        populateFieldsValue(target, findDictFields(target.getClass(), Dictionary.class));
    }

    /**
     * <p>填充数据字典属性</p>
     *
     * @param target   目标类
     * @param fieldSet 待转义的字典字段集合
     * @author guocq
     * @date 2023/2/2 15:24
     */
    protected void populateFieldsValue(Object target, Set<Field> fieldSet) {
        Set<Field> newFieldSet = fieldSet.stream().map(fieldFilterMapper()).filter(Objects::nonNull).collect(Collectors.toSet());
        final AtomicReference<Dictionary> dictionaryReference = new AtomicReference<>();
        newFieldSet.forEach(field -> populateFieldValue(target, dictionaryReference, field));
    }

    /**
     * <p>填充属性值</p>
     *
     * @param target              目标类
     * @param dictionaryReference 字典注解引用
     * @param field               属性
     * @author guocq
     * @date 2023/2/2 17:01
     */
    protected void populateFieldValue(Object target, AtomicReference<Dictionary> dictionaryReference, Field field) {
        dictionaryReference.set(field.getAnnotation(Dictionary.class));
        String fieldName = dictionaryReference.get().fieldName();
        Object rawDictValue = ReflectUtil.getFieldValue(target, fieldName);
        String dictValue;
        try {
            dictValue = StrUtil.toStringOrNull(rawDictValue);
        } catch (Exception e) {
            log.warn("目标对象{}的属性[{}]值[{}]转化为Integer类型失败", target, field.getName(), rawDictValue);
            return;
        }
        String code = dictionaryReference.get().code();
        String valueAfterTranslate = findValueAfterTranslate(code, dictValue, dictionaryReference.get());
        ReflectUtil.setFieldValue(target, field, valueAfterTranslate);
    }

    /**
     * <p>获取指定类的被指定注解标识的字段集合</p>
     *
     * @param clazz           指定类
     * @param annotationClass 指定注解
     * @return {@link Set< Field> }
     * @author guocq
     * @date 2023/2/2 15:21
     */
    @SuppressWarnings("all")
    private Set<Field> findDictFields(Class<?> clazz, Class<? extends Annotation> annotationClass) {
        Field[] fields = ReflectUtil.getFields(clazz, field -> field.isAnnotationPresent(annotationClass));
        if (ArrayUtil.isEmpty(fields)) {
            log.debug("类型[{}]中不存在被注解[{}]标识的字段", clazz.getName(), annotationClass.getName());
            return Sets.newHashSet();
        }
        return Sets.newHashSet(fields);
    }
}
