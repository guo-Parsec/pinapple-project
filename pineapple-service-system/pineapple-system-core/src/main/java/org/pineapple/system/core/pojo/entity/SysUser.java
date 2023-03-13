package org.pineapple.system.core.pojo.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.support.data.BaseEntity;

import java.time.LocalDate;
import java.util.StringJoiner;

/**
 * <p> 系统用户信息表 </p>
 *
 * @author guocq
 * @since 2023-03-13
 */
@Getter
@Setter
@TableName(value = "sys_user", schema = "system")
@ApiModel(value = "User对象", description = "系统用户信息表")
public class SysUser extends BaseEntity{

    private static final long serialVersionUID = 1L;

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
    private LocalDate birthday;

    @Override
    public String toString() {
        return new StringJoiner(", ", SysUser.class.getSimpleName() + "[", "]")
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
                .add("addTime=" + addTime)
                .add("editTime=" + editTime)
                .add("id=" + id)
                .toString();
    }
}
