package org.pineapple.core.retrieve;

import org.pineapple.common.entity.SystemDictEntity;
import org.springframework.stereotype.Repository;

import java.util.Set;

/**
 * <p>字典数据检索</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
@Repository
public interface SystemDictRetrieve {
    /**
     * <p>根据数据字典类型码{@code typeCode}查询字典数据</p>
     *
     * @param typeCode 数据字典类型码
     * @return {@link java.util.Set }
     * @author guocq
     * @date 2023/2/8 13:41
     */
    Set<SystemDictEntity> findDictionaryByType(String typeCode);
}
