package org.pineapple.common.valid;

import cn.hutool.core.util.ArrayUtil;
import lombok.Getter;
import lombok.Setter;

import java.util.StringJoiner;

/**
 * <p>字段校验结果</p>
 *
 * @author guocq
 * @since 2023/3/21
 */
@Setter
@Getter
public class FieldValidateResult implements ValidateResult {
    /**
     * 是否校验成功
     */
    private boolean pass;

    /**
     * 字段名称
     */
    private String fieldName;

    /**
     * 校验失败原因
     */
    private String failedReason;

    private FieldValidateResult(boolean pass) {
        this.pass = pass;
    }

    private FieldValidateResult(boolean pass, String fieldName, String failedReason) {
        this.pass = pass;
        this.fieldName = fieldName;
        this.failedReason = failedReason;
    }

    public static FieldValidateResult validateFailed(String fieldName, String failedReason) {
        return new FieldValidateResult(false, fieldName, failedReason);
    }

    public static FieldValidateResult validateSuccess() {
        return new FieldValidateResult(true);
    }

    /**
     * <p>任意属性为空的校验</p>
     *
     * @param willValidateProperties 待校验的属性
     * @return {@link ValidateResult }
     * @author guocq
     * @date 2023/3/21 13:58
     */
    public static ValidateResult anyBlankValidate(Object... willValidateProperties) {
        if (ArrayUtil.isEmpty(willValidateProperties)) {
            return validateSuccess();
        }
        ValidateResult result = null;
//        Arrays.stream(willValidateProperties).forEach(properties -> {
//            if (properties instanceof CharSequence && StrUtil.isBlank((CharSequence) properties)) {
//                result = validateFailed()
//            }
////            if (ObjectUtil.hasEmpty(properties))
//        });
        return null;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", FieldValidateResult.class.getSimpleName() + "[", "]")
                .add("pass=" + pass)
                .add("fieldName='" + fieldName + "'")
                .add("failedReason='" + failedReason + "'")
                .toString();
    }
}
