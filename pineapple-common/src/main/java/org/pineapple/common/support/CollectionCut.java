package org.pineapple.common.support;

import org.pineapple.common.NameInterface;

import java.util.Collection;
import java.util.List;

/**
 * <p>集合分割接口</p>
 *
 * @author guocq
 * @since 2023/3/22
 */
public interface CollectionCut<C extends Collection<E>, E> extends NameInterface {
    /**
     * <p>设置处理集合</p>
     *
     * @param collection 集合
     * @param cutLength  分割长度
     * @return {@link org.pineapple.common.support.CollectionCut }
     * @author guocq
     * @date 2023/3/22 11:30
     */
    CollectionCut<C, E> put(C collection, int cutLength);

    /**
     * <p>执行切割</p>
     *
     * @return {@link java.util.List<C> }
     * @author guocq
     * @date 2023/3/22 11:32
     */
    List<C> cut();
}
