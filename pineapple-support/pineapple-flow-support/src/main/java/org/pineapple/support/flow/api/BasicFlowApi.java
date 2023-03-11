package org.pineapple.support.flow.api;

import org.pineapple.support.flow.pojo.dto.ProcessStartDto;

import javax.servlet.http.HttpServletResponse;

/**
 * <p>流程API接口</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
public interface BasicFlowApi {
    /**
     * <p>流程资源操作</p>
     *
     * @return 流程资源
     * @author hedwing
     * @since 2023/3/11
     */
    BasicFlowApiForRepository repository();

    /**
     * <p>流程运行操作</p>
     *
     * @return 流程运行
     * @author hedwing
     * @since 2023/3/11
     */
    BasicFlowApiForRuntime runtime();

    /**
     * <p>流程任务操作</p>
     *
     * @return 流程任务
     * @author hedwing
     * @since 2023/3/11
     */
    BasicFlowApiForTask task();

    /**
     * <p>流程历史操作</p>
     *
     * @return 流程历史
     * @author hedwing
     * @since 2023/3/11
     */
    BasicFlowApiForHistory history();

    /**
     * <p>生成流程图</p>
     *
     * @param response          相应
     * @param processInstanceId 流程实例id
     * @author hedwing
     * @since 2023/3/11
     */
    void generateProcessDiagram(HttpServletResponse response, String processInstanceId);

    /**
     * <p>流程启动</p>
     *
     * @param dto 流程启动参数
     * @author hedwing
     * @since 2023/3/11
     */
    void startProcess(ProcessStartDto dto);
}
