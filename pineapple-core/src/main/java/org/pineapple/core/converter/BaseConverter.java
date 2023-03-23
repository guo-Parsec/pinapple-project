package org.pineapple.core.converter;

import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.util.ReflectUtil;
import com.baomidou.mybatisplus.core.toolkit.ReflectionKit;
import org.pineapple.common.pojo.vo.BaseVo;
import org.pineapple.engine.basequery.annotations.DictConverter;
import org.pineapple.support.data.BaseEntity;

/**
 * <p>基础转换器抽象类</p>
 *
 * @author guocq
 * @since 2023/3/20
 */
@DictConverter
public abstract class BaseConverter<E extends BaseEntity, V extends BaseVo> implements IConverter<E, V> {
    protected Class<E> entityClass = currentEntityClass();

    protected Class<V> voClass = currentVoClass();

    @SuppressWarnings("unchecked")
    protected Class<E> currentEntityClass() {
        return (Class<E>) ReflectionKit.getSuperClassGenericType(this.getClass(), BaseEntity.class, 0);
    }

    @SuppressWarnings("unchecked")
    protected Class<V> currentVoClass() {
        return (Class<V>) ReflectionKit.getSuperClassGenericType(this.getClass(), BaseVo.class, 1);
    }

    /**
     * <p>实体对象转换为vo</p>
     *
     * @param entity 实体对象
     * @return {@link V }
     * @author guocq
     * @date 2023/3/20 13:52
     */
    @Override
    public V entityToVo(E entity) {
        V vo = ReflectUtil.newInstanceIfPossible(voClass);
        vo.setAddTime(LocalDateTimeUtil.formatNormal(entity.getAddTime()));
        vo.setEditTime(LocalDateTimeUtil.formatNormal(entity.getEditTime()));
        return vo;
    }

    /**
     * <p>实体对象转换为vo</p>
     *
     * @param entity 实体对象
     * @param vo     vo对象
     * @return {@link V }
     * @author guocq
     * @date 2023/3/20 14:28
     */
    protected V entityToVo(E entity, V vo) {
        if (vo == null) {
            return this.entityToVo(entity);
        }
        vo.setAddTime(LocalDateTimeUtil.formatNormal(entity.getAddTime()));
        vo.setEditTime(LocalDateTimeUtil.formatNormal(entity.getEditTime()));
        return vo;
    }
}
