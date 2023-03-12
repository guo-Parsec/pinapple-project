package org.pineapple.support.flow.api;

import com.google.common.collect.Lists;
import org.pineapple.support.flow.pojo.dto.TaskCompleteDto;
import org.pineapple.support.flow.pojo.vo.TaskVo;

import java.util.List;

/**
 * <p>流程任务</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
public interface BasicFlowApiForTask {
    /**
     * <p>领取任务</p>
     *
     * @param taskId 任务id
     * @param userId 用户id
     * @author hedwing
     * @since 2023/3/11
     */
    void claim(String taskId, String userId);

    /**
     * <p>根据用户id获取被用户认领的任务</p>
     *
     * @param userId userId
     * @return java.util.List<org.pineapple.support.flow.pojo.vo.TaskVo>
     * @author hedwing
     * @since 2023/3/11
     */
    List<TaskVo> findAssigneeTaskByUserId(String userId);

    /**
     * <p>根据用户id获取被用户认领的任务</p>
     *
     * @param userId            用户id
     * @param processInstanceId 流程实例id
     * @return java.util.List<org.pineapple.support.flow.pojo.vo.TaskVo>
     * @author hedwing
     * @since 2023/3/11
     */
    TaskVo findAssigneeTaskByUserIdAndProcessInstanceId(String userId, String processInstanceId);

    /**
     * <p>根据用户id获取未被用户认领的任务</p>
     *
     * @param userId userId
     * @return java.util.List<org.pineapple.support.flow.pojo.vo.TaskVo>
     * @author hedwing
     * @since 2023/3/11
     */
    List<TaskVo> findUnClaimTaskByUserId(String userId);

    /**
     * <p>分配任务给用户</p>
     *
     * @param processInstanceId 流程实例id
     * @param userId            用户id
     * @author hedwing
     * @since 2023/3/11
     */
    void assignee(String processInstanceId, String userId);

    /**
     * <p>添加任务的候选用户</p>
     *
     * @param processInstanceId 流程实例id
     * @param userId            用户id
     * @author hedwing
     * @since 2023/3/11
     */
    default void addCandidateUser(String processInstanceId, String userId) {
        addCandidateUser(processInstanceId, Lists.newArrayList(userId));
    }

    /**
     * <p>添加任务的候选用户</p>
     *
     * @param processInstanceId 流程实例id
     * @param userIdList        用户id列表
     * @author hedwing
     * @since 2023/3/11
     */
    void addCandidateUser(String processInstanceId, List<String> userIdList);

    /**
     * <p>判断任务{@code taskId}是否为用户{@code userId}所认领的任务</p>
     *
     * @param taskId 任务id
     * @param userId 用户id
     * @return boolean
     * @author hedwing
     * @since 2023/3/12
     */
    boolean isUserAssignee(String taskId, String userId);

    /**
     * <p>完成当前任务</p>
     *
     * @param dto 任务完成DTO
     * @author hedwing
     * @since 2023/3/12
     */
    void complete(TaskCompleteDto dto);
}
