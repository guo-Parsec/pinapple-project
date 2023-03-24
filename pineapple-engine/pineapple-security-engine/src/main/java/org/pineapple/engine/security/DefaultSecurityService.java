package org.pineapple.engine.security;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.spring.SpringUtil;
import org.pineapple.common.constant.BeanNameDefineConstant;
import org.pineapple.common.support.error.ErrorRecords;
import org.pineapple.common.utils.UrlUtil;
import org.pineapple.engine.security.api.SecuritySignatureService;
import org.pineapple.engine.security.entity.SecurityInfo;
import org.pineapple.engine.security.entity.SecuritySignature;
import org.pineapple.engine.security.utils.SecurityUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * <p>默认安全业务类</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
@Service(BeanNameDefineConstant.DEFAULT_SECURITY_SERVICE)
public class DefaultSecurityService implements SecurityService {
    private static final Logger log = LoggerFactory.getLogger(DefaultSecurityService.class);

    private final SecurityEngine securityEngine;

    public DefaultSecurityService(SecurityEngine securityEngine) {
        this.securityEngine = securityEngine;
    }

    /**
     * <p>登录操作</p>
     *
     * @param loginId     登录凭证
     * @param rawPassword 原始密码
     * @return {@link SecuritySignature } 安全签名
     * @author guocq
     * @date 2023/3/15 15:04
     */
    @Override
    public SecuritySignature login(String loginId, String rawPassword) {
        log.trace("用户[loginId={}]尝试登录系统", loginId);
        if (StrUtil.isBlank(loginId)) {
            throw ErrorRecords.valid.record(log, "用户[loginId={}]登录系统失败,原因:userId不能为空", loginId);
        }
        // 从业务系统中加载签名信息
        SecuritySignatureService signatureService = SpringUtil.getBean(SecuritySignatureService.class);
        SecuritySignature signature = signatureService.loadSignature(loginId, rawPassword);
        if (SecurityUtil.isSecuritySignatureEmpty(signature)) {
            throw ErrorRecords.valid.record(log, "用户[loginId={}]登录系统失败,原因:加载的安全签名不存在", loginId);
        }
        signature.putTokenId(SecurityUtil.generateTokenSerialNumber());
        this.logoutWithLoginId(loginId);
        Set<Map<String, Object>> resourceEntitySet = signatureService.loadUserResourceEntity(signature);
        securityEngine.putSecurityInfo(signature);
        securityEngine.putResourceEntitySet(signature, resourceEntitySet);
        log.info("用户[loginId={}]登录系统成功,其访问令牌为[token={}]", loginId, signature.getTokenDetails());
        return signature;
    }

    /**
     * <p>获取安全签名信息</p>
     *
     * @return {@link SecuritySignature } 安全签名
     * @author guocq
     * @date 2023/3/15 15:05
     */
    @Override
    public SecuritySignature findSignature() {
        log.debug("开始从当前请求中获取安全签名信息");
        String tokenText = SecurityUtil.findRawTokenInHead();
        log.debug("从当前请求中获取到的令牌文本为[tokenText={}]", tokenText);
        return findSignatureWithTokenText(tokenText);
    }

    /**
     * <p>从令牌文本中获取安全签名</p>
     *
     * @param tokenText 令牌文本
     * @return {@link SecuritySignature } 安全签名
     * @author guocq
     * @date 2023/3/15 15:06
     */
    @Override
    public SecuritySignature findSignatureWithTokenText(String tokenText) {
        if (StrUtil.isBlank(tokenText)) {
            throw ErrorRecords.valid.record(log, "根据令牌文本[tokenText={}]获取安全认证签名失败,原因:令牌文本不存在", tokenText);
        }
        log.debug("根据令牌文本[tokenText={}]获取安全认证签名", tokenText);
        return findSignatureWithTokenId(SecurityUtil.findEffectiveTokenId(tokenText));
    }

