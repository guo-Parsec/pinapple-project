package org.pineapple.engine.basequery.facade;

import org.pineapple.engine.basequery.entity.SystemDictEntity;

/**
 * <p>数据字典Facade</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
public interface SystemDictFacade {
    /**
     * <p>根据{@code typeCode}和{@code dictVal}查询单条数据字典数据</p>
     *
     * @param typeCode 数据字典类型码
     * @param dictCode 数据字典值
     * @return {@link SystemDictEntity }
     * @author guocq
     * @date 2023/2/8 14:30
     */
    SystemDictEntity findSingleDictionary(String typeCode, String dictCode);
}
