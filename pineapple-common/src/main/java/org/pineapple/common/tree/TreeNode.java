package org.pineapple.common.tree;

import org.pineapple.common.pojo.DomainModel;

import java.io.Serializable;
import java.util.Collection;

/**
 * <p>树节点数据</p>
 *
 * @author guocq
 * @since 2023/3/22
 */
public interface TreeNode<K extends Serializable> extends DomainModel {
    /**
     * <p>获取主键</p>
     *
     * @return K 主键
     * @author guocq
     * @date 2023/1/16 16:49
     */
    K getId();

    /**
     * <p>获取父级主键</p>
     *
     * @return K 父级主键
     * @author guocq
     * @date 2023/1/16 16:49
     */
    K getParentId();

    /**
     * <p>设置子元素集合</p>
     *
     * @param children 子元素集合
     * @author guocq
     * @date 2023/1/16 16:50
     */
    void setChildren(Collection<? extends TreeNode<K>> children);

    /**
     * <p>获取子元素集合</p>
     *
     * @return {@link Collection}
     * @author guocq
     * @date 2023/1/16 16:54
     */
    Collection<? extends TreeNode<K>> getChildren();

    /**
     * <p>是否根节点</p>
     *
     * @return boolean
     * @author guocq
     * @date  2023/1/18 16:31
     */
    boolean isRoot();

    /**
     * <p>设置是否根节点</p>
     *
     * @param root 是否为根节点
     * @author guocq
     * @date  2023/1/18 16:31
     */
    void setRoot(boolean root);

    /**
     * <p>设置是否为叶子节点</p>
     *
     * @param isLeaf 是否为叶子节点
     * @author guocq
     * @date 2023/1/18 16:31
     */
    void setLeaf(boolean isLeaf);

    /**
     * <p>是否为叶子节点</p>
     *
     * @return java.lang.Boolean
     * @author guocq
     * @date 2023/1/18 16:31
     */
    boolean isLeaf();
}
