package org.pineapple.support.durability.config;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.BlockAttackInnerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import org.apache.ibatis.reflection.MetaObject;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.LocalDateTime;

/**
 * <p>mybatisPlus配置类</p>
 *
 * @author guocq
 * @since 2023/2/7
 */
@MapperScan({
        "org.pineapple.**.mapper",
        "org.pineapple.**.retrieve",
        "com.baomidou.mybatisplus.samples.quickstart.mapper"
})
@Configuration
public class MybatisPlusConfig implements MetaObjectHandler {
    /**
     * <p>MybatisPlusInterceptor注册为bean</p>
     *
     * @return {@link com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor }
     * @author guocq
     * @date 2023/2/7 18:36
     */
    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        // 防止全表更新与删除：攻击SQL阻断解析器、加入解析链，防止恶意进行delete、update全表操作
        interceptor.addInnerInterceptor(new BlockAttackInnerInterceptor());
        // 自动分页
        PaginationInnerInterceptor pageInterceptor = new PaginationInnerInterceptor(DbType.MYSQL);
        pageInterceptor.setMaxLimit(500L);
        interceptor.addInnerInterceptor(pageInterceptor);
        return interceptor;
    }

    /**
     * 插入元对象字段填充（用于插入时对公共字段的填充）
     *
     * @param metaObject 元对象
     */
    @Override
    public void insertFill(MetaObject metaObject) {
        setFieldValByName("addTime", LocalDateTime.now(), metaObject);
        setFieldValByName("editTime", LocalDateTime.now(), metaObject);
    }

    /**
     * 更新元对象字段填充（用于更新时对公共字段的填充）
     *
     * @param metaObject 元对象
     */
    @Override
    public void updateFill(MetaObject metaObject) {
        setFieldValByName("gmtModify", LocalDateTime.now(), metaObject);
    }
}
