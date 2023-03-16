package org.pineapple.support.cache.config;

import cn.hutool.core.util.StrUtil;
import org.pineapple.common.constant.CommonConstant;
import org.pineapple.common.support.RedisKeyJoin;
import org.springframework.boot.autoconfigure.cache.CacheProperties;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.CachingConfigurerSupport;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.cache.RedisCacheWriter;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import java.util.Optional;

/**
 * <p>缓存配置类</p>
 *
 * @author guocq
 * @since 2023/3/16
 */
@EnableCaching
@Configuration
@Import(CacheProperties.class)
public class CacheConfig extends CachingConfigurerSupport {
    private final RedisSerializer<Object> redisSerializer;

    private final CacheProperties cacheProperties;

    public CacheConfig(RedisSerializer<Object> redisSerializer, CacheProperties cacheProperties) {
        this.redisSerializer = redisSerializer;
        this.cacheProperties = cacheProperties;
    }

    @Bean
    public CacheManager cacheManager(RedisConnectionFactory factory) {
        RedisSerializer<String> keySerializer = new StringRedisSerializer();
        RedisCacheWriter redisCacheWriter = RedisCacheWriter.nonLockingRedisCacheWriter(factory);
        //设置Redis缓存有效期为4小时
        RedisCacheConfiguration redisCacheConfiguration = RedisCacheConfiguration.defaultCacheConfig()
                .entryTtl(cacheProperties.getRedis().getTimeToLive())
                .disableCachingNullValues()
                .computePrefixWith(this::computePrefixWith)
                .serializeKeysWith(RedisSerializationContext.SerializationPair.fromSerializer(keySerializer))
                .serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(redisSerializer));
        return new RedisCacheManager(redisCacheWriter, redisCacheConfiguration);
    }

    /**
     * <p>处理缓存key前缀问题</p>
     *
     * @param name 缓存名称
     * @return {@link java.lang.String }
     * @author guocq
     * @date 2023/3/16 13:52
     */
    private String computePrefixWith(String name) {
        String keyPrefix = Optional.ofNullable(cacheProperties.getRedis())
                .map(CacheProperties.Redis::getKeyPrefix)
                .orElse(CommonConstant.REDIS_KEY_PREFIX);
        String keyJoin = new RedisKeyJoin()
                .join(keyPrefix)
                .join(name)
                .build();
        return StrUtil.endWith(keyJoin, CommonConstant.COLON) ? keyJoin : keyJoin + CommonConstant.COLON;
    }
}
