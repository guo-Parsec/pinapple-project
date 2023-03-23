package org.pineapple.common.support.strategy;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import org.pineapple.common.constant.BeanNameDefineConstant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * <p>Md5加解密策略</p>
 *
 * @author guocq
 * @since 2023/3/16
 */
@Component(BeanNameDefineConstant.MD5_CRYPTO)
public class Md5Crypto extends AbstractCryptStrategy {
    private static final Logger log = LoggerFactory.getLogger(Md5Crypto.class);

    /**
     * <p>获取当前接口名称</p>
     *
     * @return {@link String }
     * @author guocq
     * @date 2023/3/16 9:34
     */
    @Override
    public String name() {
        return "MD5普通加密(" + super.name() + ")";
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
        return Md5SaltCrypto.getDigester().digestHex(plainText);
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
        return ObjectUtil.equals(Md5SaltCrypto.getDigester().digest(plainText), encryptText);
    }
}
