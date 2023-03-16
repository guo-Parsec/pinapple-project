package org.pineapple.core.context;

import cn.hutool.core.util.StrUtil;
import org.pineapple.common.annotations.Dictionary;
import org.pineapple.common.context.AbstractDictionaryContext;
import org.pineapple.common.entity.SystemDictEntity;
import org.pineapple.common.error.ErrorRecords;
import org.pineapple.core.facade.SystemDictFacade;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.lang.reflect.Field;
import java.util.function.Function;

import static org.pineapple.common.constant.BeanNameDefineConstant.REMOTE_DICTIONARY_CONTEXT;

/**
 * <p>远程数据字典上下文实现</p>
 *
 * @author guocq
 * @since 2023/2/8
 */
@Component(value = REMOTE_DICTIONARY_CONTEXT)
public class RemoteDictionaryContext extends AbstractDictionaryContext {
    private static final Logger log = LoggerFactory.getLogger(RemoteDictionaryContext.class);

    private final SystemDictFacade facade;

    public RemoteDictionaryContext(SystemDictFacade facade) {
        this.facade = facade;
    }

    /**
     * <p>字段过滤Mapper</p>
     *
     * @return {@link Function }
     * @author guocq
     * @date 2023/2/2 15:41
     */
    @Override
    public Function<Field, Field> fieldFilterMapper() {
        return field -> {
            Dictionary dictionary = field.getAnnotation(Dictionary.class);
            if (dictionary == null || !dictionary.remote()) {
                log.debug("当前字段[{}]不支持远程检索", field.getName());
                return null;
            }
            return field;
        };
    }

    /**
     * <p>获取字典转移后的值</p>
     *
     * @param code       字典类型
     * @param value      字典值
     * @param dictionary 字典注解
     * @return {@link String }
     * @author guocq
     * @date 2023/2/2 15:56
     */
    @Override
    public String findValueAfterTranslate(String code, String value, Dictionary dictionary) {
        if (StrUtil.isBlank(code) || value == null) {
            throw ErrorRecords.valid.record(log, "字典类型[code]和字典值[value]不能为空");
        }
        SystemDictEntity singleDictionary = facade.findSingleDictionary(code, value);
        return singleDictionary == null ? dictionary.defaultVal() : singleDictionary.getDictName();
    }
}
