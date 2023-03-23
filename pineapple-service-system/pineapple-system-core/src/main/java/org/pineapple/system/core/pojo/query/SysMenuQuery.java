package org.pineapple.system.core.pojo.query;

import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.support.data.BaseDto;

import java.util.Set;
import java.util.StringJoiner;

/**
 * <p>系统菜单分页数据</p>
 *
 * @author guocq
 * @since 2023/3/22
 */
@Setter
@Getter
public class SysMenuQuery extends BaseDto {
    private static final long serialVersionUID = -4112146007016470528L;

    @ApiModelProperty(value = "菜单编码")
    protected String menuCode;

    @ApiModelProperty(value = "菜单名称")
    protected String menuName;

    @ApiModelProperty(value = "菜单标题")
    protected String menuTitle;

    @ApiModelProperty(value = "菜单类型")
    protected Set<String> menuTypeSet;

    @Override
    public String toString() {
        return new StringJoiner(", ", SysMenuQuery.class.getSimpleName() + "[", "]")
                .add("menuCode='" + menuCode + "'")
                .add("menuName='" + menuName + "'")
                .add("menuTitle='" + menuTitle + "'")
                .add("menuTypeSet=" + menuTypeSet)
                .add("id=" + id)
                .toString();
    }
}
