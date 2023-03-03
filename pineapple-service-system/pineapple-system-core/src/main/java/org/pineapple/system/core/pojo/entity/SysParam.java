package org.pineapple.system.core.pojo.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.support.durability.BaseEntity;

import java.util.StringJoiner;

/**
 * <p>系统参数</p>
 *
 * @author guocq
 * @since 2023/2/16
 */
@Getter
@Setter
@TableName(value = "sys_param", schema = "system")
public class SysParam extends BaseEntity {
    private static final long serialVersionUID = 1982906133236203433L;
    /**
     * 分组标识
     */
    private String groupCode;

    /**
     * 参数标识
     */
    private String paramCode;

    /**
     * 参数名称
     */
    private String paramName;

    /**
     * 参数值
     */
    private String paramValue;

    /**
     * 参数描述
     */
    private String paramDesc;

    /**
     * 参数排序
     */
    private Integer paramSort;

    @Override
    public String toString() {
        return new StringJoiner(", ", SysParam.class.getSimpleName() + "[", "]")
                .add("groupCode='" + groupCode + "'")
                .add("paramCode='" + paramCode + "'")
                .add("paramName='" + paramName + "'")
                .add("paramValue='" + paramValue + "'")
                .add("paramDesc='" + paramDesc + "'")
                .add("paramSort=" + paramSort)
                .add("addTime=" + addTime)
                .add("editTime=" + editTime)
                .add("id=" + id)
                .toString();
    }
}
