package org.pineapple.system.core.pojo.vo;

import lombok.Getter;
import lombok.Setter;
import org.pineapple.support.data.BaseVo;

import java.util.StringJoiner;

/**
 * <p>基础数据展示层</p>
 *
 * @author guocq
 * @since 2023/2/9
 */
@Setter
@Getter
public class SysDictVo extends BaseVo {
    private static final long serialVersionUID = 6705554841452206642L;
    /**
     * 主键id
     */
    private String id;

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
        return new StringJoiner(", ", SysDictVo.class.getSimpleName() + "[", "]")
                .add("id='" + id + "'")
                .add("typeCode='" + typeCode + "'")
                .add("typeName='" + typeName + "'")
                .add("dictCode='" + dictCode + "'")
                .add("dictName='" + dictName + "'")
                .add("dictSort=" + dictSort)
                .add("addTime='" + addTime + "'")
                .add("editTime='" + editTime + "'")
                .toString();
    }
}
