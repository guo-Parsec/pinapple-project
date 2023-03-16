package org.pineapple.common.entity;

import com.google.common.base.Objects;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.AbstractDomainModel;

import java.util.StringJoiner;

/**
 * <p>系统参数实体</p>
 *
 * @author guocq
 * @since 2023/3/16
 */
@Setter
@Getter
public class SystemParamEntity extends AbstractDomainModel {
    private static final long serialVersionUID = -1919981484020807001L;

    /**
     * 参数分组编码
     */
    private String groupCode;

    /**
     * 参数编码
     */
    private String paramCode;

    /**
     * 参数名称
     */
    private String paramName;

    /**
     * 参数描述
     */
    private String paramDesc;

    /**
     * 参数排序
     */
    private Integer paramSort;

    /**
     * 参数值
     */
    private String paramValue;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        SystemParamEntity that = (SystemParamEntity) o;
        return Objects.equal(paramCode, that.paramCode);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(paramCode);
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", SystemParamEntity.class.getSimpleName() + "[", "]")
                .add("groupCode='" + groupCode + "'")
                .add("paramCode='" + paramCode + "'")
                .add("paramName='" + paramName + "'")
                .add("paramDesc='" + paramDesc + "'")
                .add("paramSort=" + paramSort)
                .add("paramValue='" + paramValue + "'")
                .toString();
    }
}
