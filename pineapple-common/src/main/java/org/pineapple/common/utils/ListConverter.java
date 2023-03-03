package org.pineapple.common.utils;

import cn.hutool.core.convert.Converter;
import com.google.common.collect.Lists;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p></p>
 *
 * @author guocq
 * @since 2023/2/21
 */
public class ListConverter<T> implements Converter<List<T>> {
    /**
     * 转换为指定类型<br>
     * 如果类型无法确定，将读取默认值的类型做为目标类型
     *
     * @param value        原始值
     * @param defaultValue 默认值
     * @return 转换后的值
     * @throws IllegalArgumentException 无法确定目标类型，且默认值为{@code null}，无法确定类型
     */
    @Override
    public List<T> convert(Object value, List<T> defaultValue) throws IllegalArgumentException {
        List<?> coll = null;
        if (value instanceof Collection) {
            coll = (List<?>) value;
        }
        if (coll == null || coll.isEmpty()) {
            return Lists.newArrayList();
        }
        @SuppressWarnings("unchecked")
        Class<T> aClass = (Class<T>) coll.get(0).getClass();
        return coll.stream().map(aClass::cast).collect(Collectors.toList());
    }
}
