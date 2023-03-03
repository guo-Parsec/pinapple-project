package org.pineapple.common.enums;

import java.io.Serializable;

/**
 * <p>二元枚举模型</p>
 *
 * @author guocq
 * @since 2023/1/31
 */
public interface BiEnumModel<C extends Serializable, D extends Serializable> extends EnumModel {
    /**
     * <p>获取枚举对应的值</p>
     *
     * @return C 枚举值
     * @author guocq
     * @date 2023/1/31 15:32
     */
    C getCode();

    /**
     * <p>获取枚举对应的说明</p>
     *
     * @return D 枚举说明
     * @author guocq
     * @date 2023/1/31 15:32
     */
    D getDesc();
}
