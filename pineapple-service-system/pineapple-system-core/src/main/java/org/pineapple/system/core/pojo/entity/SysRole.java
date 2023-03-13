package org.pineapple.system.core.pojo.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.support.data.BaseEntity;

import java.util.StringJoiner;

/**
 * <p> 系统角色表 </p>
 *
 * @author guocq
 * @since 2023-03-13
 */
@Getter
@Setter
@TableName(value = "sys_role", schema = "system")
@ApiModel(value = "Role对象", description = "系统角色表")
public class SysRole extends BaseEntity{

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "角色编码")
    private String roleCode;

    @ApiModelProperty(value = "角色名称")
    private String roleName;

    @ApiModelProperty(value = "角色排序")
    private Integer roleSort;

    @ApiModelProperty(value = "角色备注信息")
    private String roleDesc;

    @Override
    public String toString() {
        return new StringJoiner(", ", SysRole.class.getSimpleName() + "[", "]")
                .add("roleCode='" + roleCode + "'")
                .add("roleName='" + roleName + "'")
                .add("roleSort=" + roleSort)
                .add("roleDesc='" + roleDesc + "'")
                .add("addTime=" + addTime)
                .add("editTime=" + editTime)
                .add("id=" + id)
                .toString();
    }
}
