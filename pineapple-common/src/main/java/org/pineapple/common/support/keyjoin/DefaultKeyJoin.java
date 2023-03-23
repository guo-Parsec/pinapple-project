package org.pineapple.common.support.keyjoin;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.google.common.collect.Lists;
import lombok.Getter;
import org.pineapple.common.enums.KeyCase;
import org.pineapple.common.support.error.ErrorRecords;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Locale;
import java.util.StringJoiner;
import java.util.stream.Collectors;

/**
 * <p>默认键拼接类</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
public class DefaultKeyJoin implements KeyJoin {
    private static final Logger log = LoggerFactory.getLogger(DefaultKeyJoin.class);

    /**
     * 拼接定界符
     */
    @Getter
    private final CharSequence delimiter;

    /**
     * 键集合
     */
    @Getter
    protected final List<String> keys;

    public DefaultKeyJoin(CharSequence delimiter) {
        if (StrUtil.isBlank(delimiter)) {
            throw ErrorRecords.valid.record(log, "键拼接[{}]初始化拼接定界符[delimiter={}]不能为空", name(), delimiter);
        }
        this.delimiter = delimiter;
        this.keys = Lists.newLinkedList();
        log.trace("键拼接[{}]初始化拼接定界符[delimiter]为[delimiter=`{}`]", name(), delimiter);
    }

    /**
     * <p>添加新的key</p>
     *
     * @param key 键
     * @return {@link DefaultKeyJoin }
     * @author guocq
     * @date 2023/3/15 9:24
     */
    @Override
    public DefaultKeyJoin join(String key, boolean isAllowRepeat) {
        if (!isAllowRepeat && keys.contains(key)) {
            log.warn("键拼接[{}]添加新键[key={}]时不允许重复，当前键[{}]将不会加入列表中", name(), key, key);
            return this;
        }
        this.keys.add(key);
        return this;
    }

    /**
     * <p>组装构建最终结果</p>
     *
     * @param keyCase key大小写类型
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 9:23
     */
    @Override
    public String build(KeyCase keyCase) {
        if (keyCase == null) {
            log.warn("键拼接[{}]构建时,键大小写类型[keyCase]为null,系统默认采用[RAW]模式", name());
            keyCase = KeyCase.RAW;
        }
        log.trace("键拼接[{}]开始构建, 采用的键大小写类型[keyCase]为[{}],当前构建对象为{}", name(), keyCase.name(), this);
        String buildResult = StrUtil.EMPTY;
        if (CollUtil.isEmpty(this.keys)) {
            log.warn("键拼接[{}]构建完成,待拼接的键列表集合[keys={}]为空, 最终构建结果为[{}]", name(), this.keys, buildResult);
            return buildResult;
        }
        if (keyCase.equals(KeyCase.RAW)) {
            buildResult = StrUtil.join(this.delimiter, this.keys);
            log.trace("键拼接[{}]构建完成,采用的keyCase模式为[RAW], 最终构建结果为[{}]", name(), buildResult);
            return buildResult;
        }
        boolean toUpperCase = keyCase.equals(KeyCase.UPPER);
        buildResult = this.keys.stream()
                .map(key -> toUpperCase ? key.toUpperCase(Locale.ROOT) : key.toLowerCase(Locale.ROOT))
                .collect(Collectors.joining(this.delimiter));
        log.trace("键拼接[{}]构建完成,采用的keyCase模式为[{}], 最终构建结果为[{}]", name(), keyCase.name(), buildResult);
        return buildResult;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", DefaultKeyJoin.class.getSimpleName() + "[", "]")
                .add("delimiter=" + delimiter)
                .add("keys=" + keys)
                .toString();
    }
}
