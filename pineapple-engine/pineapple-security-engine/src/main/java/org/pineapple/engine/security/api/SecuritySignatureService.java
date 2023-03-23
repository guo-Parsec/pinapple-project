package org.pineapple.engine.security.api;

import org.pineapple.common.support.error.ErrorRecords;
import org.pineapple.engine.security.entity.SecuritySignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;
import java.util.Set;

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

    /**
     * <p>根据签名信息{@code loginId}加载资源实体集合</p>
     *
     * @param signature 签名信息
     * @return 资源实体集合
     * @author guocq
     * @date 2023/3/23 9:51
     */
    default Set<Map<String, Object>> loadUserResourceEntity(SecuritySignature signature) {
        Logger logger = LoggerFactory.getLogger(SecuritySignatureService.class);
        throw ErrorRecords.unauthorized.record(logger, "当前安全签名业务类未能实现加载资源实体集合的方法");
    }
}
