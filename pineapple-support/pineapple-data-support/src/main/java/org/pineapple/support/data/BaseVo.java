package org.pineapple.support.data;

import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.AbstractVo;

import java.util.StringJoiner;

/**
 * <p>基础Vo</p>
 *
 * @author guocq
 * @since 2023/2/9
 */
@Setter
@Getter
public abstract class BaseVo extends AbstractVo {
    private static final long serialVersionUID = -6979608806992927907L;
    /**
     * 数据创建时间
     */
    protected String addTime;

    /**
     * 数据修改时间
     */
    protected String editTime;

    public BaseVo() {
        super();
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", BaseVo.class.getSimpleName() + "[", "]")
                .add("addTime=" + addTime)
                .add("editTime=" + editTime)
                .toString();
    }
}
