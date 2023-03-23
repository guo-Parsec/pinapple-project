package org.pineapple.common.support.collcut;

import cn.hutool.core.collection.CollUtil;
import com.google.common.collect.Lists;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

/**
 * <p>list切割</p>
 *
 * @author guocq
 * @since 2023/3/22
 */
public class ListCut<E> implements CollectionCut<List<E>, E> {
    private static final Logger log = LoggerFactory.getLogger(ListCut.class);

    /**
     * 待处理集合
     */
    protected List<E> collection;

    /**
     * 切割长度
     */
    protected int cutLength;

    public ListCut() {
        this.collection = Lists.newArrayList();
    }

    public ListCut(List<E> collection) {
        this.collection = collection;
    }

    public ListCut(List<E> collection, int cutLength) {
        this.collection = collection;
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
    public CollectionCut<List<E>, E> put(List<E> collection, int cutLength) {
        this.collection = collection;
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
    public List<List<E>> cut() {
        final List<List<E>> cutResult = Lists.newArrayList();
        cutResult.add(this.collection);
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
                cutResult.add(this.collection.subList(startIndex, endIndex));
                continue;
            }
            cutResult.add(this.collection.subList(startIndex, size));
        }
        return cutResult;
    }
}
