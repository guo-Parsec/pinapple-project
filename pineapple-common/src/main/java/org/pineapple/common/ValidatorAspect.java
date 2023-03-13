package org.pineapple.common;

import cn.hutool.aop.aspects.Aspect;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.StrUtil;
import com.google.common.collect.Lists;
import org.pineapple.common.annotations.NotBlank;
import org.pineapple.common.annotations.Valid;
import org.pineapple.common.error.ErrorRecords;
import org.pineapple.common.utils.CastUtil;
import org.pineapple.common.utils.SpelUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.AnnotationUtils;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicReference;

/**
 * <p>校验器切面</p>
 *
 * @author guocq
 * @since 2023/3/13
 */
public class ValidatorAspect implements Aspect {
    private static final Logger log = LoggerFactory.getLogger(ValidatorAspect.class);

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
        log.debug("校验目标[class={},method={}]参数启动", target.getClass().getName(), method.getName());
        Valid valid = AnnotationUtils.findAnnotation(method, Valid.class);
        if (valid == null) {
            log.debug("校验目标[class={},method={}]不存在Valid注解, 跳过校验", target.getClass().getName(), method.getName());
            return true;
        }
        NotBlank[] notBlanks = valid.notBlank();
        if (ArrayUtil.isNotEmpty(notBlanks)) {
            processNotBlankValid(Lists.newArrayList(notBlanks), method, args);
        }
        return true;
    }

    private void processNotBlankValid(List<NotBlank> list, Method method, Object[] args) {
        Map<String, NotBlank> notBlankMap = CastUtil.collectionToMap(list, NotBlank::value, notBlank -> notBlank, true);
        List<String> elList = Lists.newArrayList(notBlankMap.keySet());
        Map<String, Object> resultMap = SpelUtil.parse(method, args, elList);
        if (CollUtil.isEmpty(resultMap)) {
            return;
        }
        AtomicReference<NotBlank> currNotBlank = new AtomicReference<>();
        resultMap.forEach((el, val) -> {
            if (StrUtil.isBlankIfStr(val)) {
                currNotBlank.set(notBlankMap.get(el));
                return;
            }
        });
        if (currNotBlank.get() != null) {
            throw ErrorRecords.valid.record(log, currNotBlank.get().message());
        }
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
