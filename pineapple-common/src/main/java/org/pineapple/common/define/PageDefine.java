package org.pineapple.common.define;

import com.google.common.collect.Lists;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.AbstractVo;

import java.util.List;

/**
 * <p>分页定义</p>
 *
 * @author hedwing
 * @since 2023/3/11
 **/
@Setter
@Getter
@ApiModel(value = "分页定义")
public class PageDefine<T> extends AbstractVo {
    private static final long serialVersionUID = -8310821916753276896L;

    @ApiModelProperty(value = "当前页")
    private Integer pageIndex;

    @ApiModelProperty(value = "页大小")
    private Integer pageSize;

    @ApiModelProperty(value = "数据记录")
    private List<T> records;

    @ApiModelProperty(value = "总页数")
    private Long total;

    @ApiModelProperty(value = "是否是第一页")
    private boolean firstPage;

    @ApiModelProperty(value = "是否是最后一页")
    private boolean lastPage;

    @ApiModelProperty(value = "页码列表")
    private List<String> pageList;

    public PageDefine(Integer pageIndex, Integer pageSize, List<T> records, Long total) {
        this.pageIndex = pageIndex <= 1 ? 1 : pageIndex;
        this.pageSize = pageSize <= 1 ? 1 : pageSize;
        this.records = records;
        this.total = total;
        this.pageList = Lists.newArrayList();
        long lastPageIndex = total / pageSize + 1;
        this.firstPage = pageIndex == 1;
        this.lastPage = pageIndex == lastPageIndex;
        for (int index = 1; index <= lastPageIndex; index++) {
            this.pageList.add(String.valueOf(index));
        }
    }
}
