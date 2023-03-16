package org.pineapple.common;

import cn.hutool.crypto.Mode;
import cn.hutool.crypto.Padding;
import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * <p>AES加解密属性类</p>
 *
 * @author guocq
 * @since 2022/12/28
 */
@Component
@ConfigurationProperties(prefix = "crypto.aes")
public class AesProp {
    /**
     * 加密算法模式
     *
     * @see Mode
     */
    @Setter
    @Getter
    private Mode mode = Mode.ECB;

    /**
     * 补码方式
     *
     * @see Padding
     */
    @Setter
    @Getter
    private Padding padding = Padding.PKCS5Padding;

    /**
     * 密钥
     */
    @Setter
    @Getter
    private String key;

    /**
     * 偏移量
     */
    @Setter
    @Getter
    private String offset;
}
