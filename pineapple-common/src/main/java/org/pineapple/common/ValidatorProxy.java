package org.pineapple.common;

import cn.hutool.aop.ProxyUtil;
import org.pineapple.common.annotations.Validator;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.stereotype.Component;

/**
 * <p>校验器代理</p>
 *
 * @author guocq
 * @since 2023/3/13
 */
@Component
public class ValidatorProxy implements BeanPostProcessor {

    @Override
    public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
        Validator validator = AnnotationUtils.findAnnotation(bean.getClass(), Validator.class);
        if (validator == null) {
            return bean;
        }
        return ProxyUtil.proxy(bean, ValidatorAspect.class);
    }
}
