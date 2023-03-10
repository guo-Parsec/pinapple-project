package org.pineapple.support.flow;

import cn.hutool.core.util.StrUtil;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.repository.Deployment;
import org.pineapple.support.flow.define.FlowDeployDefine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * <p></p>
 *
 * @author guocq
 * @since 2023/3/10
 */
@Component
public class SimpleFlowContext implements FlowContext {
    private static final Logger log = LoggerFactory.getLogger(SimpleFlowContext.class);

    private final RepositoryService repositoryService;

    public SimpleFlowContext(RepositoryService repositoryService) {
        this.repositoryService = repositoryService;
    }

    @Override
    public void deployFlow(FlowDeployDefine flowDeployDefine) {
        if (flowDeployDefine == null || StrUtil.isBlank(flowDeployDefine.getResourceLocation())) {
            log.error("resourceClassPath不能为空");
            return;
        }
        Deployment deploy;
        try {
            deploy = repositoryService.createDeployment()
                    .addClasspathResource(flowDeployDefine.getResourceLocation())
                    .name(flowDeployDefine.getName())
                    .key(flowDeployDefine.getKey())
                    .deploy();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        log.debug("流程[{}]已被成功部署,流程信息为[key={},name={}]", deploy.getId(), deploy.getKey(), deploy.getName());
    }
}
