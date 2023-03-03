package org.pineapple.common.enums;

/**
 * <p>结果通用枚举模型</p>
 *
 * @author guocq
 * @since 2023/1/31
 */
public interface ResultEnumModel extends BiEnumModel<Integer, String> {
    /**
     * <p>获取结果枚举信息内容</p>
     *
     * @return java.lang.String
     * @author guocq
     * @date 2023/1/31 15:37
     */
    String getMessage();

    /**
     * <p>获取枚举对应的说明</p>
     *
     * @return D 枚举说明
     * @author guocq
     * @date 2023/1/31 15:32
     */
    @Override
    default String getDesc() {
        return getMessage();
    }
}
