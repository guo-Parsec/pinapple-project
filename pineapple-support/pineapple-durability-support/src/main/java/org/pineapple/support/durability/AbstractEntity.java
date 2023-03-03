package org.pineapple.support.durability;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.google.common.base.Objects;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.AbstractDomainModel;

/**
 * <p>抽象实体类</p>
 *
 * @author guocq
 * @since 2023/2/7
 */
@Setter
@Getter
public abstract class AbstractEntity extends AbstractDomainModel {
    private static final long serialVersionUID = -7447998157498188146L;

    /**
     * id主键
     */
    @Setter
    @Getter
    @TableId(type = IdType.ASSIGN_ID)
    protected Long id;


    public AbstractEntity() {
    }

    public AbstractEntity(Long id) {
        this.id = id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        AbstractEntity that = (AbstractEntity) o;
        return Objects.equal(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(id);
    }
}
