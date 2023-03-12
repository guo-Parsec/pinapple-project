package org.pineapple.support.flow.api.impl;

import cn.hutool.core.util.StrUtil;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.DeploymentQuery;
import org.pineapple.common.define.PageDefine;
import org.pineapple.common.error.ErrorRecords;
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
     * <p>流程挂起,该流程会被立即挂起</p>
     *
     * @param deploymentId            部署id
     * @param suspendProcessInstances 如果为真，所有提供的进程定义的进程实例也将被暂停。
     * @author hedwing
     * @since 2023/3/12
     */
    @Override
    public void suspend(String deploymentId, boolean suspendProcessInstances) {
        if (StrUtil.isBlank(deploymentId)) {
            throw ErrorRecords.valid.record(log, "挂起流程时deploymentId不能为空");
        }
        Deployment deployment = repositoryService.createDeploymentQuery().deploymentId(deploymentId).singleResult();
        if (deployment == null) {
            log.warn("挂起流程时根据deploymentId[{}]查询流程部署实例不存在,无法挂起!", deploymentId);
            return;
        }
        repositoryService.suspendProcessDefinitionById(deploymentId, suspendProcessInstances, null);
        if (suspendProcessInstances) {
            log.debug("流程[deploymentId={}]挂起成功,其相关的流程实例也被暂停!", deploymentId);
            return;
        }
        log.debug("流程[deploymentId={}]挂起成功,其相关的流程实例未被暂停!", deploymentId);
    }

    /**
     * <p>流程激活,该流程会被立即激活</p>
     *
     * @param deploymentId             部署id
     * @param activateProcessInstances 如果为真，所有提供的进程定义的进程实例也将被激活。
     * @author hedwing
     * @since 2023/3/12
     */
    @Override
    public void activate(String deploymentId, boolean activateProcessInstances) {
        if (StrUtil.isBlank(deploymentId)) {
            throw ErrorRecords.valid.record(log, "激活流程时deploymentId不能为空");
        }
        Deployment deployment = repositoryService.createDeploymentQuery().deploymentId(deploymentId).singleResult();
        if (deployment == null) {
            log.warn("激活流程时根据deploymentId[{}]查询流程部署实例不存在,无法激活!", deploymentId);
            return;
        }
        repositoryService.activateProcessDefinitionById(deploymentId, activateProcessInstances, null);
        if (activateProcessInstances) {
            log.debug("流程[deploymentId={}]激活成功,其相关的流程实例也被激活!", deploymentId);
            return;
        }
        log.debug("流程[deploymentId={}]激活成功,其相关的流程实例未被激活!", deploymentId);
    }

    /**
     * <p>删除流程，并且级联删除</p>
     *
     * @param deploymentId 部署id
     * @author hedwing
     * @since 2023/3/12
     */
    @Override
    public void delete(String deploymentId) {
        if (StrUtil.isBlank(deploymentId)) {
            throw ErrorRecords.valid.record(log, "删除流程时deploymentId不能为空");
        }
        Deployment deployment = repositoryService.createDeploymentQuery().deploymentId(deploymentId).singleResult();
        if (deployment == null) {
            log.warn("删除流程时根据deploymentId[{}]查询流程部署实例不存在,无法删除!", deploymentId);
            return;
        }
        repositoryService.deleteDeployment(deploymentId, true);
        log.debug("流程[deploymentId={}]删除成功", deploymentId);
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
