package org.pineapple.system.core.pojo.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.annotations.Dictionary;
import org.pineapple.core.AbstractTreeNode;

import java.util.StringJoiner;

/**
 * <p>系统菜单vo</p>
 *
 * @author guocq
 * @since 2023/3/22
 */
@Setter
@Getter
@ApiModel(value = "系统菜单vo")
public class SysMenuVo extends AbstractTreeNode<Long> {
    private static final long serialVersionUID = 621527041465684582L;
    @ApiModelProperty(value = "菜单编码")
    private String menuCode;

    @ApiModelProperty(value = "菜单名称")
    private String menuName;

    @ApiModelProperty(value = "菜单标题")
    private String menuTitle;

    @ApiModelProperty(value = "菜单类型")
    private String menuType;

    @Dictionary(code = "menu_type", fieldName = "menuType")
    @ApiModelProperty(value = "菜单类型字典值")
    private String menuTypeName;

    @ApiModelProperty(value = "菜单图标")
    private String menuIcon;

    @ApiModelProperty(value = "接口uri")
    private String apiUri;

    @ApiModelProperty(value = "页面显示路径")
    private String viewPageUri;

    @ApiModelProperty(value = "页面文件存储地址")
    private String viewPageLocation;

    @ApiModelProperty(value = "菜单排序")
    private Integer menuSort;

    @ApiModelProperty(value = "菜单备注信息")
    private String menuDesc;

    @Override
    public String toString() {
        return new StringJoiner(", ", SysMenuVo.class.getSimpleName() + "[", "]")
                .add("menuCode='" + menuCode + "'")
                .add("menuName='" + menuName + "'")
                .add("menuTitle='" + menuTitle + "'")
                .add("menuType='" + menuType + "'")
                .add("menuTypeName='" + menuTypeName + "'")
                .add("menuIcon='" + menuIcon + "'")
                .add("apiUri='" + apiUri + "'")
                .add("viewPageUri='" + viewPageUri + "'")
                .add("viewPageLocation='" + viewPageLocation + "'")
                .add("menuSort=" + menuSort)
                .add("menuDesc='" + menuDesc + "'")
                .add("id=" + id)
                .add("parentId=" + parentId)
                .add("children=" + children)
                .add("root=" + root)
                .add("leaf=" + leaf)
                .add("addTime='" + addTime + "'")
                .add("editTime='" + editTime + "'")
                .toString();
    }
}
