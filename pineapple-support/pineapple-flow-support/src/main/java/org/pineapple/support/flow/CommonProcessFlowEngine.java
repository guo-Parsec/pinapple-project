package org.pineapple.support.flow;

import cn.hutool.extra.spring.SpringUtil;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.flowable.engine.runtime.ProcessInstance;
import org.pineapple.support.flow.api.BasicFlowApi;
import org.pineapple.support.flow.pojo.dto.ProcessStartDto;
import org.pineapple.support.flow.pojo.dto.TaskCompleteDto;
import org.pineapple.support.flow.pojo.vo.TaskVo;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

/**
 * <p>通用流程引擎</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
@Component(value = "commonProcessFlowEngine")
public class CommonProcessFlowEngine {

    private final BasicFlowApi basicFlowApi;

    public CommonProcessFlowEngine(BasicFlowApi basicFlowApi) {
        this.basicFlowApi = basicFlowApi;
    }

    @Transactional(rollbackFor = Exception.class)
    public void startCommonTwoStepProcess(String startUser) {
        CommonProcessFlowEngine commonProcessFlowEngine = SpringUtil.getBean(CommonProcessFlowEngine.class);
        ProcessStartDto dto = new ProcessStartDto(FlowConstant.COMMON_TWO_STEP_PROCESS_KEY);
        dto.setStartWithAssignee(true);
        dto.setAssigneeUser(startUser);
        ProcessInstance processInstance = basicFlowApi.startProcess(dto);
        TaskVo task = basicFlowApi.task().findAssigneeTaskByUserIdAndProcessInstanceId(startUser, processInstance.getProcessInstanceId());
        commonProcessFlowEngine.submitToConfirm(task.getId(), startUser);
    }

    public void submitToConfirm(String taskId, String userId) {
        Map<String, Object> variables = Maps.newHashMap();
        variables.put("confirmRole", "roleTest");
        TaskCompleteDto dto = new TaskCompleteDto(taskId, variables);
        dto.setCompleteUserId(userId);
        dto.setNextTaskWithCandidate(true);
        dto.setCandidateUserList(Lists.newArrayList("user1", "user2", "user3"));
        basicFlowApi.completeTask(dto);
    }

    public void confirmApply(String taskId, String userId, String confirm) {
        Map<String, Object> variables = Maps.newHashMap();
        variables.put("confirm", confirm);
        variables.put("approveRole", "approveRole");
        TaskCompleteDto dto = new TaskCompleteDto(taskId, variables);
        dto.setCompleteUserId(userId);
        dto.setNextTaskWithCandidate(true);
        dto.setCandidateUserList(Lists.newArrayList("user1", "user2", "user3"));
        basicFlowApi.completeTask(dto);
    }

    public void finalApprove(String taskId, String userId, String approve) {
        Map<String, Object> variables = Maps.newHashMap();
        variables.put("approve", approve);
        TaskCompleteDto dto = new TaskCompleteDto(taskId, variables);
        dto.setCompleteUserId(userId);
        basicFlowApi.completeTask(dto);
    }

}
