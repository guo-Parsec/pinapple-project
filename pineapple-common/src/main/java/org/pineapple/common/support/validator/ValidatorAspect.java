package org.pineapple.common.support.validator;

import cn.hutool.aop.aspects.Aspect;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.comparator.CompareUtil;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.google.common.collect.Lists;
import org.pineapple.common.annotations.MinAndMax;
import org.pineapple.common.annotations.NotBlank;
import org.pineapple.common.annotations.NotNull;
import org.pineapple.common.annotations.Valid;
import org.pineapple.common.enums.MinAndMaxType;
import org.pineapple.common.support.error.ErrorRecords;
import org.pineapple.common.utils.CastUtil;
import org.pineapple.common.utils.SpelUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.AnnotationUtils;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;
import java.util.Optional;

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
        NotNull[] notNulls = valid.notNull();
        if (ArrayUtil.isNotEmpty(notNulls)) {
            processNotNullValid(Lists.newArrayList(notNulls), method, args);
        }
        MinAndMax[] minAndMaxes = valid.minAndMax();
        if (ArrayUtil.isNotEmpty(minAndMaxes)) {
            processMinAndMaxValid(Lists.newArrayList(minAndMaxes), method, args);
        }
        log.debug("校验目标[class={},method={}]参数校验通过", target.getClass().getName(), method.getName());
        return true;
    }

    /**
     * <p>处理非空校验</p>
     *
     * @param list   非空集合注解
     * @param method 代理方法
     * @param args   代理方法参数
     * @author guocq
     * @date 2023/3/13 16:02
     */
    private void processNotBlankValid(List<NotBlank> list, Method method, Object[] args) {
       Map<String, NotBlank> annotationMap = CastUtil.collectionToMap(list, NotBlank::value, el -> el);
        List<String> elList = Lists.newArrayList(annotationMap.keySet());
        Map<String, Object> elVarMap = SpelUtil.parseElVarMap(method, args, elList);
        if (CollUtil.isEmpty(elVarMap)) {
            return;
        }
        Optional<NotBlank> validResult = elVarMap.entrySet().stream()
                .filter(entry -> StrUtil.isBlankIfStr(entry.getValue()))
                .map(entry -> annotationMap.get(entry.getKey()))
                .findFirst();
        if (validResult.isPresent()) {
            throw ErrorRecords.valid.record(log, validResult.get().message());
        }
    }

    /**
     * <p>处理非null校验</p>
     *
     * @param list   非null集合注解
     * @param method 代理方法
     * @param args   代理方法参数
     * @author guocq
     * @date 2023/3/13 16:23
     */
    private void processNotNullValid(List<NotNull> list, Method method, Object[] args) {
        Map<String, NotNull> annotationMap = CastUtil.collectionToMap(list, NotNull::value, el -> el);
        List<String> elList = Lists.newArrayList(annotationMap.keySet());
        Map<String, Object> elVarMap = SpelUtil.parseElVarMap(method, args, elList);
        if (CollUtil.isEmpty(elVarMap)) {
            return;
        }
        Optional<NotNull> validResult = elVarMap.entrySet().stream()
                .filter(entry -> ObjectUtil.isNull(entry.getValue()))
                .map(entry -> annotationMap.get(entry.getKey()))
                .findFirst();
        if (validResult.isPresent()) {
            throw ErrorRecords.valid.record(log, validResult.get().message());
        }
    }

    /**
     * <p>处理最大值最小值校验</p>
     *
     * @param list   非null集合注解
     * @param method 代理方法
     * @param args   代理方法参数
     * @author guocq
     * @date 2023/3/13 16:23
     */
    private void processMinAndMaxValid(List<MinAndMax> list, Method method, Object[] args) {
        Map<String, MinAndMax> annotationMap = CastUtil.collectionToMap(list, MinAndMax::value, el -> el);
        List<String> elList = Lists.newArrayList(annotationMap.keySet());
        Map<String, Object> elVarMap = SpelUtil.parseElVarMap(method, args, elList);
        if (CollUtil.isEmpty(elVarMap)) {
            return;
        }
        Optional<MinAndMax> validResult = elVarMap.entrySet().stream()
                .filter(entry -> {
                    MinAndMax minAndMax = annotationMap.get(entry.getKey());
                    assert entry.getValue() instanceof Integer;
                    boolean gtMax = CompareUtil.compare((Integer) entry.getValue(), minAndMax.max()) > 0;
                    boolean ltMin = CompareUtil.compare((Integer) entry.getValue(), minAndMax.min()) < 0;
                    if (ObjectUtil.equals(minAndMax.type(), MinAndMaxType.ONLY_MAX) && gtMax) {
                        return true;
                    }
                    if (ObjectUtil.equals(minAndMax.type(), MinAndMaxType.ONLY_MIN) && ltMin) {
                        return true;
                    }
                    return ObjectUtil.equals(minAndMax.type(), MinAndMaxType.MIN_AND_MAX) && (gtMax || ltMin);
                })
                .map(entry -> annotationMap.get(entry.getKey()))
                .findFirst();
        if (validResult.isPresent()) {
            throw ErrorRecords.valid.record(log, validResult.get().message());
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
