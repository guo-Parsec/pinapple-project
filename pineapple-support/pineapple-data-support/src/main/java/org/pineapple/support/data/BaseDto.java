package org.pineapple.support.data;

import com.google.common.base.Objects;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.pojo.dto.AbstractDto;
import org.pineapple.common.support.valid.CurdValidateGroup;
import org.pineapple.common.support.valid.FieldValidateResult;

import javax.validation.constraints.NotNull;
import java.util.StringJoiner;

/**
 * <p>基础参数抽象类</p>
 *
 * @author guocq
 * @since 2023/2/16
 */
@Setter
@Getter
public abstract class BaseDto extends AbstractDto {
    private static final long serialVersionUID = 673186599240587558L;

    /**
     * 主键
     */
    @NotNull(message = "主键不能为空", groups = {CurdValidateGroup.Edit.class})
    protected Long id;

    /**
     * <p>校验结果</p>
     *
     * @return {@link FieldValidateResult }
     * @author guocq
     * @date 2023/3/21 13:48
     */
    public FieldValidateResult beforeCreateValidate() {
        return FieldValidateResult.validateSuccess();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        BaseDto baseDto = (BaseDto) o;
        return Objects.equal(id, baseDto.id);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(id);
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", BaseDto.class.getSimpleName() + "[", "]")
                .add("id=" + id)
                .toString();
    }
}
