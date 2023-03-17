package org.pineapple.engine.basequery;

import cn.hutool.aop.aspects.Aspect;
import org.pineapple.engine.basequery.annotations.DictTranslate;
import org.pineapple.engine.basequery.context.DictionaryContext;
import org.pineapple.engine.basequery.context.DictionaryContextBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.AnnotationUtils;

import java.lang.reflect.Method;

/**
 * <p>数据字典切面支持</p>
 *
 * @author guocq
 * @since 2023/3/17
 */
public class DictTranslateAspectSupport implements Aspect {
    private static final Logger log = LoggerFactory.getLogger(DictTranslateAspectSupport.class);

    /**
     * 目标方法执行前的操作
     *
     * @param target 目标对象
     * @param method 目标方法
     * @param args   参数
     * @return 是否继续执行接下来的操作
     */
    @Override
    public boolean before(Object target, Method method, Object[] args) {
        return true;
    }

    /**
     * 目标方法执行后的操作<br>
     * 如果 target.method 抛出异常且 {@link Aspect#afterException} 返回true,则不会执行此操作<br>
     * 如果 {@link Aspect#afterException} 返回false,则无论target.method是否抛出异常，均会执行此操作<br>
     *
     * @param target    目标对象
     * @param method    目标方法
     * @param args      参数
     * @param returnVal 目标方法执行返回值
     * @return 是否允许返回值（接下来的操作）
     */
    @Override
    public boolean after(Object target, Method method, Object[] args, Object returnVal) {
        DictTranslate dictTranslate = AnnotationUtils.findAnnotation(method, DictTranslate.class);
        if (dictTranslate == null) {
            log.trace("目标[class={},method={}]不存在DictTranslate注解, 跳过字典转义", target.getClass().getName(), method.getName());
            return true;
        }
        log.debug("目标[class={},method={}]字典转义启动", target.getClass().getName(), method.getName());
        String contextName = dictTranslate.context();
        DictionaryContext ctx = DictionaryContextBuilder.build(contextName);
        ctx.translate(returnVal);
        return true;
    }

    /**
     * 目标方法抛出异常时的操作
     *
     * @param target 目标对象
     * @param method 目标方法
     * @param args   参数
     * @param e      异常
     * @return 是否允许抛出异常
     */
    @Override
    public boolean afterException(Object target, Method method, Object[] args, Throwable e) {
        return true;
    }
}
