package org.pineapple.common.support.lang;

import java.io.Serializable;

/**
 * <p>提供三元素对象</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
public interface Triple<L, M, R> extends Comparable<Triple<L, M, R>>, Serializable {
    /**
     * <p>获取左侧元素</p>
     *
     * @return {@link L }
     * @author guocq
     * @date 2023/2/8 17:06
     */
    L getLeft();

    /**
     * <p>获取中间元素</p>
     *
     * @return {@link L }
     * @author guocq
     * @date 2023/2/8 17:06
     */
    M getMiddle();

    /**
     * <p>获取右侧元素</p>
     *
     * @return {@link L }
     * @author guocq
     * @date 2023/2/8 17:06
     */
    R getRight();
}
