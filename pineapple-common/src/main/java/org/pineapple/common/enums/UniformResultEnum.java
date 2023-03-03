package org.pineapple.common.enums;

import lombok.Getter;

/**
 * <p>结果枚举</p>
 *
 * @author guocq
 * @since 2023/1/31
 */
public enum UniformResultEnum implements ResultEnumModel {
    /**
     * 操作成功
     */
    SUCCESS(200, "操作成功"),

    /**
     * 校验失败
     */
    VALID_ERROR(4001000, "校验失败"),

    /**
     * 资源未经授权
     */
    UNAUTHORIZED(5001000, "资源未经授权"),

    /**
     * 操作失败
     */
    ERROR;
    
    @Getter
    private final Integer code;
    @Getter
    private final String message;

    UniformResultEnum() {
        this.code = 500;
        this.message = "系统操作失败";
    }

    UniformResultEnum(Integer code) {
        this.code = code;
        this.message = "系统操作失败";
    }

    UniformResultEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }
}
