package org.pineapple.common.strategy;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.digest.DigestAlgorithm;
import cn.hutool.crypto.digest.Digester;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.util.Map;

/**
 * <p>md5加盐加解密策略</p>
 *
 * @author guocq
 * @since 2023/3/16
 */
@Component(value = "md5SaltCrypto")
public class Md5SaltCrypto extends AbstractCryptStrategy {
    private static final Logger log = LoggerFactory.getLogger(Md5SaltCrypto.class);

    /**
     * 额外选项key - 盐
     */
    public static final String OPTION_KEY_SALT = "salt";

    private static final String DEFAULT_SALT = "PINEAPPLE";

    /**
     * <p>获取当前接口名称</p>
     *
     * @return {@link String }
     * @author guocq
     * @date 2023/3/16 9:34
     */
    @Override
    public String name() {
        return "MD5加盐加密(" + super.name() + ")";
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
        return this.encrypt(plainText, null);
    }

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
        log.debug("加解密策略[{}]对文本[{}]进行加密,使用额外选项[option={}]", this.name(), plainText, option);
        if (StrUtil.isBlank(plainText)) {
            log.warn("加解密策略[{}]加密时被加密的文本[plainText={}]不能为空", this.name(), plainText);
            return StrUtil.EMPTY;
        }
        return getDigester(option).digestHex(plainText);
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
        return this.match(plainText, encryptText, null);
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
        log.debug("加解密策略[{}]对待匹配的文本信息[plainText={}]和已加密的文本信息[encryptText={}]进行匹配, 使用额外选项[option={}]", this.name(), plainText, encryptText, option);
        if (StrUtil.hasBlank(plainText, encryptText)) {
            log.warn("加解密策略[{}]匹配时待匹配字符串[plainText={}]和已经加密的密文[encryptText={}]不能为空", this.name(), plainText, encryptText);
            return false;
        }
        return ObjectUtil.equals(getDigester(option).digestHex(plainText), encryptText);
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
        log.info("当前加解密策略[{}]需要额外选项", this.name());
        return true;
    }

    /**
     * <p>获取Digester(携带盐)</p>
     *
     * @param option 额外选项
     * @return {@link cn.hutool.crypto.digest.Digester }
     * @author guocq
     * @date 2023/3/16 9:48
     */
    static Digester getDigester(Map<String, Object> option) {
        return getDigester(true, option);
    }

    /**
     * <p>获取Digester(不携带盐)</p>
     *
     * @return {@link cn.hutool.crypto.digest.Digester }
     * @author guocq
     * @date 2023/3/16 9:48
     */
    static Digester getDigester() {
        return getDigester(false, null);
    }

    /**
     * <p>获取Digester</p>
     *
     * @param isCarrySalt 是否携带盐
     * @param option      额外选项
     * @return {@link cn.hutool.crypto.digest.Digester }
     * @author guocq
     * @date 2023/3/16 9:47
     */
    static Digester getDigester(final boolean isCarrySalt, Map<String, Object> option) {
        Digester md5 = new Digester(DigestAlgorithm.MD5);
        if (!isCarrySalt) {
            return md5;
        }
        if (CollUtil.isEmpty(option) || !option.containsKey(OPTION_KEY_SALT)) {
            log.warn("额外选项内未传入key为[{}]的值，系统将使用默认盐[{}]", OPTION_KEY_SALT, DEFAULT_SALT);
            option.put(OPTION_KEY_SALT, DEFAULT_SALT);
        }
        String salt = StrUtil.toStringOrNull(option.get(OPTION_KEY_SALT));
        log.debug("MD5加盐加密使用盐为[{}]", salt);
        md5.setSalt(salt.getBytes(StandardCharsets.UTF_8));
        return md5;
    }
}
