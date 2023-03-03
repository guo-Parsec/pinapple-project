package org.pineapple.system.core.pojo.dto;

import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.valid.CurdValidateGroup;
import org.pineapple.support.durability.BaseDto;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

/**
 * <p>系统字典参数</p>
 *
 * @author guocq
 * @since 2023/2/16
 */
@Setter
@Getter
@ApiModel(value = "系统字典参数")
public class SysDictDto extends BaseDto {
    private static final long serialVersionUID = 5902181968691003221L;

    /**
     * 数据字典类型码
     */
    @NotEmpty(message = "数据字典类型码不能为空", groups = {CurdValidateGroup.Create.class})
    private String typeCode;

    /**
     * 数据字典类型名
     */
    @NotEmpty(message = "数据字典类型名不能为空", groups = {CurdValidateGroup.Create.class})
    private String typeName;

    /**
     * 数据字典值
     */
    @NotNull(message = "数据字典值不能为空", groups = {CurdValidateGroup.Create.class})
    private Integer dictVal;

    /**
     * 数据字典显示
     */
    @NotEmpty(message = "数据字典显示不能为空", groups = {CurdValidateGroup.Create.class})
    private String display;

    /**
     * 数据字典排序值
     */
    @NotNull(message = "数据字典显示不能为空", groups = {CurdValidateGroup.Create.class})
    private Integer sort;
}
