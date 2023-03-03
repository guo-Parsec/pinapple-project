package org.pineapple.common.context;

import com.google.common.collect.Sets;
import org.pineapple.common.annotations.Dictionary;
import org.pineapple.common.enums.BiEnumModel;
import org.pineapple.common.enums.DictionaryEnum;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.lang.reflect.Field;
import java.util.Optional;
import java.util.Set;
import java.util.function.Function;

import static org.pineapple.common.constant.BeanNameDefineConstant.LOCAL_DICTIONARY_CONTEXT;

/**
 * <p>本地数据字典上下文实现</p>
 *
 * @author guocq
 * @since 2023/2/2
 */
@Component(value = LOCAL_DICTIONARY_CONTEXT)
public class LocalDictionaryContext extends AbstractDictionaryContext {
    private static final Logger log = LoggerFactory.getLogger(LocalDictionaryContext.class);

    /**
     * <p>字段过滤Mapper</p>
     *
     * @return {@link java.util.function.Function<Field,Field> }
     * @author guocq
     * @date 2023/2/2 15:41
     */
    @Override
    public Function<Field, Field> fieldFilterMapper() {
        return field -> {
            Dictionary dictionary = field.getAnnotation(Dictionary.class);
            if (dictionary == null || dictionary.remote()) {
                log.debug("当前字段[{}]不支持本地检索", field.getName());
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
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/2/2 15:56
     */
    @Override
    public String findValueAfterTranslate(String code, Integer value, Dictionary dictionary) {
        Class<? extends DictionaryEnum> localEnums = dictionary.localEnums();
        Set<? extends DictionaryEnum> dictionaryEnums = Sets.newHashSet(localEnums.getEnumConstants());
        Optional<String> dictNameOptional = dictionaryEnums.stream().filter(ele -> ele.getCode().equals(value)).map(BiEnumModel::getDesc).findFirst();
        return dictNameOptional.orElse(dictionary.defaultVal());
    }
}
