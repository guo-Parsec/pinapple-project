package org.pineapple.system.api.vo;

import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.BaseVo;

import java.util.StringJoiner;

/**
 * <p>用户信息</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
@Setter
@Getter
public class SysUserVo extends BaseVo {
    private static final long serialVersionUID = -8816048051938017232L;

    @ApiModelProperty(value = "主键")
    private String id;

    @ApiModelProperty(value = "登录标识")
    private String loginId;

    @ApiModelProperty(value = "登录密码")
    private String loginPassword;

    @ApiModelProperty(value = "登录用户昵称")
    private String nickname;

    @ApiModelProperty(value = "用户姓氏")
    private String lastName;

    @ApiModelProperty(value = "用户名称")
    private String firstName;

    @ApiModelProperty(value = "用户头像地址路径")
    private String avatarUrl;

    @ApiModelProperty(value = "用户性别")
    private String sexCode;

    @ApiModelProperty(value = "用户类型")
    private String userType;

    @ApiModelProperty(value = "用户状态")
    private String userStatus;

    @ApiModelProperty(value = "用户出生日期")
    private String birthday;

    @Override
    public String toString() {
        return new StringJoiner(", ", SysUserVo.class.getSimpleName() + "[", "]")
                .add("id='" + id + "'")
                .add("loginId='" + loginId + "'")
                .add("loginPassword='" + loginPassword + "'")
                .add("nickname='" + nickname + "'")
                .add("lastName='" + lastName + "'")
                .add("firstName='" + firstName + "'")
                .add("avatarUrl='" + avatarUrl + "'")
                .add("sexCode='" + sexCode + "'")
                .add("userType='" + userType + "'")
                .add("userStatus='" + userStatus + "'")
                .add("birthday='" + birthday + "'")
                .add("addTime='" + addTime + "'")
                .add("editTime='" + editTime + "'")
                .toString();
    }
}
