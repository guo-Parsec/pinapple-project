package org.pineapple.system.core.service;

import java.util.Set;

/**
 * <p> 系统角色表 服务类 </p>
 *
 * @author guocq
 * @since 2023-03-13
 */
public interface SysRoleService {
    /**
     * <p>根据用户Id查询角色列表</p>
     *
     * @param userId
     * @return {@link java.util.Set<java.lang.String> }
     * @author guocq
     * @date 2023/3/21 10:06
     */
    Set<String> findRoleCodeByUserId(Long userId);
}
