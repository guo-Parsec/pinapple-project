package org.pineapple.support.flow;

import com.google.common.collect.Lists;
import org.pineapple.support.flow.api.BasicFlowApi;
import org.pineapple.support.flow.pojo.dto.ProcessStartDto;
import org.springframework.stereotype.Component;

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

    public void startCommonTwoStepProcess() {
        ProcessStartDto dto = new ProcessStartDto("common-two-step-process");
        dto.setStartWithCandidate(true);
        dto.setCandidateUserList(Lists.newArrayList("user1","user2","user3"));
        basicFlowApi.startProcess(dto);
    }
}
