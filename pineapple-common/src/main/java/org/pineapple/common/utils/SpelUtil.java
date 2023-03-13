package org.pineapple.common.utils;

import cn.hutool.core.util.ArrayUtil;
import com.google.common.collect.Maps;
import org.springframework.core.DefaultParameterNameDiscoverer;
import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * <p>Spel工具类</p>
 *
 * @author guocq
 * @since 2023/3/13
 */
public class SpelUtil {
    public static Map<String, Object> parse(Method method, Object[] args, List<String> elList) {
        DefaultParameterNameDiscoverer discoverer = new DefaultParameterNameDiscoverer();
        String[] parameterNames = discoverer.getParameterNames(method);
        if (ArrayUtil.isEmpty(parameterNames)) {
            return null;
        }
        ExpressionParser parser = new SpelExpressionParser();
        Map<String, Expression> expressionMap = elList.stream().collect(Collectors.toMap(el -> el, parser::parseExpression));
        StandardEvaluationContext ctx = new StandardEvaluationContext();
        for (int i = 0; i < parameterNames.length; i++) {
            ctx.setVariable(parameterNames[i], args[i]);
        }
        Map<String, Object> result = Maps.newHashMap();
        expressionMap.forEach((el, expression) -> {
            result.put(el, expression.getValue(ctx));
        });
        return result;
    }

    public static String parse(String el, Method method, Object[] args) {
        DefaultParameterNameDiscoverer discoverer = new DefaultParameterNameDiscoverer();
        String[] parameterNames = discoverer.getParameterNames(method);
        if (ArrayUtil.isEmpty(parameterNames)) {
            return null;
        }
        ExpressionParser parser = new SpelExpressionParser();
        Expression expression = parser.parseExpression(el);
        StandardEvaluationContext ctx = new StandardEvaluationContext();
        for (int i = 0; i < parameterNames.length; i++) {
            ctx.setVariable(parameterNames[i], args[i]);
        }
        return expression.getValue(ctx, String.class);

    }
}
