package org.pineapple.engine.security;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.spring.SpringUtil;
import com.google.common.collect.Sets;
import org.pineapple.common.error.ErrorRecords;
import org.pineapple.common.utils.RedisUtil;
import org.pineapple.engine.basequery.entity.SystemParamEntity;
import org.pineapple.engine.basequery.facade.SystemParamFacade;
import org.pineapple.engine.security.contant.SystemParamConstant;
import org.pineapple.engine.security.entity.SecurityInfo;
import org.pineapple.engine.security.entity.SecuritySignature;
import org.pineapple.engine.security.utils.SecurityUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * <p>安全引擎</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
@Component(value = "securityService")
public class SecurityEngine {
    private static final Logger log = LoggerFactory.getLogger(SecurityEngine.class);

    private final RedisUtil redisUtil;

    public SecurityEngine(RedisUtil redisUtil) {
        this.redisUtil = redisUtil;
    }

    /**
     * <p>根据令牌id获取安全信息</p>
     *
     * @param tokenId 令牌id
     * @return {@link java.util.Map< String, Boolean> }
     * @author guocq
     * @date 2023/3/15 16:17
     */
    public SecurityInfo findSecurityInfoWithTokenId(String tokenId) {
        if (StrUtil.isBlank(tokenId)) {
            throw ErrorRecords.valid.record(log, "根据令牌id[tokenId={}]获取安全信息失败,原因:令牌id不能为空", tokenId);
        }
        log.trace("根据令牌id[tokenId={}]获取安全信息", tokenId);
        String securityTokenKey = SecurityUtil.generateSecurityTokenKey(tokenId);
        String securityUserKey = (String) redisUtil.get(securityTokenKey);
        log.trace("根据令牌信息[securityTokenKey={}]获取安全信息[securityUserKey={}]", securityTokenKey, securityUserKey);
        SecurityInfo securityInfo = new SecurityInfo(securityUserKey, null, securityTokenKey, securityUserKey);
        if (StrUtil.isBlank(securityUserKey)) {
            log.trace("根据令牌信息[securityTokenKey={}]获取安全信息[securityInfo={}]", securityTokenKey, securityInfo);
            return securityInfo;
        }
        Object signatureObject = redisUtil.get(securityUserKey);
        if (signatureObject instanceof SecuritySignature) {
            securityInfo = new SecurityInfo(securityUserKey, (SecuritySignature) signatureObject, securityTokenKey, securityUserKey);
            log.trace("根据令牌信息[securityTokenKey={}]获取安全信息[securityInfo={}]", securityTokenKey, securityInfo);
            return securityInfo;
        }
        log.trace("根据令牌信息[securityTokenKey={}]获取安全信息[securityInfo={}]", securityTokenKey, securityInfo);
        return securityInfo;
    }

    /**
     * <p>根据登录凭证获取安全信息</p>
     *
     * @param loginId 登录凭证
     * @return {@link SecurityInfo }
     * @author guocq
     * @date 2023/3/15 17:27
     */
    public SecurityInfo findSecurityInfoWithLoginId(String loginId) {
        if (StrUtil.isBlank(loginId)) {
            throw ErrorRecords.valid.record(log, "根据登录凭证[loginId={}]获取安全信息失败,原因:登录凭证不能为空", loginId);
        }
        log.trace("根据登录凭证[loginId={}]获取安全信息", loginId);
        String securityUserKey = SecurityUtil.generateSecurityUserKey(loginId);
        Object signatureObject = redisUtil.get(securityUserKey);
        SecurityInfo securityInfo = new SecurityInfo(null, null, null, securityUserKey);
        if (signatureObject instanceof SecuritySignature) {
            SecuritySignature signature = (SecuritySignature) signatureObject;
            String tokenId = signature.findTokenId();
            String securityTokenKey = SecurityUtil.generateSecurityTokenKey(tokenId);
            securityInfo = new SecurityInfo(securityUserKey, signature, securityTokenKey, securityUserKey);
            log.trace("根据令牌信息[securityUserKey={}]获取安全信息[securityInfo={}]", securityUserKey, securityInfo);
            return securityInfo;
        }
        log.trace("根据令牌信息[securityUserKey={}]获取安全信息[securityInfo={}]", securityUserKey, securityInfo);
        return securityInfo;
    }

