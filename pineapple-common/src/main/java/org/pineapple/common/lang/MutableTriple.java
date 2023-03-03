package org.pineapple.common.lang;

import lombok.Getter;
import lombok.Setter;

/**
 * <p>由三个Object元素组成的可变三元组</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
public class MutableTriple<L, M, R> extends AbstractTriple<L, M, R> {
    private static final long serialVersionUID = -4425376627480508018L;

    @Setter
    @Getter
    public L left;

    @Setter
    @Getter
    public M middle;

    @Setter
    @Getter
    public R right;

    public MutableTriple() {
        super();
    }

    public MutableTriple(final L left, final M middle, final R right) {
        super();
        this.left = left;
        this.middle = middle;
        this.right = right;
    }

    public static <L, M, R> MutableTriple<L, M, R> of(final L left, final M middle, final R right) {
        return new MutableTriple<>(left, middle, right);
    }
}
