package org.pineapple.core.facade.impl;

import cn.hutool.core.util.ObjectUtil;
import org.pineapple.common.define.DictionaryDefine;
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
     * @param dictVal  数据字典值
     * @return {@link DictionaryDefine }
     * @author guocq
     * @date 2023/2/8 14:30
     */
    @Override
    public DictionaryDefine findSingleDictionary(String typeCode, Integer dictVal) {
        Set<DictionaryDefine> dictionaryDefineSet = retrieve.findDictionaryByType(typeCode);
        Optional<DictionaryDefine> optional = dictionaryDefineSet.stream()
                .filter(dictionaryEntity -> ObjectUtil.equals(dictVal, dictionaryEntity.getDictVal()))
                .findFirst();
        return optional.orElse(null);
    }
}
