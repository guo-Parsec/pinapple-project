package org.pineapple.common.utils;

import cn.hutool.core.util.ArrayUtil;
import com.google.common.collect.Maps;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.DefaultParameterNameDiscoverer;
import org.springframework.core.ParameterNameDiscoverer;
import org.springframework.expression.EvaluationContext;
import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

/**
 * <p>Spel工具类</p>
 *
 * @author guocq
 * @since 2023/3/13
 */
public class SpelUtil {
    private static final Logger log = LoggerFactory.getLogger(SpelUtil.class);

    /**
     * <p>解析el为key,值为value的map</p>
     *
     * @param method 方法
     * @param args 参数
     * @param elList el表达式list
     * @return {@link java.util.Map<java.lang.String,java.lang.Object> }
     * @author guocq
     * @date 2023/3/13 15:55
     */
    public static Map<String, Object> parseElVarMap(Method method, Object[] args, List<String> elList) {
        log.debug("对方法[{}]上的参数获取spel表达式[{}]解析值", method.getName(), elList);
        ParameterNameDiscoverer discoverer = new DefaultParameterNameDiscoverer();
        String[] parameterNames = discoverer.getParameterNames(method);
        if (ArrayUtil.isEmpty(parameterNames)) {
            log.debug("方法参数为空，无法解析SPEL表达式内容");
            return null;
        }
        ExpressionParser parser = new SpelExpressionParser();
        Map<String, Expression> expressionMap = CastUtil.collectionToMap(elList, parser::parseExpression);
        EvaluationContext ctx = new StandardEvaluationContext();
        for (int i = 0; i < parameterNames.length; i++) {
            ctx.setVariable(parameterNames[i], args[i]);
        }
        Map<String, Object> elValMap = Maps.newHashMap();
        expressionMap.forEach((el, expression) -> elValMap.put(el, expression.getValue(ctx)));
        return elValMap;
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
