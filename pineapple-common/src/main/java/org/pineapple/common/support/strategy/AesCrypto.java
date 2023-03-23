package org.pineapple.common.support.strategy;

import cn.hutool.core.util.CharsetUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.Mode;
import cn.hutool.crypto.Padding;
import cn.hutool.crypto.symmetric.AES;
import org.pineapple.common.AesProp;
import org.pineapple.common.constant.BeanNameDefineConstant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.util.Optional;

/**
 * <p>aes加解密策略</p>
 *
 * @author guocq
 * @since 2023/3/16
 */
@Component(BeanNameDefineConstant.AES_CRYPTO)
public class AesCrypto extends AbstractCryptStrategy {
    private static final Logger log = LoggerFactory.getLogger(AesCrypto.class);

    private final AesProp aesProp;

    private static final String DEFAULT_KEY = "abc123456";

    public AesCrypto(AesProp aesProp) {
        this.aesProp = aesProp;
    }

    /**
     * <p>获取当前接口名称</p>
     *
     * @return {@link String }
     * @author guocq
     * @date 2023/3/16 9:34
     */
    @Override
    public String name() {
        return "AES对称加密(" + super.name() + ")";
    }

    /**
     * <p>加密实现</p>
     *
     * @param plainText 被加密的文本
     * @return {@link String }
     * @author guocq
     * @date 2023/3/16 9:22
     */
    @Override
    public String encrypt(String plainText) {
        log.debug("加解密策略[{}]对文本[{}]进行加密", this.name(), plainText);
        if (StrUtil.isBlank(plainText)) {
            log.warn("加解密策略[{}]加密时被加密的文本[plainText={}]不能为空", this.name(), plainText);
            return StrUtil.EMPTY;
        }
        return getAes().encryptHex(plainText);
    }

    /**
     * <p>判断文本信息{@code plainText}是否与已加密的文本信息{@code encryptText}匹配</p>
     *
     * @param plainText   待匹配的文本信息
     * @param encryptText 已加密的文本信息
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/16 9:23
     */
    @Override
    public boolean match(String plainText, String encryptText) {
        log.debug("加解密策略[{}]对待匹配的文本信息[plainText={}]和已加密的文本信息[encryptText={}]进行匹配", this.name(), plainText, encryptText);
        if (StrUtil.hasBlank(plainText, encryptText)) {
            log.warn("加解密策略[{}]匹配时待匹配字符串[plainText={}]和已经加密的密文[encryptText={}]不能为空", this.name(), plainText, encryptText);
            return false;
        }
        return ObjectUtil.equals(decrypt(encryptText), plainText);
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
        log.debug("加解密策略[{}]对已加密的文本信息[encryptText={}]进行解密", this.name(), encryptText);
        if (StrUtil.hasBlank(encryptText)) {
            log.warn("加解密策略[{}]匹配时已经加密的密文[encryptText={}]不能为空", this.name(), encryptText);
            return StrUtil.EMPTY;
        }
        return getAes().decryptStr(encryptText, CharsetUtil.CHARSET_UTF_8);
    }

    /**
     * <p>获取aes</p>
     *
     * @return {@link cn.hutool.crypto.symmetric.AES }
     * @author guocq
     * @date 2023/3/16 10:01
     */
    AES getAes() {
        Mode mode = aesProp.getMode();
        Padding padding = aesProp.getPadding();
        log.debug("aes加密模式为[{}],补码方式为[{}]", mode, padding);
        String key = Optional.ofNullable(aesProp.getKey()).filter(text -> !StrUtil.isEmpty(text)).orElse(DEFAULT_KEY);
        log.debug("aes加密密钥为[{}]", key);
        String offset = aesProp.getOffset();
        byte[] keyBytes = key.getBytes(StandardCharsets.UTF_8);
        if (StrUtil.isEmpty(offset)) {
            log.debug("aes不使用偏移量");
            return new AES(mode, padding, keyBytes);
        }
        log.debug("aes加密偏移量为[{}]", offset);
        return new AES(mode, padding, keyBytes, offset.getBytes(StandardCharsets.UTF_8));
    }
}
