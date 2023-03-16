package org.pineapple.support.security.api;

import org.pineapple.support.security.entity.SecuritySignature;

/**
 * <p>安全签名业务类</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
public interface SecuritySignatureService {
    /**
     * <p>根据登录凭证{@code loginId}加载签名信息</p>
     *
     * @param loginId     登录凭证
     * @param rawPassword 原始密码
     * @return {@link SecuritySignature }
     * @author guocq
     * @date 2023/3/15 15:18
     */
    SecuritySignature loadSignature(String loginId, String rawPassword);
}
