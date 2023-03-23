package org.pineapple.common.support.keyjoin;

import org.pineapple.common.constant.CommonConstant;

/**
 * <p>redis键拼接类</p>
 *
 * @author guocq
 * @since 2023/3/15
 */
public class RedisKeyJoin extends DefaultKeyJoin {
    public RedisKeyJoin() {
        super(CommonConstant.COLON);
    }
}
