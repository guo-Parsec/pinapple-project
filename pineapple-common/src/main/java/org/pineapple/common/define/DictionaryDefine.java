package org.pineapple.common.define;

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
public class DictionaryDefine extends AbstractDomainModel {
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
     * 数据字典值
     */
    private Integer dictVal;

    /**
     * 数据字典显示名称
     */
    private String display;

    /**
     * 数据字典排序
     */
    private Integer sort;

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        DictionaryDefine that = (DictionaryDefine) o;
        return Objects.equal(typeCode, that.typeCode) && Objects.equal(dictVal, that.dictVal);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(typeCode, dictVal);
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", DictionaryDefine.class.getSimpleName() + "[", "]")
                .add("typeCode='" + typeCode + "'")
                .add("dictVal=" + dictVal)
                .add("display='" + display + "'")
                .toString();
    }
}
