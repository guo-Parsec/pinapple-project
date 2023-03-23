package org.pineapple.common.support.strategy;

import org.pineapple.common.NameInterface;

import java.util.Map;

/**
 * <p>加解密策略器</p>
 *
 * @author guocq
 * @since 2023/3/16
 */
public interface CryptoStrategy extends NameInterface {
    /**
     * <p>加密实现</p>
     *
     * @param plainText 被加密的文本
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/16 9:22
     */
    String encrypt(String plainText);

    /**
     * <p>通过额外选项实文本现加密</p>
     *
     * @param plainText 被加密的文本
     * @param option    额外选项
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/16 9:26
     */
    String encrypt(String plainText, Map<String, Object> option);

    /**
     * <p>判断文本信息{@code plainText}是否与已加密的文本信息{@code encryptText}匹配</p>
     *
     * @param plainText   待匹配的文本信息
     * @param encryptText 已加密的文本信息
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/16 9:23
     */
    boolean match(String plainText, String encryptText);

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
    boolean match(String plainText, String encryptText, Map<String, Object> option);

    /**
     * <p>对已加密的文本信息{@code encryptText}解密</p>
     *
     * @param encryptText 已加密的文本信息
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/16 9:28
     */
    String decrypt(String encryptText);

    /**
     * <p>通过额外选项{@code option}对已加密的文本信息{@code encryptText}解密</p>
     *
     * @param encryptText 已加密的文本信息
     * @param option      额外选项
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/16 9:28
     */
    String decrypt(String encryptText, Map<String, Object> option);

    /**
     * <p>加解密时是否需要额外选项</p>
     *
     * @return true: 需要 false: 不需要
     * @author guocq
     * @date 2023/3/16 9:24
     */
    boolean isOptionRequired();
}
