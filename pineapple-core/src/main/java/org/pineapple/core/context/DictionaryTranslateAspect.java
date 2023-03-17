package org.pineapple.core.context;

import com.google.common.collect.Lists;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.pineapple.common.DomainModel;
import org.pineapple.engine.basequery.context.DictionaryContext;
import org.pineapple.common.utils.CastUtil;
import org.pineapple.support.aspect.annotations.DictionaryTranslateMethod;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>数据字典翻译切面</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
@Component
@Aspect
public class DictionaryTranslateAspect {
    @Pointcut(value = "@annotation(org.pineapple.support.aspect.annotations.DictionaryTranslateMethod)")
    public void dictionaryTranslateMethodPointCut() {
    }

    @Around(value = "dictionaryTranslateMethodPointCut()", argNames = "point")
    public Object around(ProceedingJoinPoint point) throws Throwable {
        Object[] args = point.getArgs();
        MethodSignature signature = (MethodSignature) point.getSignature();
        Method method = signature.getMethod();
        DictionaryTranslateMethod annotation = method.getAnnotation(DictionaryTranslateMethod.class);
        Object result = point.proceed(args);
        String contextName = annotation.context();
        DictionaryContext context = DictionaryContextBuilder.build(contextName);
        if (result instanceof List) {
            result = listHandler((List<?>) result, context);
        }
        return result;
    }

    private static Object listHandler(Collection<?> result, DictionaryContext context) {
        if (result == null) {
            return null;
        }
        List<DomainModel> list = Lists.newArrayList();
        if (instanceOf(result, DomainModel.class)) {
            CastUtil.castColl(result, DomainModel.class, list);
            System.out.println(111111);
//            list.forEach(context::translate);
            return list;
        }
        if (instanceOf(result, Collection.class)) {
            return result.stream().map(__ -> listHandler((Collection<?>) __, context)).collect(Collectors.toList());
        }
        return list;
    }

    public static <T> boolean instanceOf(Collection<?> list, Class<T> tClass) {
        for (Object __ : list) {
            if (__ == null) {
                continue;
            }
            if (!tClass.isAssignableFrom(__.getClass())) {
                return false;
            }
        }
        return true;
    }
}
