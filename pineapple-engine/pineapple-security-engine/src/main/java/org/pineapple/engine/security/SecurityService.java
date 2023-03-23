package org.pineapple.engine.security;

import org.pineapple.engine.security.entity.SecuritySignature;

/**
 * <p>安全业务接口</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
public interface SecurityService {
    /**
     * <p>登录操作</p>
     *
     * @param loginId     登录凭证
     * @param rawPassword 原始密码
     * @return {@link SecuritySignature } 安全签名
     * @author guocq
     * @date 2023/3/15 15:04
     */
    SecuritySignature login(String loginId, String rawPassword);

    /**
     * <p>获取安全签名信息</p>
     *
     * @return {@link SecuritySignature } 安全签名
     * @author guocq
     * @date 2023/3/15 15:05
     */
    SecuritySignature findSignature();

    /**
     * <p>从令牌文本中获取安全签名</p>
     *
     * @param tokenText 令牌文本
     * @return {@link SecuritySignature } 安全签名
     * @author guocq
     * @date 2023/3/15 15:06
     */
    SecuritySignature findSignatureWithTokenText(String tokenText);

    /**
     * <p>根据令牌id获取安全签名</p>
     *
     * @param tokenId 令牌id
     * @return {@link SecuritySignature }
     * @author guocq
     * @date 2023/3/15 16:37
     */
    SecuritySignature findSignatureWithTokenId(String tokenId);

    /**
     * <p>是否在线</p>
     *
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/15 15:08
     */
    boolean isOnline();

    /**
     * <p>根据令牌文本判断是否在线</p>
     *
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/15 15:08
     */
    boolean isOnlineWithTokenText(String tokenText);

    /**
     * <p>根据令牌id判断是否在线</p>
     *
     * @param tokenId 令牌id
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/15 16:23
     */
    boolean isOnlineWithTokenId(String tokenId);

    /**
     * <p>根据登录凭证判断是否在线</p>
     *
     * @param loginId 登录凭证
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/15 15:08
     */
    boolean isOnlineWithLoginId(String loginId);

    /**
     * <p>当前用户退出系统</p>
     *
     * @author guocq
     * @date 2023/3/15 15:09
     */
    void logout();

    /**
     * <p>根据令牌文本退出系统</p>
     *
     * @param tokenText 令牌文本
     * @author guocq
     * @date 2023/3/15 15:09
     */
    void logoutWithTokenText(String tokenText);

    /**
     * <p>根据令牌id退出系统</p>
     *
     * @param tokenId 令牌id
     * @author guocq
     * @date 2023/3/15 15:09
     */
    void logoutWithTokenId(String tokenId);

    /**
     * <p>指定userId的用户退出系统</p>
     *
     * @param loginId 登录凭证
     * @author guocq
     * @date 2023/3/15 15:09
     */
    void logoutWithLoginId(String loginId);

    /**
     * <p>根据令牌文本{@code tokenText}判断用户是否拥有对资源{@code requestUrl}的权限</p>
     *
     * @param requestUrl 请求路径
     * @param tokenText  令牌文本
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/23 11:00
     */
    boolean hasResourceWithTokenText(String requestUrl, String tokenText);

    /**
     * <p>根据令牌id{@code tokenId}判断用户是否拥有对资源{@code requestUrl}的权限</p>
     *
     * @param requestUrl 请求路径
     * @param tokenId    令牌id
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/23 11:00
     */
    boolean hasResourceWithTokenId(String requestUrl, String tokenId);

    /**
     * <p>根据登陆凭证{@code loginId}判断用户是否拥有对资源{@code requestUrl}的权限</p>
     *
     * @param requestUrl 请求路径
     * @param loginId    登陆凭证
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/23 11:00
     */
    boolean hasResourceWithLoginId(String requestUrl, String loginId);
}
