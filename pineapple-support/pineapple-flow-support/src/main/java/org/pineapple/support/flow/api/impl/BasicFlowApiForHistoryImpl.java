package org.pineapple.support.flow.api.impl;

import cn.hutool.core.util.StrUtil;
import org.flowable.engine.HistoryService;
import org.flowable.engine.history.HistoricProcessInstance;
import org.pineapple.common.support.error.ErrorRecords;
import org.pineapple.support.flow.api.BasicFlowApiForHistory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * <p>流程历史实现类</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
@Component(value = "basicFlowApiForHistory")
public class BasicFlowApiForHistoryImpl implements BasicFlowApiForHistory {
    private static final Logger log = LoggerFactory.getLogger(BasicFlowApiForHistoryImpl.class);

    final HistoryService historyService;

    public BasicFlowApiForHistoryImpl(HistoryService historyService) {
        this.historyService = historyService;
    }

    /**
     * <p>根据流程实例id判断流程是否完结</p>
     *
     * @param processInstanceId 流程实例id
     * @return boolean
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public boolean isFinished(String processInstanceId) {
        if (StrUtil.isBlank(processInstanceId)) {
            throw ErrorRecords.valid.record(log, "根据流程实例id判断流程是否完结时processInstanceId不能为空");
        }
        return historyService.createHistoricProcessInstanceQuery()
                .finished()
                .processInstanceId(processInstanceId).count() > 0;
    }

    /**
     * <p>根据流程实例id获取历史流程实例</p>
     *
     * @param processInstanceId 流程实例id
     * @return org.flowable.engine.history.HistoricProcessInstance
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public HistoricProcessInstance findHistoricProcessInstanceByProcessInstanceId(String processInstanceId) {
        if (StrUtil.isBlank(processInstanceId)) {
            throw ErrorRecords.valid.record(log, "根据流程实例id判断流程是否完结时processInstanceId不能为空");
        }
        return historyService.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
    }

    @Override
    public HistoryService getHistoryService() {
        return historyService;
    }
}
