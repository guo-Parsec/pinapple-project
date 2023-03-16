package org.pineapple.system.core.service.impl;

import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import org.pineapple.common.annotations.NotBlank;
import org.pineapple.common.annotations.Valid;
import org.pineapple.common.annotations.Validator;
import org.pineapple.system.api.vo.SysUserVo;
import org.pineapple.system.core.mapper.SysUserMapper;
import org.pineapple.system.core.pojo.converter.SysUserConverter;
import org.pineapple.system.core.pojo.entity.SysUser;
import org.pineapple.system.core.service.SysUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * <p> 系统用户信息表 服务实现类 </p>
 *
 * @author guocq
 * @since 2023-03-13
 */
@Validator
@Service(value = "sysUserService")
public class SysUserServiceImpl implements SysUserService {
    private static final Logger log = LoggerFactory.getLogger(SysUserServiceImpl.class);

    @Resource
    private SysUserMapper sysUserMapper;

    /**
     * <p>加载系统用户</p>
     *
     * @param loginId 登录凭证
     * @return {@link SysUserVo }
     * @author guocq
     * @date 2023/3/14 11:17
     */
    @Cacheable(cacheNames = {"sys_user_vo_single"}, key = "'login_id_' + #loginId")
    @Valid(notBlank = {@NotBlank(value = "#loginId", message = "登录凭证不能为空")})
    @Override
    public SysUserVo loadUser(String loginId) {
        log.debug("根据登录凭证[loginId={}]加载用户", loginId);
        SysUser sysUser = new LambdaQueryChainWrapper<>(sysUserMapper)
                .eq(SysUser::getLoginId, loginId)
                .one();
        if (sysUser == null) {
            log.debug("根据登录凭证[loginId={}]加载用户不存在", loginId);
        }
        return SysUserConverter.entityToVo(sysUser);
    }
}
