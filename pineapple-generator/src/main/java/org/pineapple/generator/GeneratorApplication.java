package org.pineapple.generator;

import com.github.davidfantasy.mybatisplus.generatorui.GeneratorConfig;
import com.github.davidfantasy.mybatisplus.generatorui.MybatisPlusToolsApplication;

/**
 * <p>生成器启动入口</p>
 *
 * @author guocq
 * @since 2023/3/13
 */
public class GeneratorApplication {
    public static void main(String[] args) {
        GeneratorConfig generatorConfig = GeneratorConfig.builder()
                .jdbcUrl("jdbc:postgresql://127.0.0.1/pineapple?useUnicode=true&characterEncoding=utf-8&serverTimezone=Asia/Shanghai&useSSL=false&allowMultiQueries=true&allowPublicKeyRetrieval=true")
                .schemaName("system")
                .userName("pineapple")
                .password("123456")
                .driverClassName("org.postgresql.Driver")
                .basePackage("org.pineapple.system.core")
                .port(16900)
                .build();
        MybatisPlusToolsApplication.run(generatorConfig);
    }
}
