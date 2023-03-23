package org.pineapple.common.support.valid;

/**
 * <p>增删改查参数校验分组</p>
 *
 * @author guocq
 * @since 2023/2/16
 */
public interface CurdValidateGroup extends ValidateGroup {
    interface Create extends CurdValidateGroup {
    }
    interface Edit extends CurdValidateGroup {
    }
    interface Page extends CurdValidateGroup {
    }
}
