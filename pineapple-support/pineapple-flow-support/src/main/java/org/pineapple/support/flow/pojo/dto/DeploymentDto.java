package org.pineapple.support.flow.pojo.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.util.StringJoiner;

/**
 * <p>流程部署DTO</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
@Setter
@Getter
@ApiModel(value = "流程部署DTO")
public class DeploymentDto {
    /**
     * 部署id
     */
    @ApiModelProperty(value = "部署id")
    protected String deploymentId;

    /**
     * 部署名称
     */
    @ApiModelProperty(value = "部署名称")
    protected String deploymentName;

    /**
     * 部署key
     */
    @ApiModelProperty(value = "部署key")
    protected String deploymentKey;

    @Override
    public String toString() {
        return new StringJoiner(", ", DeploymentDto.class.getSimpleName() + "[", "]")
                .add("deploymentId='" + deploymentId + "'")
                .add("deploymentName='" + deploymentName + "'")
                .add("deploymentKey='" + deploymentKey + "'")
                .toString();
    }
}
