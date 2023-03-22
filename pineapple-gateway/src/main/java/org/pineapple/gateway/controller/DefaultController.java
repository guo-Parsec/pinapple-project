package org.pineapple.gateway.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.reactive.result.view.Rendering;

/**
 * <p>默认控制器</p>
 *
 * @author guocq
 * @since 2023/3/22
 */
@Controller
public class DefaultController {
    @RequestMapping(value = "/")
    public Rendering rendering() {
        return Rendering.redirectTo("/swagger-ui/index.html").build();
    }
}
