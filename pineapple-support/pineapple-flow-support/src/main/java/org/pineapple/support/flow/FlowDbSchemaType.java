package org.pineapple.support.flow;

import lombok.Getter;
import org.flowable.engine.ProcessEngineConfiguration;
import org.pineapple.common.enums.EnumModel;

/**
 * <p>流程数据库模型类型</p>
 *
 * @author guocq
 * @since 2023/3/10
 */
public enum FlowDbSchemaType implements EnumModel {
    DB_SCHEMA_UPDATE_TRUE(ProcessEngineConfiguration.DB_SCHEMA_UPDATE_TRUE),
    DB_SCHEMA_UPDATE_FALSE(ProcessEngineConfiguration.DB_SCHEMA_UPDATE_FALSE),
    DB_SCHEMA_UPDATE_CREATE(ProcessEngineConfiguration.DB_SCHEMA_UPDATE_CREATE),
    DB_SCHEMA_UPDATE_CREATE_DROP(ProcessEngineConfiguration.DB_SCHEMA_UPDATE_CREATE_DROP),
    DB_SCHEMA_UPDATE_DROP_CREATE(ProcessEngineConfiguration.DB_SCHEMA_UPDATE_DROP_CREATE);

    @Getter
    private final String value;

    FlowDbSchemaType(String value) {
        this.value = value;
    }
}
