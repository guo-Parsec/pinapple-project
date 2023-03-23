package org.pineapple.common;

import org.pineapple.common.constant.SystemConstant;

/**
 * <p>通用网络API定义常量</p>
 *
 * @author guocq
 * @since 2023/2/9
 */
public class CommonWebApiDefineConstant {
    /**
     * 执行操作后缀
     */
    public static final String DO_ACTION_SUFFIX = SystemConstant.DOT + "do";

    /**
     * 通用创建操作API
     */
    public static final String COMMON_CREATE_ACTION_API = "/create" + DO_ACTION_SUFFIX;

    /**
     * 通用修改操作API
     */
    public static final String COMMON_EDIT_ACTION_API = "/edit" + DO_ACTION_SUFFIX;

    /**
     * 通用软删操作API
     */
    public static final String COMMON_SOFT_REMOVE_ACTION_API = "/soft/remove" + DO_ACTION_SUFFIX;

    /**
     * 通用分页查询操作API
     */
    public static final String COMMON_PAGE_ACTION_API = "/page";

    /**
     * 通用列表查询操作API
     */
    public static final String COMMON_LIST_ACTION_API = "/list";
}
