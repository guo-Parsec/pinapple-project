package org.pineapple.engine.security.config;

import cn.hutool.extra.spring.SpringUtil;
import org.pineapple.common.constant.BeanNameDefineConstant;
import org.pineapple.common.support.error.ErrorRecords;
import org.pineapple.engine.security.SecurityService;
import org.pineapple.engine.security.annotations.SecurityParam;
import org.pineapple.engine.security.contant.SecurityCommonConstant;
import org.pineapple.engine.security.entity.SecuritySignature;
import org.pineapple.engine.security.entity.TokenDetails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import java.util.Set;

/**
 * <p>{@link org.pineapple.engine.security.annotations.SecurityParam}解析器</p>
 *
 * @author guocq
 * @since 2023/3/23
 */
public class SecurityParamArgumentResolver implements HandlerMethodArgumentResolver {
    private static final String JSON_BODY_ATTRIBUTE = "JSON_REQUEST_BODY";

    private static final Logger log = LoggerFactory.getLogger(SecurityParamArgumentResolver.class);

    /**
     * <p>设置支持的方法参数类型</p>
     *
     * @param parameter 方法参数
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/23 14:22
     */
    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        return parameter.hasParameterAnnotation(SecurityParam.class);
    }

    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
        SecurityParam securityParam = parameter.getParameterAnnotation(SecurityParam.class);
        if (securityParam == null) {
            throw ErrorRecords.error.record(log, "解析错误,无法从参数上获取SecurityParam注解");
        }
        SecurityService securityService = SpringUtil.getBean(BeanNameDefineConstant.DEFAULT_SECURITY_SERVICE, SecurityService.class);
        SecuritySignature signature = null;
        try {
            signature = securityService.findSignature();
        } catch (Exception e) {
            log.warn("获取当前请求中的安全签名失败, 参数将返回null");
            return null;
        }
        if (signature == null) {
            return null;
        }
        Class<?> parameterType = parameter.getParameterType();
        String key = securityParam.value();
        if (SecurityCommonConstant.SECURITY_SIGNATURE_KEY.equals(key) && parameterType == SecuritySignature.class) {
            return signature;
        }
        if (SecurityCommonConstant.TOKEN_DETAILS_KEY.equals(key) && parameterType == TokenDetails.class) {
            return signature.getTokenDetails();
        }
        if (SecurityCommonConstant.DETAILS_KEY.equals(key)) {
            return signature.getDetails();
        }
        if (SecurityCommonConstant.PERMISSIONS_KEY.equals(key) && parameterType == Set.class) {
            return signature.getPermissions();
        }
        if (SecurityCommonConstant.RES_ENTITY_SET_KEY.equals(key) && parameterType == Set.class) {
            // todo 获取资源实体信息集合
            return null;
        }
        if (SecurityCommonConstant.ROLES_KEY.equals(key) && parameterType == Set.class) {
            return signature.getRoles();
        }
        return null;
    }


}
