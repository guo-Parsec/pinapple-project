package org.pineapple.common.support;

import org.pineapple.common.constant.CommonConstant;
import org.pineapple.common.enums.KeyCase;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.StringJoiner;

/**
 * <p>通用redis键拼接类</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
public class BasicRedisKeyJoin extends RedisKeyJoin {
    private static final Logger log = LoggerFactory.getLogger(BasicRedisKeyJoin.class);

    /**
     * 是否向尾部添加占位符{@link CommonConstant#PLACEHOLDER}
     */
    private final boolean isTailPlaceholder;

    public BasicRedisKeyJoin() {
        this(true);
    }

    public BasicRedisKeyJoin(boolean isTailPlaceholder) {
        this(true, isTailPlaceholder);
    }

    public BasicRedisKeyJoin(boolean isJoinRedisKeyPrefix, boolean isTailPlaceholder) {
        super();
        this.isTailPlaceholder = isTailPlaceholder;
        if (isJoinRedisKeyPrefix) {
            log.trace("键拼接[{}]初始化时会自动向头部添加默认键[{}]", this.name(), CommonConstant.REDIS_KEY_PREFIX);
            super.keys.add(CommonConstant.REDIS_KEY_PREFIX);
        }
    }

    /**
     * <p>组装构建最终结果</p>
     *
     * @param keyCase key大小写类型
     * @return {@link String }
     * @author guocq
     * @date 2023/3/15 9:23
     */
    @Override
    public String build(KeyCase keyCase) {
        if (this.isTailPlaceholder) {
            log.trace("键拼接[{}]构建时会默认向尾部添加占位符[{}]", name(), CommonConstant.PLACEHOLDER);
            super.keys.add(CommonConstant.PLACEHOLDER);
        }
        return super.build(keyCase);
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", BasicRedisKeyJoin.class.getSimpleName() + "[", "]")
                .add("delimiter=" + this.getDelimiter())
                .add("isTailPlaceholder=" + isTailPlaceholder)
                .add("keys=" + keys)
                .toString();
    }
}
