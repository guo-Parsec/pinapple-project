package org.pineapple.system.core.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.pineapple.common.CommonWebApiDefineConstant;
import org.pineapple.common.uniforms.UniformResultDefinition;
import org.pineapple.common.uniforms.UniformResultTool;
import org.pineapple.system.api.SystemWebApiDefineConstant;
import org.pineapple.system.core.pojo.entity.SysDict;
import org.pineapple.system.core.service.SysDictService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>系统字典管理</p>
 *
 * @author guocq
 * @since 2023/2/9
 */
@Api(tags = "系统字典管理")
@RestController
@RequestMapping(SystemWebApiDefineConstant.WEB_API_DICT_PREFIX)
public class SysDictController {
    private final SysDictService service;

    public SysDictController(SysDictService service) {
        this.service = service;
    }

    @ApiOperation(value = "新增数据字典")
    @PostMapping(CommonWebApiDefineConstant.COMMON_CREATE_ACTION_API)
    public UniformResultDefinition<Void> create(@RequestBody SysDict sysDict) {
        service.createSysDict(sysDict);
        return UniformResultTool.success();
    }

    @ApiOperation(value = "修改数据字典")
    @PutMapping(CommonWebApiDefineConstant.COMMON_EDIT_ACTION_API)
    public UniformResultDefinition<Void> edit(@RequestBody SysDict sysDict) {
        service.editSysDict(sysDict);
        return UniformResultTool.success();
    }

    @ApiOperation(value = "删除数据字典")
    @DeleteMapping(CommonWebApiDefineConstant.COMMON_SOFT_REMOVE_ACTION_API)
    public UniformResultDefinition<Void> softRemove(@RequestBody Long id) {
        service.softRemove(id);
        return UniformResultTool.success();
    }

    @ApiOperation(value = "查询数据字典")
    @GetMapping(value = "/find-all")
    public UniformResultDefinition<List<SysDict>> findAll(SysDict sysDict) {
        return UniformResultTool.success(service.findAll(sysDict));
    }
}
