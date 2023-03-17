package org.pineapple.engine.basequery;

import cn.hutool.aop.ProxyUtil;
import org.pineapple.engine.basequery.annotations.DictConverter;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.stereotype.Component;

/**
 * <p>转换器代理</p>
 *
 * @author guocq
 * @since 2023/3/17
 */
@Component
public class ConverterProxy implements BeanPostProcessor {
    @Override
    public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
        DictConverter dictConverter = AnnotationUtils.findAnnotation(bean.getClass(), DictConverter.class);
        if (dictConverter == null) {
            return bean;
        }
        return ProxyUtil.proxy(bean, DictTranslateAspectSupport.class);
    }
}
