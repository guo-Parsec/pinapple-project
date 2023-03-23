package org.pineapple.gateway;

import org.pineapple.common.utils.UrlUtil;
import org.pineapple.common.utils.WebfluxUtil;
import org.pineapple.engine.security.SecurityService;
import org.pineapple.engine.security.contant.SecurityCommonConstant;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.http.server.RequestPath;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.List;

/**
 * <p>安全认证过滤器</p>
 *
 * @author guocq
 * @since 2023/3/23
 */
@Component
public class SecurityFilter implements GlobalFilter, Ordered {
    private final WhiteUrlsProp whiteUrlsProp;

    private final SecurityService securityService;

    public SecurityFilter(WhiteUrlsProp whiteUrlsProp, SecurityService securityService) {
        this.whiteUrlsProp = whiteUrlsProp;
        this.securityService = securityService;
    }

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        List<String> urls = whiteUrlsProp.getUrls();
        ServerHttpRequest request = exchange.getRequest();
        RequestPath requestPath = request.getPath();
        String reqUrl = UrlUtil.autoCompletePath(requestPath.toString());
        if (UrlUtil.matches(reqUrl, urls)) {
            return chain.filter(exchange);
        }
        String tokenText = request.getHeaders().getFirst(SecurityCommonConstant.TOKEN_IN_HEAD_KEY);
        boolean isOnline = securityService.isOnlineWithTokenText(tokenText);
        if (!isOnline) {
            return WebfluxUtil.unauthorizedWrite(exchange.getResponse(), "用户未登录");
        }
        return chain.filter(exchange);
    }

    @Override
    public int getOrder() {
        return 0;
    }
}
