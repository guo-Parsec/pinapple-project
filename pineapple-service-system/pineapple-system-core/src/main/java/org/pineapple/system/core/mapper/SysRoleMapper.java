package org.pineapple.system.core.mapper;

import org.apache.ibatis.annotations.Param;
import org.pineapple.support.data.mapper.IMapper;
import org.pineapple.system.core.pojo.entity.SysRole;

import java.util.Set;

/**
 * <p> 系统角色表 Mapper 接口 </p>
 *
 * @author guocq
 * @since 2023-03-13
 */
public interface SysRoleMapper extends IMapper<SysRole> {
    /**
     * <p>根据用户id查询角色码集合</p>
     *
     * @param userId 用户id
     * @return {@link java.util.Set<java.lang.String> }
     * @author guocq
     * @date 2023/3/21 10:15
     */
    Set<String> findRoleCodeByUserId(@Param("userId") Long userId);
}