    /**
     * <p>根据令牌id获取安全签名</p>
     *
     * @param tokenId 令牌id
     * @return {@link SecuritySignature }
     * @author guocq
     * @date 2023/3/15 16:37
     */
    @Override
    public SecuritySignature findSignatureWithTokenId(String tokenId) {
        if (StrUtil.isBlank(tokenId) || !SecurityUtil.validateTokenSerialNumber(tokenId)) {
            throw ErrorRecords.valid.record(log, "根据令牌id[tokenId={}]获取安全签名失败,原因:令牌id不合法", tokenId);
        }
        log.debug("根据令牌id[tokenId={}]获取安全签名", tokenId);
        SecurityInfo securityInfo = securityEngine.findSecurityInfoWithTokenId(tokenId);
        if (!securityInfo.isHasDetailsInfo()) {
            log.warn("根据令牌id[tokenId={}]获取安全签名不存在", tokenId);
        }
        SecuritySignature signature = securityInfo.getDetailsInfoValue();
        SecurityUtil.checkSecuritySignatureEmpty(signature);
        log.debug("根据令牌id[tokenId={}]获取安全签名为[signature={}]", tokenId, signature);
        return signature;
    }

    /**
     * <p>是否在线</p>
     *
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/15 15:08
     */
    @Override
    public boolean isOnline() {
        log.debug("开始从当前请求中判断是否在线");
        String tokenText = SecurityUtil.findRawTokenInHead();
        log.debug("从当前请求中获取到的令牌文本为[tokenText={}]", tokenText);
        return isOnlineWithTokenText(tokenText);
    }

    /**
     * <p>根据令牌文本判断是否在线</p>
     *
     * @param tokenText 令牌文本
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/15 15:08
     */
    @Override
    public boolean isOnlineWithTokenText(String tokenText) {
        if (StrUtil.isBlank(tokenText)) {
            log.error("根据令牌文本[tokenText={}]判断是否在线失败,原因:令牌文本不存在", tokenText);
            return false;
        }
        log.debug("根据令牌文本[tokenText={}]判断是否在线", tokenText);
        return isOnlineWithTokenId(SecurityUtil.findEffectiveTokenId(tokenText));
    }

    /**
     * <p>根据令牌id判断是否在线</p>
     *
     * @param tokenId 令牌id
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/15 16:23
     */
    @Override
    public boolean isOnlineWithTokenId(String tokenId) {
        log.debug("根据令牌id[tokenId={}]判断是否在线", tokenId);
        SecurityInfo securityInfo = securityEngine.findSecurityInfoWithTokenId(tokenId);
        log.debug("根据令牌id[tokenId={}]判断用户{}", tokenId, (securityInfo.isOnline() ? "在线" : "掉线"));
        return securityInfo.isOnline();
    }

    /**
     * <p>根据登录凭证判断是否在线</p>
     *
     * @param loginId 登录凭证
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/15 15:08
     */
    @Override
    public boolean isOnlineWithLoginId(String loginId) {
        log.debug("根据登录凭证[loginId={}]判断是否在线", loginId);
        SecurityInfo securityInfo = securityEngine.findSecurityInfoWithLoginId(loginId);
        log.debug("根据登录凭证[loginId={}]判断用户{}", loginId, (securityInfo.isOnline() ? "在线" : "掉线"));
        return securityInfo.isOnline();
    }

    /**
     * <p>当前用户退出系统</p>
     *
     * @author guocq
     * @date 2023/3/15 15:09
     */
    @Override
    public void logout() {
        log.debug("开始处理当前请求中的用户退出系统");
        String tokenText = SecurityUtil.findRawTokenInHead();
        log.debug("从当前请求中获取到的令牌文本为[tokenText={}]", tokenText);
        logoutWithTokenText(tokenText);
    }

    /**
     * <p>根据令牌文本退出系统</p>
     *
     * @param tokenText 令牌文本
     * @author guocq
     * @date 2023/3/15 15:09
     */
    @Override
    public void logoutWithTokenText(String tokenText) {
        if (StrUtil.isBlank(tokenText)) {
            throw ErrorRecords.valid.record(log, "根据令牌文本[tokenText={}]退出登录失败,原因:令牌文本不存在", tokenText);
        }
        log.debug("根据令牌文本[tokenText={}]退出登录", tokenText);
        logoutWithTokenId(SecurityUtil.findEffectiveTokenId(tokenText));
    }

