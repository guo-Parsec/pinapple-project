package org.pineapple.system.core.pojo.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.support.data.BaseEntity;

import java.util.StringJoiner;

/**
 * <p>系统字典</p>
 *
 * @author guocq
 * @since 2023/2/9
 */
@Getter
@Setter
@TableName(value = "sys_dict", schema = "system")
public class SysDict extends BaseEntity {
    private static final long serialVersionUID = 26754567054180319L;
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
    private String dictCode;

    /**
     * 数据字典显示
     */
    private String dictName;

    /**
     * 数据字典排序值
     */
    private Integer dictSort;

    @Override
    public String toString() {
        return new StringJoiner(", ", SysDict.class.getSimpleName() + "[", "]")
                .add("id=" + id)
                .add("addTime=" + addTime)
                .add("editTime=" + editTime)
                .add("typeCode='" + typeCode + "'")
                .add("typeName='" + typeName + "'")
                .add("dictVal=" + dictCode)
                .add("dictName='" + dictName + "'")
                .add("dictSort=" + dictSort)
                .toString();
    }
}