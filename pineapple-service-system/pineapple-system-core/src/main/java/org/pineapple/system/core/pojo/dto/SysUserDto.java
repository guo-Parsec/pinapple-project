package org.pineapple.system.core.pojo.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.support.valid.CurdValidateGroup;
import org.pineapple.support.data.BaseDto;

import javax.validation.constraints.NotEmpty;
import java.time.LocalDate;
import java.util.StringJoiner;

/**
 * <p>系统用户DTO</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
@Setter
@Getter
@ApiModel(value = "系统用户DTO")
public class SysUserDto extends BaseDto {
    private static final long serialVersionUID = 394737682035156000L;

    @NotEmpty(message = "登录标识不能为空", groups = {CurdValidateGroup.Create.class})
    @ApiModelProperty(value = "登录标识")
    private String loginId;

    @NotEmpty(message = "登录密码不能为空", groups = {CurdValidateGroup.Create.class})
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
    private LocalDate birthday;

    @Override
    public String toString() {
        return new StringJoiner(", ", SysUserDto.class.getSimpleName() + "[", "]")
                .add("loginId='" + loginId + "'")
                .add("loginPassword='" + loginPassword + "'")
                .add("nickname='" + nickname + "'")
                .add("lastName='" + lastName + "'")
                .add("firstName='" + firstName + "'")
                .add("avatarUrl='" + avatarUrl + "'")
                .add("sexCode='" + sexCode + "'")
                .add("userType='" + userType + "'")
                .add("userStatus='" + userStatus + "'")
                .add("birthday=" + birthday)
                .add("id=" + id)
                .toString();
    }
}
