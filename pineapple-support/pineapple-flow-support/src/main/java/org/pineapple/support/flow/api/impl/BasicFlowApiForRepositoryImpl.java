package org.pineapple.support.flow.api.impl;

import cn.hutool.core.util.StrUtil;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.DeploymentQuery;
import org.pineapple.common.define.PageDefine;
import org.pineapple.common.utils.StreamUtil;
import org.pineapple.support.flow.api.BasicFlowApiForRepository;
import org.pineapple.support.flow.define.FlowDeployDefine;
import org.pineapple.support.flow.pojo.dto.DeploymentPageQueryDto;
import org.pineapple.support.flow.pojo.vo.DeploymentVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * <p>流程资源实现类</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
@Component(value = "basicFlowApiForRepository")
public class BasicFlowApiForRepositoryImpl implements BasicFlowApiForRepository {
    private static final Logger log = LoggerFactory.getLogger(BasicFlowApiForRepositoryImpl.class);

    private final RepositoryService repositoryService;

    public BasicFlowApiForRepositoryImpl(RepositoryService repositoryService) {
        this.repositoryService = repositoryService;
    }

    /**
     * <p>资源部署</p>
     *
     * @param resourceLocation 资源文件位置
     * @param define           资源定义
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public void deploy(String resourceLocation, FlowDeployDefine define) {
        if (StrUtil.isBlank(resourceLocation)) {
            log.error("resourceClassPath不能为空");
            return;
        }
        Deployment deploy;
        try {
            deploy = repositoryService.createDeployment()
                    .addClasspathResource(resourceLocation)
                    .name(define.getName())
                    .key(define.getKey())
                    .deploy();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        log.debug("流程[{}]已被成功部署,流程信息为[key={},name={}]", deploy.getId(), deploy.getKey(), deploy.getName());
    }

    /**
     * <p>分页查询已部署的流程</p>
     *
     * @param dto 查询参数
     * @return 流程列表
     * @author hedwing
     * @since 2023/3/11
     */
    public PageDefine<DeploymentVo> queryPageProcessDeployment(DeploymentPageQueryDto dto) {
        DeploymentQuery deploymentQuery = repositoryService.createDeploymentQuery();
        if (StrUtil.isNotBlank(dto.getDeploymentName())) {
            deploymentQuery.deploymentNameLike(dto.getDeploymentName());
        }
        if (StrUtil.isNotBlank(dto.getDeploymentKey())) {
            deploymentQuery.deploymentKeyLike(dto.getDeploymentKey());
        }
        long total = deploymentQuery.count();
        Integer pageIndex = dto.getPageIndex();
        Integer pageSize = dto.getPageSize();
        List<Deployment> deployments = deploymentQuery.orderByDeploymentTime().asc().listPage(pageIndex - 1, pageSize);
        List<DeploymentVo> deploymentVos = StreamUtil.castElementForList(deployments, DeploymentVo::buildFormTask);
        return new PageDefine<>(pageIndex, pageSize, deploymentVos, total);
    }

    /**
     * <p>获取RepositoryService</p>
     *
     * @return org.flowable.engine.RepositoryService
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public RepositoryService getRepositoryService() {
        return repositoryService;
    }
}