    /**
     * <p>根据令牌id退出系统</p>
     *
     * @param tokenId 令牌id
     * @author guocq
     * @date 2023/3/15 15:09
     */
    @Override
    public void logoutWithTokenId(String tokenId) {
        log.debug("开始根据令牌id[tokenId={}]退出登录", tokenId);
        securityEngine.closeSecurityInfoWithTokenId(tokenId);
        securityEngine.closeResourceEntitySetWithTokenId(tokenId);
        log.debug("根据令牌id[tokenId={}]退出登录成功", tokenId);
    }

    /**
     * <p>指定userId的用户退出系统</p>
     *
     * @param loginId 登录凭证
     * @author guocq
     * @date 2023/3/15 15:09
     */
    @Override
    public void logoutWithLoginId(String loginId) {
        log.debug("开始根据登录凭证[loginId={}]退出登录", loginId);
        securityEngine.closeSecurityInfoWithLoginId(loginId);
        securityEngine.closeResourceEntitySetWithLoginId(loginId);
        log.debug("根据登录凭证[loginId={}]退出登录成功", loginId);
    }

    /**
     * <p>根据令牌文本{@code tokenText}判断用户是否拥有对资源{@code requestUrl}的权限</p>
     *
     * @param requestUrl 请求路径
     * @param tokenText  令牌文本
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/23 11:00
     */
    @Override
    public boolean hasResourceWithTokenText(String requestUrl, String tokenText) {
        if (StrUtil.isBlank(tokenText)) {
            throw ErrorRecords.valid.record(log, "根据令牌文本[tokenText={}]判断用户是否拥有对资源[requestUrl={}]的权限失败,原因:令牌文本不存在", tokenText, requestUrl);
        }
        log.debug("根据令牌文本[tokenText={}]判断用户是否拥有对资源[requestUrl={}]的权限", tokenText, requestUrl);
        return hasResourceWithTokenId(requestUrl, SecurityUtil.findEffectiveTokenId(tokenText));
    }

    /**
     * <p>根据令牌id{@code tokenId}判断用户是否拥有对资源{@code requestUrl}的权限</p>
     *
     * @param requestUrl 请求路径
     * @param tokenId    令牌id
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/23 11:00
     */
    @Override
    public boolean hasResourceWithTokenId(String requestUrl, String tokenId) {
        log.debug("根据令牌id[tokenId={}]判断用户是否拥有对资源[requestUrl={}]的权限", tokenId, requestUrl);
        return hasResource(requestUrl, securityEngine.findResourceEntitySetWithTokenId(tokenId));
    }

    /**
     * <p>根据登陆凭证{@code loginId}判断用户是否拥有对资源{@code requestUrl}的权限</p>
     *
     * @param requestUrl 请求路径
     * @param loginId    登陆凭证
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/23 11:00
     */
    @Override
    public boolean hasResourceWithLoginId(String requestUrl, String loginId) {
        log.debug("根据登录凭证[loginId={}]判断用户是否拥有对资源[requestUrl={}]的权限", loginId, requestUrl);
        return hasResource(requestUrl, securityEngine.findResourceEntitySetWithLoginId(loginId));
    }

    /**
     * <p>判断用户是否拥有对资源{@code requestUrl}的权限</p>
     *
     * @param requestUrl        请求路径
     * @param resourceEntitySet 资源实体信息集合
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/23 11:25
     */
    private boolean hasResource(String requestUrl, Set<Map<String, Object>> resourceEntitySet) {
        if (CollUtil.isEmpty(resourceEntitySet)) {
            return false;
        }
        Set<String> apiUrlSet = resourceEntitySet.stream().map(ele -> (String) ele.get("apiUrl"))
                .filter(StrUtil::isNotBlank)
                .collect(Collectors.toSet());
        if (CollUtil.isEmpty(apiUrlSet)) {
            return false;
        }
        return UrlUtil.matches(requestUrl, apiUrlSet);
    }
}
