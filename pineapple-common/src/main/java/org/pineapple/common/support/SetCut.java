package org.pineapple.common.support;

import cn.hutool.core.collection.CollUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Set;

/**
 * <p>set切割</p>
 *
 * @author guocq
 * @since 2023/3/22
 */
public class SetCut<E> implements CollectionCut<Set<E>, E> {
    private static final Logger log = LoggerFactory.getLogger(SetCut.class);
    /**
     * 待处理集合
     */
    protected List<E> collection;

    /**
     * 切割长度
     */
    protected int cutLength;

    public SetCut() {
    }

    public SetCut(Set<E> collection) {
        this.collection = Lists.newArrayList(collection);
    }

    public SetCut(Set<E> collection, int cutLength) {
        this.collection = Lists.newArrayList(collection);
        this.cutLength = cutLength;
    }

    /**
     * <p>设置处理集合</p>
     *
     * @param collection 集合
     * @param cutLength  分割长度
     * @return {@link CollectionCut }
     * @author guocq
     * @date 2023/3/22 11:30
     */
    @Override
    public CollectionCut<Set<E>, E> put(Set<E> collection, int cutLength) {
        this.collection = Lists.newArrayList(collection);
        this.cutLength = cutLength;
        return this;
    }

    /**
     * <p>执行切割</p>
     *
     * @return {@link List }
     * @author guocq
     * @date 2023/3/22 11:32
     */
    @Override
    public List<Set<E>> cut() {
        final List<Set<E>> cutResult = Lists.newArrayList();
        cutResult.add(Sets.newHashSet(this.collection));
        if (CollUtil.isEmpty(this.collection) || this.cutLength <= 0) {
            log.warn("[{}]输入参数有误,将返回原始集合", this.name());
            return cutResult;
        }
        int size = this.collection.size();
        if (size <= this.cutLength) {
            log.warn("[{}]集合大小[size={}]未能大于切割长度[cutLength={}],将返回原始集合", this.name(), size, this.cutLength);
            return cutResult;
        }
        cutResult.clear();
        int div = size / this.cutLength;
        int cutCount = size % this.cutLength == 0 ? div : div + 1;
        for (int i = 0, startIndex = 0; i < cutCount; startIndex = (++i) * this.cutLength) {
            int endIndex = startIndex + this.cutLength;
            if (endIndex < size) {
                cutResult.add(Sets.newHashSet(this.collection.subList(startIndex, endIndex)));
                continue;
            }
            cutResult.add(Sets.newHashSet(this.collection.subList(startIndex, size)));
        }
        return cutResult;
    }
}
