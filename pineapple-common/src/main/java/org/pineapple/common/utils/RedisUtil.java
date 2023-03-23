package org.pineapple.common.utils;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ArrayUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.spring.SpringUtil;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import org.pineapple.common.constant.CommonConstant;
import org.pineapple.common.support.error.ErrorRecords;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * <p>Redis工具类</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
@Component
public class RedisUtil {
    private static final Logger log = LoggerFactory.getLogger(RedisUtil.class);

    private final RedisTemplate<String, Object> redisTemplate;

    public RedisUtil(RedisTemplate<String, Object> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    public static RedisUtil getInstance() {
        return SpringUtil.getBean(RedisUtil.class);
    }

    /**
     * <p>根据匹配符{@code pattern}获取所有匹配的key列表</p>
     *
     * @param pattern  key的匹配符
     * @param isLogger 是否打印日志信息
     * @return java.util.Set<java.lang.String>
     * @author guocq
     * @date 2022/12/15 14:54
     */
    private Set<String> keys(String pattern, boolean isLogger) {
        if (isLogger) {
            log.debug("根据传入的key的匹配符[pattern={}]获取匹配的所有的key集合", pattern);
        }
        if (StrUtil.isBlank(pattern)) {
            if (isLogger) {
                log.debug("根据传入的key的匹配符[pattern]为空");
            }
            return Sets.newHashSet();
        }
        Set<String> keys = redisTemplate.keys(pattern);
        if (isLogger) {
            log.debug("根据传入的key的匹配符[pattern={}]查询到的key集合为[keys={}]", pattern, keys);
        }
        return keys;
    }

    /**
     * <p>根据匹配符{@code pattern}获取所有匹配的key列表</p>
     *
     * @param pattern key的匹配符
     * @return java.util.Set<java.lang.String>
     * @author guocq
     * @date 2022/12/15 14:54
     */
    public Set<String> keys(String pattern) {
        return keys(pattern, true);
    }

    /**
     * <p>根据key获取redis的值</p>
     *
     * @param key      存储的key
     * @param isLogger 是否打印日志信息
     * @return 值
     * @author guocq
     * @date 2022/12/15 14:52
     */
    private Object get(String key, boolean isLogger) {
        if (isLogger) {
            log.debug("根据传入的key[{}]查询redis中存储的值", key);
        }
        checkKeyBeforeGet(key);
        Object val = redisTemplate.opsForValue().get(key);
        if (isLogger) {
            log.debug("根据传入的key[{}]查询redis中存储的值为[val={}]", key, val);
        }
        return val;
    }

    /**
     * <p>根据key获取redis的值</p>
     *
     * @param key 存储的key
     * @return 值
     * @author guocq
     * @date 2022/12/15 14:52
     */
    private Object getWithoutLogger(String key) {
        return get(key, false);
    }

    /**
     * <p>根据key获取redis的值</p>
     *
     * @param key 存储的key
     * @return 值
     * @author guocq
     * @date 2022/12/15 14:52
     */
    public Object get(String key) {
        return get(key, true);
    }

    /**
     * <p>根据匹配符{@code pattern}获取所有key-value映射</p>
     *
     * @param pattern key的匹配符
     * @return java.util.Map<java.lang.String, Object>
     * @author guocq
     * @date 2022/12/15 15:02
     */
    public Map<String, Object> getAll(String pattern) {
        log.debug("根据传入的key的匹配符[pattern={}]获取key-value组成的map", pattern);
        Set<String> keys = this.keys(pattern, false);
        log.debug("根据传入的key的匹配符[pattern={}]查询到的key集合为[keys={}]", pattern, keys);
        if (CollUtil.isEmpty(keys)) {
            log.debug("传入的key的匹配符[pattern={}]查询到的key集合为空", pattern);
            return Maps.newHashMap();
        }
        Map<String, Object> kvMap = CastUtil.collectionToMap(keys, this::getWithoutLogger);
        log.debug("根据传入的key的匹配符[pattern={}]查询到的key-value组成的map为[kvMap={}]", pattern, kvMap);
        return kvMap;
    }

    /**
     * <p>向redis中添加key-value键值对</p>
     *
     * @param key      键
     * @param val      值
     * @param time     过期时间
     * @param timeUnit 时间单位
     * @author guocq
     * @date 2022/12/15 15:05
     */
    public <V> void set(String key, V val, long time, TimeUnit timeUnit) {
        log.debug("开始向redis中存储[key={},val={}]的数据并设置过期时间为[time={}, timeUnit={}]", key, val, time, timeUnit);
        checkKeyAndValBeforeSet(key, val);
        if (time <= 0) {
            throw ErrorRecords.valid.record(log, "向redis中存储数据时设置的过期时间不能小于等于0");
        }
        if (timeUnit == null) {
            timeUnit = TimeUnit.SECONDS;
            log.warn("向redis中存储数据时设置的过期时间单位为null, 系统采用默认值{}", TimeUnit.SECONDS.name());
        }
        redisTemplate.opsForValue().set(key, val, time, timeUnit);
        log.debug("已成功向redis中存储[key={},val={}]的数据并设置过期时间为[time={}, timeUnit={}]", key, val, time, timeUnit);
    }

    /**
     * <p>向redis中添加key-value键值对</p>
     *
     * @param key  键
     * @param val  值
     * @param time 过期时间 默认为秒
     * @author guocq
     * @date 2022/12/15 15:07
     */
    public <V> void set(String key, V val, long time) {
        set(key, val, time, TimeUnit.SECONDS);
    }

    /**
     * <p>向redis中添加key-value键值对 该键值对不会过期</p>
     *
     * @param key 键
     * @param val 值
     * @author guocq
     * @date 2022/12/15 15:09
     */
    public void set(String key, Object val) {
        log.debug("开始向redis中存储[key={},val={}]的数据并且该数据不会过期", key, val);
        checkKeyAndValBeforeSet(key, val);
        redisTemplate.opsForValue().set(key, val);
        log.debug("已成功向redis中存储[key={},val={}]的数据并且该数据不会过期", key, val);
    }

    /**
     * <p>删除redis中的指定key, 删除成功返回true</p>
     *
     * @param key 键
     * @return boolean
     * @author guocq
     * @date 2022/12/15 15:12
     */
    public boolean delete(String key) {
        log.debug("开始从redis中删除已存储的键[key={}]", key);
        checkKeyBeforeDelete(key);
        Boolean isDeleted = Optional.ofNullable(redisTemplate.delete(key)).orElse(Boolean.FALSE);
        if (isDeleted) {
            log.debug("已成功从redis中删除已存储的键[key={}]", key);
            return true;
        }
        log.debug("从redis中删除已存储的键[key={}]失败", key);
        return false;
    }

    /**
     * <p>批量删除redis中的key</p>
     *
     * @param keys     键列表
     * @param isLogger 是否输出日志
     * @return boolean
     * @author guocq
     * @date 2022/12/15 16:01
     */
    private long delete(Collection<String> keys, boolean isLogger) {
        if (isLogger) {
            log.debug("开始从redis中批量删除已存储的键[keys={}]", keys);
        }
        if (CollUtil.isEmpty(keys)) {
            log.warn("待批量删除的键集合为空");
            return 0L;
        }
        long deletedCount = Optional.ofNullable(redisTemplate.delete(keys)).orElse(0L);
        if (isLogger) {
            log.debug("已成功从redis中批量删除已存储的键共计{}条", deletedCount);
        }
        return deletedCount;
    }

    /**
     * <p>批量删除redis中的key</p>
     *
     * @param keys 键列表
     * @return boolean
     * @author guocq
     * @date 2022/12/15 16:01
     */
    public long delete(Collection<String> keys) {
        return delete(keys, true);
    }

    /**
     * <p>根据匹配符{@code pattern}删除匹配的key-value映射</p>
     *
     * @param pattern 匹配符
     * @return long
     * @author guocq
     * @date 2022/12/15 16:06
     */
    public long deleteByPattern(String pattern) {
        log.debug("开始从redis中删除匹配的键[pattern={}]", pattern);
        Set<String> keys = this.keys(pattern, false);
        log.debug("根据传入的key的匹配符[pattern={}]查询到的key集合为[keys={}]", pattern, keys);
        long deletedCount = delete(keys, false);
        log.debug("已成功从redis中批量删除key的匹配符[pattern={}]共计{}条", pattern, deletedCount);
        return deletedCount;
    }

    /**
     * <p>对指定{@code key}设置过期时间</p>
     *
     * @param key      键
     * @param time     过期时间
     * @param timeUnit 时间单位
     * @return boolean
     * @author guocq
     * @date 2022/12/15 16:08
     */
    public boolean expire(String key, long time, TimeUnit timeUnit) {
        log.debug("开始向redis中的数据[key={}]设置过期时间[time={}, timeUnit={}]", key, time, timeUnit);
        checkKeyBeforeOperation(key, "向redis中的数据设置过期时间时");
        if (time <= 0) {
            throw ErrorRecords.valid.record(log, "向redis中的数据设置过期时间时设置的过期时间不能小于等于0");
        }
        if (timeUnit == null) {
            timeUnit = TimeUnit.SECONDS;
            log.warn("向redis中的数据设置过期时间时设置的过期时间单位为null, 系统采用默认值{}", TimeUnit.SECONDS.name());
        }
        Boolean isSetExpire = Optional.ofNullable(redisTemplate.expire(key, time, timeUnit)).orElse(Boolean.FALSE);
        if (isSetExpire) {
            log.debug("已成功向redis中的数据[key={}]设置过期时间[time={}, timeUnit={}]", key, time, timeUnit);
            return true;
        }
        log.debug("向redis中的数据[key={}]设置过期时间[time={}, timeUnit={}]失败", key, time, timeUnit);
        return false;
    }

    /**
     * <p>对指定{@code key}设置过期时间</p>
     *
     * @param key  键
     * @param time 过期时间 默认单位为秒
     * @return boolean
     * @author guocq
     * @date 2022/12/15 16:09
     */
    public boolean expire(String key, long time) {
        return expire(key, time, TimeUnit.SECONDS);
    }

    /**
     * <p>获取{@code key}的过期时间</p>
     *
     * @param key      键
     * @param timeUnit 时间单位
     * @return java.lang.Long
     * @author guocq
     * @date 2022/12/15 16:10
     */
    public Long getExpire(String key, TimeUnit timeUnit) {
        log.debug("获取键[key={}]的过期时间[timeUnit={}]", key, timeUnit);
        checkKeyBeforeOperation(key, "获取数据的过期时间时");
        if (timeUnit == null) {
            timeUnit = TimeUnit.SECONDS;
            log.warn("获取redis中的数据的过期时间时设置的过期时间单位为null, 系统采用默认值{}", TimeUnit.SECONDS.name());
        }
        Long expireTime = redisTemplate.getExpire(key, timeUnit);
        log.debug("已成功获取键[key={}]的过期时间[expireTime={}, timeUnit={}]", key, expireTime, timeUnit);
        return expireTime;
    }

    /**
     * <p>获取{@code key}的过期时间 默认单位为秒</p>
     *
     * @param key 键
     * @return java.lang.Long
     * @author guocq
     * @date 2022/12/15 16:10
     */
    public Long getExpire(String key) {
        return getExpire(key, TimeUnit.SECONDS);
    }

    /**
     * <p>判断redis中是否含有{@code key}</p>
     *
     * @param key 键
     * @return boolean
     * @author guocq
     * @date 2022/12/15 16:12
     */
    public boolean hasKey(String key) {
        log.debug("判断redis中是否含有键[key={}]的数据", key);
        Boolean hasKey = Optional.ofNullable(redisTemplate.hasKey(key)).orElse(Boolean.FALSE);
        log.debug("判断redis中是否含有键[key={}]的数据, 结果 = {}", key, hasKey);
        return hasKey;
    }

    /**
     * <p>按{@code delta}对{@code key}的value增长</p>
     *
     * @param key   键
     * @param delta 增长长度
     * @author guocq
     * @date 2022/12/15 16:14
     */
    public void increment(String key, Long delta) {
        log.debug("开始对redis中的数据[key={}]自增, 增长的步长={}]", key, delta);
        checkKeyBeforeOperation(key, "对redis中的数据自增时");
        if (delta <= 0) {
            throw ErrorRecords.valid.record(log, "对redis中的数据[key={}]自增时，增长的步长[delta={}]不能小于0", key, delta);
        }
        redisTemplate.opsForValue().increment(key, delta);
        log.debug("已成功对redis中的数据[key={}]自增, 增长的步长={}]", key, delta);
    }

    /**
     * <p>按{@code delta}对{@code key}的value增长</p>
     *
     * @param key   键
     * @param delta 增长长度
     * @author guocq
     * @date 2022/12/15 16:14
     */
    public void increment(String key, Double delta) {
        log.debug("开始对redis中的数据[key={}]自增, 增长的步长={}]", key, delta);
        checkKeyBeforeOperation(key, "对redis中的数据自增时");
        if (delta <= 0) {
            throw ErrorRecords.valid.record(log, "对redis中的数据[key={}]自增时，增长的步长[delta={}]不能小于0", key, delta);
        }
        redisTemplate.opsForValue().increment(key, delta);
        log.debug("已成功对redis中的数据[key={}]自增, 增长的步长={}]", key, delta);
    }

    /**
     * <p>对{@code key}的value自增1</p>
     *
     * @param key 键
     * @author guocq
     * @date 2022/12/15 16:14
     */
    public void increment(String key) {
        increment(key, 1L);
    }

    /**
     * <p>按{@code delta}对{@code key}的value减少</p>
     *
     * @param key   键
     * @param delta 减少长度
     * @author guocq
     * @date 2022/12/15 16:14
     */
    public void decrement(String key, Long delta) {
        log.debug("开始对redis中的数据[key={}]自减, 减少的步长={}]", key, delta);
        checkKeyBeforeOperation(key, "对redis中的数据自减时");
        if (delta <= 0) {
            throw ErrorRecords.valid.record(log, "对redis中的数据[key={}]自减时，减少的步长[delta={}]不能小于0", key, delta);
        }
        redisTemplate.opsForValue().increment(key, -delta);
        log.debug("已成功对redis中的数据[key={}]自减, 减少的步长={}]", key, delta);
    }

    /**
     * <p>按{@code delta}对{@code key}的value减少</p>
     *
     * @param key   键
     * @param delta 减少长度
     * @author guocq
     * @date 2022/12/15 16:14
     */
    public void decrement(String key, Double delta) {
        log.debug("开始对redis中的数据[key={}]自减, 减少的步长={}]", key, delta);
        checkKeyBeforeOperation(key, "对redis中的数据自减时");
        if (delta <= 0) {
            throw ErrorRecords.valid.record(log, "对redis中的数据[key={}]自减时，减少的步长[delta={}]不能小于0", key, delta);
        }
        redisTemplate.opsForValue().increment(key, -delta);
        log.debug("已成功对redis中的数据[key={}]自减, 减少的步长={}]", key, delta);
    }

    /**
     * <p>对{@code key}的value自减1</p>
     *
     * @param key 键
     * @author guocq
     * @date 2022/12/15 16:14
     */
    public void decrement(String key) {
        decrement(key, 1L);
    }

    /**
     * <p>向redis中存储数据前校验键和值</p>
     *
     * @param key 键
     * @param val 值
     * @author guocq
     * @date 2023/3/14 14:32
     */
    private void checkKeyAndValBeforeSet(String key, Object val) {
        if (StrUtil.isBlank(key) || ObjectUtil.isNull(val)) {
            throw ErrorRecords.valid.record(log, "向redis中存储数据时key和val不能为空");
        }
    }

    /**
     * <p>从redis中读取数据前校验键</p>
     *
     * @param key 键
     * @author guocq
     * @date 2023/3/14 14:33
     */
    private void checkKeyBeforeGet(String key) {
        checkKeyBeforeOperation(key, "从redis中读取数据时");
    }

    /**
     * <p>从redis中删除数据前校验键</p>
     *
     * @param key 键
     * @author guocq
     * @date 2023/3/14 14:33
     */
    private void checkKeyBeforeDelete(String key) {
        checkKeyBeforeOperation(key, "从redis中删除数据时");
    }

    /**
     * <p>从redis中删除数据前校验键</p>
     *
     * @param key 键
     * @author guocq
     * @date 2023/3/14 14:33
     */
    private void checkKeyBeforeOperation(String key, String operation) {
        if (StrUtil.isBlank(key)) {
            throw ErrorRecords.valid.record(log, operation + "key不能为空");
        }
    }

    /**
     * <p>对指定列表集合{@code keySet}使用{@link CommonConstant#COLON}进行拼接</p>
     *
     * @param keySet 列表集合
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 8:57
     */
    public static String keyJoin(Set<String> keySet) {
        return keyJoin(false, keySet);
    }

    /**
     * <p>对指定列表集合{@code keySet}使用{@link CommonConstant#COLON}进行拼接</p>
     *
     * @param keySet 列表集合
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 8:57
     */
    public static String keyJoin(String... keySet) {
        return keyJoin(false, keySet);
    }

    /**
     * <p>对指定列表集合{@code keySet}使用{@link CommonConstant#COLON}进行拼接</p>
     * <p>当toUpperCase为true时,所有字符将转换为大写后再拼接</p>
     *
     * @param toUpperCase 是否转换为大写
     * @param keySet      列表集合
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/15 8:57
     */
    public static String keyJoin(boolean toUpperCase, String... keySet) {
        if (ArrayUtil.isEmpty(keySet)) {
            throw ErrorRecords.valid.record(log, "对指定的key列表集合进行字符拼接时key列表集合[keySet]不能为空");
        }
        return keyJoin(toUpperCase, Sets.newHashSet(keySet));
    }

    /**
     * <p>对指定列表集合{@code keySet}使用{@link CommonConstant#COLON}进行拼接</p>
     * <p>当toUpperCase为true时,所有字符将转换为大写后再拼接</p>
     *
     * @param toUpperCase 是否转换为大写
     * @param keySet      列表集合
     * @author guocq
     * @date 2023/3/15 8:53
     */
    public static String keyJoin(boolean toUpperCase, Set<String> keySet) {
        if (CollUtil.isEmpty(keySet)) {
            throw ErrorRecords.valid.record(log, "对指定的key列表集合进行字符拼接时key列表集合[keySet]不能为空");
        }
        return keySet.stream()
                .map(key -> toUpperCase ? key.toUpperCase(Locale.ROOT) : key)
                .collect(Collectors.joining(CommonConstant.COLON));
    }

}
