package org.pineapple.system.core.pojo.dto;

import cn.hutool.core.util.StrUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.support.valid.FieldValidateResult;
import org.pineapple.support.data.BaseDto;

import java.util.StringJoiner;

/**
 * <p>系统菜单DTO</p>
 *
 * @author guocq
 * @since 2023/3/21
 */
@Setter
@Getter
@ApiModel(value = "系统菜单DTO")
public class SysMenuDto extends BaseDto {
    private static final long serialVersionUID = 428277118975244529L;

    @ApiModelProperty(value = "上级菜单主键")
    protected Long parentId;

    @ApiModelProperty(value = "菜单编码")
    protected String menuCode;

    @ApiModelProperty(value = "菜单名称")
    protected String menuName;

    @ApiModelProperty(value = "菜单标题")
    protected String menuTitle;

    @ApiModelProperty(value = "菜单类型")
    protected String menuType;

    @ApiModelProperty(value = "菜单图标")
    protected String menuIcon;

    @ApiModelProperty(value = "接口uri")
    protected String apiUri;

    @ApiModelProperty(value = "页面显示路径")
    protected String viewPageUri;

    @ApiModelProperty(value = "页面文件存储地址")
    protected String viewPageLocation;

    @ApiModelProperty(value = "菜单排序")
    protected Integer menuSort;

    @ApiModelProperty(value = "菜单备注信息")
    protected String menuDesc;

    /**
     * <p>校验结果</p>
     *
     * @return {@link FieldValidateResult }
     * @author guocq
     * @date 2023/3/21 13:48
     */
    @Override
    public FieldValidateResult beforeCreateValidate() {
        if (StrUtil.hasBlank(menuCode, menuName, menuType)) {
            return FieldValidateResult.validateFailed("menuCode", "");
        }
        return super.beforeCreateValidate();
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", SysMenuDto.class.getSimpleName() + "[", "]")
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
                .add("id=" + id)
                .toString();
    }


}
