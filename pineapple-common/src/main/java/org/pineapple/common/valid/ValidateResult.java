package org.pineapple.common.valid;

/**
 * <p>校验结果</p>
 *
 * @author guocq
 * @since 2023/3/21
 */
public interface ValidateResult {
    /**
     * <p>是否通过校验</p>
     *
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/21 13:43
     */
    boolean isPass();

    /**
     * <p>获取校验失败原因</p>
     *
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/21 13:43
     */
    String getFailedReason();
}
