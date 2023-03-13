package org.pineapple.system.core.service.impl;

import com.google.common.collect.Lists;
import org.pineapple.common.annotations.NotBlank;
import org.pineapple.common.annotations.Valid;
import org.pineapple.common.annotations.Validator;
import org.pineapple.system.core.mapper.SysDictMapper;
import org.pineapple.system.core.pojo.entity.SysDict;
import org.pineapple.system.core.service.SysDictService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>数据字典Service实现类</p>
 *
 * @author guocq
 * @since 2023/2/9
 */
@Validator
@Service(value = "sysDictService")
public class SysDictServiceImpl implements SysDictService {
    private static final Logger log = LoggerFactory.getLogger(SysDictServiceImpl.class);
    @Resource
    private SysDictMapper sysDictMapper;

    @Valid(notBlank = {
            @NotBlank(value = "#sysDict.typeCode", message = "数据字典类型码不能为空"),
            @NotBlank(value = "#sysDict.typeName", message = "数据字典类型名不能为空"),
    })
    @Override
    public void createSysDict(SysDict sysDict) {
        log.debug("新增数据");
        sysDictMapper.insert(sysDict);
    }

    @Override
    public void editSysDict(SysDict sysDict) {
        sysDictMapper.updateById(sysDict);
    }

    @Override
    public void softRemove(Long id) {
        sysDictMapper.deleteById(id);
    }

    @Override
    public List<SysDict> findAll(SysDict sysDict) {
        return Lists.newArrayList(sysDictMapper.selectById(sysDict.getId()));
    }
}
