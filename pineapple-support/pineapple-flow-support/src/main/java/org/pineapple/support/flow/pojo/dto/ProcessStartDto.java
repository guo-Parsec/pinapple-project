package org.pineapple.support.flow.pojo.dto;

import com.google.common.collect.Maps;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.Map;
import java.util.StringJoiner;

/**
 * <p>流程启动DTO</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
@Setter
@Getter
@ApiModel(value = "流程启动DTO")
public class ProcessStartDto {
    @ApiModelProperty(value = "流程定义key")
    private String processDefinitionKey;

    @ApiModelProperty(value = "流程相关变量")
    private Map<String, Object> variables;

    @ApiModelProperty(value = "启动时是否指定分配人")
    private boolean startWithAssignee = false;

    @ApiModelProperty(value = "启动时是否指定候选人")
    private boolean startWithCandidate = true;

    @ApiModelProperty(value = "候选人列表")
    private List<String> candidateUserList;

    @ApiModelProperty(value = "分配人")
    private String assigneeUser;

    public ProcessStartDto() {
    }

    public ProcessStartDto(String processDefinitionKey) {
        this(processDefinitionKey, null);
    }

    public ProcessStartDto(String processDefinitionKey, Map<String, Object> variables) {
        this.processDefinitionKey = processDefinitionKey;
        this.variables = variables == null ? Maps.newHashMap() : variables;
    }

    @Override
    public String toString() {
        StringJoiner toStringTemp = new StringJoiner(", ", ProcessStartDto.class.getSimpleName() + "[", "]")
                .add("processDefinitionKey='" + processDefinitionKey + "'")
                .add("variables=" + variables)
                .add("startWithAssignee=" + startWithAssignee)
                .add("startWithCandidate=" + startWithCandidate);
        if (startWithAssignee) {
            toStringTemp.add("assigneeUser='" + assigneeUser + "'");
        }
        if (startWithCandidate) {
            toStringTemp.add("candidateUserList=" + candidateUserList);
        }
        return toStringTemp.toString();
    }
}
