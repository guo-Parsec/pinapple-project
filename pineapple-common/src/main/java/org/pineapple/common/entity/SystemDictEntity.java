package org.pineapple.common.entity;

import com.google.common.base.Objects;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.AbstractDomainModel;

import java.util.StringJoiner;

/**
 * <p>数据字典实体</p>
 *
 * @author guocq
 * @since 2023/2/6
 */
@Setter
@Getter
public class SystemDictEntity extends AbstractDomainModel {
    private static final long serialVersionUID = 3609974062302364509L;

    /**
     * 数据字典类型码
     */
    private String typeCode;

    /**
     * 数据字典类型名
     */
    private String typeName;

    /**
     * 数据字典编码
     */
    private String dictCode;

    /**
     * 数据字典名称
     */
    private String dictName;

    /**
     * 数据字典排序
     */
    private Integer dictSort;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        SystemDictEntity that = (SystemDictEntity) o;
        return Objects.equal(typeCode, that.typeCode) && Objects.equal(dictCode, that.dictCode);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(typeCode, dictCode);
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", SystemDictEntity.class.getSimpleName() + "[", "]")
                .add("typeCode='" + typeCode + "'")
                .add("typeName='" + typeName + "'")
                .add("dictCode='" + dictCode + "'")
                .add("dictName='" + dictName + "'")
                .add("dictSort=" + dictSort)
                .toString();
    }
}
