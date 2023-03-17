package org.pineapple.engine.security.entity;

import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.error.ErrorRecords;
import org.pineapple.engine.security.contant.SecurityCommonConstant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.Serializable;
import java.util.Optional;
import java.util.Set;
import java.util.StringJoiner;

/**
 * <p>安全签名实体类</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
@Setter
@Getter
@ApiModel(value = "安全签名实体类")
public class SecuritySignature implements Serializable {
    private static final long serialVersionUID = -7860223682908057459L;
    private static final Logger log = LoggerFactory.getLogger(SecuritySignature.class);

    @ApiModelProperty(value = "主键")
    private String id;

    @ApiModelProperty(value = "用户账户信息")
    private String loginId;

    @ApiModelProperty(value = "用户所拥有的角色码")
    private Set<String> roles;

    @ApiModelProperty(value = "用户所拥有的权限码")
    private Set<String> permissions;

    @ApiModelProperty(value = "用户详情信息")
    private Object details;

    @ApiModelProperty(value = "令牌详情信息")
    private TokenDetails tokenDetails;

    public SecuritySignature() {
    }

    public SecuritySignature(String id, String loginId) {
        this.id = id;
        this.loginId = loginId;
    }

    /**
     * <p>注入令牌id信息</p>
     *
     * @param tokenId 令牌id
     * @author guocq
     * @date 2022/12/28 10:03
     */
    public void putTokenId(String tokenId) {
        log.debug("开始注入令牌id信息,令牌id为={}", tokenId);
        if (StrUtil.isBlank(tokenId)) {
            throw ErrorRecords.valid.record(log, "令牌id不能为空");
        }
        this.setTokenDetails(Optional.ofNullable(this.getTokenDetails()).map(token -> {
            log.debug("当前签名中[{}]已存在令牌信息，原令牌信息[token={}]将被更新", this, token);
            token.setId(tokenId);
            token.setContent(SecurityCommonConstant.EFFECTIVE_TOKEN_PREFIX + tokenId);
            log.debug("当前签名[{}]中已存在令牌信息，更新后的令牌信息为{}", this, token);
            return token;
        }).orElseGet(() -> {
            TokenDetails token = TokenDetails.ofId(tokenId);
            log.debug("当前签名[{}]中不存在令牌信息,将生成新的令牌{}", this, token);
            return token;
        }));
    }

    /**
     * <p>获取tokenId</p>
     *
     * @return {@link String }
     * @author guocq
     * @date 2023/3/15 15:54
     */
    public String findTokenId() {
        log.debug("开始获取令牌id信息,当前签名为={}", this);
        TokenDetails tokenDetails = this.getTokenDetails();
        if (tokenDetails == null) {
            log.error("当前签名[signature={}]中未保存令牌信息", this);
            return StrUtil.EMPTY;
        }
        String tokenId = tokenDetails.getId();
        if (StrUtil.isBlank(tokenId)) {
            throw ErrorRecords.error.record(log, "当前令牌[token={}]格式有误", tokenDetails);
        }
        log.debug("当前令牌[token={}]中的tokenId是={}", tokenDetails, tokenId);
        return tokenId;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", SecuritySignature.class.getSimpleName() + "[", "]")
                .add("id='" + id + "'")
                .add("loginId='" + loginId + "'")
                .add("tokenDetails=" + tokenDetails)
                .toString();
    }
}
