package org.pineapple.common.support;

import org.pineapple.common.enums.KeyCase;

import java.util.List;

/**
 * <p>键拼接接口</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
public interface KeyJoin {
    /**
     * <p>键拼接名称</p>
     *
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 9:28
     */
    default String name() {
        return this.getClass().getSimpleName();
    }

    /**
     * <p>添加新的key</p>
     *
     * @param key           键
     * @param isAllowRepeat 是否允许重复
     * @return {@link DefaultKeyJoin }
     * @author guocq
     * @date 2023/3/15 9:24
     */
    KeyJoin join(String key, boolean isAllowRepeat);

    /**
     * <p>添加新的key, 不允许重复</p>
     *
     * @param key 键
     * @return {@link DefaultKeyJoin }
     * @author guocq
     * @date 2023/3/15 9:24
     */
    default KeyJoin join(String key) {
        return join(key, false);
    }

    /**
     * <p>组装构建最终结果</p>
     *
     * @param keyCase key大小写类型
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 9:23
     */
    String build(KeyCase keyCase);

    /**
     * <p>组装构建最终结果,采用RAW模式</p>
     *
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 9:23
     */
    default String build() {
        return build(KeyCase.RAW);
    }

    /**
     * <p>获取拼接定界符</p>
     *
     * @return {@link CharSequence }
     * @author guocq
     * @date 2023/3/15 9:31
     */
    CharSequence getDelimiter();

    /**
     * <p>获取键列表集合</p>
     *
     * @return {@link java.util.List<java.lang.String> }
     * @author guocq
     * @date 2023/3/15 9:31
     */
    List<String> getKeys();
}
