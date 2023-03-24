package org.pineapple.system.core.pojo.converter;

import org.pineapple.common.constant.BeanNameDefineConstant;
import org.pineapple.core.converter.BaseConverter;
import org.pineapple.engine.basequery.annotations.DictTranslate;
import org.pineapple.system.core.pojo.entity.SysMenu;
import org.pineapple.system.api.vo.SysMenuVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * <p>系统菜单转换器</p>
 *
 * @author guocq
 * @since 2023/3/22
 */
@Component("sysMenuConverter")
public class SysMenuConverter extends BaseConverter<SysMenu, SysMenuVo> {
    private static final Logger log = LoggerFactory.getLogger(SysMenuConverter.class);

    /**
     * <p>实体对象转换为vo</p>
     *
     * @param entity 实体对象
     * @return {@link SysMenuVo }
     * @author guocq
     * @date 2023/3/20 13:52
     */
    @Override
    @DictTranslate(context = BeanNameDefineConstant.REMOTE_DICTIONARY_CONTEXT)
    public SysMenuVo entityToVo(SysMenu entity) {
        if (entity == null) {
            log.debug("SysUser转SysUserVo时, sysUser为null");
            return null;
        }
        SysMenuVo vo = new SysMenuVo();
        super.entityToVo(entity, vo);
        vo.setId(entity.getId());
        vo.setParentId(entity.getParentId());
        vo.setMenuCode(entity.getMenuCode());
        vo.setMenuName(entity.getMenuName());
        vo.setMenuTitle(entity.getMenuTitle());
        vo.setMenuType(entity.getMenuType());
        vo.setMenuIcon(entity.getMenuIcon());
        vo.setApiUri(entity.getApiUri());
        vo.setViewPageUri(entity.getViewPageUri());
        vo.setViewPageLocation(entity.getViewPageLocation());
        vo.setMenuSort(entity.getMenuSort());
        vo.setMenuDesc(entity.getMenuDesc());
        return vo;
    }
}
