package org.pineapple.support.security;

import cn.hutool.core.util.StrUtil;
import org.pineapple.common.error.ErrorRecords;
import org.pineapple.common.utils.RedisUtil;
import org.pineapple.support.security.utils.SecurityUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

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
     * @return {@link java.util.Map<java.lang.String,java.lang.Boolean> }
     * @author guocq
     * @date 2023/3/15 16:17
     */
    public SecurityInfo findSecurityInfoWithTokenId(String tokenId) {
        if (StrUtil.isBlank(tokenId)) {
            throw ErrorRecords.valid.record(log, "根据令牌id[tokenId={}]获取安全信息失败,原因:令牌id不能为空", tokenId);
        }
        log.debug("根据令牌id[tokenId={}]获取安全信息", tokenId);
        String securityTokenKey = SecurityUtil.generateSecurityTokenKey(tokenId);
        String securityUserKey = (String) redisUtil.get(securityTokenKey);
        log.debug("根据令牌信息[securityTokenKey={}]获取安全信息[securityUserKey={}]", securityTokenKey, securityUserKey);
        SecurityInfo securityInfo = new SecurityInfo(securityUserKey, null, securityTokenKey, securityUserKey);
        if (StrUtil.isBlank(securityUserKey)) {
            log.debug("根据令牌信息[securityTokenKey={}]获取安全信息[securityInfo={}]", securityTokenKey, securityInfo);
            return securityInfo;
        }
        Object signatureObject = redisUtil.get(securityUserKey);
        if (signatureObject instanceof SecuritySignature) {
            securityInfo = new SecurityInfo(securityUserKey, (SecuritySignature) signatureObject, securityTokenKey, securityUserKey);
            log.debug("根据令牌信息[securityTokenKey={}]获取安全信息[securityInfo={}]", securityTokenKey, securityInfo);
            return securityInfo;
        }
        log.debug("根据令牌信息[securityTokenKey={}]获取安全信息[securityInfo={}]", securityTokenKey, securityInfo);
        return securityInfo;
    }

    /**
     * <p>根据登录凭证获取安全信息</p>
     *
     * @param loginId 登录凭证
     * @return {@link org.pineapple.support.security.SecurityInfo }
     * @author guocq
     * @date 2023/3/15 17:27
     */
    public SecurityInfo findSecurityInfoWithLoginId(String loginId) {
        if (StrUtil.isBlank(loginId)) {
            throw ErrorRecords.valid.record(log, "根据登录凭证[loginId={}]获取安全信息失败,原因:登录凭证不能为空", loginId);
        }
        log.debug("根据登录凭证[loginId={}]获取安全信息", loginId);
        String securityUserKey = SecurityUtil.generateSecurityUserKey(loginId);
        Object signatureObject = redisUtil.get(securityUserKey);
        SecurityInfo securityInfo = new SecurityInfo(null, null, null, securityUserKey);
        if (signatureObject instanceof SecuritySignature) {
            SecuritySignature signature = (SecuritySignature) signatureObject;
            String tokenId = signature.findTokenId();
            String securityTokenKey = SecurityUtil.generateSecurityTokenKey(tokenId);
            securityInfo = new SecurityInfo(securityUserKey, signature, securityTokenKey, securityUserKey);
            log.debug("根据令牌信息[securityUserKey={}]获取安全信息[securityInfo={}]", securityUserKey, securityInfo);
            return securityInfo;
        }
        log.debug("根据令牌信息[securityUserKey={}]获取安全信息[securityInfo={}]", securityUserKey, securityInfo);
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
        log.debug("开始根据令牌id[tokenId={}]关闭安全信息", tokenId);
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
        log.debug("开始根据令牌id[loginId={}]关闭安全信息", loginId);
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
        log.debug("开始关闭安全信息, securityInfo={}", securityInfo);
        String securityTokenKey = securityInfo.getSecurityTokenKey();
        if (StrUtil.isNotBlank(securityTokenKey)) {
            redisUtil.delete(securityTokenKey);
        }
        String securityUserKey = securityInfo.getSecurityUserKey();
        if (StrUtil.isNotBlank(securityUserKey)) {
            redisUtil.delete(securityUserKey);
        }
        log.debug("关闭安全信息完成, securityInfo={}", securityInfo);
    }

    /**
     * <p>存储安全信息</p>
     *
     * @param signature 安全签名
     * @author guocq
     * @date 2023/3/15 15:58
     */
    public void putSecurityInfo(SecuritySignature signature) {
        log.debug("根据签名[signature={}]存储登录信息", signature);
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
        long defaultTokenExpireTime = 6L;
        redisUtil.set(securityUserKey, signature, defaultTokenExpireTime, TimeUnit.HOURS);
        redisUtil.set(securityTokenKey, securityUserKey, defaultTokenExpireTime, TimeUnit.HOURS);
        log.debug("根据签名[signature={}]存储登录信息成功", signature);
    }
}
