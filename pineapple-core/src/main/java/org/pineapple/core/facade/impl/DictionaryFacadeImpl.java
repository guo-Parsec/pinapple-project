package org.pineapple.core.facade.impl;

import cn.hutool.core.util.ObjectUtil;
import org.pineapple.common.entity.SystemDictEntity;
import org.pineapple.core.facade.DictionaryFacade;
import org.pineapple.core.retrieve.DictionaryRetrieve;
import org.springframework.stereotype.Component;

import java.util.Optional;
import java.util.Set;

/**
 * <p>数据字典Facade实现类</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
@Component(value = "dictionaryFacade")
public class DictionaryFacadeImpl implements DictionaryFacade {
    private final DictionaryRetrieve retrieve;

    public DictionaryFacadeImpl(DictionaryRetrieve retrieve) {
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
    public SystemDictEntity findSingleDictionary(String typeCode, String dictCode) {
        Set<SystemDictEntity> systemDictEntitySet = retrieve.findDictionaryByType(typeCode);
        Optional<SystemDictEntity> optional = systemDictEntitySet.stream()
                .filter(dictionaryEntity -> ObjectUtil.equals(dictCode, dictionaryEntity.getDictCode()))
                .findFirst();
        return optional.orElse(null);
    }
}
