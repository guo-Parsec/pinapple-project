package org.pineapple.common.utils;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.lang.Filter;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.ReflectUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import org.pineapple.common.error.ErrorRecords;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.BinaryOperator;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * <p>类型转换工具类</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
public class CastUtil {
    private static final Logger log = LoggerFactory.getLogger(CastUtil.class);

    /**
     * <p>bean转换为map</p>
     *
     * @param bean             bean对象
     * @param ignoreProperties 忽略属性列表
     * @param isCoverMode      是否采取覆盖模式
     * @return {@link java.util.Map}
     * @author guocq
     * @date 2023/2/20 13:36
     */
    public static Map<String, Object> beanToMap(Object bean, boolean isCoverMode, String... ignoreProperties) {
        if (bean == null) {
            throw ErrorRecords.valid.record(log, "bean转换为map错误：bean不能为null");
        }
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
        Field[] fieldArray = ReflectUtil.getFields(beanClass, filter);
        if (ArrayUtil.isEmpty(fieldArray)) {
            log.warn("bean[{}]不存在属性字段，将返回空的map", bean.getClass().getName());
            return Maps.newHashMap();
        }
        List<Field> fields = Lists.newArrayList(fieldArray);
        // 组成map的value注入方法
        Function<Field, Object> valueMapper = field -> {
            // 获取当前属性的值
            Object fieldValue = ReflectUtil.getFieldValue(bean, field);
            field.setAccessible(false);
            return fieldValue;
        };
        return collectionToMap(fields, Field::getName, valueMapper, isCoverMode);
    }

    /**
     * <p>集合{@code coll}转换为map</p>
     *
     * @param coll        集合
     * @param valueMapper value的生成策略
     * @return {@link java.util.Map }
     * @author guocq
     * @date 2023/2/21 15:55
     */
    public static <K, V> Map<K, V> collectionToMap(Collection<K> coll, Function<K, V> valueMapper) {
        return collectionToMap(coll, raw -> raw, valueMapper, true);
    }

    /**
     * <p>集合{@code coll}转换为map</p>
     *
     * @param coll        集合
     * @param keyMapper   key的生成策略
     * @param valueMapper value的生成策略
     * @return {@link java.util.Map }
     * @author guocq
     * @date 2023/2/21 15:55
     */
    public static <T, K, V> Map<K, V> collectionToMap(Collection<T> coll, Function<T, K> keyMapper, Function<T, V> valueMapper) {
        return collectionToMap(coll, keyMapper, valueMapper, true);
    }

    /**
     * <p>集合{@code coll}转换为map, 当{@code isCoverMode}为{@code true}时，map的key重复时将后者覆盖前者；否则始终保持第一个数据的值</p>
     *
     * @param coll        集合
     * @param keyMapper   key的生成策略
     * @param valueMapper value的生成策略
     * @param isCoverMode 是否采取覆盖模式
     * @return {@link java.util.Map }
     * @author guocq
     * @date 2023/2/21 15:55
     */
    public static <T, K, V> Map<K, V> collectionToMap(Collection<T> coll, Function<T, K> keyMapper, Function<T, V> valueMapper,
                                                      boolean isCoverMode) {
        // key重复时判断是否为覆盖操作 如果为覆盖操作则覆盖原有值 否则始终保持第一个值
        BinaryOperator<V> mergeFunction = (pre, next) -> isCoverMode ? next : pre;
        return collectionToMap(coll, keyMapper, valueMapper, mergeFunction);
    }

    /**
     * <p>集合{@code coll}转换为map</p>
     *
     * @param coll          集合
     * @param keyMapper     key的生成策略
     * @param valueMapper   value的生成策略
     * @param mergeFunction 合并策略
     * @return {@link java.util.Map }
     * @author guocq
     * @date 2023/2/21 15:49
     */
    public static <T, K, V> Map<K, V> collectionToMap(Collection<T> coll, Function<T, K> keyMapper, Function<T, V> valueMapper,
                                                      BinaryOperator<V> mergeFunction) {
        if (CollUtil.isEmpty(coll)) {
            throw ErrorRecords.valid.record(log, "collection转map错误：coll不能为空");
        }
        return coll.stream().collect(Collectors.toMap(keyMapper, valueMapper, mergeFunction));
    }

    public static <T> void castColl(Object coll, Class<T> tClass, Collection<T> collection) {
//        if (coll == null || CollUtil.isEmpty(collection) || tClass == null) {
//            throw ErrorRecords.valid.record(log, "coll和collection不能为空");
//        }
        collection = ((Collection<?>) coll).stream().map(tClass::cast).collect(Collectors.toList());
    }
}
