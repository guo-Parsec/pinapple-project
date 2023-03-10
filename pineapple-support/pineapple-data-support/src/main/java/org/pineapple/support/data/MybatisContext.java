package org.pineapple.support.data;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Component;

/**
 * <p>Mybatis上下文</p>
 *
 * @author guocq
 * @since 2023/2/24
 */
@Component
public class MybatisContext {
    private SqlSessionFactory sqlSessionFactory;

//    private SqlBuilderStatement sqlBuilderStatement;
}
