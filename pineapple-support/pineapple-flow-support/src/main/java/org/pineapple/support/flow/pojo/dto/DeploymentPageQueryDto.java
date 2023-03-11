package org.pineapple.support.flow.pojo.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.util.StringJoiner;

/**
 * <p>流程部署分页查询DTO</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
@Setter
@Getter
@ApiModel(value = "流程部署分页查询DTO")
public class DeploymentPageQueryDto extends DeploymentDto {
    /**
     * 当前页
     */
    @NotNull(message = "当前页不能为空")
    @Min(value = 1, message = "当前页不能小于1")
    @ApiModelProperty(value = "当前页")
    private Integer pageIndex;

    /**
     * 页大小
     */
    @NotNull(message = "页大小不能为空")
    @Min(value = 1, message = "页大小不能小于1")
    @ApiModelProperty(value = "页大小")
    private Integer pageSize;

    @Override
    public String toString() {
        return new StringJoiner(", ", DeploymentPageQueryDto.class.getSimpleName() + "[", "]")
                .add("pageIndex=" + pageIndex)
                .add("pageSize=" + pageSize)
                .add("deploymentId='" + deploymentId + "'")
                .add("deploymentName='" + deploymentName + "'")
                .add("deploymentKey='" + deploymentKey + "'")
                .toString();
    }
}
