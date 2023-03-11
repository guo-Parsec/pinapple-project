package org.pineapple.support.flow.api.impl;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import com.google.common.collect.Lists;
import org.flowable.engine.TaskService;
import org.flowable.task.api.Task;
import org.pineapple.common.error.ErrorRecords;
import org.pineapple.common.utils.StreamUtil;
import org.pineapple.support.flow.api.BasicFlowApiForTask;
import org.pineapple.support.flow.pojo.vo.TaskVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * <p>流程任务实现类</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
@Component(value = "basicFlowApiForTask")
public class BasicFlowApiForTaskImpl implements BasicFlowApiForTask {
    private static final Logger log = LoggerFactory.getLogger(BasicFlowApiForTaskImpl.class);

    private final TaskService taskService;

    public BasicFlowApiForTaskImpl(TaskService taskService) {
        this.taskService = taskService;
    }

    /**
     * <p>领取任务</p>
     *
     * @param taskId 任务id
     * @param userId 用户id
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public void claim(String taskId, String userId) {
        log.debug("用户[{}]认领任务[{}]", taskId, userId);
        taskService.claim(taskId, userId);
    }

    /**
     * <p>根据用户id获取被用户认领的任务</p>
     *
     * @param userId userId
     * @return java.util.List<org.pineapple.support.flow.pojo.vo.TaskVo>
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public List<TaskVo> findAssigneeTaskByUserId(String userId) {
        log.debug("用户[{}]获取已认领任务", userId);
        List<Task> taskList = taskService.createTaskQuery().taskAssignee(userId).list();
        if (CollUtil.isEmpty(taskList)) {
            log.debug("用户[{}]无已认领任务", userId);
            return Lists.newArrayList();
        }
        return StreamUtil.castElementForList(taskList, TaskVo::buildFormTask);
    }

    /**
     * <p>根据用户id获取未被用户认领的任务</p>
     *
     * @param userId userId
     * @return java.util.List<org.pineapple.support.flow.pojo.vo.TaskVo>
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public List<TaskVo> findUnClaimTaskByUserId(String userId) {
        log.debug("用户[{}]获取未认领任务", userId);
        List<Task> taskList = taskService.createTaskQuery().taskCandidateUser(userId).list();
        if (CollUtil.isEmpty(taskList)) {
            log.debug("用户[{}]无未认领任务", userId);
            return Lists.newArrayList();
        }
        return StreamUtil.castElementForList(taskList, TaskVo::buildFormTask);
    }

    /**
     * <p>分配任务给用户</p>
     *
     * @param processInstanceId 流程实例id
     * @param userId            用户id
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public void assignee(String processInstanceId, String userId) {
        log.debug("向流程实例[{}]分配用户为[{}]", processInstanceId, userId);
        if (StrUtil.isBlank(processInstanceId)) {
            throw ErrorRecords.valid.record(log, "流程实例id不能为空");
        }
        Task task = taskService.createTaskQuery().processInstanceId(processInstanceId)
                .orderByTaskCreateTime()
                .desc()
                .singleResult();
        if (task == null) {
            log.warn("流程实例[{}]不存在任务", processInstanceId);
            return;
        }
        log.debug("向流程实例[{}]最新创建的任务[{}]分配用户", processInstanceId, task.getId());
        taskService.setAssignee(task.getId(), userId);
    }

    /**
     * <p>添加任务的候选用户</p>
     *
     * @param processInstanceId 流程实例id
     * @param userIdList        用户id列表
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public void addCandidateUser(String processInstanceId, List<String> userIdList) {
        log.debug("向流程实例[{}]添加候选用户为{}", processInstanceId, userIdList);
        if (StrUtil.isBlank(processInstanceId)) {
            throw ErrorRecords.valid.record(log, "流程实例id不能为空");
        }
        Task task = taskService.createTaskQuery().processInstanceId(processInstanceId)
                .orderByTaskCreateTime()
                .desc()
                .singleResult();
        if (task == null) {
            log.warn("流程实例[{}]不存在任务", processInstanceId);
            return;
        }
        log.debug("向流程实例[{}]最新创建的任务[{}]添加候选人", processInstanceId, task.getId());
        userIdList.forEach(userId -> taskService.addCandidateUser(task.getId(), userId));
    }
}
