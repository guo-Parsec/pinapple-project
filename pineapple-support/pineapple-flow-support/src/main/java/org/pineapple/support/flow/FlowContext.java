package org.pineapple.support.flow;

import org.pineapple.support.flow.define.FlowDeployDefine;

/**
 * <p>流程上下文</p>
 *
 * @author guocq
 * @since 2023/3/10
 */
@SuppressWarnings("unused")
public interface FlowContext {
    /**
     * <p>流程部署</p>
     *
     * @param flowDeployDefine 流程部署定义
     * @author guocq
     * @date 2023/3/10 14:45
     */
    void deployFlow(FlowDeployDefine flowDeployDefine);
}
