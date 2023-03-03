package org.pineapple.support.durability;

import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.SqlSource;

/**
 * <p>boundSql - SqlSource</p>
 *
 * @author guocq
 * @since 2023/3/2
 */
public class BoundSqlSqlSource implements SqlSource {
    private final BoundSql boundSql;

    public BoundSqlSqlSource(BoundSql boundSql) {
        this.boundSql = boundSql;
    }

    public BoundSql getBoundSql(Object parameterObject) {
        return boundSql;
    }
}