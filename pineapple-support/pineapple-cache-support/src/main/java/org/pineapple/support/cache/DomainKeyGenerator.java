package org.pineapple.support.cache;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import org.pineapple.common.pojo.DomainModel;
import org.pineapple.common.NameInterface;
import org.pineapple.common.constant.CommonConstant;
import org.pineapple.common.error.ErrorRecords;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.interceptor.KeyGenerator;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.util.Map;
import java.util.TreeMap;

/**
 * <p>实体缓存key生成</p>
 *
 * @author guocq
 * @since 2023/3/16
 */
@Component(value = "domainKeyGenerator")
public class DomainKeyGenerator implements KeyGenerator, NameInterface {
    private static final Logger log = LoggerFactory.getLogger(DomainKeyGenerator.class);

    static final String EMPTY_STR = "EMPTY";

    /**
     * <p>为给定的方法及其参数生成key。</p>
     *
     * @param target 目标实例
     * @param method 被调用的方法
     * @param params 方法参数（扩展了任何可变参数）
     * @return 生成的key
     * @author guocq
     * @date 2023/3/16 13:55
     */
    @Override
    public Object generate(Object target, Method method, Object... params) {
        if (ArrayUtil.isEmpty(params)) {
            throw ErrorRecords.unsupported.record(log, "key生成器[{}]不支持向无参方法[method={}]生成key", this.name(), method.getName());
        }
        if (params.length > 1) {
            throw ErrorRecords.unsupported.record(log, "key生成器[{}]不支持向多参方法[method={}]生成key,当前生成器只允许单参方法", this.name(), method.getName());
        }
        Object param = params[0];
        if (!(param instanceof DomainModel)) {
            throw ErrorRecords.unsupported.record(log, "key生成器[{}]不支持向参数并非[DomainModel]类型生成key", this.name());
        }
        DomainModel model = (DomainModel) param;
        Map<String, Object> modelMap = BeanUtil.beanToMap(model);
        StringBuilder builder = new StringBuilder();
        TreeMap<String, Object> sortedMap = MapUtil.sort(modelMap);
        sortedMap.forEach((key, value) -> {
            if (StrUtil.isNotBlank(key) && ObjectUtil.isNotEmpty(value)) {
                builder.append(key).append(CommonConstant.REDIS_KEY_PREFIX).append(value).append(CommonConstant.COLON);
            }
        });
        String builderStr = builder.toString();
        int lastIndex = builder.length() - 1;
        int lastSeparatorIndex = builderStr.lastIndexOf(CommonConstant.COLON);
        if (lastSeparatorIndex == lastIndex && lastIndex != -1) {
            builderStr = builderStr.substring(0, lastSeparatorIndex);
        }
        String key = StrUtil.isBlank(builderStr) ? EMPTY_STR : builderStr;
        log.debug("key生成器[{}]生成的key为[key={}]", this.name(), key);
        return key;
    }
}
