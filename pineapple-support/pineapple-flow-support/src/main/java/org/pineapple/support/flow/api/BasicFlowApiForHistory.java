package org.pineapple.support.flow.api;

import org.flowable.engine.HistoryService;
import org.flowable.engine.history.HistoricProcessInstance;

/**
 * <p>流程历史</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
public interface BasicFlowApiForHistory {
    /**
     * <p>根据流程实例id判断流程是否完结</p>
     *
     * @param processInstanceId 流程实例id
     * @return boolean
     * @author hedwing
     * @since 2023/3/11
     */
    boolean isFinished(String processInstanceId);

    /**
     * <p>根据流程实例id获取历史流程实例</p>
     *
     * @param processInstanceId 流程实例id
     * @return org.flowable.engine.history.HistoricProcessInstance
     * @author hedwing
     * @since 2023/3/11
     */
    HistoricProcessInstance findHistoricProcessInstanceByProcessInstanceId(String processInstanceId);

    /**
     * <p>获取HistoryService</p>
     *
     * @return org.flowable.engine.HistoryService
     * @author hedwing
     * @since 2023/3/11
     */
    HistoryService getHistoryService();
}
