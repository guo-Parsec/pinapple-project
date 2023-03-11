package org.pineapple.common.utils;

import cn.hutool.core.collection.CollUtil;
import com.google.common.collect.Lists;

import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * <p>流工具类</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
public class StreamUtil {
    /**
     * <p>将List元素{@code E}类型转换为{@code T}类型</p>
     *
     * @param rawList 原始list
     * @param mapper  转换mapper
     * @return java.util.List<T>
     * @author hedwing
     * @since 2023/3/11
     */
    public static <T, E> List<T> castElementForList(List<E> rawList, Function<E, T> mapper) {
        if (CollUtil.isEmpty(rawList)) {
            return Lists.newArrayList();
        }
        return rawList.stream().map(mapper).collect(Collectors.toList());
    }
}
