package org.pineapple.core.facade.impl;

import org.pineapple.common.annotations.NotBlank;
import org.pineapple.common.annotations.Valid;
import org.pineapple.common.annotations.Validator;
import org.pineapple.common.entity.SystemParamEntity;
import org.pineapple.core.facade.SystemParamFacade;
import org.pineapple.core.retrieve.SystemParamRetrieve;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * <p>系统参数Facade实现类</p>
 *
 * @author guocq
 * @since 2023/3/16
 */
@Validator
@Component(value = "systemParamFacade")
public class SystemParamFacadeImpl implements SystemParamFacade {
    private static final Logger log = LoggerFactory.getLogger(SystemParamFacadeImpl.class);

    private final SystemParamRetrieve systemParamRetrieve;

    public SystemParamFacadeImpl(SystemParamRetrieve systemParamRetrieve) {
        this.systemParamRetrieve = systemParamRetrieve;
    }

    /**
     * <p>根据参数编码{@code paramCode}获取系统参数</p>
     *
     * @param paramCode 参数编码
     * @return {@link SystemParamEntity }
     * @author guocq
     * @date 2023/3/16 11:54
     */
    @Valid(notBlank = @NotBlank(value = "#paramCode", message = "参数编码不能为空"))
    @Override
    public SystemParamEntity findParamByParamCode(String paramCode) {
        log.debug("根据参数编码[paramCode={}]获取系统参数开始", paramCode);
        SystemParamEntity systemParamEntity = systemParamRetrieve.findParamByParamCode(paramCode);
        log.debug("根据参数编码[paramCode={}]获取系统参数为[systemParamEntity={}]", paramCode, systemParamEntity);
        return systemParamEntity;
    }
}
