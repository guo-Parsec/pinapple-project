package org.pineapple.engine.basequery.entity;

import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.AbstractDomainModel;

/**
 * <p>系统菜单实体</p>
 *
 * @author guocq
 * @since 2023/3/23
 */
@Setter
@Getter
public class SystemMenuEntity extends AbstractDomainModel {
    private static final long serialVersionUID = -6603750935523695403L;

    /**
     * 主键
     */
    private Long id;

    /**
     * 菜单编码
     */
    private String menuCode;

    /**
     * 菜单名称
     */
    private String menuName;

    /**
     * 菜单标题
     */
    private String menuTitle;

    /**
     * 菜单类型
     */
    private String menuType;

    /**
     * 菜单类型字典值
     */
    private String menuTypeName;

    /**
     * 菜单图标
     */
    private String menuIcon;

    /**
     * 接口uri
     */
    private String apiUri;

    /**
     * 页面显示路径
     */
    private String viewPageUri;

    /**
     * 页面文件存储地址
     */
    private String viewPageLocation;

    /**
     * 菜单排序
     */
    private Integer menuSort;

    /**
     * 菜单备注信息
     */
    private String menuDesc;
}
