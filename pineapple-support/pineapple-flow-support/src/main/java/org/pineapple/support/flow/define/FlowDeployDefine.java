package org.pineapple.support.flow.define;

import lombok.Getter;
import lombok.Setter;

/**
 * <p>流程部署定义</p>
 *
 * @author guocq
 * @since 2023/3/10
 */
@Setter
@Getter
public class FlowDeployDefine {
    /**
     * 资源位置
     */
    private String resourceLocation;

    /**
     * 流程存储的key
     */
    private String key;

    /**
     * 流程名称
     */
    private String name;

    public FlowDeployDefine() {
    }

    public FlowDeployDefine(String resourceLocation, String key, String name) {
        this.resourceLocation = resourceLocation;
        this.key = key;
        this.name = name;
    }
}
