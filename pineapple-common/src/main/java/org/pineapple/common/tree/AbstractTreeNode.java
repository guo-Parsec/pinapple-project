package org.pineapple.common.tree;

import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import org.pineapple.common.pojo.vo.BaseVo;

import java.io.Serializable;
import java.util.Collection;

/**
 * <p>树结构数据节点</p>
 *
 * @author guocq
 * @since 2023/3/22
 */
@Setter
@Getter
public class AbstractTreeNode<K extends Serializable> extends BaseVo implements TreeNode<K> {
    private static final long serialVersionUID = 5028688995092234285L;

    /**
     * 主键
     */
    @ApiModelProperty(value = "主键")
    protected K id;

    /**
     * 父级id
     */
    @ApiModelProperty(value = "父级id")
    protected K parentId;

    /**
     * 子元素id
     */
    @ApiModelProperty(value = "子元素id")
    protected Collection<? extends TreeNode<K>> children;

    /**
     * 是否为根元素
     */
    @ApiModelProperty(value = "是否为根元素")
    protected boolean root;

    /**
     * 是否为叶子节点
     */
    @ApiModelProperty(value = "是否为叶子节点")
    protected boolean leaf;
}
