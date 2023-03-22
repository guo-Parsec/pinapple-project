package org.pineapple.system.core.mapper;

import org.apache.ibatis.annotations.Param;
import org.pineapple.support.data.mapper.IMapper;
import org.pineapple.system.core.pojo.entity.SysMenu;

import java.util.Set;

/**
 * <p> 系统菜单表 Mapper 接口 </p>
 *
 * @author guocq
 * @since 2023-03-13
 */
public interface SysMenuMapper extends IMapper<SysMenu> {
    /**
     * <p>根据角色主键列表获取菜单码</p>
     *
     * @param roleIdSet 角色主键列表
     * @return {@link java.util.Set<java.lang.Long> }
     * @author guocq
     * @date 2023/3/21 11:19
     */
    Set<String> findMenuCodeByRoleId(@Param("roleIdSet") Set<Long> roleIdSet);
}
