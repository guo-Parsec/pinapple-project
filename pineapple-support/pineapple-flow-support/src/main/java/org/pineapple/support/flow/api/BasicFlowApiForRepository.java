package org.pineapple.support.flow.api;

import org.flowable.engine.RepositoryService;
import org.pineapple.common.define.PageDefine;
import org.pineapple.support.flow.define.FlowDeployDefine;
import org.pineapple.support.flow.pojo.dto.DeploymentPageQueryDto;
import org.pineapple.support.flow.pojo.vo.DeploymentVo;

/**
 * <p>流程资源</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
public interface BasicFlowApiForRepository {
    /**
     * <p>资源部署</p>
     *
     * @param resourceLocation 资源文件位置
     * @param define           资源定义
     * @author hedwing
     * @since 2023/3/11
     */
    void deploy(String resourceLocation, FlowDeployDefine define);

    /**
     * <p>分页查询已部署的流程</p>
     *
     * @param dto 查询参数
     * @return 流程列表
     * @author hedwing
     * @since 2023/3/11
     */
    PageDefine<DeploymentVo> queryPageProcessDeployment(DeploymentPageQueryDto dto);

    /**
     * <p>流程挂起,该流程会被立即挂起,所有提供的进程定义的进程实例也将被暂停</p>
     *
     * @param deploymentId 部署id
     * @author hedwing
     * @since 2023/3/12
     */
    default void suspend(String deploymentId) {
        suspend(deploymentId, true);
    }

    /**
     * <p>流程挂起,该流程会被立即挂起</p>
     *
     * @param deploymentId            部署id
     * @param suspendProcessInstances 如果为真，所有提供的进程定义的进程实例也将被暂停。
     * @author hedwing
     * @since 2023/3/12
     */
    void suspend(String deploymentId, boolean suspendProcessInstances);

    /**
     * <p>流程激活,该流程会被立即激活,所有提供的进程定义的进程实例也将被激活</p>
     *
     * @param deploymentId 部署id
     * @author hedwing
     * @since 2023/3/12
     */
    default void activate(String deploymentId) {
        activate(deploymentId, true);
    }

    /**
     * <p>流程激活,该流程会被立即激活</p>
     *
     * @param deploymentId             部署id
     * @param activateProcessInstances 如果为真，所有提供的进程定义的进程实例也将被激活。
     * @author hedwing
     * @since 2023/3/12
     */
    void activate(String deploymentId, boolean activateProcessInstances);

    /**
     * <p>删除流程，并且级联删除</p>
     *
     * @param deploymentId 部署id
     * @author hedwing
     * @since 2023/3/12
     */
    void delete(String deploymentId);

    /**
     * <p>获取RepositoryService</p>
     *
     * @return org.flowable.engine.RepositoryService
     * @author hedwing
     * @since 2023/3/11
     */
    RepositoryService getRepositoryService();
}
