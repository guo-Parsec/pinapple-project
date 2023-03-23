package org.pineapple.support.flow.pojo.dto;

import com.google.common.collect.Maps;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.pojo.DomainModel;

import java.util.List;
import java.util.Map;
import java.util.StringJoiner;

/**
 * <p>任务完成DTO</p>
 *
 * @author hedwing
 * @since 2023/3/12
 **/
@Setter
@Getter
@ApiModel(value = "任务完成DTO")
public class TaskCompleteDto implements DomainModel {
    private static final long serialVersionUID = 6585507165556766058L;

    @ApiModelProperty(value = "流程id")
    private String taskId;

    @ApiModelProperty(value = "流程相关变量")
    private Map<String, Object> variables;

    @ApiModelProperty(value = "任务完成的用户id")
    private String completeUserId;

    @ApiModelProperty(value = "下一步任务是否指定分配人")
    private boolean nextTaskWithAssignee = false;

    @ApiModelProperty(value = "下一步任务是否指定候选人")
    private boolean nextTaskWithCandidate = true;

    @ApiModelProperty(value = "候选人列表")
    private List<String> candidateUserList;

    @ApiModelProperty(value = "分配人")
    private String assigneeUser;

    public TaskCompleteDto() {
    }

    public TaskCompleteDto(String taskId) {
        this(taskId, null);
    }

    public TaskCompleteDto(String taskId, Map<String, Object> variables) {
        this.taskId = taskId;
        this.variables = variables == null ? Maps.newHashMap() : variables;
    }

    @Override
    public String toString() {
        StringJoiner toStringTemp = new StringJoiner(", ", ProcessStartDto.class.getSimpleName() + "[", "]")
                .add("taskId='" + taskId + "'")
                .add("completeUserId='" + completeUserId + "'")
                .add("variables=" + variables)
                .add("nextTaskWithAssignee=" + nextTaskWithAssignee)
                .add("nextTaskWithCandidate=" + nextTaskWithCandidate);
        if (nextTaskWithAssignee) {
            toStringTemp.add("assigneeUser='" + assigneeUser + "'");
        }
        if (nextTaskWithCandidate) {
            toStringTemp.add("candidateUserList=" + candidateUserList);
        }
        return toStringTemp.toString();
    }
}
