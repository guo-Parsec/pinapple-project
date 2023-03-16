package org.pineapple.common.utils;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;

/**
 * <p>序列号工具类</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
public class SerialNumberUtil {
    /**
     * <p>生成业务序列号</p>
     *
     * @param biz 业务
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 15:35
     */
    public static String generateBizSerialNumber(String biz) {
        String uuid = IdUtil.fastSimpleUUID();
        return StrUtil.isBlank(biz) ? uuid : biz + uuid;
    }

    /**
     * <p>校验业务序列号</p>
     *
     * @param biz             业务代码
     * @param bizSerialNumber 业务序列号
     * @return {@link boolean }
     * @author guocq
     * @date 2023/3/15 17:07
     */
    public static boolean validateBizSerialNumber(String biz, String bizSerialNumber) {
        if (StrUtil.isBlank(bizSerialNumber)) {
            return false;
        }
        if (StrUtil.isBlank(biz)) {
            return true;
        }
        return bizSerialNumber.startsWith(biz);
    }
}
