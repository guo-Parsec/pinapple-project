package org.pineapple.core.aspect;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.StrUtil;
import com.google.common.collect.Sets;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.pineapple.common.support.error.ErrorRecords;
import org.pineapple.common.utils.UrlUtil;
import org.pineapple.engine.security.SecurityService;
import org.pineapple.engine.security.annotations.HasPermission;
import org.pineapple.engine.security.annotations.HasRole;
import org.pineapple.engine.security.contant.SecurityCommonConstant;
import org.pineapple.engine.security.entity.SecuritySignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.util.Set;

/**
 * <p>安全切面支持</p>
 *
 * @author guocq
 * @since 2023/3/24
 */
@Aspect
@Component
public class SecurityAspectSupport {
    private static final Logger log = LoggerFactory.getLogger(SecurityAspectSupport.class);

    private final SecurityService securityService;

    public SecurityAspectSupport(SecurityService securityService) {
        this.securityService = securityService;
    }

    @Pointcut("@annotation(org.pineapple.engine.security.annotations.HasRole)")
    private void pointCutForHasRole() {
    }

    @Pointcut("@annotation(org.pineapple.engine.security.annotations.HasPermission)")
    private void pointCutForHasPermission() {
    }

    @Around(value = "pointCutForHasRole()")
    public Object aroundForHasRole(ProceedingJoinPoint point) throws Throwable {
        MethodSignature methodSignature = (MethodSignature) point.getSignature();
        Method method = methodSignature.getMethod();
        HasRole hasRole = AnnotationUtils.findAnnotation(method, HasRole.class);
        if (hasRole == null || ArrayUtil.isEmpty(hasRole.roles())) {
            return point.proceed();
        }
        Set<String> roleSet = Sets.newHashSet(hasRole.roles());
        String methodName = method.getName();
        log.debug("校验请求方法[method={}]是否拥有指定角色[roleSet={}],注解条件为[denyAdmin={}, fuzzyMatchSupport={}, adminRoleName={}]",
                methodName, roleSet, hasRole.denyAdmin(), hasRole.fuzzyMatchSupport(), hasRole.adminRoleName());
        if (hasRole(roleSet, hasRole, methodName)) {
            return point.proceed();
        }
        throw ErrorRecords.unauthorized.record(log, "权限验证失败");
    }

    @Around(value = "pointCutForHasPermission()")
    public Object aroundForHasPermission(ProceedingJoinPoint point) throws Throwable {
        MethodSignature methodSignature = (MethodSignature) point.getSignature();
        Method method = methodSignature.getMethod();
        HasPermission hasPermission = AnnotationUtils.findAnnotation(method, HasPermission.class);
        if (hasPermission == null || ArrayUtil.isEmpty(hasPermission.permissions())) {
            return point.proceed();
        }
        Set<String> permissionSet = Sets.newHashSet(hasPermission.permissions());
        String methodName = method.getName();
        log.debug("校验请求方法[method={}]是否拥有指定权限[permissionSet={}],注解条件为[denyAdmin={}, fuzzyMatchSupport={}, adminRoleName={}]",
                methodName, permissionSet, hasPermission.denyAdmin(), hasPermission.fuzzyMatchSupport(), hasPermission.adminRoleName());
        if (hasPermission(permissionSet, hasPermission, methodName)) {
            return point.proceed();
        }
        throw ErrorRecords.unauthorized.record(log, "权限验证失败");
    }

    /**
     * <p>判断当前请求是否拥有角色</p>
     *
     * @param roleSet    需要拥有的角色集合
     * @param hasRole    注解
     * @param methodName 方法名
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/24 10:06
     */
    private boolean hasRole(Set<String> roleSet, HasRole hasRole, String methodName) {
        SecuritySignature signature = null;
        try {
            signature = securityService.findSignature();
        } catch (Exception e) {
            log.warn("当前请求无法获取登录用户");
            return false;
        }
        String adminRoleCode = hasRole.adminRoleName();
        if (StrUtil.isBlank(adminRoleCode)) {
            adminRoleCode = SecurityCommonConstant.ROLE_ADMIN_CODE;
            log.debug("注解指定超级管理员角色码为空,系统使用默认超级管理员角色码[adminRoleCode={}]", adminRoleCode);
        }
        boolean fuzzyMatchSupport = hasRole.fuzzyMatchSupport();
        Set<String> userRoles = signature.getRoles();
        boolean denyAdmin = hasRole.denyAdmin();
        if (!denyAdmin && userRoles.contains(adminRoleCode)) {
            log.debug("用户[loginId={}]为超级管理员允许访问当前接口[method={}]", signature.getLoginId(), methodName);
            return true;
        }
        return userRoles.stream().anyMatch(role -> {
            if (fuzzyMatchSupport) {
                return UrlUtil.matches(role, roleSet);
            }
            return roleSet.contains(role);
        });
    }

    /**
     * <p>判断当前请求是否拥有权限</p>
     *
     * @param permissionSet 需要拥有的权限集合
     * @param hasPermission 注解
     * @param methodName    方法名
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/24 10:40
     */
    private boolean hasPermission(Set<String> permissionSet, HasPermission hasPermission, String methodName) {
        SecuritySignature signature = null;
        try {
            signature = securityService.findSignature();
        } catch (Exception e) {
            log.warn("当前请求无法获取登录用户");
            return false;
        }
        String adminRoleCode = hasPermission.adminRoleName();
        if (StrUtil.isBlank(adminRoleCode)) {
            adminRoleCode = SecurityCommonConstant.ROLE_ADMIN_CODE;
            log.debug("注解指定超级管理员角色码为空,系统使用默认超级管理员角色码[adminRoleCode={}]", adminRoleCode);
        }
        boolean fuzzyMatchSupport = hasPermission.fuzzyMatchSupport();
        Set<String> userPermissions = signature.getPermissions();
        Set<String> userRoles = signature.getRoles();
        boolean denyAdmin = hasPermission.denyAdmin();
        if (!denyAdmin && CollUtil.isNotEmpty(userRoles) && userRoles.contains(adminRoleCode)) {
            log.debug("用户[loginId={}]为超级管理员允许访问当前接口[method={}]", signature.getLoginId(), methodName);
            return true;
        }
        if (CollUtil.isEmpty(userPermissions)) {
            return false;
        }
        return userPermissions.stream().anyMatch(permission -> {
            if (fuzzyMatchSupport) {
                return UrlUtil.matches(permission, permissionSet);
            }
            return permissionSet.contains(permission);
        });
    }
}
