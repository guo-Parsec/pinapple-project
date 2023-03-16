package org.pineapple.support.security.utils;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import org.pineapple.common.error.ErrorRecords;
import org.pineapple.common.support.BasicRedisKeyJoin;
import org.pineapple.common.utils.RequestUtil;
import org.pineapple.common.utils.SerialNumberUtil;
import org.pineapple.support.security.entity.SecuritySignature;
import org.pineapple.support.security.contant.SecurityCommonConstant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;

/**
 * <p>安全认证工具类</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
public class SecurityUtil {
    private static final Logger log = LoggerFactory.getLogger(SecurityUtil.class);

    /**
     * <p>判断安全认证签名是否为空</p>
     *
     * @param signature 安全认证签名
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/14 15:47
     */
    public static boolean isSecuritySignatureEmpty(SecuritySignature signature) {
        return ObjectUtil.isNull(signature) || ObjectUtil.isNull(signature.getDetails());
    }

    /**
     * <p>根据用户id生成用户信息存储的key</p>
     *
     * @param loginId 登录凭证
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 9:52
     */
    public static String generateSecurityUserKey(String loginId) {
        if (StrUtil.isBlank(loginId)) {
            throw ErrorRecords.valid.record(log, "根据用户[loginId={}]生成用户信息存储的key时, [loginId]不能为空", loginId);
        }
        log.debug("开始根据用户[loginId={}]生成用户信息存储的key", loginId);
        String securityUserKey = new BasicRedisKeyJoin(false)
                .join(SecurityCommonConstant.REDIS_BIZ_SECURITY_KEY_PREFIX)
                .join(SecurityCommonConstant.REDIS_BIZ_KEY_FOR_USER)
                .join(loginId)
                .build();
        log.debug("根据用户[loginId={}]生成用户信息存储的key为{}", loginId, securityUserKey);
        return securityUserKey;
    }

    /**
     * <p>根据令牌id生成令牌信息存储的key</p>
     *
     * @param tokenId 令牌id
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 10:06
     */
    public static String generateSecurityTokenKey(String tokenId) {
        if (StrUtil.isBlank(tokenId)) {
            throw ErrorRecords.valid.record(log, "根据令牌id[tokenId={}]生成令牌信息存储的key时,令牌id[tokenId]不能为空", tokenId);
        }
        log.debug("开始根据令牌id[tokenId={}]生成令牌信息存储的key", tokenId);
        String securityTokenKey = new BasicRedisKeyJoin(false)
                .join(SecurityCommonConstant.REDIS_BIZ_SECURITY_KEY_PREFIX)
                .join(SecurityCommonConstant.REDIS_BIZ_KEY_FOR_TOKEN)
                .join(tokenId)
                .build();
        log.debug("根据令牌id[tokenId={}]生成令牌信息存储的key为{}", tokenId, securityTokenKey);
        return securityTokenKey;
    }

    /**
     * <p>根据文本获取有效tokenId</p>
     *
     * @param text 文本
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 10:24
     */
    public static String findEffectiveTokenId(String text) {
        log.debug("开始根据文本[text={}]获取有效tokenId", text);
        String effectiveTokenId = StrUtil.EMPTY;
        if (StrUtil.isBlank(text) || !text.startsWith(SecurityCommonConstant.EFFECTIVE_TOKEN_PREFIX)) {
            log.warn("根据文本[text={}]获取有效tokenId时,文本[text={}]未能以有效令牌前缀[{}]开始", text, text, SecurityCommonConstant.EFFECTIVE_TOKEN_PREFIX);
            log.debug("根据文本[text={}]获取有效tokenId为[{}]", text, effectiveTokenId);
            return effectiveTokenId;
        }
        effectiveTokenId = text.replace(SecurityCommonConstant.EFFECTIVE_TOKEN_PREFIX, StrUtil.EMPTY);
        if (StrUtil.isBlank(effectiveTokenId)) {
            throw ErrorRecords.valid.record(log, "从文本{}中解析有效的token失败", text);
        }
        log.debug("根据文本[text={}]获取有效tokenId为[{}]", text, effectiveTokenId);
        return effectiveTokenId;
    }

    /**
     * <p>从当前请求中获取原生token</p>
     *
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 11:23
     */
    public static String findRawTokenInHead() {
        return findRawTokenInHead(RequestUtil.getHttpServletRequest());
    }

    /**
     * <p>从当前请求中获取原生token</p>
     *
     * @param request 请求
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 11:23
     */
    public static String findRawTokenInHead(HttpServletRequest request) {
        String tokenText = RequestUtil.findHeadByName(request, SecurityCommonConstant.TOKEN_IN_HEAD_KEY, true);
        if (StrUtil.isBlank(tokenText)) {
            log.warn("从请求头[headName={}]中解析出的tokenText为空", SecurityCommonConstant.TOKEN_IN_HEAD_KEY);
            tokenText = StrUtil.EMPTY;
        }
        return tokenText;
    }

    /**
     * <p>校验安全认证签名是否为空</p>
     *
     * @param signature 安全认证签名
     * @author guocq
     * @date 2022/12/28 10:16
     */
    public static void checkSecuritySignatureEmpty(SecuritySignature signature) {
        if (isSecuritySignatureEmpty(signature)) {
            throw ErrorRecords.valid.record(log, "获取登录凭证信息失败，无法获取到登录信息，可能因为令牌已过期");
        }
    }

    /**
     * <p>生成token序列号</p>
     *
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 17:09
     */
    public static String generateTokenSerialNumber() {
        return SerialNumberUtil.generateBizSerialNumber(SecurityCommonConstant.REDIS_BIZ_KEY_FOR_TOKEN);
    }

    /**
     * <p>校验token序列号合法性</p>
     *
     * @param tokenSerialNumber token序列号
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/15 17:10
     */
    public static boolean validateTokenSerialNumber(String tokenSerialNumber) {
        return SerialNumberUtil.validateBizSerialNumber(SecurityCommonConstant.REDIS_BIZ_KEY_FOR_TOKEN, tokenSerialNumber);
    }
}
