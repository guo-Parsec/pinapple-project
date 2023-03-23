package org.pineapple.support.data.utils;

import com.baomidou.mybatisplus.core.override.MybatisMapperProxy;
import org.pineapple.common.support.error.ErrorRecords;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;

/**
 * <p>Mybatis工具类</p>
 *
 * @author guocq
 * @since 2023/2/23
 */
public class MapperUtil {
    private static final Logger log = LoggerFactory.getLogger(MapperUtil.class);

    private static final String FIELD_MAPPER_INTERFACE = "mapperInterface";

    /**
     * <p>根据mapper对象获取目标类</p>
     *
     * @param mapper mapper对象
     * @return {@link java.lang.Class }
     * @author guocq
     * @date 2023/2/23 14:13
     */
    public static Class<?> getMapperInterface(Object mapper) {
        if (mapper == null) {
            throw ErrorRecords.valid.record(log, "mapper对象不能为空");
        }
        Class<?> mapperClass = mapper.getClass();
        if (!Proxy.isProxyClass(mapperClass)) {
            return mapperClass;
        }
        InvocationHandler invocationHandler = Proxy.getInvocationHandler(mapper);
        if (!(invocationHandler instanceof MybatisMapperProxy)) {
            return mapperClass;
        }
        MybatisMapperProxy<?> mybatisMapperProxy = (MybatisMapperProxy<?>) invocationHandler;
        try {
            Field mapperInterfaceField = mybatisMapperProxy.getClass().getDeclaredField(FIELD_MAPPER_INTERFACE);
            mapperInterfaceField.setAccessible(true);
            return (Class<?>) mapperInterfaceField.get(mybatisMapperProxy);
        } catch (Exception e) {
            throw ErrorRecords.error.record(log, e, "获取mapper代理目标类对象失败");
        }
    }
}
