package org.pineapple.system.core.service;

import org.pineapple.system.core.pojo.dto.SysMenuDto;

import java.util.Set;

/**
 * <p> 系统菜单表 服务类 </p>
 *
 * @author guocq
 * @since 2023-03-13
 */
public interface SysMenuService {
    /**
     * <p>根据角色码列表获取菜单码</p>
     *
     * @param roleCodeSet 角色码列表
     * @return {@link java.util.Set<java.lang.String> }
     * @author guocq
     * @date 2023/3/21 11:28
     */
    Set<String> findMenuCodeByRoleCode(Set<String> roleCodeSet);

    /**
     * <p>新增菜单信息</p>
     *
     * @param dto 系统菜单
     * @author guocq
     * @date 2023/3/21 14:08
     */
    void createSysMenu(SysMenuDto dto);

    /**
     * <p>更新菜单信息</p>
     *
     * @param dto 系统菜单
     * @author guocq
     * @date 2023/3/21 14:21
     */
    void updateSysMenu(SysMenuDto dto);

    /**
     * <p>删除系统菜单</p>
     *
     * @param idSet id集合
     * @author guocq
     * @date 2023/3/21 14:36
     */
    void deleteSysMenu(Set<Long> idSet);
}
