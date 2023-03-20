package org.pineapple.core.converter;

import org.pineapple.common.BaseVo;
import org.pineapple.support.data.BaseEntity;

/**
 * <p>基础转换器</p>
 *
 * @author guocq
 * @since 2023/3/20
 */
public interface IConverter<E extends BaseEntity, V extends BaseVo> {
    /**
     * <p>实体对象转换为vo都西昂</p>
     *
     * @param entity 实体对象
     * @return {@link V }
     * @author guocq
     * @date 2023/3/20 13:52
     */
    V entityToVo(E entity);
}
