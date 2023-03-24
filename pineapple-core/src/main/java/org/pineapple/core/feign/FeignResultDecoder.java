package org.pineapple.core.feign;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import feign.FeignException;
import feign.Response;
import feign.codec.DecodeException;
import feign.codec.Decoder;
import org.apache.commons.io.IOUtils;
import org.pineapple.common.support.error.ErrorRecords;
import org.pineapple.common.uniforms.UniformResultDefinition;
import org.pineapple.common.uniforms.UniformResultTool;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.support.SpringDecoder;

import java.io.IOException;
import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.nio.charset.StandardCharsets;

/**
 * <p>OpenFeign返回结果解码器</p>
 *
 * @author guocq
 * @since 2023/3/24
 */
public class FeignResultDecoder implements Decoder {
    private static final Logger log = LoggerFactory.getLogger(FeignResultDecoder.class);

    private final SpringDecoder decoder;

    public FeignResultDecoder(SpringDecoder decoder) {
        this.decoder = decoder;
    }

    @Override
    public Object decode(Response response, Type type) throws IOException, DecodeException, FeignException {
        if (response.body() == null) {
            throw ErrorRecords.error.record(log, "未返回有效数据");
        }
        Method method = response.request().requestTemplate().methodMetadata().method();
        boolean isUniformResult = method.getReturnType() == UniformResultDefinition.class;
        if (isUniformResult) {
            return this.decoder.decode(response, type);
        }
        String bodyStr = IOUtils.toString(response.body().asReader(StandardCharsets.UTF_8));
        UniformResultDefinition<?> definition = JSONObject.parseObject(bodyStr, UniformResultDefinition.class);
        Object data = UniformResultTool.grabDataNoException(definition);
        return JSON.parseObject(JSONObject.toJSONString(data), type);
    }
}
