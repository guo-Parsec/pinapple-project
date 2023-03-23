package org.pineapple.common.pojo;

/**
 * <p>领域模型抽象类</p>
 *
 * @author guocq
 * @since 2023/1/31
 */
public abstract class AbstractDomainModel implements DomainModel {
    private static final long serialVersionUID = 7313923667182552010L;

    public AbstractDomainModel() {
    }

    @Override
    public AbstractDomainModel clone() {
        try {
            return (AbstractDomainModel) super.clone();
        } catch (CloneNotSupportedException exception) {
            return null;
        }
    }

    /**
     * <p>领域模型toString方法</p>
     *
     * @return java.lang.String
     * @author guocq
     * @date 2023/1/31 15:19
     * @see Object#toString()
     */
    @Override
    public String toString() {
        return super.toString();
    }


    /**
     * <p>简短对象信息转toString</p>
     *
     * @return java.lang.String
     * @author guocq
     * @date 2023/1/31 17:28
     */
    public String simpleToString() {
        return this.toString();
    }
}