    /**
     * <p>根据令牌id关闭安全信息</p>
     *
     * @param tokenId 令牌id
     * @author guocq
     * @date 2023/3/15 17:42
     */
    public void closeSecurityInfoWithTokenId(String tokenId) {
        log.trace("开始根据令牌id[tokenId={}]关闭安全信息", tokenId);
        this.closeSecurityInfo(this.findSecurityInfoWithTokenId(tokenId));
    }

    /**
     * <p>根据令牌id关闭安全信息</p>
     *
     * @param loginId 登陆凭证
     * @author guocq
     * @date 2023/3/15 17:42
     */
    public void closeSecurityInfoWithLoginId(String loginId) {
        log.trace("开始根据令牌id[loginId={}]关闭安全信息", loginId);
        this.closeSecurityInfo(this.findSecurityInfoWithLoginId(loginId));
    }

    /**
     * <p>关闭安全信息</p>
     *
     * @param securityInfo 安全信息
     * @author guocq
     * @date 2023/3/15 17:40
     */
    public void closeSecurityInfo(SecurityInfo securityInfo) {
        if (securityInfo == null) {
            throw ErrorRecords.valid.record(log, "关闭安全信息失败,原因:securityInfo不能为null");
        }
        log.trace("开始关闭安全信息, securityInfo={}", securityInfo);
        String securityTokenKey = securityInfo.getSecurityTokenKey();
        if (StrUtil.isNotBlank(securityTokenKey)) {
            redisUtil.delete(securityTokenKey);
        }
        String securityUserKey = securityInfo.getSecurityUserKey();
        if (StrUtil.isNotBlank(securityUserKey)) {
            redisUtil.delete(securityUserKey);
        }
        log.trace("关闭安全信息完成, securityInfo={}", securityInfo);
    }

    /**
     * <p>根据令牌id{@code tokenId}关闭资源实体信息集合</p>
     *
     * @param tokenId 令牌id
     * @author guocq
     * @date 2023/3/23 10:30
     */
    public void closeResourceEntitySetWithTokenId(String tokenId) {
        if (StrUtil.isBlank(tokenId)) {
            throw ErrorRecords.valid.record(log, "关闭资源实体信息集合失败,原因:tokenId不能为空");
        }
        log.trace("关闭资源实体信息开始, tokenId={}", tokenId);
        SecurityInfo securityInfo = this.findSecurityInfoWithTokenId(tokenId);
        if (securityInfo != null && SecurityUtil.isSecuritySignatureEmpty(securityInfo.getDetailsInfoValue())) {
            SecuritySignature signature = securityInfo.getDetailsInfoValue();
            this.closeResourceEntitySetWithLoginId(signature.getLoginId());
        }
        log.trace("关闭资源实体信息完成, tokenId={}", tokenId);
    }

    /**
     * <p>根据登陆凭证{@code loginId}关闭资源实体信息集合</p>
     *
     * @param loginId 登陆凭证
     * @author guocq
     * @date 2023/3/23 10:24
     */
    public void closeResourceEntitySetWithLoginId(String loginId) {
        if (StrUtil.isBlank(loginId)) {
            throw ErrorRecords.valid.record(log, "关闭资源实体信息集合失败,原因:loginId不能为空");
        }
        log.trace("关闭资源实体信息开始, loginId={}", loginId);
        String resourceEntitySetKey = SecurityUtil.generateResourceEntitySetKey(loginId);
        redisUtil.delete(resourceEntitySetKey);
        log.trace("关闭资源实体信息完成, loginId={}", loginId);
    }

    /**
     * <p>存储安全信息</p>
     *
     * @param signature 安全签名
     * @author guocq
     * @date 2023/3/15 15:58
     */
    public void putSecurityInfo(SecuritySignature signature) {
        log.trace("根据签名[signature={}]存储登录信息", signature);
        if (SecurityUtil.isSecuritySignatureEmpty(signature)) {
            throw ErrorRecords.valid.record(log, "签名信息为空, 无法保存");
        }
        String tokenId = signature.findTokenId();
        String loginId = signature.getLoginId();
        if (StrUtil.hasBlank(tokenId, loginId)) {
            throw ErrorRecords.valid.record(log, "签名信息中[loginId={}, tokenId={}]不能为空", loginId, tokenId);
        }
        String securityTokenKey = SecurityUtil.generateSecurityTokenKey(tokenId);
        String securityUserKey = SecurityUtil.generateSecurityUserKey(loginId);
        long defaultTokenExpireTime = this.findTokenExpireTime();
        redisUtil.set(securityUserKey, signature, defaultTokenExpireTime, TimeUnit.HOURS);
        redisUtil.set(securityTokenKey, securityUserKey, defaultTokenExpireTime, TimeUnit.HOURS);
        log.trace("根据签名[signature={}]存储登录信息成功", signature);
    }

