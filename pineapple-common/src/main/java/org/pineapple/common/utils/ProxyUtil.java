package org.pineapple.common.utils;

import org.pineapple.common.error.ErrorRecords;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.framework.AdvisedSupport;
import org.springframework.aop.framework.AopProxy;
import org.springframework.aop.support.AopUtils;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;

/**
 * <p>代理工具类</p>
 *
 * @author guocq
 * @since 2023/2/23
 */
public class ProxyUtil {
    private static final String CGLIB_TARGET_FIELD = "CGLIB$CALLBACK_0";
    private static final String FIELD_ADVISED = "advised";
    private static final String JDK_TARGET_FIELD = "h";
    private static final Logger log = LoggerFactory.getLogger(ProxyUtil.class);

    public static Object getProxyTarget(Object proxy) {
        if (proxy == null) {
            throw ErrorRecords.valid.record(log, "代理对象不能为null");
        }
        if (!AopUtils.isAopProxy(proxy)) {
            return proxy.getClass();
        }
        if (AopUtils.isJdkDynamicProxy(proxy)) {
            proxy = getJdkProxyTarget(proxy);
        } else {
            proxy = getCglibProxyTarget(proxy);
        }
        return getProxyTarget(proxy);
    }

    private static Object getCglibProxyTarget(Object proxy) {
        if (proxy == null) {
            throw ErrorRecords.valid.record(log, "代理对象不能为空");
        }
        try {
            Field field = proxy.getClass().getDeclaredField(CGLIB_TARGET_FIELD);
            field.setAccessible(true);
            Object dynamicAdvisedInterceptor = field.get(proxy);
            Field advised = dynamicAdvisedInterceptor.getClass().getDeclaredField(FIELD_ADVISED);
            advised.setAccessible(true);
            return ((AdvisedSupport) advised.get(dynamicAdvisedInterceptor)).getTargetSource().getTarget();
        } catch (Exception e) {
            throw ErrorRecords.error.record(log, e, "获取Cglib代理目标类对象失败");
        }
    }

    private static Object getJdkProxyTarget(Object proxy) {
        if (proxy == null) {
            throw ErrorRecords.valid.record(log, "代理对象不能为空");
        }
        try {
            Field field = proxy.getClass().getDeclaredField(JDK_TARGET_FIELD);
            field.setAccessible(true);
            AopProxy aopProxy = (AopProxy) field.get(proxy);
            Field advised = aopProxy.getClass().getDeclaredField("advised");
            advised.setAccessible(true);
            return ((AdvisedSupport) advised.get(aopProxy)).getTargetSource().getTarget();
        } catch (Exception e) {
            throw ErrorRecords.error.record(log, e, "获取Cglib代理目标类对象失败");
        }
    }


}
