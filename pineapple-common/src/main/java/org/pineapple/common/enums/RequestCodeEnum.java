package org.pineapple.common.enums;

/**
 * <p>请求码枚举类</p>
 *
 * @author guocq
 * @since 2023/2/16
 */
public interface RequestCodeEnum extends BiEnumModel<String, String> {
    public static final RequestCodeEnum NULL_REQ_CODE = null;
    /**
     * <p>获取详情</p>
     *
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/2/16 19:05
     */
    default String getDetail() {
        return this.getDesc();
    }
}
