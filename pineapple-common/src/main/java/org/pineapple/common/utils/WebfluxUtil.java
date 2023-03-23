package org.pineapple.common.utils;

import cn.hutool.json.JSONUtil;
import org.pineapple.common.enums.ResultEnumModel;
import org.pineapple.common.enums.UniformResultEnum;
import org.pineapple.common.uniforms.UniformResultDefinition;
import org.pineapple.common.uniforms.UniformResultTool;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.server.reactive.ServerHttpResponse;
import reactor.core.publisher.Mono;

/**
 * <p>webflux相关工具类</p>
 *
 * @author guocq
 * @since 2023/3/23
 */
public class WebfluxUtil {

    /**
     * <p>失败写入</p>
     *
     * @param response 响应
     * @param message  错误信息
     * @return {@link reactor.core.publisher.Mono<java.lang.Void> }
     * @author guocq
     * @date 2023/3/23 10:56
     */
    public static Mono<Void> failedWrite(ServerHttpResponse response, String message) {
        return failedWrite(response, message, UniformResultEnum.ERROR);
    }

    /**
     * <p>鉴权失败写入</p>
     *
     * @param response 响应
     * @return {@link reactor.core.publisher.Mono<java.lang.Void> }
     * @author guocq
     * @date 2023/3/23 10:55
     */
    public static Mono<Void> unauthorizedWrite(ServerHttpResponse response) {
        return failedWrite(response, UniformResultEnum.UNAUTHORIZED);
    }


    /**
     * <p>鉴权失败写入</p>
     *
     * @param response 响应
     * @param message  错误信息
     * @return {@link Mono<Void> }
     * @author guocq
     * @date 2023/3/23 10:55
     */
    public static Mono<Void> unauthorizedWrite(ServerHttpResponse response, String message) {
        return failedWrite(response, message, UniformResultEnum.UNAUTHORIZED);
    }

    /**
     * <p>失败写入</p>
     *
     * @param response 响应
     * @param model    错误码枚举
     * @return {@link reactor.core.publisher.Mono<java.lang.Void> }
     * @author guocq
     * @date 2023/3/23 10:54
     */
    public static Mono<Void> failedWrite(ServerHttpResponse response, ResultEnumModel model) {
        return failedWrite(response, model.getMessage(), model);
    }

    /**
     * <p>失败写入</p>
     *
     * @param response 响应
     * @param message  错误信息
     * @param model    错误码枚举
     * @return {@link reactor.core.publisher.Mono<java.lang.Void> }
     * @author guocq
     * @date 2023/3/23 10:53
     */
    public static Mono<Void> failedWrite(ServerHttpResponse response, String message, ResultEnumModel model) {
        return failedWrite(response, HttpStatus.FORBIDDEN, message, model);
    }

    /**
     * <p>失败写入</p>
     *
     * @param response 响应
     * @param status   http状态
     * @param message  错误信息
     * @param model    错误码枚举
     * @return {@link reactor.core.publisher.Mono<java.lang.Void> }
     * @author guocq
     * @date 2023/3/23 10:52
     */
    public static Mono<Void> failedWrite(ServerHttpResponse response, HttpStatus status, String message, ResultEnumModel model) {
        return failedWrite(response, MediaType.APPLICATION_JSON_VALUE, status, message, model);
    }

    /**
     * <p>失败写入</p>
     *
     * @param response    响应
     * @param contentType HTTP Content-Type标头字段
     * @param status      http状态
     * @param message     错误信息
     * @param model       错误码枚举
     * @return {@link Mono<Void> }
     * @author guocq
     * @date 2023/3/23 10:52
     */
    public static Mono<Void> failedWrite(ServerHttpResponse response, String contentType, HttpStatus status, String message, ResultEnumModel model) {
        response.setStatusCode(status);
        response.getHeaders().add(HttpHeaders.CONTENT_TYPE, contentType);
        UniformResultDefinition<Void> definition = UniformResultTool.failed(model, message);
        DataBuffer dataBuffer = response.bufferFactory().wrap(JSONUtil.toJsonStr(definition).getBytes());
        return response.writeWith(Mono.just(dataBuffer));
    }
}
