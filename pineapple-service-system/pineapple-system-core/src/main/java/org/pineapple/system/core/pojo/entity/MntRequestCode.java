package org.pineapple.system.core.pojo.entity;

import com.google.common.base.Objects;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.support.durability.BaseEntity;

import java.util.StringJoiner;

/**
 * <p>维护请求码信息</p>
 *
 * @author guocq
 * @since 2023/2/16
 */
@Setter
@Getter
public class MntRequestCode extends BaseEntity {
    private static final long serialVersionUID = 8435702378884775168L;

    /**
     * 请求码名称
     */
    private String codeName;

    /**
     * 请求码值
     */
    private String codeVal;

    /**
     * 请求码说明
     */
    private String codeDetail;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        if (!super.equals(o)) {
            return false;
        }
        MntRequestCode that = (MntRequestCode) o;
        return Objects.equal(codeVal, that.codeVal);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(super.hashCode(), codeVal);
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", MntRequestCode.class.getSimpleName() + "[", "]")
                .add("codeName='" + codeName + "'")
                .add("codeVal='" + codeVal + "'")
                .add("codeDetail='" + codeDetail + "'")
                .add("addTime=" + addTime)
                .add("editTime=" + editTime)
                .add("id=" + id)
                .toString();
    }
}
