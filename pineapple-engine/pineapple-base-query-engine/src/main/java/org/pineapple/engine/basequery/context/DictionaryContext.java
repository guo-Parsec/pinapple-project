package org.pineapple.engine.basequery.context;

/**
 * <p>数据字典上下文</p>
 *
 * @author guocq
 * @since 2023/2/2
 */
public interface DictionaryContext {
    /**
     * <p>对目标类中的字段进行数据字典转义</p>
     *
     * @param target 目标类
     * @author guocq
     * @date 2023/2/2 15:23
     */
    void translate(Object target);
}
