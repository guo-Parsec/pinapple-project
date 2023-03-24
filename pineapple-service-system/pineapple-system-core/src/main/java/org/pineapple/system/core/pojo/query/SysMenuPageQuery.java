package org.pineapple.system.core.pojo.query;

import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.pojo.dto.PageDto;

/**
 * <p>分页查询</p>
 *
 * @author guocq
 * @since 2023/3/23
 */
@Setter
@Getter
public class SysMenuPageQuery extends PageDto {
    /**
     * 查询参数
     */
    private SysMenuQuery queryDto;
}
