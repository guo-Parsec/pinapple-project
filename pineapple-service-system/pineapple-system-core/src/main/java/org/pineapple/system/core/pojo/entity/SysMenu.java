package org.pineapple.system.core.pojo.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.support.data.BaseEntity;

import java.util.StringJoiner;

/**
 * <p> 系统菜单表 </p>
 *
 * @author guocq
 * @since 2023-03-13
 */
@Getter
@Setter
@TableName(value = "sys_menu", schema = "system")
@ApiModel(value = "Menu对象", description = "系统菜单表")
public class SysMenu extends BaseEntity{

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "上级菜单主键")
    private Long parentId;

    @ApiModelProperty(value = "菜单编码")
    private String menuCode;

    @ApiModelProperty(value = "菜单名称")
    private String menuName;

    @ApiModelProperty(value = "菜单标题")
    private String menuTitle;

    @ApiModelProperty(value = "菜单类型")
    private String menuType;

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
        return new StringJoiner(", ", SysMenu.class.getSimpleName() + "[", "]")
                .add("parentId=" + parentId)
                .add("menuCode='" + menuCode + "'")
                .add("menuName='" + menuName + "'")
                .add("menuTitle='" + menuTitle + "'")
                .add("menuType='" + menuType + "'")
                .add("menuIcon='" + menuIcon + "'")
                .add("apiUri='" + apiUri + "'")
                .add("viewPageUri='" + viewPageUri + "'")
                .add("viewPageLocation='" + viewPageLocation + "'")
                .add("menuSort=" + menuSort)
                .add("menuDesc='" + menuDesc + "'")
                .add("addTime=" + addTime)
                .add("editTime=" + editTime)
                .add("id=" + id)
                .toString();
    }
}
