package org.pineapple.common.utils;

import cn.hutool.core.lang.Filter;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.ReflectUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.BinaryOperator;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * <p>转换工具类</p>
 *
 * @author guocq
 * @since 2023/2/20
 */
public class ConvertUtil {
    /**
     * <p>bean转换为map</p>
     *
     * @param bean             bean对象
     * @param ignoreProperties 忽略属性列表
     * @return {@link Map }
     * @author guocq
     * @date 2023/2/20 14:25
     */
    public static Map<String, Object> beanToMap(Object bean, String... ignoreProperties) {
        return beanToMap(bean, true, ignoreProperties);
    }

    /**
     * <p>bean转换为map</p>
     *
     * @param bean             bean对象
     * @param ignoreProperties 忽略属性列表
     * @param isCover          键值相同时是否采取覆盖原则
     * @return {@link java.util.Map}
     * @author guocq
     * @date 2023/2/20 13:36
     */
    public static Map<String, Object> beanToMap(Object bean, boolean isCover, String... ignoreProperties) {
        Class<?> beanClass = bean.getClass();
        // 字段过滤条件
        Filter<Field> filter = field -> {
            int modifiers = field.getModifiers();
            // 默认只过滤非静态和非transient修饰的字段
            boolean condition = !Modifier.isTransient(modifiers) && !Modifier.isStatic(modifiers);
            if (ArrayUtil.isNotEmpty(ignoreProperties)) {
                Set<String> ignorePropertiesSet = Sets.newHashSet(ignoreProperties);
                // 如果忽略属性列表不为空则过滤不属于忽略属性列表的字段
                condition = condition && !ignorePropertiesSet.contains(field.getName());
            }
            return condition;
        };
        List<Field> fields = Lists.newArrayList(ReflectUtil.getFields(beanClass, filter));
        // 组成map的value注入方法
        Function<Field, Object> valueMapper = field -> {
            // 获取当前属性的值
            Object fieldValue = ReflectUtil.getFieldValue(bean, field);
            field.setAccessible(false);
            return fieldValue;
        };
        // key重复时判断是否为覆盖操作 如果为覆盖操作则覆盖原有值 否则始终保持第一个值
        BinaryOperator<Object> binaryOperator = (pre, next) -> isCover ? next : pre;
        return fields.stream().collect(Collectors.toMap(Field::getName, valueMapper, binaryOperator));
    }

}
