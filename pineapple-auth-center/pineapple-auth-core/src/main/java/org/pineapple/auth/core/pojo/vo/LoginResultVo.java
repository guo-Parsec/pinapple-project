package org.pineapple.auth.core.pojo.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.engine.security.entity.SecuritySignature;
import org.pineapple.system.api.vo.SysMenuVo;

import java.util.List;

/**
 * <p>登录结果返回</p>
 *
 * @author guocq
 * @since 2023/3/24
 */
@Setter
@Getter
@ApiModel(value = "登录结果返回")
public class LoginResultVo {
    @ApiModelProperty(value = "安全签名")
    private SecuritySignature signature;

    @ApiModelProperty(value = "菜单信息")
    private List<SysMenuVo> menuVos;
}
