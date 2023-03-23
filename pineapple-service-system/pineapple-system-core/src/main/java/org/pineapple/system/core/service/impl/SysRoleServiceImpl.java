package org.pineapple.system.core.service.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import com.google.common.collect.Sets;
import org.pineapple.common.support.error.ErrorRecords;
import org.pineapple.system.core.mapper.SysRoleMapper;
import org.pineapple.system.core.service.SysRoleService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Set;

/**
 * <p> 系统角色表 服务实现类 </p>
 *
 * @author guocq
 * @since 2023-03-13
 */
@Service("sysRoleService")
public class SysRoleServiceImpl implements SysRoleService {
    private static final Logger log = LoggerFactory.getLogger(SysRoleServiceImpl.class);

    @Resource
    private SysRoleMapper sysRoleMapper;

    /**
     * <p>根据用户Id查询角色列表</p>
     *
     * @param userId 用户id
     * @return {@link Set < String> }
     * @author guocq
     * @date 2023/3/21 10:06
     */
    @Override
    @Cacheable(cacheNames = "sys_role", key = "'find_role_code_by_user_id_' + #userId")
    public Set<String> findRoleCodeByUserId(Long userId) {
        if (ObjectUtil.isNull(userId)) {
            throw ErrorRecords.valid.record(log, "用户id[userId={}]不能为空", userId);
        }
        log.debug("根据用户id[userId={}]查询角色信息, 获取角色码集合", userId);
        Set<String> roleCodes = sysRoleMapper.findRoleCodeByUserId(userId);
        if (CollUtil.isEmpty(roleCodes)) {
            log.warn("根据用户id[userId={}]查询到的角色为空", userId);
            return Sets.newHashSet();
        }
        return roleCodes;
    }
}
