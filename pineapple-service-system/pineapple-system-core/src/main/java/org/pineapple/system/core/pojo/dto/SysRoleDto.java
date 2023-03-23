package org.pineapple.system.core.pojo.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.support.valid.CurdValidateGroup;
import org.pineapple.support.data.BaseDto;

import javax.validation.constraints.NotEmpty;

/**
 * <p>系统角色DTO</p>
 *
 * @author guocq
 * @since 2023/3/13
 */
@Setter
@Getter
@ApiModel(value = "系统角色DTO")
public class SysRoleDto extends BaseDto {
    private static final long serialVersionUID = 7343078545251156502L;

    @NotEmpty(message = "角色编码不能为空", groups = {CurdValidateGroup.Create.class})
    @ApiModelProperty(value = "角色编码")
    private String roleCode;

    @NotEmpty(message = "角色名称不能为空", groups = {CurdValidateGroup.Create.class})
    @ApiModelProperty(value = "角色名称")
    private String roleName;

    @ApiModelProperty(value = "角色排序")
    private Integer roleSort;

    @ApiModelProperty(value = "角色备注信息")
    private String roleDesc;
}
