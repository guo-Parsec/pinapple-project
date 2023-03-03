package org.pineapple.core;

import org.pineapple.common.context.DictionaryContext;
import org.pineapple.core.context.DictionaryContextBuilder;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * <p>针对数据字典的查询处理器</p>
 *
 * @author guocq
 * @since 2023/2/17
 */
@Component(value = "queryPostProcessorForDictionary")
public class QueryPostProcessorForDictionary {
    /**
     * <p>查询后置处理</p>
     *
     * @param dataMapList 数据list集合
     * @author guocq
     * @date 2023/2/17 16:59
     */
//    @Override
    public void afterQueryPostProcessor(List<Map<String, Object>> dataMapList) {
        DictionaryContext context = DictionaryContextBuilder.build();
        dataMapList.forEach(context::translate);
    }
}
