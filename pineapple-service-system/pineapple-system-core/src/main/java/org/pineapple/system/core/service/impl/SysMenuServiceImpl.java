package org.pineapple.system.core.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.google.common.collect.Sets;
import org.pineapple.common.error.ErrorRecords;
import org.pineapple.system.core.mapper.SysMenuMapper;
import org.pineapple.system.core.mapper.SysRoleMapper;
import org.pineapple.system.core.pojo.dto.SysMenuDto;
import org.pineapple.system.core.pojo.entity.SysMenu;
import org.pineapple.system.core.pojo.entity.SysRole;
import org.pineapple.system.core.service.SysMenuService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * <p> 系统菜单表 服务实现类 </p>
 *
 * @author guocq
 * @since 2023-03-13
 */
@Service("sysMenuService")
public class SysMenuServiceImpl implements SysMenuService {
    private static final Logger log = LoggerFactory.getLogger(SysMenuServiceImpl.class);

    @Resource
    private SysMenuMapper sysMenuMapper;
    @Resource
    private SysRoleMapper sysRoleMapper;

    /**
     * <p>根据角色码列表获取菜单码</p>
     *
     * @param roleCodeSet 角色码列表
     * @return {@link Set < String> }
     * @author guocq
     * @date 2023/3/21 11:28
     */
    @Override
    @Cacheable(cacheNames = "sys_role", key = "'find_menu_code_by_role_code_' + #roleCodeSet")
    public Set<String> findMenuCodeByRoleCode(Set<String> roleCodeSet) {
        if (CollUtil.isEmpty(roleCodeSet)) {
            throw ErrorRecords.valid.record(log, "根据角色码列表[roleCodeSet={}]查询菜单码信息时,角色码列表不能为空", roleCodeSet);
        }
        log.debug("根据角色码列表[roleCodeSet={}]查询菜单码信息", roleCodeSet);
        Wrapper<SysRole> wrapper = new LambdaQueryWrapper<SysRole>()
                .in(SysRole::getRoleCode, roleCodeSet).select(SysRole::getId);
        List<SysRole> sysRoles = sysRoleMapper.selectList(wrapper);
        if (CollUtil.isEmpty(sysRoles)) {
            log.warn("根据角色码列表[roleCodeSet={}]查询菜单码信息为空", roleCodeSet);
            return Sets.newHashSet();
        }
        Set<Long> roleIdSet = sysRoles.stream().map(SysRole::getId).collect(Collectors.toSet());
        Set<String> menuCode = sysMenuMapper.findMenuCodeByRoleId(roleIdSet);
        if (CollUtil.isEmpty(menuCode)) {
            log.warn("根据角色码列表[roleCodeSet={}]查询菜单码信息为空", roleCodeSet);
            return Sets.newHashSet();
        }
        return menuCode;
    }

    /**
     * <p>新增菜单信息</p>
     *
     * @param dto 系统菜单
     * @author guocq
     * @date 2023/3/21 14:08
     */
    @Override
    @CacheEvict(cacheNames = "sys_menu", allEntries = true)
    public void createSysMenu(SysMenuDto dto) {
        log.debug("开始新增菜单信息[dto={}]", dto);
        checkBeforeCreateMenu(dto);
        SysMenu sysMenu = new SysMenu();
        BeanUtil.copyProperties(dto, sysMenu);
        sysMenuMapper.insert(sysMenu);
        log.debug("新增菜单信息[sysMenu={}]成功", sysMenu);
    }

    /**
     * <p>更新菜单信息</p>
     *
     * @param dto 系统菜单
     * @author guocq
     * @date 2023/3/21 14:21
     */
    @Override
    @CacheEvict(cacheNames = "sys_menu", allEntries = true)
    public void updateSysMenu(SysMenuDto dto) {
        log.debug("开始更新菜单信息[dto={}]", dto);
        checkBeforeUpdateMenu(dto);
        SysMenu sysMenu = new SysMenu();
        BeanUtil.copyProperties(dto, sysMenu);
        sysMenuMapper.updateById(sysMenu);
        log.debug("更新菜单信息[sysMenu={}]成功", sysMenu);
    }

    /**
     * <p>删除系统菜单</p>
     *
     * @param idSet id集合
     * @author guocq
     * @date 2023/3/21 14:36
     */
    @Override
    @CacheEvict(cacheNames = "sys_menu", allEntries = true)
    public void deleteSysMenu(Set<Long> idSet) {
        log.debug("开始删除菜单信息[idSet={}]", idSet);
        if (CollUtil.isEmpty(idSet)) {
            log.warn("待删除的主键集合为空");
            return;
        }
        sysMenuMapper.deleteBatchIds(idSet);
        log.debug("删除菜单信息[idSet={}]成功", idSet);
    }


    /**
     * <p>新增前校验</p>
     *
     * @param dto 系统菜单
     * @author guocq
     * @date 2023/3/21 14:17
     */
    private void checkBeforeCreateMenu(SysMenuDto dto) {
        String menuCode = dto.getMenuCode();
        Wrapper<SysMenu> wrapper = new LambdaQueryWrapper<SysMenu>()
                .eq(SysMenu::getMenuCode, menuCode);
        if (sysMenuMapper.exists(wrapper)) {
            throw ErrorRecords.valid.record(log, "新增系统菜单时,菜单编码[menuCode={}]已存在,无法新增", menuCode);
        }
    }

    /**
     * <p>更新前校验</p>
     *
     * @param dto 系统菜单
     * @author guocq
     * @date 2023/3/21 14:24
     */
    private void checkBeforeUpdateMenu(SysMenuDto dto) {
        String menuCode = dto.getMenuCode();
        if (StrUtil.isNotBlank(menuCode)) {
            Wrapper<SysMenu> wrapper = new LambdaQueryWrapper<SysMenu>()
                    .eq(SysMenu::getMenuCode, menuCode)
                    .ne(SysMenu::getId, dto.getId());
            if (sysMenuMapper.exists(wrapper)) {
                throw ErrorRecords.valid.record(log, "更新系统菜单时,菜单编码[menuCode={}]已存在,无法更新", menuCode);
            }
        }
    }
}
