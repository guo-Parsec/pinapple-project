package org.pineapple.support.durability;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.StringJoiner;

/**
 * <p>基础实体类</p>
 *
 * @author guocq
 * @since 2023/2/7
 */
@Setter
@Getter
public abstract class BaseEntity extends AbstractEntity {
    private static final long serialVersionUID = 5019387567862071825L;

    /**
     * 数据创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    protected LocalDateTime addTime;

    /**
     * 数据修改时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    protected LocalDateTime editTime;

    public BaseEntity() {
        super();
    }

    public BaseEntity(Long id) {
        super(id);
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", BaseEntity.class.getSimpleName() + "[", "]")
                .add("id=" + id)
                .add("addTime=" + addTime)
                .add("editTime=" + editTime)
                .toString();
    }
}
