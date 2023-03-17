package org.pineapple.engine.basequery.context;

import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.spring.SpringUtil;
import com.google.common.collect.Maps;
import org.pineapple.common.constant.BeanNameDefineConstant;
import org.pineapple.common.error.ErrorRecords;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;

/**
 * <p>数据字典上下文构建器</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
public class DictionaryContextBuilder {
    private static final Logger log = LoggerFactory.getLogger(DictionaryContextBuilder.class);

    private static Map<String, Class<? extends DictionaryContext>> contextNameMapper = null;

    static {
        contextNameMapper = Maps.newHashMapWithExpectedSize(6);
        contextNameMapper.put(BeanNameDefineConstant.LOCAL_DICTIONARY_CONTEXT, LocalDictionaryContext.class);
        contextNameMapper.put(BeanNameDefineConstant.REMOTE_DICTIONARY_CONTEXT, RemoteDictionaryContext.class);
        contextNameMapper.put(null, RemoteDictionaryContext.class);
        contextNameMapper.put(StrUtil.EMPTY, RemoteDictionaryContext.class);
    }

    /**
     * <p>构建{@link DictionaryContext},默认采用{@link RemoteDictionaryContext}</p>
     *
     * @return {@link org.pineapple.engine.basequery.context.DictionaryContext }
     * @author guocq
     * @date 2023/2/8 14:56
     */
    public static DictionaryContext build() {
        return build(RemoteDictionaryContext.class);
    }

    /**
     * <p>构建{@link DictionaryContext},默认采用{@link RemoteDictionaryContext}</p>
     *
     * @param contextName 上下文名称
     * @return {@link org.pineapple.engine.basequery.context.DictionaryContext }
     * @author guocq
     * @date 2023/2/8 14:56
     */
    public static DictionaryContext build(String contextName) {
        Class<? extends DictionaryContext> contextClass = contextNameMapper.get(contextName);
        if (contextClass == null) {
            throw ErrorRecords.error.record(log, "上下文[{}]不存在,请输入正确的上下文名称", contextName);
        }
        return build(contextClass);
    }

    /**
     * <p>构建{@link DictionaryContext}</p>
     *
     * @param contextClass 指定上下文类行
     * @return {@link org.pineapple.engine.basequery.context.DictionaryContext }
     * @author guocq
     * @date 2023/2/8 14:56
     */
    public static DictionaryContext build(Class<? extends DictionaryContext> contextClass) {
        if (contextClass == null) {
            throw ErrorRecords.valid.record(log, "输入的上下文class对象不能为空");
        }
        DictionaryContext context = SpringUtil.getBean(contextClass);
        if (context == null) {
            throw ErrorRecords.error.record(log, "类型[{}]的数据字典上下文没有被注册为bean", contextClass);
        }
        return context;
    }
}
