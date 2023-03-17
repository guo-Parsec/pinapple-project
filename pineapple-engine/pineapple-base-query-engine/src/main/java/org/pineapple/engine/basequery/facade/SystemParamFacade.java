package org.pineapple.engine.basequery.facade;

import org.pineapple.engine.basequery.entity.SystemParamEntity;

/**
 * <p>系统参数Facade</p>
 *
 * @author guocq
 * @since 2023/3/16
 */
public interface SystemParamFacade {
    /**
     * <p>根据参数编码{@code paramCode}获取系统参数</p>
     *
     * @param paramCode 参数编码
     * @return {@link SystemParamEntity }
     * @author guocq
     * @date 2023/3/16 11:54
     */
    SystemParamEntity findParamByParamCode(String paramCode);
}
