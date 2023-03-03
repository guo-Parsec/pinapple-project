package org.pineapple.support.durability.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.pineapple.support.durability.AbstractEntity;

/**
 * <p>通用repository接口</p>
 *
 * @author guocq
 * @since 2023/2/7
 */
public interface IMapper<T extends AbstractEntity> extends BaseMapper<T> {
}