    /**
     * <p>存储资源实体信息集合</p>
     *
     * @param signature   安全签名
     * @param resourceSet 资源实体信息集合
     * @author guocq
     * @date 2023/3/23 10:16
     */
    public void putResourceEntitySet(SecuritySignature signature, Set<Map<String, Object>> resourceSet) {
        log.trace("根据签名[signature={}]存储资源实体信息集合[resourceSet={}]信息", signature, resourceSet);
        if (SecurityUtil.isSecuritySignatureEmpty(signature) || CollUtil.isEmpty(resourceSet)) {
            log.trace("根据签名[signature={}]存储资源实体信息集合[resourceSet={}]信息为空,跳过保存", signature, resourceSet);
            return;
        }
        String loginId = signature.getLoginId();
        if (StrUtil.hasBlank(loginId)) {
            throw ErrorRecords.valid.record(log, "签名信息中[loginId={}]不能为空", loginId);
        }
        String resourceEntitySetKey = SecurityUtil.generateResourceEntitySetKey(loginId);
        long defaultTokenExpireTime = this.findTokenExpireTime();
        redisUtil.set(resourceEntitySetKey, resourceSet, defaultTokenExpireTime, TimeUnit.HOURS);
        log.trace("根据签名[signature={}]存储资源实体信息集合[resourceSet={}]信息成功", signature, resourceSet);
    }

    /**
     * <p>根据令牌id{@code tokenId}获取资源实体信息集合信息</p>
     *
     * @param tokenId 令牌id
     * @return {@link java.util.Set<java.util.Map> }
     * @author guocq
     * @date 2023/3/23 11:23
     */
    public Set<Map<String, Object>> findResourceEntitySetWithTokenId(String tokenId) {
        if (StrUtil.isBlank(tokenId)) {
            throw ErrorRecords.valid.record(log, "获取资源实体信息集合失败,原因:tokenId不能为空");
        }
        log.trace("获取资源实体信息集合开始, tokenId={}", tokenId);
        SecurityInfo securityInfo = this.findSecurityInfoWithTokenId(tokenId);
        if (securityInfo != null && SecurityUtil.isSecuritySignatureEmpty(securityInfo.getDetailsInfoValue())) {
            SecuritySignature signature = securityInfo.getDetailsInfoValue();
            log.trace("获取资源实体信息集合完成, tokenId={}", tokenId);
            return this.findResourceEntitySetWithLoginId(signature.getLoginId());
        }
        return Sets.newHashSet();
    }

    /**
     * <p>根据登录凭证{@code loginId}获取资源实体信息集合信息</p>
     *
     * @param loginId 登录凭证
     * @return {@link java.util.Set<java.util.Map> }
     * @author guocq
     * @date 2023/3/23 11:07
     */
    public Set<Map<String, Object>> findResourceEntitySetWithLoginId(String loginId) {
        if (StrUtil.isBlank(loginId)) {
            throw ErrorRecords.valid.record(log, "根据登陆凭证[loginId={}]获取资源实体信息集合信息时,loginId不能为空", loginId);
        }
        log.trace("根据登陆凭证[loginId={}]获取资源实体信息集合信息", loginId);
        String resourceEntitySetKey = SecurityUtil.generateResourceEntitySetKey(loginId);
        @SuppressWarnings("unchecked")
        Set<Map<String, Object>> resourceSet = (Set<Map<String, Object>>) redisUtil.get(resourceEntitySetKey);
        log.trace("根据登陆凭证[loginId={}]获取资源实体信息集合信息为[resourceSet={}]", loginId, resourceSet);
        return resourceSet;
    }

    /**
     * <p>获取过期时间</p>
     *
     * @return {@link java.lang.Long }
     * @author guocq
     * @date 2023/3/17 9:48
     */
    private Long findTokenExpireTime() {
        SystemParamFacade facade = SpringUtil.getBean(SystemParamFacade.class);
        SystemParamEntity systemParamEntity = facade.findParamByParamCode(SystemParamConstant.PARAM_CODE_TOKEN_EXPIRE_TIME_HOUR);
        String tokenExpireTimeString = Optional.ofNullable(systemParamEntity).map(SystemParamEntity::getParamValue).orElse("6");
        return Long.valueOf(tokenExpireTimeString);
    }
}
