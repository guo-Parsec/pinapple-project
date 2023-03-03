package org.pineapple.system.core.service;

import org.pineapple.system.core.pojo.entity.SysDict;

import java.util.List;

/**
 * <p>数据字典Service</p>
 *
 * @author guocq
 * @since 2023/2/9
 */
public interface SysDictService {
    void createSysDict(SysDict sysDict);

    void editSysDict(SysDict sysDict);

    void softRemove(Long id);

    List<SysDict> findAll(SysDict sysDict);
}
