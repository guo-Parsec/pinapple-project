package org.pineapple.support.security;

import cn.hutool.core.util.StrUtil;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.support.security.utils.SecurityUtil;

import java.io.Serializable;
import java.util.StringJoiner;

/**
 * <p>安全信息</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
@Setter
@Getter
public class SecurityInfo implements Serializable {
    private static final long serialVersionUID = -8624916829432343826L;

    /**
     * 是否在线
     */
    private boolean online;

    /**
     * 是否存储了令牌信息
     */
    private boolean hasTokenInfo;

    /**
     * 是否存储了详情信息
     */
    private boolean hasDetailsInfo;

    /**
     * 令牌信息内容
     */
    private String tokenInfoValue;

    /**
     * 详情信息内容
     */
    private SecuritySignature detailsInfoValue;

    /**
     * 安全令牌key
     */
    private String securityTokenKey;

    /**
     * 安全用户key
     */
    private String securityUserKey;

    public SecurityInfo(String tokenInfoValue, SecuritySignature detailsInfoValue, String securityTokenKey, String securityUserKey) {
        this.tokenInfoValue = tokenInfoValue;
        this.detailsInfoValue = detailsInfoValue;
        this.securityTokenKey = securityTokenKey;
        this.securityUserKey = securityUserKey;
        if (StrUtil.isEmpty(this.tokenInfoValue)) {
            this.hasTokenInfo = false;
            this.hasDetailsInfo = false;
            this.online = false;
            return;
        }
        this.hasTokenInfo = true;
        this.online = true;
        this.hasDetailsInfo = !SecurityUtil.isSecuritySignatureEmpty(this.detailsInfoValue);
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", SecurityInfo.class.getSimpleName() + "[", "]")
                .add("online=" + online)
                .add("hasTokenInfo=" + hasTokenInfo)
                .add("hasDetailsInfo=" + hasDetailsInfo)
                .add("tokenInfoValue='" + tokenInfoValue + "'")
                .add("detailsInfoValue=" + detailsInfoValue)
                .add("securityTokenKey='" + securityTokenKey + "'")
                .add("securityUserKey='" + securityUserKey + "'")
                .toString();
    }
}
