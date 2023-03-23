package org.pineapple.common.support.strategy;

import org.pineapple.common.support.error.ErrorRecords;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;

/**
 * <p>抽象加解密策略器</p>
 *
 * @author guocq
 * @since 2023/3/16
 */
public abstract class AbstractCryptStrategy implements CryptoStrategy {
    private static final Logger log = LoggerFactory.getLogger(AbstractCryptStrategy.class);

    /**
     * <p>通过额外选项实文本现加密</p>
     *
     * @param plainText 被加密的文本
     * @param option    额外选项
     * @return {@link String }
     * @author guocq
     * @date 2023/3/16 9:26
     */
    @Override
    public String encrypt(String plainText, Map<String, Object> option) {
        throw ErrorRecords.unsupported.record(log, "当前加解密策略[{}]不支持额外选项，请使用[encrypt(String)]", this.name());
    }

    /**
     * <p>通过额外选项{@code option}判断文本信息{@code plainText}是否与已加密的文本信息{@code encryptText}匹配</p>
     *
     * @param plainText   待匹配的文本信息
     * @param encryptText 已加密的文本信息
     * @param option      额外选项
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/16 9:27
     */
    @Override
    public boolean match(String plainText, String encryptText, Map<String, Object> option) {
        throw ErrorRecords.unsupported.record(log, "当前加解密策略[{}]不支持额外选项，请使用[match(String, String)]", this.name());
    }

    /**
     * <p>对已加密的文本信息{@code encryptText}解密</p>
     *
     * @param encryptText 已加密的文本信息
     * @return {@link String }
     * @author guocq
     * @date 2023/3/16 9:28
     */
    @Override
    public String decrypt(String encryptText) {
        throw ErrorRecords.unsupported.record(log, "加解密策略[{}]不支持还原已被加密的文本", this.name());
    }

    /**
     * <p>通过额外选项{@code option}对已加密的文本信息{@code encryptText}解密</p>
     *
     * @param encryptText 已加密的文本信息
     * @param option      额外选项
     * @return {@link String }
     * @author guocq
     * @date 2023/3/16 9:28
     */
    @Override
    public String decrypt(String encryptText, Map<String, Object> option) {
        throw ErrorRecords.unsupported.record(log, "当前加解密策略[{}]不支持额外选项，请使用[decrypt(String)]", this.name());
    }

    /**
     * <p>加解密时是否需要额外选项</p>
     *
     * @return true: 需要 false: 不需要
     * @author guocq
     * @date 2023/3/16 9:24
     */
    @Override
    public boolean isOptionRequired() {
        log.info("当前加解密策略[{}]不需要额外选项", this.name());
        return false;
    }
}
