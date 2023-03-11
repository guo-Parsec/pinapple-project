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
     * <p>获取RepositoryService</p>
     *
     * @return org.flowable.engine.RepositoryService
     * @author hedwing
     * @since 2023/3/11
     */
    RepositoryService getRepositoryService();
}
