package org.pineapple.core.facade.impl;

import cn.hutool.core.util.ObjectUtil;
import org.pineapple.common.annotations.NotBlank;
import org.pineapple.common.annotations.Valid;
import org.pineapple.common.annotations.Validator;
import org.pineapple.common.entity.SystemDictEntity;
import org.pineapple.core.facade.SystemDictFacade;
import org.pineapple.core.retrieve.SystemDictRetrieve;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

import java.util.Optional;
import java.util.Set;

/**
 * <p>数据字典Facade实现类</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
@Validator
@Component(value = "systemDictFacade")
public class SystemDictFacadeImpl implements SystemDictFacade {
    private SystemDictRetrieve retrieve;

    @Autowired
    public void setRetrieve(SystemDictRetrieve retrieve) {
        this.retrieve = retrieve;
    }

    /**
     * <p>根据{@code typeCode}和{@code dictVal}查询单条数据字典数据</p>
     *
     * @param typeCode 数据字典类型码
     * @param dictCode 数据字典值
     * @return {@link SystemDictEntity }
     * @author guocq
     * @date 2023/2/8 14:30
     */
    @Override
    @Valid(notBlank = {
            @NotBlank(value = "#typeCode", message = "数据字典类型码不能为空"),
            @NotBlank(value = "#dictCode", message = "数据字典值不能为空")
    })
    @Cacheable(cacheNames = "system_dict_entity_single", key = "'type_code_' + #typeCode + '_dict_code_' + #dictCode")
    public SystemDictEntity findSingleDictionary(String typeCode, String dictCode) {
        Set<SystemDictEntity> systemDictEntitySet = retrieve.findDictionaryByType(typeCode);
        Optional<SystemDictEntity> optional = systemDictEntitySet.stream()
                .filter(dictionaryEntity -> ObjectUtil.equals(dictCode, dictionaryEntity.getDictCode()))
                .findFirst();
        return optional.orElse(null);
    }
}
