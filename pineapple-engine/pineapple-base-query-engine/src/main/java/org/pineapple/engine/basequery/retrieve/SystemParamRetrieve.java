package org.pineapple.engine.basequery.retrieve;

import org.apache.ibatis.annotations.Param;
import org.pineapple.engine.basequery.entity.SystemParamEntity;
import org.springframework.stereotype.Repository;

/**
 * <p>参数数据检索</p>
 *
 * @author guocq
 * @since 2023/3/16
 */
@Repository
public interface SystemParamRetrieve {
    /**
     * <p>根据参数码获取参数信息</p>
     *
     * @param paramCode 参数码
     * @return {@link java.util.Set< SystemParamEntity > }
     * @author guocq
     * @date 2023/3/16 9:16
     */
    SystemParamEntity findParamByParamCode(@Param("paramCode") String paramCode);
}
