package org.pineapple.support.flow.api.impl;

import cn.hutool.core.util.StrUtil;
import com.google.common.collect.Lists;
import org.flowable.bpmn.model.BpmnModel;
import org.flowable.engine.HistoryService;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.ProcessEngineConfiguration;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.image.ProcessDiagramGenerator;
import org.pineapple.common.support.error.ErrorRecords;
import org.pineapple.common.utils.IOUtil;
import org.pineapple.support.flow.api.*;
import org.pineapple.support.flow.pojo.dto.ProcessStartDto;
import org.pineapple.support.flow.pojo.dto.TaskCompleteDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>默认流程API</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
@Component(value = "defaultBasicFlowApi")
public class DefaultBasicFlowApi implements BasicFlowApi {
    private static final Logger log = LoggerFactory.getLogger(DefaultBasicFlowApi.class);

    private final BasicFlowApiForRepository basicFlowApiForRepository;

    private final BasicFlowApiForRuntime basicFlowApiForRuntime;

    private final BasicFlowApiForTask basicFlowApiForTask;

    private final BasicFlowApiForHistory basicFlowApiForHistory;

    private ProcessEngine processEngine;

    /**
     * <p>流程资源操作</p>
     *
     * @return 流程资源
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public BasicFlowApiForRepository repository() {
        return basicFlowApiForRepository;
    }

    /**
     * <p>流程运行操作</p>
     *
     * @return 流程运行
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public BasicFlowApiForRuntime runtime() {
        return basicFlowApiForRuntime;
    }

    /**
     * <p>流程任务操作</p>
     *
     * @return 流程任务
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public BasicFlowApiForTask task() {
        return basicFlowApiForTask;
    }

    /**
     * <p>流程历史操作</p>
     *
     * @return 流程历史
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public BasicFlowApiForHistory history() {
        return basicFlowApiForHistory;
    }

    /**
     * <p>生成流程图</p>
     *
     * @param response          相应
     * @param processInstanceId 流程实例id
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public void generateProcessDiagram(HttpServletResponse response, String processInstanceId) {
        if (StrUtil.isBlank(processInstanceId)) {
            throw ErrorRecords.valid.record(log, "根据流程实例id判断流程是否完结时processInstanceId不能为空");
        }
        String processDefinitionId = this.getProcessDefinitionId(processInstanceId);
        HistoryService historyService = this.basicFlowApiForHistory.getHistoryService();
        List<HistoricActivityInstance> list = historyService.createHistoricActivityInstanceQuery()
                .processInstanceId(processInstanceId)
                .orderByHistoricActivityInstanceStartTime().asc()
                .list();
        List<String> highLightedActivities = list.stream().map(HistoricActivityInstance::getActivityId).collect(Collectors.toList());
        List<String> flows = Lists.newArrayList();
        //获取流程图
        BpmnModel bpmnModel = this.basicFlowApiForRepository.getRepositoryService().getBpmnModel(processDefinitionId);
        drawProcessDiagramInResponse(response, bpmnModel, highLightedActivities, flows);
    }

    /**
     * <p>流程启动</p>
     *
     * @param dto 流程启动参数
     * @return 流程实例
     * @author hedwing
     * @since 2023/3/11
     */
    @Override
    public ProcessInstance startProcess(ProcessStartDto dto) {
        return this.runtime().startProcess(dto);
    }

    /**
     * <p>完成任务</p>
     *
     * @param dto 完成任务dto
     * @author hedwing
     * @since 2023/3/12
     */
    @Override
    public void completeTask(TaskCompleteDto dto) {
        this.task().complete(dto);
    }

    /**
     * <p>绘制流程图到响应内</p>
     *
     * @param response              response
     * @param bpmnModel             bpmnModel
     * @param highLightedActivities highLightedActivities
     * @param flows                 flows
     * @author hedwing
     * @since 2023/3/11
     */
    private void drawProcessDiagramInResponse(HttpServletResponse response, BpmnModel bpmnModel, List<String> highLightedActivities, List<String> flows) {
        ProcessEngineConfiguration config = processEngine.getProcessEngineConfiguration();
        ProcessDiagramGenerator diagramGenerator = config.getProcessDiagramGenerator();
        InputStream in = diagramGenerator.generateDiagram(bpmnModel, "bmp", highLightedActivities, flows, config.getActivityFontName(),
                config.getLabelFontName(), config.getAnnotationFontName(), config.getClassLoader(), 1.0, true);
        OutputStream out = null;
        byte[] buf = new byte[1024];
        int length = 0;
        try {
            out = response.getOutputStream();
            while ((length = in.read(buf)) != -1) {
                out.write(buf, 0, length);
            }
        } catch (IOException e) {
            log.error("操作异常", e);
        } finally {
            IOUtil.closeQuietly(out, (err) -> {
                log.error("输出流关闭失败", err);
            });
            IOUtil.closeQuietly(in, (err) -> {
                log.error("输入流关闭失败", err);
            });
        }
    }

    /**
     * <p>根据流程实例id获取流程定义id</p>
     *
     * @param processInstanceId 流程实例id
     * @return java.lang.String 流程定义id
     * @author hedwing
     * @since 2023/3/11
     */
    private String getProcessDefinitionId(String processInstanceId) {
        if (this.basicFlowApiForHistory.isFinished(processInstanceId)) {
            HistoryService historyService = this.basicFlowApiForHistory.getHistoryService();
            // 如果流程已经结束，则得到结束节点
            HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
            return historicProcessInstance.getProcessDefinitionId();
        }
        // 如果流程没有结束，则取当前活动节点
        // 根据流程实例ID获得当前处于活动状态的ActivityId合集
        RuntimeService runtimeService = this.basicFlowApiForRuntime.getRuntimeService();
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        return processInstance.getProcessDefinitionId();
    }

    public DefaultBasicFlowApi(BasicFlowApiForRepository basicFlowApiForRepository, BasicFlowApiForRuntime basicFlowApiForRuntime, BasicFlowApiForTask basicFlowApiForTask, BasicFlowApiForHistory basicFlowApiForHistory) {
        this.basicFlowApiForRepository = basicFlowApiForRepository;
        this.basicFlowApiForRuntime = basicFlowApiForRuntime;
        this.basicFlowApiForTask = basicFlowApiForTask;
        this.basicFlowApiForHistory = basicFlowApiForHistory;
    }

    @Autowired
    public void setProcessEngine(ProcessEngine processEngine) {
        this.processEngine = processEngine;
    }
}
