package org.pineapple.common.support.lang;

import lombok.Getter;

/**
 * <p>由三个Object元素组成的不可变三元组。
 * 虽然实现是不可变的，但对可以存储的对象没有限制。如果可变对象存储在三元组中，则三元组本身实际上变为可变的。该类也是final的，因此子类不能添加不良行为。
 * #ThreadSafe# 如果所有三个对象都是线程安全的</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
public final class ImmutableTriple<L, M, R> extends AbstractTriple<L, M, R> {
    private static final long serialVersionUID = 2567052812135582808L;

    @SuppressWarnings("rawtypes")
    private static final ImmutableTriple NULL = of(null, null, null);


    @SuppressWarnings("unchecked")
    public static <L, M, R> ImmutableTriple<L, M, R> nullTriple() {
        return NULL;
    }

    /**
     * Left object
     */
    @Getter
    public final L left;

    /**
     * Middle object
     */
    @Getter
    public final M middle;

    /**
     * Right object
     */
    @Getter
    public final R right;

    public ImmutableTriple(final L left, final M middle, final R right) {
        super();
        this.left = left;
        this.middle = middle;
        this.right = right;
    }

    public static <L, M, R> ImmutableTriple<L, M, R> of(final L left, final M middle, final R right) {
        return new ImmutableTriple<>(left, middle, right);
    }
}
