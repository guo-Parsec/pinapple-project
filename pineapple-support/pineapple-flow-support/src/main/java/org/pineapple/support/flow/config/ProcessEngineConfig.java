package org.pineapple.support.flow.config;

import lombok.Getter;
import lombok.Setter;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.ProcessEngineConfiguration;
import org.flowable.engine.impl.cfg.StandaloneProcessEngineConfiguration;
import org.pineapple.common.error.ErrorRecords;
import org.pineapple.support.flow.FlowProp;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

/**
 * <p>流程引擎配置</p>
 *
 * @author guocq
 * @since 2023/3/10
 */
@Getter
@Setter
@Configuration
@ConfigurationProperties(prefix = "spring.datasource")
public class ProcessEngineConfig {
    private static final Logger log = LoggerFactory.getLogger(ProcessEngineConfig.class);

    private final FlowProp flowProp;

    /**
     * jdbc-url
     */
    @Value("${spring.datasource.url}")
    private String url;

    /**
     * 驱动类名称
     */
    @Value("${spring.datasource.driver-class-name}")
    private String driverClassName;

    /**
     * 用户名
     */
    @Value("${spring.datasource.username}")
    private String username;

    /**
     * 密码
     */
    @Value("${spring.datasource.password}")
    private String password;

    public ProcessEngineConfig(FlowProp flowProp) {
        this.flowProp = flowProp;
    }

    @Primary
    @Bean(name = "processEngine")
    public ProcessEngine initProcessEngine() {
        log.info("初始化流程引擎开始");
        ProcessEngineConfiguration config = null;
        try {
            config = new StandaloneProcessEngineConfiguration()
                    .setJdbcDriver(driverClassName)
                    .setDatabaseSchema(flowProp.getSchema())
                    .setJdbcUrl(url)
                    .setJdbcUsername(username)
                    .setJdbcPassword(password)
                    .setDatabaseSchemaUpdate(flowProp.getDbSchemaType().getValue())
                    .setActivityFontName(flowProp.getActivityFontName())
                    .setLabelFontName(flowProp.getLabelFontName())
                    .setAnnotationFontName(flowProp.getAnnotationFontName());
        } catch (Exception e) {
            throw ErrorRecords.error.record(log, "配置流程引擎失败,原因：{}", e.getMessage());
        }
        if (config != null) {
            ProcessEngine processEngine = config.buildProcessEngine();
            log.info("初始化流程引擎结束");
            return processEngine;
        }
        throw ErrorRecords.error.record(log, "配置流程引擎失败");
    }
}
