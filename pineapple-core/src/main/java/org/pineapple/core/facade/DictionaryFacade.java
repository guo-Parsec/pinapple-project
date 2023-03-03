package org.pineapple.core.facade;

import org.pineapple.common.define.DictionaryDefine;

/**
 * <p>数据字典Facade</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
public interface DictionaryFacade {
    /**
     * <p>根据{@code typeCode}和{@code dictVal}查询单条数据字典数据</p>
     *
     * @param typeCode 数据字典类型码
     * @param dictVal  数据字典值
     * @return {@link DictionaryDefine }
     * @author guocq
     * @date 2023/2/8 14:30
     */
    DictionaryDefine findSingleDictionary(String typeCode, Integer dictVal);
}
