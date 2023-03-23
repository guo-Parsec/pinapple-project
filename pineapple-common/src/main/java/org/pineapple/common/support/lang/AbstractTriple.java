package org.pineapple.common.support.lang;

import cn.hutool.core.builder.CompareToBuilder;

import java.util.Objects;
import java.util.StringJoiner;

/**
 * <p>提供三元素对象</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
public abstract class AbstractTriple<L, M, R> implements Triple<L, M, R> {
    private static final long serialVersionUID = 4680153383136443115L;

    @Override
    public int compareTo(final Triple<L, M, R> other) {
        return new CompareToBuilder().append(getLeft(), other.getLeft())
                .append(getMiddle(), other.getMiddle())
                .append(getRight(), other.getRight()).toComparison();
    }

    @Override
    public boolean equals(final Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof Triple<?, ?, ?>) {
            final Triple<?, ?, ?> other = (Triple<?, ?, ?>) obj;
            return Objects.equals(getLeft(), other.getLeft())
                    && Objects.equals(getMiddle(), other.getMiddle())
                    && Objects.equals(getRight(), other.getRight());
        }
        return false;
    }

    @Override
    public int hashCode() {
        return (getLeft() == null ? 0 : getLeft().hashCode()) ^
                (getMiddle() == null ? 0 : getMiddle().hashCode()) ^
                (getRight() == null ? 0 : getRight().hashCode());
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", AbstractTriple.class.getSimpleName() + "[", "]")
                .add("left=" + getLeft())
                .add("middle=" + getMiddle())
                .add("right=" + getRight())
                .toString();
    }
}
