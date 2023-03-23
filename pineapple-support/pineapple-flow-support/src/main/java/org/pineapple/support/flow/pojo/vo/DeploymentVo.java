package org.pineapple.support.flow.pojo.vo;

import cn.hutool.core.date.DateUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.flowable.engine.repository.Deployment;
import org.pineapple.common.pojo.vo.AbstractVo;

import java.util.StringJoiner;

/**
 * <p>流程部署VO</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
@Setter
@Getter
@ApiModel(value = "流程部署VO")
public class DeploymentVo extends AbstractVo {
    private static final long serialVersionUID = -4811893317607723573L;
    @ApiModelProperty(value = "流程部署Id")
    private String id;

    @ApiModelProperty(value = "流程部署名称")
    private String name;

    @ApiModelProperty(value = "流程部署key")
    private String key;

    @ApiModelProperty(value = "流程部署时间")
    private String deploymentTime;

    @ApiModelProperty(value = "引擎版本")
    private String engineVersion;

    @Override
    public String toString() {
        return new StringJoiner(", ", DeploymentVo.class.getSimpleName() + "[", "]")
                .add("id='" + id + "'")
                .add("name='" + name + "'")
                .add("key='" + key + "'")
                .add("deploymentTime='" + deploymentTime + "'")
                .add("engineVersion='" + engineVersion + "'")
                .toString();
    }

    /**
     * <p>从{@link Deployment}中构建{@link DeploymentVo}</p>
     *
     * @param deployment deployment
     * @return org.pineapple.support.flow.pojo.vo.DeploymentVo
     * @author hedwing
     * @since 2023/3/12
     */
    public static DeploymentVo buildFormTask(Deployment deployment) {
        DeploymentVo deploymentVo = new DeploymentVo();
        deploymentVo.setId(deployment.getId());
        deploymentVo.setName(deployment.getName());
        deploymentVo.setKey(deployment.getKey());
        deploymentVo.setDeploymentTime(DateUtil.formatDateTime(deployment.getDeploymentTime()));
        deploymentVo.setEngineVersion(deployment.getEngineVersion());
        return deploymentVo;
    }
}
