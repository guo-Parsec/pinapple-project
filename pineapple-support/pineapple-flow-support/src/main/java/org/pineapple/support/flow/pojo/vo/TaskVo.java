package org.pineapple.support.flow.pojo.vo;

import cn.hutool.core.date.DateUtil;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.flowable.task.api.Task;
import org.pineapple.common.AbstractVo;

import java.util.StringJoiner;

/**
 * <p>任务信息</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
@Setter
@Getter
@ApiModel(value = "任务信息")
public class TaskVo extends AbstractVo {
    private static final long serialVersionUID = 1L;
    @ApiModelProperty(value = "任务id")
    private String id;

    @ApiModelProperty(value = "任务名称")
    private String name;

    @ApiModelProperty(value = "流程实例id")
    private String processInstanceId;

    @ApiModelProperty(value = "流程定义id")
    private String processDefinitionId;

    @ApiModelProperty(value = "任务定义id")
    private String taskDefinitionId;

    @ApiModelProperty(value = "任务定义key")
    private String taskDefinitionKey;

    @ApiModelProperty(value = "当前承办人")
    private String assignee;

    @ApiModelProperty(value = "认领时间")
    private String claimTime;

    @ApiModelProperty(value = "创建时间")
    private String createTime;

    @Override
    public String toString() {
        return new StringJoiner(", ", TaskVo.class.getSimpleName() + "[", "]")
                .add("id='" + id + "'")
                .add("name='" + name + "'")
                .add("processInstanceId='" + processInstanceId + "'")
                .add("processDefinitionId='" + processDefinitionId + "'")
                .add("taskDefinitionKey='" + taskDefinitionKey + "'")
                .toString();
    }

    /**
     * <p>从{@link Task}中构建{@link TaskVo}</p>
     *
     * @param task task
     * @return org.pineapple.support.flow.pojo.vo.TaskVo
     * @author hedwing
     * @since 2023/3/11
     */
    public static TaskVo buildFormTask(Task task) {
        TaskVo taskVo = new TaskVo();
        taskVo.setId(task.getId());
        taskVo.setName(task.getName());
        taskVo.setProcessInstanceId(task.getProcessInstanceId());
        taskVo.setProcessDefinitionId(task.getProcessDefinitionId());
        taskVo.setTaskDefinitionId(task.getTaskDefinitionId());
        taskVo.setTaskDefinitionKey(task.getTaskDefinitionKey());
        taskVo.setAssignee(task.getAssignee());
        taskVo.setClaimTime(DateUtil.formatDateTime(task.getClaimTime()));
        taskVo.setCreateTime(DateUtil.formatDateTime(task.getCreateTime()));
        return taskVo;
    }
}
