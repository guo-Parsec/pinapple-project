package org.pineapple.core.retrieve;

import org.apache.ibatis.annotations.Param;
import org.pineapple.common.entity.SystemParamEntity;
import org.springframework.stereotype.Repository;

import java.util.Set;

/**
 * <p>参数数据检索</p>
 *
 * @author guocq
 * @since 2023/3/16
 */
@Repository
public interface ParamRetrieve {
    /**
     * <p>根据参数码获取参数信息</p>
     *
     * @param paramCode 参数码
     * @return {@link java.util.Set< SystemParamEntity > }
     * @author guocq
     * @date 2023/3/16 9:16
     */
    Set<SystemParamEntity> findParamByParamCode(@Param("paramCode") String paramCode);
}
