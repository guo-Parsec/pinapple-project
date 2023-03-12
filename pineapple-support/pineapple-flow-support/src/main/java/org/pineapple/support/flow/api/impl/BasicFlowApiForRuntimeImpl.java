package org.pineapple.support.flow.api.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.runtime.ProcessInstance;
import org.pineapple.common.error.ErrorRecords;
import org.pineapple.support.flow.api.BasicFlowApiForRuntime;
import org.pineapple.support.flow.api.BasicFlowApiForTask;
import org.pineapple.support.flow.pojo.dto.ProcessStartDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>流程运行实现类</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
@Component(value = "basicFlowApiForRuntime")
public class BasicFlowApiForRuntimeImpl implements BasicFlowApiForRuntime {
    private static final Logger log = LoggerFactory.getLogger(BasicFlowApiForRuntimeImpl.class);

    private final RuntimeService runtimeService;

    private BasicFlowApiForTask basicFlowApiForTask;

    public BasicFlowApiForRuntimeImpl(RuntimeService runtimeService) {
        this.runtimeService = runtimeService;
    }

    /**
     * <p>获取RuntimeService</p>
     *
     * @return org.flowable.engine.RuntimeService
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public RuntimeService getRuntimeService() {
        return runtimeService;
    }

    /**
     * <p>流程启动</p>
     *
     * @param dto 流程启动参数
     * @return
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public ProcessInstance startProcess(ProcessStartDto dto) {
        log.debug("流程开始启动, 入参={}", dto);
        if (dto == null || StrUtil.isBlank(dto.getProcessDefinitionKey())) {
            throw ErrorRecords.valid.record(log, "流程定义id不能为空");
        }
        String processDefinitionKey = dto.getProcessDefinitionKey();
        ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(processDefinitionKey, dto.getVariables());
        if (processInstance == null) {
            throw ErrorRecords.valid.record(log, "流程[{}]启动失败", dto.getProcessDefinitionKey());
        }
        String processInstanceId = processInstance.getProcessInstanceId();
        if (dto.isStartWithAssignee() && StrUtil.isNotBlank(dto.getAssigneeUser())) {
            String assigneeUser = dto.getAssigneeUser();
            basicFlowApiForTask.assignee(processInstanceId, assigneeUser);
        }
        if (dto.isStartWithCandidate() && CollUtil.isNotEmpty(dto.getCandidateUserList())) {
            List<String> candidateUserList = dto.getCandidateUserList();
            basicFlowApiForTask.addCandidateUser(processInstanceId, candidateUserList);
        }
        log.debug("流程[{}]已被成功发起,流程信息为[processDefinitionId={}]", processInstance.getName(), processInstance.getProcessDefinitionId());
        return processInstance;
    }

    @Autowired
    public void setBasicFlowApiForTask(BasicFlowApiForTask basicFlowApiForTask) {
        this.basicFlowApiForTask = basicFlowApiForTask;
    }
}
