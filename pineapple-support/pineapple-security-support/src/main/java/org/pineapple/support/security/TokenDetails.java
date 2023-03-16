package org.pineapple.support.security;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.support.security.contant.SecurityCommonConstant;

import java.io.Serializable;
import java.util.StringJoiner;

/**
 * <p>token详情</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
@Setter
@Getter
@ApiModel(value = "token详情")
public class TokenDetails implements Serializable {
    private static final long serialVersionUID = 6657389330278878407L;

    /**
     * 令牌id
     */
    @ApiModelProperty(value = "令牌id")
    private String id;

    /**
     * 令牌名称
     */
    @ApiModelProperty(value = "令牌名称")
    private String name;

    /**
     * 令牌内容
     */
    @ApiModelProperty(value = "令牌内容")
    private String content;

    TokenDetails(String id, String name) {
        this.id = id;
        this.name = name;
        if (id != null) {
            this.content = SecurityCommonConstant.EFFECTIVE_TOKEN_PREFIX + id;
        }
    }

    public static TokenDetails of(String id, String name) {
        return new TokenDetails(id, name);
    }

    public static TokenDetails ofId(String id) {
        TokenDetails details = of(id, SecurityCommonConstant.TOKEN_IN_HEAD_KEY);
        details.setContent(SecurityCommonConstant.EFFECTIVE_TOKEN_PREFIX + id);
        return details;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", TokenDetails.class.getSimpleName() + "[", "]")
                .add("id='" + id + "'")
                .add("name='" + name + "'")
                .add("content='" + content + "'")
                .toString();
    }
}
