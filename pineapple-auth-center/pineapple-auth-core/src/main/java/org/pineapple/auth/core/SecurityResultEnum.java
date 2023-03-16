package org.pineapple.auth.core;

import lombok.Getter;
import org.pineapple.common.enums.ResultEnumModel;

/**
 * <p>安全结果枚举</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
public enum SecurityResultEnum implements ResultEnumModel {
    NOT_FOUND_USER(5002001, "用户不存在"),
    PASSWORD_ERROR(5002002, "密码错误"),
    ;

    @Getter
    private final Integer code;
    @Getter
    private final String message;

    SecurityResultEnum() {
        this.code = 500;
        this.message = "系统操作失败";
    }

    SecurityResultEnum(Integer code) {
        this.code = code;
        this.message = "系统操作失败";
    }

    SecurityResultEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }
}
