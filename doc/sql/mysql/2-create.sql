create table sys_dict
(
    id         bigint                             not null comment '主键'
        primary key,
    type_code  varchar(128)                       not null comment '数据字典类型码',
    type_name  varchar(128)                       not null comment '数据字典类型名',
    dict_val   int                                not null comment '数据字典值',
    display    varchar(128)                       not null comment '数据字典显示',
    sort       int      default 0                 not null comment '数据字典排序值',
    delete_at  bigint   default 0                 not null comment '数据软删除值(未删除时显示为0)',
    gmt_create datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    gmt_modify datetime default CURRENT_TIMESTAMP not null comment '更新时间',
    constraint sys_dict_type_code_dict_val_delete_at_uindex
        unique (type_code, dict_val, delete_at)
)
    comment '系统字典表';

create table sys_menu
(
    id           bigint                                 not null comment '主键' primary key,
    parent_id    bigint                                 not null comment '上级菜单id',
    menu_name    varchar(128)                           not null comment '菜单名称',
    menu_code    varchar(128)                           not null comment '菜单标识',
    menu_type    int(2)                                 not null default 0 comment '菜单类型',
    menu_icon    varchar(128) default '' comment '菜单图标',
    menu_display int(2)       default 0 comment '菜单是否显示',
    sort         int(8)       default 0 comment '菜单排序',
    api_uri      varchar(255) default '' comment '接口uri',
    page_uri     varchar(255) default '' comment '页面uri',
    page_path    varchar(255) default '' comment '页面所在路径',
    menu_desc    varchar(255) default '' comment '菜单描述',
    delete_at    bigint       default 0                 not null comment '数据软删除值(未删除时显示为0)',
    gmt_create   datetime     default CURRENT_TIMESTAMP not null comment '创建时间',
    gmt_modify   datetime     default CURRENT_TIMESTAMP not null comment '更新时间',
    constraint sys_menu_menu_code_delete_at_uindex unique (menu_code, delete_at)
) comment '系统菜单表';

create table sys_role
(
    id         bigint                                 not null comment '主键' primary key,
    role_name  varchar(128)                           not null comment '角色名称',
    role_code  varchar(128)                           not null comment '角色标识',
    sort       int(8)       default 0 comment '角色排序',
    role_desc  varchar(255) default '' comment '角色描述',
    delete_at  bigint       default 0                 not null comment '数据软删除值(未删除时显示为0)',
    gmt_create datetime     default CURRENT_TIMESTAMP not null comment '创建时间',
    gmt_modify datetime     default CURRENT_TIMESTAMP not null comment '更新时间',
    constraint sys_role_role_code_delete_at_uindex unique (role_code, delete_at)
) comment '系统角色表';

create table sys_user
(
    id          bigint                                 not null comment '主键' primary key,
    login_id    varchar(64)                            not null comment '登录id',
    cipher_code varchar(225)                           not null comment '登录密码',
    nickname    varchar(128) default '' comment '用户昵称',
    sex         int(2)       default 0 comment '用户性别',
    avatar_url  varchar(225) default '' comment '头像地址',
    birthday    date                                   null comment '用户出生日期',
    user_type   int(2)       default 0 comment '用户类型',
    user_status int(2)       default 0 comment '用户状态',
    delete_at   bigint       default 0                 not null comment '数据软删除值(未删除时显示为0)',
    gmt_create  datetime     default CURRENT_TIMESTAMP not null comment '创建时间',
    gmt_modify  datetime     default CURRENT_TIMESTAMP not null comment '更新时间',
    constraint sys_user_login_id_delete_at_uindex unique (login_id, delete_at)
) comment '系统用户表';

create table sys_user_role
(
    user_id   bigint       not null comment '关联用户id',
    login_id  varchar(64)  not null comment '关联用户登录id',
    role_id   bigint       not null comment '关联角色id',
    role_code varchar(128) not null comment '关联角色标识'
) comment '系统用户角色关联表';

create table sys_role_menu
(
    role_id   bigint       not null comment '关联角色id',
    role_code varchar(128) not null comment '关联角色标识',
    menu_id   bigint       not null comment '关联菜单id',
    menu_code varchar(128) not null comment '关联菜单标识',
    primary key (role_id, menu_id),
    constraint sys_role_menu_sys_role_id_fk foreign key (role_id) references sys_role (id),
    constraint sys_role_menu_sys_role_role_code_fk foreign key (role_code) references sys_role (role_code),
    constraint sys_role_menu_sys_menu_id_fk foreign key (menu_id) references sys_menu (id),
    constraint sys_role_menu_sys_menu_menu_code_fk foreign key (menu_code) references sys_menu (menu_code),
    constraint sys_role_menu_role_code_menu_code_uindex unique (role_code, menu_code)
) comment '系统角色菜单关联表';

create table sys_user_role
(
    user_id   bigint       not null comment '关联用户id',
    login_id  varchar(64)  not null comment '关联用户登录id',
    role_id   bigint       not null comment '关联角色id',
    role_code varchar(128) not null comment '关联角色标识',
    primary key (user_id, role_id),
    constraint sys_user_role_sys_user_id_fk foreign key (user_id) references sys_user (id),
    constraint sys_user_role_sys_user_login_id_fk foreign key (login_id) references sys_user (login_id),
    constraint sys_user_role_sys_role_id_fk foreign key (role_id) references sys_role (id),
    constraint sys_user_role_sys_role_role_code_fk foreign key (role_code) references sys_role (role_code),
    constraint sys_user_role_login_id_role_code_uindex unique (login_id, role_code)
) comment '系统用户角色关联表';

create table sys_param
(
    id         bigint                             not null comment '主键' primary key,
    group_name varchar(128)                       null comment '分组名称',
    group_code varchar(128)                       null comment '分组标识',
    param_name varchar(128)                       not null comment '参数名称',
    param_code varchar(128)                       not null comment '参数标识',
    param_val  varchar(225)                       not null comment '参数值',
    delete_at  bigint   default 0                 not null comment '数据软删除值(未删除时显示为0)',
    gmt_create datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    gmt_modify datetime default CURRENT_TIMESTAMP not null comment '更新时间',
    constraint sys_param_param_code_delete_at unique (param_code, delete_at)
) comment '系统参数表';

create table mnt_request_code
(
    id          bigint                             not null comment '主键' primary key,
    code_name   varchar(128)                       not null comment '请求码名称',
    code_val    varchar(64)                        not null comment '请求码值',
    code_detail varchar(255)                       not null comment '请求码说明',
    delete_at   bigint   default 0                 not null comment '数据软删除值(未删除时显示为0)',
    gmt_create  datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    gmt_modify  datetime default CURRENT_TIMESTAMP not null comment '更新时间',
    constraint mnt_request_code_code_val_delete_at unique (code_val, delete_at)
) comment '维护请求码表';

create table mnt_operation_log
(
    id            bigint       not null comment '主键' primary key,
    login_id      bigint       null comment '操作人登录id',
    operation_uri varchar(255) not null comment '操作uri',
    operation_ip  varchar(64)  not null comment '操作ip',
    request_code  varchar(64)  not null default '200' comment '请求码',
    error_cause   longtext     null comment '错误原因',
    time_spent    bigint       not null comment '消耗时间',
    time_unit     varchar(64)  not null comment '消耗时间单位',
    log_time      datetime              default CURRENT_TIMESTAMP not null comment '日志记录时间',
    constraint mnt_operation_log_mnt_request_code_request_code_fk foreign key (request_code) references mnt_request_code (code_val)
) comment '维护操作日志表';