package org.pineapple.system.core.pojo.converter;

import cn.hutool.core.date.LocalDateTimeUtil;
import cn.hutool.core.util.StrUtil;
import org.pineapple.common.constant.BeanNameDefineConstant;
import org.pineapple.core.converter.BaseConverter;
import org.pineapple.engine.basequery.annotations.DictTranslate;
import org.pineapple.system.api.vo.SysUserVo;
import org.pineapple.system.core.pojo.entity.SysUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * <p>系统用户转换类</p>
 *
 * @author guocq
 * @since 2023/3/14
 */
@Component("sysUserConverter")
public class SysUserConverter extends BaseConverter<SysUser, SysUserVo> {
    private static final Logger log = LoggerFactory.getLogger(SysUserConverter.class);

    /**
     * <p>实体类转vo</p>
     *
     * @param sysUser 用户实体
     * @return {@link org.pineapple.system.api.vo.SysUserVo }
     * @author guocq
     * @date 2023/3/14 11:17
     */
    @DictTranslate(context = BeanNameDefineConstant.REMOTE_DICTIONARY_CONTEXT)
    public SysUserVo entityToVo(SysUser sysUser) {
        if (sysUser == null) {
            log.debug("SysUser转SysUserVo时, sysUser为null");
            return null;
        }
        SysUserVo vo = new SysUserVo();
        super.entityToVo(sysUser, vo);
        vo.setId(StrUtil.toStringOrNull(sysUser.getId()));
        vo.setLoginId(sysUser.getLoginId());
        vo.setLoginPassword(sysUser.getLoginPassword());
        vo.setNickname(sysUser.getNickname());
        vo.setLastName(sysUser.getLastName());
        vo.setFirstName(sysUser.getFirstName());
        vo.setAvatarUrl(sysUser.getAvatarUrl());
        vo.setSexCode(sysUser.getSexCode());
        vo.setUserType(sysUser.getUserType());
        vo.setUserStatus(sysUser.getUserStatus());
        vo.setBirthday(LocalDateTimeUtil.formatNormal(sysUser.getBirthday()));
        return vo;
    }
}
