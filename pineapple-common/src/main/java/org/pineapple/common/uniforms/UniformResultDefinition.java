package org.pineapple.common.uniforms;

import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.AbstractDomainModel;
import org.pineapple.common.enums.ResultEnumModel;
import org.pineapple.common.exceptions.ExceptionModel;
import org.pineapple.common.utils.ExceptionUtil;

import java.util.StringJoiner;

/**
 * <p>统一结果</p>
 *
 * @author guocq
 * @since 2023/1/31
 */
@Setter
@Getter
public class UniformResultDefinition<T> extends AbstractDomainModel {
    private static final long serialVersionUID = 3965804141138685302L;

    /**
     * 结果码
     */
    private Integer code;

    /**
     * 结果信息
     */
    private String message;

    /**
     * 结果数据
     */
    private T data;

    UniformResultDefinition() {
        super();
    }

    UniformResultDefinition(Integer code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    UniformResultDefinition(ResultEnumModel resultEnumModel) {
        this.code = resultEnumModel.getCode();
        this.message = resultEnumModel.getMessage();
    }

    UniformResultDefinition(ResultEnumModel resultEnumModel, T data) {
        this.code = resultEnumModel.getCode();
        this.message = resultEnumModel.getMessage();
        this.data = data;
    }

    UniformResultDefinition(ResultEnumModel resultEnumModel, String message) {
        this.code = resultEnumModel.getCode();
        this.message = message;
    }

    UniformResultDefinition(ExceptionModel exceptionModel) {
        this.code = exceptionModel.getCode();
        this.message = exceptionModel.getDesc();
    }

    UniformResultDefinition(Throwable cause) {
        this(ExceptionUtil.toModel(cause));
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", UniformResultDefinition.class.getSimpleName() + "[", "]")
                .add("code=" + code)
                .add("message='" + message + "'")
                .add("data=" + data)
                .toString();
    }

    /**
     * <p>简短对象信息转toString</p>
     *
     * @return java.lang.String
     * @author guocq
     * @date 2023/1/31 17:28
     */
    @Override
    public String simpleToString() {
        return new StringJoiner(", ", UniformResultDefinition.class.getSimpleName() + "[", "]")
                .add("code=" + code)
                .add("message='" + message + "'")
                .toString();
    }
}
