--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS pineapple;
--
-- Name: pineapple; Type: DATABASE; Schema: -; Owner: pineapple
--

-- CREATE DATABASE pineapple WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE pineapple OWNER TO pineapple;

\connect pineapple

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE pineapple; Type: COMMENT; Schema: -; Owner: pineapple
--

COMMENT ON DATABASE pineapple IS 'pineapple-project';


--
-- Name: authorization; Type: SCHEMA; Schema: -; Owner: pineapple
--

CREATE SCHEMA "authorization";


ALTER SCHEMA "authorization" OWNER TO pineapple;

--
-- Name: SCHEMA "authorization"; Type: COMMENT; Schema: -; Owner: pineapple
--

COMMENT ON SCHEMA "authorization" IS '认证服务';


--
-- Name: flow; Type: SCHEMA; Schema: -; Owner: pineapple
--

CREATE SCHEMA flow;


ALTER SCHEMA flow OWNER TO pineapple;

--
-- Name: SCHEMA flow; Type: COMMENT; Schema: -; Owner: pineapple
--

COMMENT ON SCHEMA flow IS '流程';


--
-- Name: nacos; Type: SCHEMA; Schema: -; Owner: pineapple
--

CREATE SCHEMA nacos;


ALTER SCHEMA nacos OWNER TO pineapple;

--
-- Name: SCHEMA nacos; Type: COMMENT; Schema: -; Owner: pineapple
--

COMMENT ON SCHEMA nacos IS 'nacos服务';


--
-- Name: system; Type: SCHEMA; Schema: -; Owner: pineapple
--

CREATE SCHEMA system;


ALTER SCHEMA system OWNER TO pineapple;

--
-- Name: SCHEMA system; Type: COMMENT; Schema: -; Owner: pineapple
--

COMMENT ON SCHEMA system IS '系统模块模式';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: oauth_access_token; Type: TABLE; Schema: authorization; Owner: pineapple
--

CREATE TABLE "authorization".oauth_access_token (
    token_id character varying(256),
    token bytea,
    authentication_id character varying(256) NOT NULL,
    user_name character varying(256),
    client_id character varying(256),
    authentication bytea,
    refresh_token character varying(256)
);


ALTER TABLE "authorization".oauth_access_token OWNER TO pineapple;

--
-- Name: TABLE oauth_access_token; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON TABLE "authorization".oauth_access_token IS '认证授权Token记录表';


--
-- Name: COLUMN oauth_access_token.token_id; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_access_token.token_id IS 'Token标识';


--
-- Name: COLUMN oauth_access_token.token; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_access_token.token IS 'OAuth2AccessToken.java对象序列化内容';


--
-- Name: COLUMN oauth_access_token.authentication_id; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_access_token.authentication_id IS '根据当前的username、client_id与scope通过MD5加密生成该字段的值';


--
-- Name: COLUMN oauth_access_token.user_name; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_access_token.user_name IS '用户名，若客户端没有用户名则该值等于client_id';


--
-- Name: COLUMN oauth_access_token.client_id; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_access_token.client_id IS '认证授权客户端ID';


--
-- Name: COLUMN oauth_access_token.authentication; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_access_token.authentication IS 'OAuth2Authentication.java对象序列化内容';


--
-- Name: COLUMN oauth_access_token.refresh_token; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_access_token.refresh_token IS 'RefreshToken标识：通过MD5加密refresh_token的值';


--
-- Name: oauth_client_details; Type: TABLE; Schema: authorization; Owner: pineapple
--

CREATE TABLE "authorization".oauth_client_details (
    client_id character varying(256) NOT NULL,
    resource_ids text,
    client_secret character varying(256),
    scope text,
    authorized_grant_types text,
    web_server_redirect_uri character varying(256),
    authorities text,
    access_token_validity character varying(128),
    refresh_token_validity character varying(128),
    additional_information text,
    autoapprove character varying(32)
);


ALTER TABLE "authorization".oauth_client_details OWNER TO pineapple;

--
-- Name: TABLE oauth_client_details; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON TABLE "authorization".oauth_client_details IS '客户端详细信息表';


--
-- Name: COLUMN oauth_client_details.client_id; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_client_details.client_id IS '主键，客户端ID';


--
-- Name: COLUMN oauth_client_details.resource_ids; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_client_details.resource_ids IS '客户端所能访问的资源id集合，多个资源时用逗号(,)分隔';


--
-- Name: COLUMN oauth_client_details.client_secret; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_client_details.client_secret IS '客户端访问密匙';


--
-- Name: COLUMN oauth_client_details.scope; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_client_details.scope IS '客户端申请的权限范围，可选值包括read,write,trust;若有多个权限范围用逗号(,)分隔';


--
-- Name: COLUMN oauth_client_details.authorized_grant_types; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_client_details.authorized_grant_types IS '客户端支持的授权许可类型(grant_type)，可选值包括authorization_code,password,refresh_token,implicit,client_credentials,若支持多个授权许可类型用逗号(,)分隔';


--
-- Name: COLUMN oauth_client_details.web_server_redirect_uri; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_client_details.web_server_redirect_uri IS '客户端重定向URI，当grant_type为authorization_code或implicit时, 在Oauth的流程中会使用并检查与数据库内的redirect_uri是否一致';


--
-- Name: COLUMN oauth_client_details.authorities; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_client_details.authorities IS '客户端所拥有的Spring Security的权限值,可选, 若有多个权限值,用逗号(,)分隔';


--
-- Name: COLUMN oauth_client_details.access_token_validity; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_client_details.access_token_validity IS '设定客户端的access_token的有效时间值(单位:秒)，若不设定值则使用默认的有效时间值(60 * 60 * 12, 12小时)';


--
-- Name: COLUMN oauth_client_details.refresh_token_validity; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_client_details.refresh_token_validity IS '设定客户端的refresh_token的有效时间值(单位:秒)，若不设定值则使用默认的有效时间值(60 * 60 * 24 * 30, 30天)';


--
-- Name: COLUMN oauth_client_details.additional_information; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_client_details.additional_information IS '这是一个预留的字段,在Oauth的流程中没有实际的使用,可选,但若设置值,必须是JSON格式的数据';


--
-- Name: COLUMN oauth_client_details.autoapprove; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_client_details.autoapprove IS '设置用户是否自动批准授予权限操作, 默认值为 ‘false’, 可选值包括 ‘true’,‘false’, ‘read’,‘write’.';


--
-- Name: oauth_code; Type: TABLE; Schema: authorization; Owner: pineapple
--

CREATE TABLE "authorization".oauth_code (
    code character varying(256),
    authentication bytea
);


ALTER TABLE "authorization".oauth_code OWNER TO pineapple;

--
-- Name: TABLE oauth_code; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON TABLE "authorization".oauth_code IS '授权码Code记录表';


--
-- Name: COLUMN oauth_code.code; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_code.code IS '存储服务端系统生成的code的值(未加密)';


--
-- Name: COLUMN oauth_code.authentication; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_code.authentication IS 'AuthorizationRequestHolder.java对象序列化内容';


--
-- Name: oauth_refresh_token; Type: TABLE; Schema: authorization; Owner: pineapple
--

CREATE TABLE "authorization".oauth_refresh_token (
    token_id character varying(256),
    token bytea,
    authentication bytea
);


ALTER TABLE "authorization".oauth_refresh_token OWNER TO pineapple;

--
-- Name: TABLE oauth_refresh_token; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON TABLE "authorization".oauth_refresh_token IS '刷新授权Token记录表';


--
-- Name: COLUMN oauth_refresh_token.token_id; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_refresh_token.token_id IS 'RefreshToken标识：通过MD5加密refresh_token的值';


--
-- Name: COLUMN oauth_refresh_token.token; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_refresh_token.token IS 'OAuth2RefreshToken.java对象序列化内容';


--
-- Name: COLUMN oauth_refresh_token.authentication; Type: COMMENT; Schema: authorization; Owner: pineapple
--

COMMENT ON COLUMN "authorization".oauth_refresh_token.authentication IS 'OAuth2Authentication.java对象序列化内容';


--
-- Name: act_evt_log; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_evt_log (
    log_nr_ integer NOT NULL,
    type_ character varying(64),
    proc_def_id_ character varying(64),
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    time_stamp_ timestamp without time zone NOT NULL,
    user_id_ character varying(255),
    data_ bytea,
    lock_owner_ character varying(255),
    lock_time_ timestamp without time zone,
    is_processed_ smallint DEFAULT 0
);


ALTER TABLE flow.act_evt_log OWNER TO pineapple;

--
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE; Schema: flow; Owner: pineapple
--

CREATE SEQUENCE flow.act_evt_log_log_nr__seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE flow.act_evt_log_log_nr__seq OWNER TO pineapple;

--
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE OWNED BY; Schema: flow; Owner: pineapple
--

ALTER SEQUENCE flow.act_evt_log_log_nr__seq OWNED BY flow.act_evt_log.log_nr_;


--
-- Name: act_ge_bytearray; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ge_bytearray (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    deployment_id_ character varying(64),
    bytes_ bytea,
    generated_ boolean
);


ALTER TABLE flow.act_ge_bytearray OWNER TO pineapple;

--
-- Name: act_ge_property; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ge_property (
    name_ character varying(64) NOT NULL,
    value_ character varying(300),
    rev_ integer
);


ALTER TABLE flow.act_ge_property OWNER TO pineapple;

--
-- Name: act_hi_actinst; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_hi_actinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_def_id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64) NOT NULL,
    execution_id_ character varying(64) NOT NULL,
    act_id_ character varying(255) NOT NULL,
    task_id_ character varying(64),
    call_proc_inst_id_ character varying(64),
    act_name_ character varying(255),
    act_type_ character varying(255) NOT NULL,
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    transaction_order_ integer,
    duration_ bigint,
    delete_reason_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE flow.act_hi_actinst OWNER TO pineapple;

--
-- Name: act_hi_attachment; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_hi_attachment (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    user_id_ character varying(255),
    name_ character varying(255),
    description_ character varying(4000),
    type_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    url_ character varying(4000),
    content_id_ character varying(64),
    time_ timestamp without time zone
);


ALTER TABLE flow.act_hi_attachment OWNER TO pineapple;

--
-- Name: act_hi_comment; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_hi_comment (
    id_ character varying(64) NOT NULL,
    type_ character varying(255),
    time_ timestamp without time zone NOT NULL,
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    action_ character varying(255),
    message_ character varying(4000),
    full_msg_ bytea
);


ALTER TABLE flow.act_hi_comment OWNER TO pineapple;

--
-- Name: act_hi_detail; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_hi_detail (
    id_ character varying(64) NOT NULL,
    type_ character varying(255) NOT NULL,
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    act_inst_id_ character varying(64),
    name_ character varying(255) NOT NULL,
    var_type_ character varying(64),
    rev_ integer,
    time_ timestamp without time zone NOT NULL,
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000)
);


ALTER TABLE flow.act_hi_detail OWNER TO pineapple;

--
-- Name: act_hi_entitylink; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_hi_entitylink (
    id_ character varying(64) NOT NULL,
    link_type_ character varying(255),
    create_time_ timestamp without time zone,
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    parent_element_id_ character varying(255),
    ref_scope_id_ character varying(255),
    ref_scope_type_ character varying(255),
    ref_scope_definition_id_ character varying(255),
    root_scope_id_ character varying(255),
    root_scope_type_ character varying(255),
    hierarchy_type_ character varying(255)
);


ALTER TABLE flow.act_hi_entitylink OWNER TO pineapple;

--
-- Name: act_hi_identitylink; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_hi_identitylink (
    id_ character varying(64) NOT NULL,
    group_id_ character varying(255),
    type_ character varying(255),
    user_id_ character varying(255),
    task_id_ character varying(64),
    create_time_ timestamp without time zone,
    proc_inst_id_ character varying(64),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255)
);


ALTER TABLE flow.act_hi_identitylink OWNER TO pineapple;

--
-- Name: act_hi_procinst; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_hi_procinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_inst_id_ character varying(64) NOT NULL,
    business_key_ character varying(255),
    proc_def_id_ character varying(64) NOT NULL,
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    duration_ bigint,
    start_user_id_ character varying(255),
    start_act_id_ character varying(255),
    end_act_id_ character varying(255),
    super_process_instance_id_ character varying(64),
    delete_reason_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    name_ character varying(255),
    callback_id_ character varying(255),
    callback_type_ character varying(255),
    reference_id_ character varying(255),
    reference_type_ character varying(255)
);


ALTER TABLE flow.act_hi_procinst OWNER TO pineapple;

--
-- Name: act_hi_taskinst; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_hi_taskinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_def_id_ character varying(64),
    task_def_id_ character varying(64),
    task_def_key_ character varying(255),
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    propagated_stage_inst_id_ character varying(255),
    name_ character varying(255),
    parent_task_id_ character varying(64),
    description_ character varying(4000),
    owner_ character varying(255),
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    claim_time_ timestamp without time zone,
    end_time_ timestamp without time zone,
    duration_ bigint,
    delete_reason_ character varying(4000),
    priority_ integer,
    due_date_ timestamp without time zone,
    form_key_ character varying(255),
    category_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    last_updated_time_ timestamp without time zone
);


ALTER TABLE flow.act_hi_taskinst OWNER TO pineapple;

--
-- Name: act_hi_tsk_log; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_hi_tsk_log (
    id_ integer NOT NULL,
    type_ character varying(64),
    task_id_ character varying(64) NOT NULL,
    time_stamp_ timestamp without time zone NOT NULL,
    user_id_ character varying(255),
    data_ character varying(4000),
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64),
    scope_id_ character varying(255),
    scope_definition_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE flow.act_hi_tsk_log OWNER TO pineapple;

--
-- Name: act_hi_tsk_log_id__seq; Type: SEQUENCE; Schema: flow; Owner: pineapple
--

CREATE SEQUENCE flow.act_hi_tsk_log_id__seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE flow.act_hi_tsk_log_id__seq OWNER TO pineapple;

--
-- Name: act_hi_tsk_log_id__seq; Type: SEQUENCE OWNED BY; Schema: flow; Owner: pineapple
--

ALTER SEQUENCE flow.act_hi_tsk_log_id__seq OWNED BY flow.act_hi_tsk_log.id_;


--
-- Name: act_hi_varinst; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_hi_varinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    name_ character varying(255) NOT NULL,
    var_type_ character varying(100),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000),
    create_time_ timestamp without time zone,
    last_updated_time_ timestamp without time zone
);


ALTER TABLE flow.act_hi_varinst OWNER TO pineapple;

--
-- Name: act_id_bytearray; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_id_bytearray (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    bytes_ bytea
);


ALTER TABLE flow.act_id_bytearray OWNER TO pineapple;

--
-- Name: act_id_group; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_id_group (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    type_ character varying(255)
);


ALTER TABLE flow.act_id_group OWNER TO pineapple;

--
-- Name: act_id_info; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_id_info (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    user_id_ character varying(64),
    type_ character varying(64),
    key_ character varying(255),
    value_ character varying(255),
    password_ bytea,
    parent_id_ character varying(255)
);


ALTER TABLE flow.act_id_info OWNER TO pineapple;

--
-- Name: act_id_membership; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_id_membership (
    user_id_ character varying(64) NOT NULL,
    group_id_ character varying(64) NOT NULL
);


ALTER TABLE flow.act_id_membership OWNER TO pineapple;

--
-- Name: act_id_priv; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_id_priv (
    id_ character varying(64) NOT NULL,
    name_ character varying(255) NOT NULL
);


ALTER TABLE flow.act_id_priv OWNER TO pineapple;

--
-- Name: act_id_priv_mapping; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_id_priv_mapping (
    id_ character varying(64) NOT NULL,
    priv_id_ character varying(64) NOT NULL,
    user_id_ character varying(255),
    group_id_ character varying(255)
);


ALTER TABLE flow.act_id_priv_mapping OWNER TO pineapple;

--
-- Name: act_id_property; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_id_property (
    name_ character varying(64) NOT NULL,
    value_ character varying(300),
    rev_ integer
);


ALTER TABLE flow.act_id_property OWNER TO pineapple;

--
-- Name: act_id_token; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_id_token (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    token_value_ character varying(255),
    token_date_ timestamp without time zone,
    ip_address_ character varying(255),
    user_agent_ character varying(255),
    user_id_ character varying(255),
    token_data_ character varying(2000)
);


ALTER TABLE flow.act_id_token OWNER TO pineapple;

--
-- Name: act_id_user; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_id_user (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    first_ character varying(255),
    last_ character varying(255),
    display_name_ character varying(255),
    email_ character varying(255),
    pwd_ character varying(255),
    picture_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE flow.act_id_user OWNER TO pineapple;

--
-- Name: act_procdef_info; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_procdef_info (
    id_ character varying(64) NOT NULL,
    proc_def_id_ character varying(64) NOT NULL,
    rev_ integer,
    info_json_id_ character varying(64)
);


ALTER TABLE flow.act_procdef_info OWNER TO pineapple;

--
-- Name: act_re_deployment; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_re_deployment (
    id_ character varying(64) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    key_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    deploy_time_ timestamp without time zone,
    derived_from_ character varying(64),
    derived_from_root_ character varying(64),
    parent_deployment_id_ character varying(255),
    engine_version_ character varying(255)
);


ALTER TABLE flow.act_re_deployment OWNER TO pineapple;

--
-- Name: act_re_model; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_re_model (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    key_ character varying(255),
    category_ character varying(255),
    create_time_ timestamp without time zone,
    last_update_time_ timestamp without time zone,
    version_ integer,
    meta_info_ character varying(4000),
    deployment_id_ character varying(64),
    editor_source_value_id_ character varying(64),
    editor_source_extra_value_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE flow.act_re_model OWNER TO pineapple;

--
-- Name: act_re_procdef; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_re_procdef (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    name_ character varying(255),
    key_ character varying(255) NOT NULL,
    version_ integer NOT NULL,
    deployment_id_ character varying(64),
    resource_name_ character varying(4000),
    dgrm_resource_name_ character varying(4000),
    description_ character varying(4000),
    has_start_form_key_ boolean,
    has_graphical_notation_ boolean,
    suspension_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    derived_from_ character varying(64),
    derived_from_root_ character varying(64),
    derived_version_ integer DEFAULT 0 NOT NULL,
    engine_version_ character varying(255)
);


ALTER TABLE flow.act_re_procdef OWNER TO pineapple;

--
-- Name: act_ru_actinst; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ru_actinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_def_id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64) NOT NULL,
    execution_id_ character varying(64) NOT NULL,
    act_id_ character varying(255) NOT NULL,
    task_id_ character varying(64),
    call_proc_inst_id_ character varying(64),
    act_name_ character varying(255),
    act_type_ character varying(255) NOT NULL,
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    duration_ bigint,
    transaction_order_ integer,
    delete_reason_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE flow.act_ru_actinst OWNER TO pineapple;

--
-- Name: act_ru_deadletter_job; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ru_deadletter_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    type_ character varying(255) NOT NULL,
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    element_id_ character varying(255),
    element_name_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    correlation_id_ character varying(255),
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    create_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE flow.act_ru_deadletter_job OWNER TO pineapple;

--
-- Name: act_ru_entitylink; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ru_entitylink (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    create_time_ timestamp without time zone,
    link_type_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    parent_element_id_ character varying(255),
    ref_scope_id_ character varying(255),
    ref_scope_type_ character varying(255),
    ref_scope_definition_id_ character varying(255),
    root_scope_id_ character varying(255),
    root_scope_type_ character varying(255),
    hierarchy_type_ character varying(255)
);


ALTER TABLE flow.act_ru_entitylink OWNER TO pineapple;

--
-- Name: act_ru_event_subscr; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ru_event_subscr (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    event_type_ character varying(255) NOT NULL,
    event_name_ character varying(255),
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    activity_id_ character varying(64),
    configuration_ character varying(255),
    created_ timestamp without time zone NOT NULL,
    proc_def_id_ character varying(64),
    sub_scope_id_ character varying(64),
    scope_id_ character varying(64),
    scope_definition_id_ character varying(64),
    scope_type_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE flow.act_ru_event_subscr OWNER TO pineapple;

--
-- Name: act_ru_execution; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ru_execution (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    proc_inst_id_ character varying(64),
    business_key_ character varying(255),
    parent_id_ character varying(64),
    proc_def_id_ character varying(64),
    super_exec_ character varying(64),
    root_proc_inst_id_ character varying(64),
    act_id_ character varying(255),
    is_active_ boolean,
    is_concurrent_ boolean,
    is_scope_ boolean,
    is_event_scope_ boolean,
    is_mi_root_ boolean,
    suspension_state_ integer,
    cached_ent_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    name_ character varying(255),
    start_act_id_ character varying(255),
    start_time_ timestamp without time zone,
    start_user_id_ character varying(255),
    lock_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    is_count_enabled_ boolean,
    evt_subscr_count_ integer,
    task_count_ integer,
    job_count_ integer,
    timer_job_count_ integer,
    susp_job_count_ integer,
    deadletter_job_count_ integer,
    external_worker_job_count_ integer,
    var_count_ integer,
    id_link_count_ integer,
    callback_id_ character varying(255),
    callback_type_ character varying(255),
    reference_id_ character varying(255),
    reference_type_ character varying(255),
    propagated_stage_inst_id_ character varying(255)
);


ALTER TABLE flow.act_ru_execution OWNER TO pineapple;

--
-- Name: act_ru_external_job; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ru_external_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    type_ character varying(255) NOT NULL,
    lock_exp_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    element_id_ character varying(255),
    element_name_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    correlation_id_ character varying(255),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    create_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE flow.act_ru_external_job OWNER TO pineapple;

--
-- Name: act_ru_history_job; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ru_history_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    lock_exp_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    adv_handler_cfg_id_ character varying(64),
    create_time_ timestamp without time zone,
    scope_type_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE flow.act_ru_history_job OWNER TO pineapple;

--
-- Name: act_ru_identitylink; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ru_identitylink (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    group_id_ character varying(255),
    type_ character varying(255),
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255)
);


ALTER TABLE flow.act_ru_identitylink OWNER TO pineapple;

--
-- Name: act_ru_job; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ru_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    type_ character varying(255) NOT NULL,
    lock_exp_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    element_id_ character varying(255),
    element_name_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    correlation_id_ character varying(255),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    create_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE flow.act_ru_job OWNER TO pineapple;

--
-- Name: act_ru_suspended_job; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ru_suspended_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    type_ character varying(255) NOT NULL,
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    element_id_ character varying(255),
    element_name_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    correlation_id_ character varying(255),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    create_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE flow.act_ru_suspended_job OWNER TO pineapple;

--
-- Name: act_ru_task; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ru_task (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64),
    task_def_id_ character varying(64),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    propagated_stage_inst_id_ character varying(255),
    name_ character varying(255),
    parent_task_id_ character varying(64),
    description_ character varying(4000),
    task_def_key_ character varying(255),
    owner_ character varying(255),
    assignee_ character varying(255),
    delegation_ character varying(64),
    priority_ integer,
    create_time_ timestamp without time zone,
    due_date_ timestamp without time zone,
    category_ character varying(255),
    suspension_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    form_key_ character varying(255),
    claim_time_ timestamp without time zone,
    is_count_enabled_ boolean,
    var_count_ integer,
    id_link_count_ integer,
    sub_task_count_ integer
);


ALTER TABLE flow.act_ru_task OWNER TO pineapple;

--
-- Name: act_ru_timer_job; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ru_timer_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    type_ character varying(255) NOT NULL,
    lock_exp_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    element_id_ character varying(255),
    element_name_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    correlation_id_ character varying(255),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    create_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE flow.act_ru_timer_job OWNER TO pineapple;

--
-- Name: act_ru_variable; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.act_ru_variable (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(255) NOT NULL,
    name_ character varying(255) NOT NULL,
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    task_id_ character varying(64),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000)
);


ALTER TABLE flow.act_ru_variable OWNER TO pineapple;

--
-- Name: flw_channel_definition; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.flw_channel_definition (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    version_ integer,
    key_ character varying(255),
    category_ character varying(255),
    deployment_id_ character varying(255),
    create_time_ timestamp(3) without time zone,
    tenant_id_ character varying(255),
    resource_name_ character varying(255),
    description_ character varying(255)
);


ALTER TABLE flow.flw_channel_definition OWNER TO pineapple;

--
-- Name: flw_ev_databasechangelog; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.flw_ev_databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE flow.flw_ev_databasechangelog OWNER TO pineapple;

--
-- Name: flw_ev_databasechangeloglock; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.flw_ev_databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE flow.flw_ev_databasechangeloglock OWNER TO pineapple;

--
-- Name: flw_event_definition; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.flw_event_definition (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    version_ integer,
    key_ character varying(255),
    category_ character varying(255),
    deployment_id_ character varying(255),
    tenant_id_ character varying(255),
    resource_name_ character varying(255),
    description_ character varying(255)
);


ALTER TABLE flow.flw_event_definition OWNER TO pineapple;

--
-- Name: flw_event_deployment; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.flw_event_deployment (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    deploy_time_ timestamp(3) without time zone,
    tenant_id_ character varying(255),
    parent_deployment_id_ character varying(255)
);


ALTER TABLE flow.flw_event_deployment OWNER TO pineapple;

--
-- Name: flw_event_resource; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.flw_event_resource (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    deployment_id_ character varying(255),
    resource_bytes_ bytea
);


ALTER TABLE flow.flw_event_resource OWNER TO pineapple;

--
-- Name: flw_ru_batch; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.flw_ru_batch (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(64) NOT NULL,
    search_key_ character varying(255),
    search_key2_ character varying(255),
    create_time_ timestamp without time zone NOT NULL,
    complete_time_ timestamp without time zone,
    status_ character varying(255),
    batch_doc_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE flow.flw_ru_batch OWNER TO pineapple;

--
-- Name: flw_ru_batch_part; Type: TABLE; Schema: flow; Owner: pineapple
--

CREATE TABLE flow.flw_ru_batch_part (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    batch_id_ character varying(64),
    type_ character varying(64) NOT NULL,
    scope_id_ character varying(64),
    sub_scope_id_ character varying(64),
    scope_type_ character varying(64),
    search_key_ character varying(255),
    search_key2_ character varying(255),
    create_time_ timestamp without time zone NOT NULL,
    complete_time_ timestamp without time zone,
    status_ character varying(255),
    result_doc_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE flow.flw_ru_batch_part OWNER TO pineapple;

--
-- Name: config_info; Type: TABLE; Schema: nacos; Owner: pineapple
--

CREATE TABLE nacos.config_info (
    id bigint NOT NULL,
    data_id character varying(255) NOT NULL,
    group_id character varying(255) DEFAULT NULL::character varying,
    content text NOT NULL,
    md5 character varying(32) DEFAULT NULL::character varying,
    gmt_create timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    gmt_modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    src_user text,
    src_ip character varying(50) DEFAULT NULL::character varying,
    app_name character varying(128) DEFAULT NULL::character varying,
    tenant_id character varying(128) DEFAULT ''::character varying,
    c_desc character varying(256) DEFAULT NULL::character varying,
    c_use character varying(64) DEFAULT NULL::character varying,
    effect character varying(64) DEFAULT NULL::character varying,
    type character varying(64) DEFAULT NULL::character varying,
    c_schema text,
    encrypted_data_key text NOT NULL
);


ALTER TABLE nacos.config_info OWNER TO pineapple;

--
-- Name: TABLE config_info; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON TABLE nacos.config_info IS 'config_info';


--
-- Name: COLUMN config_info.id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info.id IS 'id';


--
-- Name: COLUMN config_info.data_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info.data_id IS 'data_id';


--
-- Name: COLUMN config_info.content; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info.content IS 'content';


--
-- Name: COLUMN config_info.md5; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info.md5 IS 'md5';


--
-- Name: COLUMN config_info.gmt_create; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info.gmt_create IS '创建时间';


--
-- Name: COLUMN config_info.gmt_modified; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info.gmt_modified IS '修改时间';


--
-- Name: COLUMN config_info.src_user; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info.src_user IS 'source user';


--
-- Name: COLUMN config_info.src_ip; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info.src_ip IS 'source ip';


--
-- Name: COLUMN config_info.tenant_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info.tenant_id IS '租户字段';


--
-- Name: COLUMN config_info.encrypted_data_key; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info.encrypted_data_key IS '秘钥';


--
-- Name: config_info_aggr; Type: TABLE; Schema: nacos; Owner: pineapple
--

CREATE TABLE nacos.config_info_aggr (
    id bigint NOT NULL,
    data_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    datum_id character varying(255) NOT NULL,
    content text NOT NULL,
    gmt_modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    app_name character varying(128) DEFAULT NULL::character varying,
    tenant_id character varying(128) DEFAULT ''::character varying
);


ALTER TABLE nacos.config_info_aggr OWNER TO pineapple;

--
-- Name: TABLE config_info_aggr; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON TABLE nacos.config_info_aggr IS '增加租户字段';


--
-- Name: COLUMN config_info_aggr.id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_aggr.id IS 'id';


--
-- Name: COLUMN config_info_aggr.data_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_aggr.data_id IS 'data_id';


--
-- Name: COLUMN config_info_aggr.group_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_aggr.group_id IS 'group_id';


--
-- Name: COLUMN config_info_aggr.datum_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_aggr.datum_id IS 'datum_id';


--
-- Name: COLUMN config_info_aggr.content; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_aggr.content IS '内容';


--
-- Name: COLUMN config_info_aggr.gmt_modified; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_aggr.gmt_modified IS '修改时间';


--
-- Name: COLUMN config_info_aggr.tenant_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_aggr.tenant_id IS '租户字段';


--
-- Name: config_info_aggr_id_seq; Type: SEQUENCE; Schema: nacos; Owner: pineapple
--

CREATE SEQUENCE nacos.config_info_aggr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE nacos.config_info_aggr_id_seq OWNER TO pineapple;

--
-- Name: config_info_aggr_id_seq; Type: SEQUENCE OWNED BY; Schema: nacos; Owner: pineapple
--

ALTER SEQUENCE nacos.config_info_aggr_id_seq OWNED BY nacos.config_info_aggr.id;


--
-- Name: config_info_beta; Type: TABLE; Schema: nacos; Owner: pineapple
--

CREATE TABLE nacos.config_info_beta (
    id bigint NOT NULL,
    data_id character varying(255) NOT NULL,
    group_id character varying(128) NOT NULL,
    app_name character varying(128) DEFAULT NULL::character varying,
    content text NOT NULL,
    beta_ips character varying(1024) DEFAULT NULL::character varying,
    md5 character varying(32) DEFAULT NULL::character varying,
    gmt_create timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    gmt_modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    src_user text,
    src_ip character varying(50) DEFAULT NULL::character varying,
    tenant_id character varying(128) DEFAULT ''::character varying,
    encrypted_data_key text NOT NULL
);


ALTER TABLE nacos.config_info_beta OWNER TO pineapple;

--
-- Name: TABLE config_info_beta; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON TABLE nacos.config_info_beta IS 'config_info_beta';


--
-- Name: COLUMN config_info_beta.id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_beta.id IS 'id';


--
-- Name: COLUMN config_info_beta.data_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_beta.data_id IS 'data_id';


--
-- Name: COLUMN config_info_beta.group_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_beta.group_id IS 'group_id';


--
-- Name: COLUMN config_info_beta.app_name; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_beta.app_name IS 'app_name';


--
-- Name: COLUMN config_info_beta.content; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_beta.content IS 'content';


--
-- Name: COLUMN config_info_beta.beta_ips; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_beta.beta_ips IS 'betaIps';


--
-- Name: COLUMN config_info_beta.md5; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_beta.md5 IS 'md5';


--
-- Name: COLUMN config_info_beta.gmt_create; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_beta.gmt_create IS '创建时间';


--
-- Name: COLUMN config_info_beta.gmt_modified; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_beta.gmt_modified IS '修改时间';


--
-- Name: COLUMN config_info_beta.src_user; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_beta.src_user IS 'source user';


--
-- Name: COLUMN config_info_beta.src_ip; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_beta.src_ip IS 'source ip';


--
-- Name: COLUMN config_info_beta.tenant_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_beta.tenant_id IS '租户字段';


--
-- Name: COLUMN config_info_beta.encrypted_data_key; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_beta.encrypted_data_key IS '秘钥';


--
-- Name: config_info_beta_id_seq; Type: SEQUENCE; Schema: nacos; Owner: pineapple
--

CREATE SEQUENCE nacos.config_info_beta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE nacos.config_info_beta_id_seq OWNER TO pineapple;

--
-- Name: config_info_beta_id_seq; Type: SEQUENCE OWNED BY; Schema: nacos; Owner: pineapple
--

ALTER SEQUENCE nacos.config_info_beta_id_seq OWNED BY nacos.config_info_beta.id;


--
-- Name: config_info_id_seq; Type: SEQUENCE; Schema: nacos; Owner: pineapple
--

CREATE SEQUENCE nacos.config_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE nacos.config_info_id_seq OWNER TO pineapple;

--
-- Name: config_info_id_seq; Type: SEQUENCE OWNED BY; Schema: nacos; Owner: pineapple
--

ALTER SEQUENCE nacos.config_info_id_seq OWNED BY nacos.config_info.id;


--
-- Name: config_info_tag; Type: TABLE; Schema: nacos; Owner: pineapple
--

CREATE TABLE nacos.config_info_tag (
    id bigint NOT NULL,
    data_id character varying(255) NOT NULL,
    group_id character varying(128) NOT NULL,
    tenant_id character varying(128) DEFAULT ''::character varying,
    tag_id character varying(128) NOT NULL,
    app_name character varying(128) DEFAULT NULL::character varying,
    content text NOT NULL,
    md5 character varying(32) DEFAULT NULL::character varying,
    gmt_create timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    gmt_modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    src_user text,
    src_ip character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE nacos.config_info_tag OWNER TO pineapple;

--
-- Name: TABLE config_info_tag; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON TABLE nacos.config_info_tag IS 'config_info_tag';


--
-- Name: COLUMN config_info_tag.id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_tag.id IS 'id';


--
-- Name: COLUMN config_info_tag.data_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_tag.data_id IS 'data_id';


--
-- Name: COLUMN config_info_tag.group_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_tag.group_id IS 'group_id';


--
-- Name: COLUMN config_info_tag.tenant_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_tag.tenant_id IS 'tenant_id';


--
-- Name: COLUMN config_info_tag.tag_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_tag.tag_id IS 'tag_id';


--
-- Name: COLUMN config_info_tag.app_name; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_tag.app_name IS 'app_name';


--
-- Name: COLUMN config_info_tag.content; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_tag.content IS 'content';


--
-- Name: COLUMN config_info_tag.md5; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_tag.md5 IS 'md5';


--
-- Name: COLUMN config_info_tag.gmt_create; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_tag.gmt_create IS '创建时间';


--
-- Name: COLUMN config_info_tag.gmt_modified; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_tag.gmt_modified IS '修改时间';


--
-- Name: COLUMN config_info_tag.src_user; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_tag.src_user IS 'source user';


--
-- Name: COLUMN config_info_tag.src_ip; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_info_tag.src_ip IS 'source ip';


--
-- Name: config_info_tag_id_seq; Type: SEQUENCE; Schema: nacos; Owner: pineapple
--

CREATE SEQUENCE nacos.config_info_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE nacos.config_info_tag_id_seq OWNER TO pineapple;

--
-- Name: config_info_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: nacos; Owner: pineapple
--

ALTER SEQUENCE nacos.config_info_tag_id_seq OWNED BY nacos.config_info_tag.id;


--
-- Name: config_tags_relation; Type: TABLE; Schema: nacos; Owner: pineapple
--

CREATE TABLE nacos.config_tags_relation (
    id bigint NOT NULL,
    tag_name character varying(128) NOT NULL,
    tag_type character varying(64) DEFAULT NULL::character varying,
    data_id character varying(255) NOT NULL,
    group_id character varying(128) NOT NULL,
    tenant_id character varying(128) DEFAULT ''::character varying,
    nid bigint NOT NULL
);


ALTER TABLE nacos.config_tags_relation OWNER TO pineapple;

--
-- Name: TABLE config_tags_relation; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON TABLE nacos.config_tags_relation IS 'config_tags_relation';


--
-- Name: COLUMN config_tags_relation.id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_tags_relation.id IS 'id';


--
-- Name: COLUMN config_tags_relation.tag_name; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_tags_relation.tag_name IS 'tag_name';


--
-- Name: COLUMN config_tags_relation.tag_type; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_tags_relation.tag_type IS 'tag_type';


--
-- Name: COLUMN config_tags_relation.data_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_tags_relation.data_id IS 'data_id';


--
-- Name: COLUMN config_tags_relation.group_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_tags_relation.group_id IS 'group_id';


--
-- Name: COLUMN config_tags_relation.tenant_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.config_tags_relation.tenant_id IS 'tenant_id';


--
-- Name: config_tags_relation_nid_seq; Type: SEQUENCE; Schema: nacos; Owner: pineapple
--

CREATE SEQUENCE nacos.config_tags_relation_nid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE nacos.config_tags_relation_nid_seq OWNER TO pineapple;

--
-- Name: config_tags_relation_nid_seq; Type: SEQUENCE OWNED BY; Schema: nacos; Owner: pineapple
--

ALTER SEQUENCE nacos.config_tags_relation_nid_seq OWNED BY nacos.config_tags_relation.nid;


--
-- Name: group_capacity; Type: TABLE; Schema: nacos; Owner: pineapple
--

CREATE TABLE nacos.group_capacity (
    id bigint NOT NULL,
    group_id character varying(128) DEFAULT ''::character varying NOT NULL,
    quota integer DEFAULT 0 NOT NULL,
    usage integer DEFAULT 0 NOT NULL,
    max_size integer DEFAULT 0 NOT NULL,
    max_aggr_count integer DEFAULT 0 NOT NULL,
    max_aggr_size integer DEFAULT 0 NOT NULL,
    max_history_count integer DEFAULT 0 NOT NULL,
    gmt_create timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    gmt_modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE nacos.group_capacity OWNER TO pineapple;

--
-- Name: TABLE group_capacity; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON TABLE nacos.group_capacity IS '集群、各Group容量信息表';


--
-- Name: COLUMN group_capacity.id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.group_capacity.id IS '主键ID';


--
-- Name: COLUMN group_capacity.group_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.group_capacity.group_id IS 'Group ID，空字符表示整个集群';


--
-- Name: COLUMN group_capacity.quota; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.group_capacity.quota IS '配额，0表示使用默认值';


--
-- Name: COLUMN group_capacity.usage; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.group_capacity.usage IS '使用量';


--
-- Name: COLUMN group_capacity.max_size; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.group_capacity.max_size IS '单个配置大小上限，单位为字节，0表示使用默认值';


--
-- Name: COLUMN group_capacity.max_aggr_count; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.group_capacity.max_aggr_count IS '聚合子配置最大个数，，0表示使用默认值';


--
-- Name: COLUMN group_capacity.max_aggr_size; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.group_capacity.max_aggr_size IS '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值';


--
-- Name: COLUMN group_capacity.max_history_count; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.group_capacity.max_history_count IS '最大变更历史数量';


--
-- Name: COLUMN group_capacity.gmt_create; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.group_capacity.gmt_create IS '创建时间';


--
-- Name: COLUMN group_capacity.gmt_modified; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.group_capacity.gmt_modified IS '修改时间';


--
-- Name: group_capacity_id_seq; Type: SEQUENCE; Schema: nacos; Owner: pineapple
--

CREATE SEQUENCE nacos.group_capacity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE nacos.group_capacity_id_seq OWNER TO pineapple;

--
-- Name: group_capacity_id_seq; Type: SEQUENCE OWNED BY; Schema: nacos; Owner: pineapple
--

ALTER SEQUENCE nacos.group_capacity_id_seq OWNED BY nacos.group_capacity.id;


--
-- Name: his_config_info; Type: TABLE; Schema: nacos; Owner: pineapple
--

CREATE TABLE nacos.his_config_info (
    id bigint NOT NULL,
    nid bigint NOT NULL,
    data_id character varying(255) NOT NULL,
    group_id character varying(128) NOT NULL,
    app_name character varying(128) DEFAULT NULL::character varying,
    content text NOT NULL,
    md5 character varying(32) DEFAULT NULL::character varying,
    gmt_create timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    gmt_modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    src_user text,
    src_ip character varying(50) DEFAULT NULL::character varying,
    op_type character(10) DEFAULT NULL::bpchar,
    tenant_id character varying(128) DEFAULT ''::character varying,
    encrypted_data_key text NOT NULL
);


ALTER TABLE nacos.his_config_info OWNER TO pineapple;

--
-- Name: TABLE his_config_info; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON TABLE nacos.his_config_info IS '多租户改造表';


--
-- Name: COLUMN his_config_info.app_name; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.his_config_info.app_name IS 'app_name';


--
-- Name: COLUMN his_config_info.tenant_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.his_config_info.tenant_id IS '租户字段';


--
-- Name: COLUMN his_config_info.encrypted_data_key; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.his_config_info.encrypted_data_key IS '秘钥';


--
-- Name: his_config_info_nid_seq; Type: SEQUENCE; Schema: nacos; Owner: pineapple
--

CREATE SEQUENCE nacos.his_config_info_nid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE nacos.his_config_info_nid_seq OWNER TO pineapple;

--
-- Name: his_config_info_nid_seq; Type: SEQUENCE OWNED BY; Schema: nacos; Owner: pineapple
--

ALTER SEQUENCE nacos.his_config_info_nid_seq OWNED BY nacos.his_config_info.nid;


--
-- Name: permissions; Type: TABLE; Schema: nacos; Owner: pineapple
--

CREATE TABLE nacos.permissions (
    role character varying(50) NOT NULL,
    resource character varying(255) NOT NULL,
    action character varying(8) NOT NULL
);


ALTER TABLE nacos.permissions OWNER TO pineapple;

--
-- Name: roles; Type: TABLE; Schema: nacos; Owner: pineapple
--

CREATE TABLE nacos.roles (
    username character varying(50) NOT NULL,
    role character varying(50) NOT NULL
);


ALTER TABLE nacos.roles OWNER TO pineapple;

--
-- Name: tenant_capacity; Type: TABLE; Schema: nacos; Owner: pineapple
--

CREATE TABLE nacos.tenant_capacity (
    id bigint NOT NULL,
    tenant_id character varying(128) DEFAULT ''::character varying NOT NULL,
    quota integer DEFAULT 0 NOT NULL,
    usage integer DEFAULT 0 NOT NULL,
    max_size integer DEFAULT 0 NOT NULL,
    max_aggr_count integer DEFAULT 0 NOT NULL,
    max_aggr_size integer DEFAULT 0 NOT NULL,
    max_history_count integer DEFAULT 0 NOT NULL,
    gmt_create timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    gmt_modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE nacos.tenant_capacity OWNER TO pineapple;

--
-- Name: TABLE tenant_capacity; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON TABLE nacos.tenant_capacity IS '租户容量信息表';


--
-- Name: COLUMN tenant_capacity.id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_capacity.id IS '主键ID';


--
-- Name: COLUMN tenant_capacity.tenant_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_capacity.tenant_id IS 'Tenant ID';


--
-- Name: COLUMN tenant_capacity.quota; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_capacity.quota IS '配额，0表示使用默认值';


--
-- Name: COLUMN tenant_capacity.usage; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_capacity.usage IS '使用量';


--
-- Name: COLUMN tenant_capacity.max_size; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_capacity.max_size IS '单个配置大小上限，单位为字节，0表示使用默认值';


--
-- Name: COLUMN tenant_capacity.max_aggr_count; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_capacity.max_aggr_count IS '聚合子配置最大个数';


--
-- Name: COLUMN tenant_capacity.max_aggr_size; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_capacity.max_aggr_size IS '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值';


--
-- Name: COLUMN tenant_capacity.max_history_count; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_capacity.max_history_count IS '最大变更历史数量';


--
-- Name: COLUMN tenant_capacity.gmt_create; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_capacity.gmt_create IS '创建时间';


--
-- Name: COLUMN tenant_capacity.gmt_modified; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_capacity.gmt_modified IS '修改时间';


--
-- Name: tenant_capacity_id_seq; Type: SEQUENCE; Schema: nacos; Owner: pineapple
--

CREATE SEQUENCE nacos.tenant_capacity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE nacos.tenant_capacity_id_seq OWNER TO pineapple;

--
-- Name: tenant_capacity_id_seq; Type: SEQUENCE OWNED BY; Schema: nacos; Owner: pineapple
--

ALTER SEQUENCE nacos.tenant_capacity_id_seq OWNED BY nacos.tenant_capacity.id;


--
-- Name: tenant_info; Type: TABLE; Schema: nacos; Owner: pineapple
--

CREATE TABLE nacos.tenant_info (
    id bigint NOT NULL,
    kp character varying(128) NOT NULL,
    tenant_id character varying(128) DEFAULT ''::character varying,
    tenant_name character varying(128) DEFAULT ''::character varying,
    tenant_desc character varying(256) DEFAULT NULL::character varying,
    create_source character varying(32) DEFAULT NULL::character varying,
    gmt_create bigint NOT NULL,
    gmt_modified bigint NOT NULL
);


ALTER TABLE nacos.tenant_info OWNER TO pineapple;

--
-- Name: TABLE tenant_info; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON TABLE nacos.tenant_info IS '租户信息表';


--
-- Name: COLUMN tenant_info.id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_info.id IS 'id';


--
-- Name: COLUMN tenant_info.kp; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_info.kp IS 'kp';


--
-- Name: COLUMN tenant_info.tenant_id; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_info.tenant_id IS 'tenant_id';


--
-- Name: COLUMN tenant_info.tenant_name; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_info.tenant_name IS 'tenant_name';


--
-- Name: COLUMN tenant_info.tenant_desc; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_info.tenant_desc IS 'tenant_desc';


--
-- Name: COLUMN tenant_info.create_source; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_info.create_source IS 'create_source';


--
-- Name: COLUMN tenant_info.gmt_create; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_info.gmt_create IS '创建时间';


--
-- Name: COLUMN tenant_info.gmt_modified; Type: COMMENT; Schema: nacos; Owner: pineapple
--

COMMENT ON COLUMN nacos.tenant_info.gmt_modified IS '修改时间';


--
-- Name: tenant_info_id_seq; Type: SEQUENCE; Schema: nacos; Owner: pineapple
--

CREATE SEQUENCE nacos.tenant_info_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE nacos.tenant_info_id_seq OWNER TO pineapple;

--
-- Name: tenant_info_id_seq; Type: SEQUENCE OWNED BY; Schema: nacos; Owner: pineapple
--

ALTER SEQUENCE nacos.tenant_info_id_seq OWNED BY nacos.tenant_info.id;


--
-- Name: users; Type: TABLE; Schema: nacos; Owner: pineapple
--

CREATE TABLE nacos.users (
    username character varying(50) NOT NULL,
    password character varying(500) NOT NULL,
    enabled boolean NOT NULL
);


ALTER TABLE nacos.users OWNER TO pineapple;

--
-- Name: act_app_appdef; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_app_appdef (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    name_ character varying(255),
    key_ character varying(255) NOT NULL,
    version_ integer NOT NULL,
    category_ character varying(255),
    deployment_id_ character varying(255),
    resource_name_ character varying(4000),
    description_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_app_appdef OWNER TO pineapple;

--
-- Name: act_app_databasechangelog; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_app_databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.act_app_databasechangelog OWNER TO pineapple;

--
-- Name: act_app_databasechangeloglock; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_app_databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.act_app_databasechangeloglock OWNER TO pineapple;

--
-- Name: act_app_deployment; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_app_deployment (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    key_ character varying(255),
    deploy_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_app_deployment OWNER TO pineapple;

--
-- Name: act_app_deployment_resource; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_app_deployment_resource (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    deployment_id_ character varying(255),
    resource_bytes_ bytea
);


ALTER TABLE public.act_app_deployment_resource OWNER TO pineapple;

--
-- Name: act_cmmn_casedef; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_cmmn_casedef (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    name_ character varying(255),
    key_ character varying(255) NOT NULL,
    version_ integer NOT NULL,
    category_ character varying(255),
    deployment_id_ character varying(255),
    resource_name_ character varying(4000),
    description_ character varying(4000),
    has_graphical_notation_ boolean,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    dgrm_resource_name_ character varying(4000),
    has_start_form_key_ boolean
);


ALTER TABLE public.act_cmmn_casedef OWNER TO pineapple;

--
-- Name: act_cmmn_databasechangelog; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_cmmn_databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.act_cmmn_databasechangelog OWNER TO pineapple;

--
-- Name: act_cmmn_databasechangeloglock; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_cmmn_databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.act_cmmn_databasechangeloglock OWNER TO pineapple;

--
-- Name: act_cmmn_deployment; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_cmmn_deployment (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    key_ character varying(255),
    deploy_time_ timestamp without time zone,
    parent_deployment_id_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_cmmn_deployment OWNER TO pineapple;

--
-- Name: act_cmmn_deployment_resource; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_cmmn_deployment_resource (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    deployment_id_ character varying(255),
    resource_bytes_ bytea,
    generated_ boolean
);


ALTER TABLE public.act_cmmn_deployment_resource OWNER TO pineapple;

--
-- Name: act_cmmn_hi_case_inst; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_cmmn_hi_case_inst (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    business_key_ character varying(255),
    name_ character varying(255),
    parent_id_ character varying(255),
    case_def_id_ character varying(255),
    state_ character varying(255),
    start_time_ timestamp without time zone,
    end_time_ timestamp without time zone,
    start_user_id_ character varying(255),
    callback_id_ character varying(255),
    callback_type_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    reference_id_ character varying(255),
    reference_type_ character varying(255)
);


ALTER TABLE public.act_cmmn_hi_case_inst OWNER TO pineapple;

--
-- Name: act_cmmn_hi_mil_inst; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_cmmn_hi_mil_inst (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    name_ character varying(255) NOT NULL,
    time_stamp_ timestamp without time zone NOT NULL,
    case_inst_id_ character varying(255) NOT NULL,
    case_def_id_ character varying(255) NOT NULL,
    element_id_ character varying(255) NOT NULL,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_cmmn_hi_mil_inst OWNER TO pineapple;

--
-- Name: act_cmmn_hi_plan_item_inst; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_cmmn_hi_plan_item_inst (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    name_ character varying(255),
    state_ character varying(255),
    case_def_id_ character varying(255),
    case_inst_id_ character varying(255),
    stage_inst_id_ character varying(255),
    is_stage_ boolean,
    element_id_ character varying(255),
    item_definition_id_ character varying(255),
    item_definition_type_ character varying(255),
    create_time_ timestamp without time zone,
    last_available_time_ timestamp without time zone,
    last_enabled_time_ timestamp without time zone,
    last_disabled_time_ timestamp without time zone,
    last_started_time_ timestamp without time zone,
    last_suspended_time_ timestamp without time zone,
    completed_time_ timestamp without time zone,
    occurred_time_ timestamp without time zone,
    terminated_time_ timestamp without time zone,
    exit_time_ timestamp without time zone,
    ended_time_ timestamp without time zone,
    last_updated_time_ timestamp without time zone,
    start_user_id_ character varying(255),
    reference_id_ character varying(255),
    reference_type_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    entry_criterion_id_ character varying(255),
    exit_criterion_id_ character varying(255),
    show_in_overview_ boolean,
    extra_value_ character varying(255),
    derived_case_def_id_ character varying(255),
    last_unavailable_time_ timestamp(3) without time zone
);


ALTER TABLE public.act_cmmn_hi_plan_item_inst OWNER TO pineapple;

--
-- Name: act_cmmn_ru_case_inst; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_cmmn_ru_case_inst (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    business_key_ character varying(255),
    name_ character varying(255),
    parent_id_ character varying(255),
    case_def_id_ character varying(255),
    state_ character varying(255),
    start_time_ timestamp without time zone,
    start_user_id_ character varying(255),
    callback_id_ character varying(255),
    callback_type_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    lock_time_ timestamp without time zone,
    is_completeable_ boolean,
    reference_id_ character varying(255),
    reference_type_ character varying(255),
    lock_owner_ character varying(255)
);


ALTER TABLE public.act_cmmn_ru_case_inst OWNER TO pineapple;

--
-- Name: act_cmmn_ru_mil_inst; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_cmmn_ru_mil_inst (
    id_ character varying(255) NOT NULL,
    name_ character varying(255) NOT NULL,
    time_stamp_ timestamp without time zone NOT NULL,
    case_inst_id_ character varying(255) NOT NULL,
    case_def_id_ character varying(255) NOT NULL,
    element_id_ character varying(255) NOT NULL,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_cmmn_ru_mil_inst OWNER TO pineapple;

--
-- Name: act_cmmn_ru_plan_item_inst; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_cmmn_ru_plan_item_inst (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    case_def_id_ character varying(255),
    case_inst_id_ character varying(255),
    stage_inst_id_ character varying(255),
    is_stage_ boolean,
    element_id_ character varying(255),
    name_ character varying(255),
    state_ character varying(255),
    create_time_ timestamp without time zone,
    start_user_id_ character varying(255),
    reference_id_ character varying(255),
    reference_type_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    item_definition_id_ character varying(255),
    item_definition_type_ character varying(255),
    is_completeable_ boolean,
    is_count_enabled_ boolean,
    var_count_ integer,
    sentry_part_inst_count_ integer,
    last_available_time_ timestamp(3) without time zone,
    last_enabled_time_ timestamp(3) without time zone,
    last_disabled_time_ timestamp(3) without time zone,
    last_started_time_ timestamp(3) without time zone,
    last_suspended_time_ timestamp(3) without time zone,
    completed_time_ timestamp(3) without time zone,
    occurred_time_ timestamp(3) without time zone,
    terminated_time_ timestamp(3) without time zone,
    exit_time_ timestamp(3) without time zone,
    ended_time_ timestamp(3) without time zone,
    entry_criterion_id_ character varying(255),
    exit_criterion_id_ character varying(255),
    extra_value_ character varying(255),
    derived_case_def_id_ character varying(255),
    last_unavailable_time_ timestamp(3) without time zone
);


ALTER TABLE public.act_cmmn_ru_plan_item_inst OWNER TO pineapple;

--
-- Name: act_cmmn_ru_sentry_part_inst; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_cmmn_ru_sentry_part_inst (
    id_ character varying(255) NOT NULL,
    rev_ integer NOT NULL,
    case_def_id_ character varying(255),
    case_inst_id_ character varying(255),
    plan_item_inst_id_ character varying(255),
    on_part_id_ character varying(255),
    if_part_id_ character varying(255),
    time_stamp_ timestamp without time zone
);


ALTER TABLE public.act_cmmn_ru_sentry_part_inst OWNER TO pineapple;

--
-- Name: act_co_content_item; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_co_content_item (
    id_ character varying(255) NOT NULL,
    name_ character varying(255) NOT NULL,
    mime_type_ character varying(255),
    task_id_ character varying(255),
    proc_inst_id_ character varying(255),
    content_store_id_ character varying(255),
    content_store_name_ character varying(255),
    field_ character varying(400),
    content_available_ boolean DEFAULT false,
    created_ timestamp(6) without time zone,
    created_by_ character varying(255),
    last_modified_ timestamp(6) without time zone,
    last_modified_by_ character varying(255),
    content_size_ bigint DEFAULT 0,
    tenant_id_ character varying(255),
    scope_id_ character varying(255),
    scope_type_ character varying(255)
);


ALTER TABLE public.act_co_content_item OWNER TO pineapple;

--
-- Name: act_co_databasechangelog; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_co_databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.act_co_databasechangelog OWNER TO pineapple;

--
-- Name: act_co_databasechangeloglock; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_co_databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.act_co_databasechangeloglock OWNER TO pineapple;

--
-- Name: act_dmn_databasechangelog; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_dmn_databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.act_dmn_databasechangelog OWNER TO pineapple;

--
-- Name: act_dmn_databasechangeloglock; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_dmn_databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.act_dmn_databasechangeloglock OWNER TO pineapple;

--
-- Name: act_dmn_decision; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_dmn_decision (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    version_ integer,
    key_ character varying(255),
    category_ character varying(255),
    deployment_id_ character varying(255),
    tenant_id_ character varying(255),
    resource_name_ character varying(255),
    description_ character varying(255),
    decision_type_ character varying(255)
);


ALTER TABLE public.act_dmn_decision OWNER TO pineapple;

--
-- Name: act_dmn_deployment; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_dmn_deployment (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    deploy_time_ timestamp without time zone,
    tenant_id_ character varying(255),
    parent_deployment_id_ character varying(255)
);


ALTER TABLE public.act_dmn_deployment OWNER TO pineapple;

--
-- Name: act_dmn_deployment_resource; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_dmn_deployment_resource (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    deployment_id_ character varying(255),
    resource_bytes_ bytea
);


ALTER TABLE public.act_dmn_deployment_resource OWNER TO pineapple;

--
-- Name: act_dmn_hi_decision_execution; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_dmn_hi_decision_execution (
    id_ character varying(255) NOT NULL,
    decision_definition_id_ character varying(255),
    deployment_id_ character varying(255),
    start_time_ timestamp without time zone,
    end_time_ timestamp without time zone,
    instance_id_ character varying(255),
    execution_id_ character varying(255),
    activity_id_ character varying(255),
    failed_ boolean DEFAULT false,
    tenant_id_ character varying(255),
    execution_json_ text,
    scope_type_ character varying(255)
);


ALTER TABLE public.act_dmn_hi_decision_execution OWNER TO pineapple;

--
-- Name: act_evt_log; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_evt_log (
    log_nr_ integer NOT NULL,
    type_ character varying(64),
    proc_def_id_ character varying(64),
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    time_stamp_ timestamp without time zone NOT NULL,
    user_id_ character varying(255),
    data_ bytea,
    lock_owner_ character varying(255),
    lock_time_ timestamp without time zone,
    is_processed_ smallint DEFAULT 0
);


ALTER TABLE public.act_evt_log OWNER TO pineapple;

--
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE; Schema: public; Owner: pineapple
--

CREATE SEQUENCE public.act_evt_log_log_nr__seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.act_evt_log_log_nr__seq OWNER TO pineapple;

--
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pineapple
--

ALTER SEQUENCE public.act_evt_log_log_nr__seq OWNED BY public.act_evt_log.log_nr_;


--
-- Name: act_fo_databasechangelog; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_fo_databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.act_fo_databasechangelog OWNER TO pineapple;

--
-- Name: act_fo_databasechangeloglock; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_fo_databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.act_fo_databasechangeloglock OWNER TO pineapple;

--
-- Name: act_fo_form_definition; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_fo_form_definition (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    version_ integer,
    key_ character varying(255),
    category_ character varying(255),
    deployment_id_ character varying(255),
    tenant_id_ character varying(255),
    resource_name_ character varying(255),
    description_ character varying(255)
);


ALTER TABLE public.act_fo_form_definition OWNER TO pineapple;

--
-- Name: act_fo_form_deployment; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_fo_form_deployment (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    deploy_time_ timestamp without time zone,
    tenant_id_ character varying(255),
    parent_deployment_id_ character varying(255)
);


ALTER TABLE public.act_fo_form_deployment OWNER TO pineapple;

--
-- Name: act_fo_form_instance; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_fo_form_instance (
    id_ character varying(255) NOT NULL,
    form_definition_id_ character varying(255) NOT NULL,
    task_id_ character varying(255),
    proc_inst_id_ character varying(255),
    proc_def_id_ character varying(255),
    submitted_date_ timestamp without time zone,
    submitted_by_ character varying(255),
    form_values_id_ character varying(255),
    tenant_id_ character varying(255),
    scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255)
);


ALTER TABLE public.act_fo_form_instance OWNER TO pineapple;

--
-- Name: act_fo_form_resource; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_fo_form_resource (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    deployment_id_ character varying(255),
    resource_bytes_ bytea
);


ALTER TABLE public.act_fo_form_resource OWNER TO pineapple;

--
-- Name: act_ge_bytearray; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ge_bytearray (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    deployment_id_ character varying(64),
    bytes_ bytea,
    generated_ boolean
);


ALTER TABLE public.act_ge_bytearray OWNER TO pineapple;

--
-- Name: act_ge_property; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ge_property (
    name_ character varying(64) NOT NULL,
    value_ character varying(300),
    rev_ integer
);


ALTER TABLE public.act_ge_property OWNER TO pineapple;

--
-- Name: act_hi_actinst; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_hi_actinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_def_id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64) NOT NULL,
    execution_id_ character varying(64) NOT NULL,
    act_id_ character varying(255) NOT NULL,
    task_id_ character varying(64),
    call_proc_inst_id_ character varying(64),
    act_name_ character varying(255),
    act_type_ character varying(255) NOT NULL,
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    transaction_order_ integer,
    duration_ bigint,
    delete_reason_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_hi_actinst OWNER TO pineapple;

--
-- Name: act_hi_attachment; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_hi_attachment (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    user_id_ character varying(255),
    name_ character varying(255),
    description_ character varying(4000),
    type_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    url_ character varying(4000),
    content_id_ character varying(64),
    time_ timestamp without time zone
);


ALTER TABLE public.act_hi_attachment OWNER TO pineapple;

--
-- Name: act_hi_comment; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_hi_comment (
    id_ character varying(64) NOT NULL,
    type_ character varying(255),
    time_ timestamp without time zone NOT NULL,
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    action_ character varying(255),
    message_ character varying(4000),
    full_msg_ bytea
);


ALTER TABLE public.act_hi_comment OWNER TO pineapple;

--
-- Name: act_hi_detail; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_hi_detail (
    id_ character varying(64) NOT NULL,
    type_ character varying(255) NOT NULL,
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    act_inst_id_ character varying(64),
    name_ character varying(255) NOT NULL,
    var_type_ character varying(64),
    rev_ integer,
    time_ timestamp without time zone NOT NULL,
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000)
);


ALTER TABLE public.act_hi_detail OWNER TO pineapple;

--
-- Name: act_hi_entitylink; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_hi_entitylink (
    id_ character varying(64) NOT NULL,
    link_type_ character varying(255),
    create_time_ timestamp without time zone,
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    parent_element_id_ character varying(255),
    ref_scope_id_ character varying(255),
    ref_scope_type_ character varying(255),
    ref_scope_definition_id_ character varying(255),
    root_scope_id_ character varying(255),
    root_scope_type_ character varying(255),
    hierarchy_type_ character varying(255)
);


ALTER TABLE public.act_hi_entitylink OWNER TO pineapple;

--
-- Name: act_hi_identitylink; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_hi_identitylink (
    id_ character varying(64) NOT NULL,
    group_id_ character varying(255),
    type_ character varying(255),
    user_id_ character varying(255),
    task_id_ character varying(64),
    create_time_ timestamp without time zone,
    proc_inst_id_ character varying(64),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255)
);


ALTER TABLE public.act_hi_identitylink OWNER TO pineapple;

--
-- Name: act_hi_procinst; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_hi_procinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_inst_id_ character varying(64) NOT NULL,
    business_key_ character varying(255),
    proc_def_id_ character varying(64) NOT NULL,
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    duration_ bigint,
    start_user_id_ character varying(255),
    start_act_id_ character varying(255),
    end_act_id_ character varying(255),
    super_process_instance_id_ character varying(64),
    delete_reason_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    name_ character varying(255),
    callback_id_ character varying(255),
    callback_type_ character varying(255),
    reference_id_ character varying(255),
    reference_type_ character varying(255)
);


ALTER TABLE public.act_hi_procinst OWNER TO pineapple;

--
-- Name: act_hi_taskinst; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_hi_taskinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_def_id_ character varying(64),
    task_def_id_ character varying(64),
    task_def_key_ character varying(255),
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    propagated_stage_inst_id_ character varying(255),
    name_ character varying(255),
    parent_task_id_ character varying(64),
    description_ character varying(4000),
    owner_ character varying(255),
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    claim_time_ timestamp without time zone,
    end_time_ timestamp without time zone,
    duration_ bigint,
    delete_reason_ character varying(4000),
    priority_ integer,
    due_date_ timestamp without time zone,
    form_key_ character varying(255),
    category_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    last_updated_time_ timestamp without time zone
);


ALTER TABLE public.act_hi_taskinst OWNER TO pineapple;

--
-- Name: act_hi_tsk_log; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_hi_tsk_log (
    id_ integer NOT NULL,
    type_ character varying(64),
    task_id_ character varying(64) NOT NULL,
    time_stamp_ timestamp without time zone NOT NULL,
    user_id_ character varying(255),
    data_ character varying(4000),
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64),
    scope_id_ character varying(255),
    scope_definition_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_hi_tsk_log OWNER TO pineapple;

--
-- Name: act_hi_tsk_log_id__seq; Type: SEQUENCE; Schema: public; Owner: pineapple
--

CREATE SEQUENCE public.act_hi_tsk_log_id__seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.act_hi_tsk_log_id__seq OWNER TO pineapple;

--
-- Name: act_hi_tsk_log_id__seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pineapple
--

ALTER SEQUENCE public.act_hi_tsk_log_id__seq OWNED BY public.act_hi_tsk_log.id_;


--
-- Name: act_hi_varinst; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_hi_varinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_inst_id_ character varying(64),
    execution_id_ character varying(64),
    task_id_ character varying(64),
    name_ character varying(255) NOT NULL,
    var_type_ character varying(100),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000),
    create_time_ timestamp without time zone,
    last_updated_time_ timestamp without time zone
);


ALTER TABLE public.act_hi_varinst OWNER TO pineapple;

--
-- Name: act_id_bytearray; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_id_bytearray (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    bytes_ bytea
);


ALTER TABLE public.act_id_bytearray OWNER TO pineapple;

--
-- Name: act_id_group; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_id_group (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    type_ character varying(255)
);


ALTER TABLE public.act_id_group OWNER TO pineapple;

--
-- Name: act_id_info; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_id_info (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    user_id_ character varying(64),
    type_ character varying(64),
    key_ character varying(255),
    value_ character varying(255),
    password_ bytea,
    parent_id_ character varying(255)
);


ALTER TABLE public.act_id_info OWNER TO pineapple;

--
-- Name: act_id_membership; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_id_membership (
    user_id_ character varying(64) NOT NULL,
    group_id_ character varying(64) NOT NULL
);


ALTER TABLE public.act_id_membership OWNER TO pineapple;

--
-- Name: act_id_priv; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_id_priv (
    id_ character varying(64) NOT NULL,
    name_ character varying(255) NOT NULL
);


ALTER TABLE public.act_id_priv OWNER TO pineapple;

--
-- Name: act_id_priv_mapping; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_id_priv_mapping (
    id_ character varying(64) NOT NULL,
    priv_id_ character varying(64) NOT NULL,
    user_id_ character varying(255),
    group_id_ character varying(255)
);


ALTER TABLE public.act_id_priv_mapping OWNER TO pineapple;

--
-- Name: act_id_property; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_id_property (
    name_ character varying(64) NOT NULL,
    value_ character varying(300),
    rev_ integer
);


ALTER TABLE public.act_id_property OWNER TO pineapple;

--
-- Name: act_id_token; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_id_token (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    token_value_ character varying(255),
    token_date_ timestamp without time zone,
    ip_address_ character varying(255),
    user_agent_ character varying(255),
    user_id_ character varying(255),
    token_data_ character varying(2000)
);


ALTER TABLE public.act_id_token OWNER TO pineapple;

--
-- Name: act_id_user; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_id_user (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    first_ character varying(255),
    last_ character varying(255),
    display_name_ character varying(255),
    email_ character varying(255),
    pwd_ character varying(255),
    picture_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_id_user OWNER TO pineapple;

--
-- Name: act_procdef_info; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_procdef_info (
    id_ character varying(64) NOT NULL,
    proc_def_id_ character varying(64) NOT NULL,
    rev_ integer,
    info_json_id_ character varying(64)
);


ALTER TABLE public.act_procdef_info OWNER TO pineapple;

--
-- Name: act_re_deployment; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_re_deployment (
    id_ character varying(64) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    key_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    deploy_time_ timestamp without time zone,
    derived_from_ character varying(64),
    derived_from_root_ character varying(64),
    parent_deployment_id_ character varying(255),
    engine_version_ character varying(255)
);


ALTER TABLE public.act_re_deployment OWNER TO pineapple;

--
-- Name: act_re_model; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_re_model (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    name_ character varying(255),
    key_ character varying(255),
    category_ character varying(255),
    create_time_ timestamp without time zone,
    last_update_time_ timestamp without time zone,
    version_ integer,
    meta_info_ character varying(4000),
    deployment_id_ character varying(64),
    editor_source_value_id_ character varying(64),
    editor_source_extra_value_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_re_model OWNER TO pineapple;

--
-- Name: act_re_procdef; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_re_procdef (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    name_ character varying(255),
    key_ character varying(255) NOT NULL,
    version_ integer NOT NULL,
    deployment_id_ character varying(64),
    resource_name_ character varying(4000),
    dgrm_resource_name_ character varying(4000),
    description_ character varying(4000),
    has_start_form_key_ boolean,
    has_graphical_notation_ boolean,
    suspension_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    derived_from_ character varying(64),
    derived_from_root_ character varying(64),
    derived_version_ integer DEFAULT 0 NOT NULL,
    engine_version_ character varying(255)
);


ALTER TABLE public.act_re_procdef OWNER TO pineapple;

--
-- Name: act_ru_actinst; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ru_actinst (
    id_ character varying(64) NOT NULL,
    rev_ integer DEFAULT 1,
    proc_def_id_ character varying(64) NOT NULL,
    proc_inst_id_ character varying(64) NOT NULL,
    execution_id_ character varying(64) NOT NULL,
    act_id_ character varying(255) NOT NULL,
    task_id_ character varying(64),
    call_proc_inst_id_ character varying(64),
    act_name_ character varying(255),
    act_type_ character varying(255) NOT NULL,
    assignee_ character varying(255),
    start_time_ timestamp without time zone NOT NULL,
    end_time_ timestamp without time zone,
    duration_ bigint,
    transaction_order_ integer,
    delete_reason_ character varying(4000),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_ru_actinst OWNER TO pineapple;

--
-- Name: act_ru_deadletter_job; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ru_deadletter_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    type_ character varying(255) NOT NULL,
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    element_id_ character varying(255),
    element_name_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    correlation_id_ character varying(255),
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    create_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_ru_deadletter_job OWNER TO pineapple;

--
-- Name: act_ru_entitylink; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ru_entitylink (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    create_time_ timestamp without time zone,
    link_type_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    parent_element_id_ character varying(255),
    ref_scope_id_ character varying(255),
    ref_scope_type_ character varying(255),
    ref_scope_definition_id_ character varying(255),
    root_scope_id_ character varying(255),
    root_scope_type_ character varying(255),
    hierarchy_type_ character varying(255)
);


ALTER TABLE public.act_ru_entitylink OWNER TO pineapple;

--
-- Name: act_ru_event_subscr; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ru_event_subscr (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    event_type_ character varying(255) NOT NULL,
    event_name_ character varying(255),
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    activity_id_ character varying(64),
    configuration_ character varying(255),
    created_ timestamp without time zone NOT NULL,
    proc_def_id_ character varying(64),
    sub_scope_id_ character varying(64),
    scope_id_ character varying(64),
    scope_definition_id_ character varying(64),
    scope_type_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_ru_event_subscr OWNER TO pineapple;

--
-- Name: act_ru_execution; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ru_execution (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    proc_inst_id_ character varying(64),
    business_key_ character varying(255),
    parent_id_ character varying(64),
    proc_def_id_ character varying(64),
    super_exec_ character varying(64),
    root_proc_inst_id_ character varying(64),
    act_id_ character varying(255),
    is_active_ boolean,
    is_concurrent_ boolean,
    is_scope_ boolean,
    is_event_scope_ boolean,
    is_mi_root_ boolean,
    suspension_state_ integer,
    cached_ent_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    name_ character varying(255),
    start_act_id_ character varying(255),
    start_time_ timestamp without time zone,
    start_user_id_ character varying(255),
    lock_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    is_count_enabled_ boolean,
    evt_subscr_count_ integer,
    task_count_ integer,
    job_count_ integer,
    timer_job_count_ integer,
    susp_job_count_ integer,
    deadletter_job_count_ integer,
    external_worker_job_count_ integer,
    var_count_ integer,
    id_link_count_ integer,
    callback_id_ character varying(255),
    callback_type_ character varying(255),
    reference_id_ character varying(255),
    reference_type_ character varying(255),
    propagated_stage_inst_id_ character varying(255)
);


ALTER TABLE public.act_ru_execution OWNER TO pineapple;

--
-- Name: act_ru_external_job; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ru_external_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    type_ character varying(255) NOT NULL,
    lock_exp_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    element_id_ character varying(255),
    element_name_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    correlation_id_ character varying(255),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    create_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_ru_external_job OWNER TO pineapple;

--
-- Name: act_ru_history_job; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ru_history_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    lock_exp_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    adv_handler_cfg_id_ character varying(64),
    create_time_ timestamp without time zone,
    scope_type_ character varying(255),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_ru_history_job OWNER TO pineapple;

--
-- Name: act_ru_identitylink; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ru_identitylink (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    group_id_ character varying(255),
    type_ character varying(255),
    user_id_ character varying(255),
    task_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255)
);


ALTER TABLE public.act_ru_identitylink OWNER TO pineapple;

--
-- Name: act_ru_job; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ru_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    type_ character varying(255) NOT NULL,
    lock_exp_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    element_id_ character varying(255),
    element_name_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    correlation_id_ character varying(255),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    create_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_ru_job OWNER TO pineapple;

--
-- Name: act_ru_suspended_job; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ru_suspended_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    type_ character varying(255) NOT NULL,
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    element_id_ character varying(255),
    element_name_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    correlation_id_ character varying(255),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    create_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_ru_suspended_job OWNER TO pineapple;

--
-- Name: act_ru_task; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ru_task (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    proc_def_id_ character varying(64),
    task_def_id_ character varying(64),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    propagated_stage_inst_id_ character varying(255),
    name_ character varying(255),
    parent_task_id_ character varying(64),
    description_ character varying(4000),
    task_def_key_ character varying(255),
    owner_ character varying(255),
    assignee_ character varying(255),
    delegation_ character varying(64),
    priority_ integer,
    create_time_ timestamp without time zone,
    due_date_ timestamp without time zone,
    category_ character varying(255),
    suspension_state_ integer,
    tenant_id_ character varying(255) DEFAULT ''::character varying,
    form_key_ character varying(255),
    claim_time_ timestamp without time zone,
    is_count_enabled_ boolean,
    var_count_ integer,
    id_link_count_ integer,
    sub_task_count_ integer
);


ALTER TABLE public.act_ru_task OWNER TO pineapple;

--
-- Name: act_ru_timer_job; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ru_timer_job (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    category_ character varying(255),
    type_ character varying(255) NOT NULL,
    lock_exp_time_ timestamp without time zone,
    lock_owner_ character varying(255),
    exclusive_ boolean,
    execution_id_ character varying(64),
    process_instance_id_ character varying(64),
    proc_def_id_ character varying(64),
    element_id_ character varying(255),
    element_name_ character varying(255),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    scope_definition_id_ character varying(255),
    correlation_id_ character varying(255),
    retries_ integer,
    exception_stack_id_ character varying(64),
    exception_msg_ character varying(4000),
    duedate_ timestamp without time zone,
    repeat_ character varying(255),
    handler_type_ character varying(255),
    handler_cfg_ character varying(4000),
    custom_values_id_ character varying(64),
    create_time_ timestamp without time zone,
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.act_ru_timer_job OWNER TO pineapple;

--
-- Name: act_ru_variable; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.act_ru_variable (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(255) NOT NULL,
    name_ character varying(255) NOT NULL,
    execution_id_ character varying(64),
    proc_inst_id_ character varying(64),
    task_id_ character varying(64),
    scope_id_ character varying(255),
    sub_scope_id_ character varying(255),
    scope_type_ character varying(255),
    bytearray_id_ character varying(64),
    double_ double precision,
    long_ bigint,
    text_ character varying(4000),
    text2_ character varying(4000)
);


ALTER TABLE public.act_ru_variable OWNER TO pineapple;

--
-- Name: flw_channel_definition; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.flw_channel_definition (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    version_ integer,
    key_ character varying(255),
    category_ character varying(255),
    deployment_id_ character varying(255),
    create_time_ timestamp(3) without time zone,
    tenant_id_ character varying(255),
    resource_name_ character varying(255),
    description_ character varying(255)
);


ALTER TABLE public.flw_channel_definition OWNER TO pineapple;

--
-- Name: flw_ev_databasechangelog; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.flw_ev_databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.flw_ev_databasechangelog OWNER TO pineapple;

--
-- Name: flw_ev_databasechangeloglock; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.flw_ev_databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.flw_ev_databasechangeloglock OWNER TO pineapple;

--
-- Name: flw_event_definition; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.flw_event_definition (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    version_ integer,
    key_ character varying(255),
    category_ character varying(255),
    deployment_id_ character varying(255),
    tenant_id_ character varying(255),
    resource_name_ character varying(255),
    description_ character varying(255)
);


ALTER TABLE public.flw_event_definition OWNER TO pineapple;

--
-- Name: flw_event_deployment; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.flw_event_deployment (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    category_ character varying(255),
    deploy_time_ timestamp(3) without time zone,
    tenant_id_ character varying(255),
    parent_deployment_id_ character varying(255)
);


ALTER TABLE public.flw_event_deployment OWNER TO pineapple;

--
-- Name: flw_event_resource; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.flw_event_resource (
    id_ character varying(255) NOT NULL,
    name_ character varying(255),
    deployment_id_ character varying(255),
    resource_bytes_ bytea
);


ALTER TABLE public.flw_event_resource OWNER TO pineapple;

--
-- Name: flw_ru_batch; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.flw_ru_batch (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    type_ character varying(64) NOT NULL,
    search_key_ character varying(255),
    search_key2_ character varying(255),
    create_time_ timestamp without time zone NOT NULL,
    complete_time_ timestamp without time zone,
    status_ character varying(255),
    batch_doc_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.flw_ru_batch OWNER TO pineapple;

--
-- Name: flw_ru_batch_part; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.flw_ru_batch_part (
    id_ character varying(64) NOT NULL,
    rev_ integer,
    batch_id_ character varying(64),
    type_ character varying(64) NOT NULL,
    scope_id_ character varying(64),
    sub_scope_id_ character varying(64),
    scope_type_ character varying(64),
    search_key_ character varying(255),
    search_key2_ character varying(255),
    create_time_ timestamp without time zone NOT NULL,
    complete_time_ timestamp without time zone,
    status_ character varying(255),
    result_doc_id_ character varying(64),
    tenant_id_ character varying(255) DEFAULT ''::character varying
);


ALTER TABLE public.flw_ru_batch_part OWNER TO pineapple;

--
-- Name: sys_dict; Type: TABLE; Schema: system; Owner: pineapple
--

CREATE TABLE system.sys_dict (
    id bigint NOT NULL,
    type_code character varying(64) DEFAULT ''::character varying NOT NULL,
    type_name character varying(64) DEFAULT ''::character varying NOT NULL,
    dict_code character varying(32) DEFAULT '0'::character varying NOT NULL,
    dict_name character varying(64) DEFAULT ''::character varying NOT NULL,
    add_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    edit_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    dict_sort integer DEFAULT 0 NOT NULL,
    CONSTRAINT dict_sort_check CHECK (((dict_sort >= 0) AND (dict_sort <= 999999)))
);


ALTER TABLE system.sys_dict OWNER TO pineapple;

--
-- Name: TABLE sys_dict; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON TABLE system.sys_dict IS '系统数据字典表';


--
-- Name: COLUMN sys_dict.id; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_dict.id IS '主键';


--
-- Name: COLUMN sys_dict.type_code; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_dict.type_code IS '类型编码';


--
-- Name: COLUMN sys_dict.type_name; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_dict.type_name IS '类型名称';


--
-- Name: COLUMN sys_dict.dict_code; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_dict.dict_code IS '字典编码';


--
-- Name: COLUMN sys_dict.dict_name; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_dict.dict_name IS '字典名称';


--
-- Name: COLUMN sys_dict.add_time; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_dict.add_time IS '新增时间';


--
-- Name: COLUMN sys_dict.edit_time; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_dict.edit_time IS '编辑时间';


--
-- Name: COLUMN sys_dict.dict_sort; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_dict.dict_sort IS '数据字典排序值';


--
-- Name: CONSTRAINT dict_sort_check ON sys_dict; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT dict_sort_check ON system.sys_dict IS '系统数据字典排序检查';


--
-- Name: sys_menu; Type: TABLE; Schema: system; Owner: pineapple
--

CREATE TABLE system.sys_menu (
    id bigint NOT NULL,
    parent_id bigint NOT NULL,
    menu_code character varying(64) DEFAULT ''::character varying NOT NULL,
    menu_name character varying(128) DEFAULT ''::character varying NOT NULL,
    menu_title character varying(64) DEFAULT ''::character varying,
    menu_type character varying(12) DEFAULT 'menu'::character varying NOT NULL,
    menu_icon character varying(64) DEFAULT ''::character varying,
    api_uri text DEFAULT ''::character varying,
    view_page_uri text DEFAULT ''::character varying,
    view_page_location text DEFAULT ''::character varying,
    menu_sort integer DEFAULT 10 NOT NULL,
    menu_desc text DEFAULT ''::character varying,
    add_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    edit_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT menu_sort_check CHECK (((menu_sort >= 0) AND (menu_sort <= 999999)))
);


ALTER TABLE system.sys_menu OWNER TO pineapple;

--
-- Name: TABLE sys_menu; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON TABLE system.sys_menu IS '系统菜单表';


--
-- Name: COLUMN sys_menu.id; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_menu.id IS '主键';


--
-- Name: COLUMN sys_menu.parent_id; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_menu.parent_id IS '上级菜单主键';


--
-- Name: COLUMN sys_menu.menu_code; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_menu.menu_code IS '菜单编码';


--
-- Name: COLUMN sys_menu.menu_name; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_menu.menu_name IS '菜单名称';


--
-- Name: COLUMN sys_menu.menu_title; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_menu.menu_title IS '菜单标题';


--
-- Name: COLUMN sys_menu.menu_type; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_menu.menu_type IS '菜单类型';


--
-- Name: COLUMN sys_menu.menu_icon; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_menu.menu_icon IS '菜单图标';


--
-- Name: COLUMN sys_menu.api_uri; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_menu.api_uri IS '接口uri';


--
-- Name: COLUMN sys_menu.view_page_uri; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_menu.view_page_uri IS '页面显示路径';


--
-- Name: COLUMN sys_menu.view_page_location; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_menu.view_page_location IS '页面文件存储地址';


--
-- Name: COLUMN sys_menu.menu_sort; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_menu.menu_sort IS '菜单排序';


--
-- Name: COLUMN sys_menu.menu_desc; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_menu.menu_desc IS '菜单备注信息';


--
-- Name: COLUMN sys_menu.add_time; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_menu.add_time IS '新增时间';


--
-- Name: COLUMN sys_menu.edit_time; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_menu.edit_time IS '编辑时间';


--
-- Name: CONSTRAINT menu_sort_check ON sys_menu; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT menu_sort_check ON system.sys_menu IS '菜单排序值范围规定';


--
-- Name: sys_param; Type: TABLE; Schema: system; Owner: pineapple
--

CREATE TABLE system.sys_param (
    id bigint NOT NULL,
    group_code character varying(32) DEFAULT 'DEFAULT'::character varying,
    param_code character varying(64) DEFAULT ''::character varying NOT NULL,
    param_name character varying(64) DEFAULT ''::character varying NOT NULL,
    param_desc text DEFAULT ''::text,
    param_sort integer DEFAULT 10 NOT NULL,
    add_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    edit_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    param_value text DEFAULT ''::text NOT NULL,
    CONSTRAINT param_sort_check CHECK (((param_sort >= 0) AND (param_sort <= 999999)))
);


ALTER TABLE system.sys_param OWNER TO pineapple;

--
-- Name: TABLE sys_param; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON TABLE system.sys_param IS '系统参数信息表';


--
-- Name: COLUMN sys_param.id; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_param.id IS '主键';


--
-- Name: COLUMN sys_param.group_code; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_param.group_code IS '参数分组编码';


--
-- Name: COLUMN sys_param.param_code; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_param.param_code IS '参数编码';


--
-- Name: COLUMN sys_param.param_name; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_param.param_name IS '参数名称';


--
-- Name: COLUMN sys_param.param_desc; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_param.param_desc IS '参数描述';


--
-- Name: COLUMN sys_param.param_sort; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_param.param_sort IS '参数排序值';


--
-- Name: COLUMN sys_param.add_time; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_param.add_time IS '新增时间';


--
-- Name: COLUMN sys_param.edit_time; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_param.edit_time IS '编辑时间';


--
-- Name: COLUMN sys_param.param_value; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_param.param_value IS '参数值';


--
-- Name: CONSTRAINT param_sort_check ON sys_param; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT param_sort_check ON system.sys_param IS '参数排序值范围规定';


--
-- Name: sys_role; Type: TABLE; Schema: system; Owner: pineapple
--

CREATE TABLE system.sys_role (
    id bigint NOT NULL,
    role_code character varying(64) DEFAULT ''::character varying NOT NULL,
    role_name character varying(128) DEFAULT ''::character varying NOT NULL,
    role_sort integer DEFAULT 10 NOT NULL,
    role_desc text DEFAULT ''::character varying,
    add_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    edit_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT role_sort_check CHECK (((role_sort >= 0) AND (role_sort <= 999999)))
);


ALTER TABLE system.sys_role OWNER TO pineapple;

--
-- Name: TABLE sys_role; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON TABLE system.sys_role IS '系统角色表';


--
-- Name: COLUMN sys_role.id; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_role.id IS '主键';


--
-- Name: COLUMN sys_role.role_code; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_role.role_code IS '角色编码';


--
-- Name: COLUMN sys_role.role_name; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_role.role_name IS '角色名称';


--
-- Name: COLUMN sys_role.role_sort; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_role.role_sort IS '角色排序';


--
-- Name: COLUMN sys_role.role_desc; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_role.role_desc IS '角色备注信息';


--
-- Name: COLUMN sys_role.add_time; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_role.add_time IS '新增时间';


--
-- Name: COLUMN sys_role.edit_time; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_role.edit_time IS '编辑时间';


--
-- Name: CONSTRAINT role_sort_check ON sys_role; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT role_sort_check ON system.sys_role IS '角色排序值范围规定';


--
-- Name: sys_role_menu; Type: TABLE; Schema: system; Owner: pineapple
--

CREATE TABLE system.sys_role_menu (
    role_id bigint NOT NULL,
    menu_id bigint NOT NULL
);


ALTER TABLE system.sys_role_menu OWNER TO pineapple;

--
-- Name: TABLE sys_role_menu; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON TABLE system.sys_role_menu IS '系统角色菜单关系映射表';


--
-- Name: COLUMN sys_role_menu.role_id; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_role_menu.role_id IS '关联角色id';


--
-- Name: COLUMN sys_role_menu.menu_id; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_role_menu.menu_id IS '关联菜单id';


--
-- Name: sys_user; Type: TABLE; Schema: system; Owner: pineapple
--

CREATE TABLE system.sys_user (
    id bigint NOT NULL,
    login_id character varying(32) DEFAULT ''::character varying NOT NULL,
    login_password text DEFAULT ''::character varying NOT NULL,
    nickname character varying(64) DEFAULT ''::character varying,
    last_name character varying(64) DEFAULT ''::character varying,
    first_name character varying(128) DEFAULT ''::character varying,
    avatar_url text DEFAULT ''::character varying,
    sex_code character varying(16) DEFAULT 'unknown'::character varying NOT NULL,
    user_type character varying(16) DEFAULT 'register'::character varying NOT NULL,
    user_status character varying(16) DEFAULT 'will-active'::character varying NOT NULL,
    birthday date DEFAULT CURRENT_DATE NOT NULL,
    add_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    edit_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE system.sys_user OWNER TO pineapple;

--
-- Name: TABLE sys_user; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON TABLE system.sys_user IS '系统用户信息表';


--
-- Name: COLUMN sys_user.id; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user.id IS '主键';


--
-- Name: COLUMN sys_user.login_id; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user.login_id IS '登录标识';


--
-- Name: COLUMN sys_user.login_password; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user.login_password IS '登录密码';


--
-- Name: COLUMN sys_user.nickname; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user.nickname IS '登录用户昵称';


--
-- Name: COLUMN sys_user.last_name; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user.last_name IS '用户姓氏';


--
-- Name: COLUMN sys_user.first_name; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user.first_name IS '用户名称';


--
-- Name: COLUMN sys_user.avatar_url; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user.avatar_url IS '用户头像地址路径';


--
-- Name: COLUMN sys_user.sex_code; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user.sex_code IS '用户性别';


--
-- Name: COLUMN sys_user.user_type; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user.user_type IS '用户类型';


--
-- Name: COLUMN sys_user.user_status; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user.user_status IS '用户状态';


--
-- Name: COLUMN sys_user.birthday; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user.birthday IS '用户出生日期';


--
-- Name: COLUMN sys_user.add_time; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user.add_time IS '新增时间';


--
-- Name: COLUMN sys_user.edit_time; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user.edit_time IS '编辑时间';


--
-- Name: sys_user_role; Type: TABLE; Schema: system; Owner: pineapple
--

CREATE TABLE system.sys_user_role (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE system.sys_user_role OWNER TO pineapple;

--
-- Name: TABLE sys_user_role; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON TABLE system.sys_user_role IS '系统用户角色关系映射表';


--
-- Name: COLUMN sys_user_role.user_id; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user_role.user_id IS '关联用户id';


--
-- Name: COLUMN sys_user_role.role_id; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON COLUMN system.sys_user_role.role_id IS '关联角色id';


--
-- Name: act_evt_log log_nr_; Type: DEFAULT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_evt_log ALTER COLUMN log_nr_ SET DEFAULT nextval('flow.act_evt_log_log_nr__seq'::regclass);


--
-- Name: act_hi_tsk_log id_; Type: DEFAULT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_hi_tsk_log ALTER COLUMN id_ SET DEFAULT nextval('flow.act_hi_tsk_log_id__seq'::regclass);


--
-- Name: config_info id; Type: DEFAULT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_info ALTER COLUMN id SET DEFAULT nextval('nacos.config_info_id_seq'::regclass);


--
-- Name: config_info_aggr id; Type: DEFAULT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_info_aggr ALTER COLUMN id SET DEFAULT nextval('nacos.config_info_aggr_id_seq'::regclass);


--
-- Name: config_info_beta id; Type: DEFAULT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_info_beta ALTER COLUMN id SET DEFAULT nextval('nacos.config_info_beta_id_seq'::regclass);


--
-- Name: config_info_tag id; Type: DEFAULT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_info_tag ALTER COLUMN id SET DEFAULT nextval('nacos.config_info_tag_id_seq'::regclass);


--
-- Name: config_tags_relation nid; Type: DEFAULT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_tags_relation ALTER COLUMN nid SET DEFAULT nextval('nacos.config_tags_relation_nid_seq'::regclass);


--
-- Name: group_capacity id; Type: DEFAULT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.group_capacity ALTER COLUMN id SET DEFAULT nextval('nacos.group_capacity_id_seq'::regclass);


--
-- Name: his_config_info nid; Type: DEFAULT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.his_config_info ALTER COLUMN nid SET DEFAULT nextval('nacos.his_config_info_nid_seq'::regclass);


--
-- Name: tenant_capacity id; Type: DEFAULT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.tenant_capacity ALTER COLUMN id SET DEFAULT nextval('nacos.tenant_capacity_id_seq'::regclass);


--
-- Name: tenant_info id; Type: DEFAULT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.tenant_info ALTER COLUMN id SET DEFAULT nextval('nacos.tenant_info_id_seq'::regclass);


--
-- Name: act_evt_log log_nr_; Type: DEFAULT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_evt_log ALTER COLUMN log_nr_ SET DEFAULT nextval('public.act_evt_log_log_nr__seq'::regclass);


--
-- Name: act_hi_tsk_log id_; Type: DEFAULT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_hi_tsk_log ALTER COLUMN id_ SET DEFAULT nextval('public.act_hi_tsk_log_id__seq'::regclass);


--
-- Data for Name: oauth_access_token; Type: TABLE DATA; Schema: authorization; Owner: pineapple
--



--
-- Data for Name: oauth_client_details; Type: TABLE DATA; Schema: authorization; Owner: pineapple
--



--
-- Data for Name: oauth_code; Type: TABLE DATA; Schema: authorization; Owner: pineapple
--



--
-- Data for Name: oauth_refresh_token; Type: TABLE DATA; Schema: authorization; Owner: pineapple
--



--
-- Data for Name: act_evt_log; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ge_bytearray; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ge_property; Type: TABLE DATA; Schema: flow; Owner: pineapple
--

INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('common.schema.version', '6.6.0.0', 1);
INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('next.dbid', '1', 1);
INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('identitylink.schema.version', '6.6.0.0', 1);
INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('entitylink.schema.version', '6.6.0.0', 1);
INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('eventsubscription.schema.version', '6.6.0.0', 1);
INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('task.schema.version', '6.6.0.0', 1);
INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('variable.schema.version', '6.6.0.0', 1);
INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('job.schema.version', '6.6.0.0', 1);
INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('batch.schema.version', '6.6.0.0', 1);
INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('schema.version', '6.6.0.0', 1);
INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('schema.history', 'create(6.6.0.0)', 1);
INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('cfg.execution-related-entities-count', 'true', 1);
INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('cfg.task-related-entities-count', 'true', 1);


--
-- Data for Name: act_hi_actinst; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_hi_attachment; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_hi_comment; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_hi_detail; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_hi_entitylink; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_hi_identitylink; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_hi_procinst; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_hi_taskinst; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_hi_tsk_log; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_hi_varinst; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_id_bytearray; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_id_group; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_id_info; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_id_membership; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_id_priv; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_id_priv_mapping; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_id_property; Type: TABLE DATA; Schema: flow; Owner: pineapple
--

INSERT INTO flow.act_id_property (name_, value_, rev_) VALUES ('schema.version', '6.6.0.0', 1);


--
-- Data for Name: act_id_token; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_id_user; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_procdef_info; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_re_deployment; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_re_model; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_re_procdef; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ru_actinst; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ru_deadletter_job; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ru_entitylink; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ru_event_subscr; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ru_execution; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ru_external_job; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ru_history_job; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ru_identitylink; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ru_job; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ru_suspended_job; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ru_task; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ru_timer_job; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ru_variable; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: flw_channel_definition; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: flw_ev_databasechangelog; Type: TABLE DATA; Schema: flow; Owner: pineapple
--

INSERT INTO flow.flw_ev_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-13 14:30:35.552937', 1, 'EXECUTED', '8:1b0c48c9cf7945be799d868a2626d687', 'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...', '', NULL, '4.9.1', NULL, NULL, '8689035386');


--
-- Data for Name: flw_ev_databasechangeloglock; Type: TABLE DATA; Schema: flow; Owner: pineapple
--

INSERT INTO flow.flw_ev_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: flw_event_definition; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: flw_event_deployment; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: flw_event_resource; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: flw_ru_batch; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: flw_ru_batch_part; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: config_info; Type: TABLE DATA; Schema: nacos; Owner: pineapple
--



--
-- Data for Name: config_info_aggr; Type: TABLE DATA; Schema: nacos; Owner: pineapple
--



--
-- Data for Name: config_info_beta; Type: TABLE DATA; Schema: nacos; Owner: pineapple
--



--
-- Data for Name: config_info_tag; Type: TABLE DATA; Schema: nacos; Owner: pineapple
--



--
-- Data for Name: config_tags_relation; Type: TABLE DATA; Schema: nacos; Owner: pineapple
--



--
-- Data for Name: group_capacity; Type: TABLE DATA; Schema: nacos; Owner: pineapple
--



--
-- Data for Name: his_config_info; Type: TABLE DATA; Schema: nacos; Owner: pineapple
--



--
-- Data for Name: permissions; Type: TABLE DATA; Schema: nacos; Owner: pineapple
--



--
-- Data for Name: roles; Type: TABLE DATA; Schema: nacos; Owner: pineapple
--

INSERT INTO nacos.roles (username, role) VALUES ('nacos', 'ROLE_ADMIN');


--
-- Data for Name: tenant_capacity; Type: TABLE DATA; Schema: nacos; Owner: pineapple
--



--
-- Data for Name: tenant_info; Type: TABLE DATA; Schema: nacos; Owner: pineapple
--

INSERT INTO nacos.tenant_info (id, kp, tenant_id, tenant_name, tenant_desc, create_source, gmt_create, gmt_modified) VALUES (1, '1', 'pineapple_dev', 'pineapple_dev', 'pineapple_dev', 'nacos', 1677816048193, 1677816048193);


--
-- Data for Name: users; Type: TABLE DATA; Schema: nacos; Owner: pineapple
--

INSERT INTO nacos.users (username, password, enabled) VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', true);


--
-- Data for Name: act_app_appdef; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_app_databasechangelog; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.act_app_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2023-03-13 14:31:55.230176', 1, 'EXECUTED', '8:496fc778bdf2ab13f2e1926d0e63e0a2', 'createTable tableName=ACT_APP_DEPLOYMENT; createTable tableName=ACT_APP_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_APP_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_APP_RSRC_DPL, referencedTableName=ACT_APP_DEPLOYMENT; createIndex...', '', NULL, '4.9.1', NULL, NULL, '8689115187');
INSERT INTO public.act_app_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2023-03-13 14:31:55.239593', 2, 'EXECUTED', '8:f1f8aff320aade831944ebad24355f3d', 'createIndex indexName=ACT_IDX_APP_DEF_UNIQ, tableName=ACT_APP_APPDEF', '', NULL, '4.9.1', NULL, NULL, '8689115187');


--
-- Data for Name: act_app_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.act_app_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: act_app_deployment; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_app_deployment_resource; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_cmmn_casedef; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_cmmn_databasechangelog; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-13 14:31:53.290245', 1, 'EXECUTED', '8:8b4b922d90b05ff27483abefc9597aa6', 'createTable tableName=ACT_CMMN_DEPLOYMENT; createTable tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_CMMN_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_CMMN_RSRC_DPL, referencedTableName=ACT_CMMN_DEPLOYMENT; create...', '', NULL, '4.9.1', NULL, NULL, '8689113035');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-13 14:31:53.307987', 2, 'EXECUTED', '8:65e39b3d385706bb261cbeffe7533cbe', 'addColumn tableName=ACT_CMMN_CASEDEF; addColumn tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '8689113035');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-13 14:31:53.337094', 3, 'EXECUTED', '8:c01f6e802b49436b4489040da3012359', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_PLAN_ITEM_STAGE_INST, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableNam...', '', NULL, '4.9.1', NULL, NULL, '8689113035');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-13 14:31:53.364016', 4, 'EXECUTED', '8:e40d29cb79345b7fb5afd38a7f0ba8fc', 'createTable tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_MIL_INST; addColumn tableName=ACT_CMMN_HI_MIL_INST', '', NULL, '4.9.1', NULL, NULL, '8689113035');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('6', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-13 14:31:53.375167', 5, 'EXECUTED', '8:10e82e26a7fee94c32a92099c059c18c', 'createIndex indexName=ACT_IDX_CASE_DEF_UNIQ, tableName=ACT_CMMN_CASEDEF', '', NULL, '4.9.1', NULL, NULL, '8689113035');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('7', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-13 14:31:53.396888', 6, 'EXECUTED', '8:530bc81a1e30618ccf4a2da1f7c6c043', 'renameColumn newColumnName=CREATE_TIME_, oldColumnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; renameColumn newColumnName=CREATE_TIME_, oldColumnName=CREATED_TIME_, tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_P...', '', NULL, '4.9.1', NULL, NULL, '8689113035');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-13 14:31:53.402245', 7, 'EXECUTED', '8:e8c2eb1ce28bc301efe07e0e29757781', 'addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '8689113035');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-13 14:31:53.411369', 8, 'EXECUTED', '8:4cb4782b9bdec5ced2a64c525aa7b3a0', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '8689113035');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('10', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-13 14:31:53.427708', 9, 'EXECUTED', '8:341c16be247f5d17badc9809da8691f9', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_CASE_INST_REF_ID_, tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE...', '', NULL, '4.9.1', NULL, NULL, '8689113035');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('11', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-13 14:31:53.435371', 10, 'EXECUTED', '8:d7c4da9276bcfffbfb0ebfb25e3f7b05', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '8689113035');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('12', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-13 14:31:53.440506', 11, 'EXECUTED', '8:adf4ecc45f2aa9a44a5626b02e1d6f98', 'addColumn tableName=ACT_CMMN_RU_CASE_INST', '', NULL, '4.9.1', NULL, NULL, '8689113035');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-13 14:31:53.447603', 12, 'EXECUTED', '8:7550626f964ab5518464709408333ec1', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '8689113035');


--
-- Data for Name: act_cmmn_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.act_cmmn_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: act_cmmn_deployment; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_cmmn_deployment_resource; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_cmmn_hi_case_inst; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_cmmn_hi_mil_inst; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_cmmn_hi_plan_item_inst; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_cmmn_ru_case_inst; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_cmmn_ru_mil_inst; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_cmmn_ru_plan_item_inst; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_cmmn_ru_sentry_part_inst; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_co_content_item; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_co_databasechangelog; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.act_co_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'activiti', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2023-03-13 14:31:50.800146', 1, 'EXECUTED', '8:7644d7165cfe799200a2abdd3419e8b6', 'createTable tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_taskid, tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_procid, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '4.9.1', NULL, NULL, '8689110777');
INSERT INTO public.act_co_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2', 'flowable', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2023-03-13 14:31:50.808192', 2, 'EXECUTED', '8:fe7b11ac7dbbf9c43006b23bbab60bab', 'addColumn tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_scope, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '4.9.1', NULL, NULL, '8689110777');


--
-- Data for Name: act_co_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.act_co_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: act_dmn_databasechangelog; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'activiti', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-13 14:31:46.837263', 1, 'EXECUTED', '8:c8701f1c71018b55029f450b2e9a10a1', 'createTable tableName=ACT_DMN_DEPLOYMENT; createTable tableName=ACT_DMN_DEPLOYMENT_RESOURCE; createTable tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.9.1', NULL, NULL, '8689106776');
INSERT INTO public.act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-13 14:31:46.849448', 2, 'EXECUTED', '8:47f94b27feb7df8a30d4e338c7bd5fb8', 'createTable tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.9.1', NULL, NULL, '8689106776');
INSERT INTO public.act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-13 14:31:46.853678', 3, 'EXECUTED', '8:ac17eae89fbdccb6e08daf3c7797b579', 'addColumn tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.9.1', NULL, NULL, '8689106776');
INSERT INTO public.act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-13 14:31:46.857704', 4, 'EXECUTED', '8:f73aabc4529e7292c2942073d1cff6f9', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.9.1', NULL, NULL, '8689106776');
INSERT INTO public.act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('6', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-13 14:31:46.864162', 5, 'EXECUTED', '8:646c6a061e0b6e8a62e69844ff96abb0', 'createIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.9.1', NULL, NULL, '8689106776');
INSERT INTO public.act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('7', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-13 14:31:46.874396', 6, 'EXECUTED', '8:215a499ff7ae77685b55355245b8b708', 'dropIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE; renameTable newTableName=ACT_DMN_DECISION, oldTableName=ACT_DMN_DECISION_TABLE; createIndex indexName=ACT_IDX_DMN_DEC_UNIQ, tableName=ACT_DMN_DECISION', '', NULL, '4.9.1', NULL, NULL, '8689106776');
INSERT INTO public.act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-13 14:31:46.877237', 7, 'EXECUTED', '8:5355bee389318afed91a11702f2df032', 'addColumn tableName=ACT_DMN_DECISION', '', NULL, '4.9.1', NULL, NULL, '8689106776');


--
-- Data for Name: act_dmn_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.act_dmn_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: act_dmn_decision; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_dmn_deployment; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_dmn_deployment_resource; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_dmn_hi_decision_execution; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_evt_log; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_fo_databasechangelog; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.act_fo_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'activiti', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-13 14:31:48.740103', 1, 'EXECUTED', '8:033ebf9380889aed7c453927ecc3250d', 'createTable tableName=ACT_FO_FORM_DEPLOYMENT; createTable tableName=ACT_FO_FORM_RESOURCE; createTable tableName=ACT_FO_FORM_DEFINITION; createTable tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.9.1', NULL, NULL, '8689108698');
INSERT INTO public.act_fo_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-13 14:31:48.746531', 2, 'EXECUTED', '8:986365ceb40445ce3b27a8e6b40f159b', 'addColumn tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.9.1', NULL, NULL, '8689108698');
INSERT INTO public.act_fo_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-13 14:31:48.750745', 3, 'EXECUTED', '8:abf482518ceb09830ef674e52c06bf15', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '4.9.1', NULL, NULL, '8689108698');
INSERT INTO public.act_fo_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('5', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-13 14:31:48.760468', 4, 'EXECUTED', '8:b4be732b89e5ca028bdd520c6ad4d446', 'createIndex indexName=ACT_IDX_FORM_DEF_UNIQ, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '4.9.1', NULL, NULL, '8689108698');


--
-- Data for Name: act_fo_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.act_fo_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: act_fo_form_definition; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_fo_form_deployment; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_fo_form_instance; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_fo_form_resource; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ge_bytearray; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ge_property; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.act_ge_property (name_, value_, rev_) VALUES ('common.schema.version', '6.6.0.0', 1);
INSERT INTO public.act_ge_property (name_, value_, rev_) VALUES ('next.dbid', '1', 1);
INSERT INTO public.act_ge_property (name_, value_, rev_) VALUES ('identitylink.schema.version', '6.6.0.0', 1);
INSERT INTO public.act_ge_property (name_, value_, rev_) VALUES ('entitylink.schema.version', '6.6.0.0', 1);
INSERT INTO public.act_ge_property (name_, value_, rev_) VALUES ('eventsubscription.schema.version', '6.6.0.0', 1);
INSERT INTO public.act_ge_property (name_, value_, rev_) VALUES ('task.schema.version', '6.6.0.0', 1);
INSERT INTO public.act_ge_property (name_, value_, rev_) VALUES ('variable.schema.version', '6.6.0.0', 1);
INSERT INTO public.act_ge_property (name_, value_, rev_) VALUES ('job.schema.version', '6.6.0.0', 1);
INSERT INTO public.act_ge_property (name_, value_, rev_) VALUES ('batch.schema.version', '6.6.0.0', 1);
INSERT INTO public.act_ge_property (name_, value_, rev_) VALUES ('schema.version', '6.6.0.0', 1);
INSERT INTO public.act_ge_property (name_, value_, rev_) VALUES ('schema.history', 'create(6.6.0.0)', 1);
INSERT INTO public.act_ge_property (name_, value_, rev_) VALUES ('cfg.execution-related-entities-count', 'true', 1);
INSERT INTO public.act_ge_property (name_, value_, rev_) VALUES ('cfg.task-related-entities-count', 'true', 1);


--
-- Data for Name: act_hi_actinst; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_hi_attachment; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_hi_comment; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_hi_detail; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_hi_entitylink; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_hi_identitylink; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_hi_procinst; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_hi_taskinst; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_hi_tsk_log; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_hi_varinst; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_id_bytearray; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_id_group; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_id_info; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_id_membership; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_id_priv; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_id_priv_mapping; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_id_property; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.act_id_property (name_, value_, rev_) VALUES ('schema.version', '6.6.0.0', 1);


--
-- Data for Name: act_id_token; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_id_user; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_procdef_info; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_re_deployment; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_re_model; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_re_procdef; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ru_actinst; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ru_deadletter_job; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ru_entitylink; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ru_event_subscr; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ru_execution; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ru_external_job; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ru_history_job; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ru_identitylink; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ru_job; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ru_suspended_job; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ru_task; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ru_timer_job; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: act_ru_variable; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: flw_channel_definition; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: flw_ev_databasechangelog; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.flw_ev_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-13 14:31:32.589098', 1, 'EXECUTED', '8:1b0c48c9cf7945be799d868a2626d687', 'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...', '', NULL, '4.9.1', NULL, NULL, '8689092100');


--
-- Data for Name: flw_ev_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.flw_ev_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: flw_event_definition; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: flw_event_deployment; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: flw_event_resource; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: flw_ru_batch; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: flw_ru_batch_part; Type: TABLE DATA; Schema: public; Owner: pineapple
--



--
-- Data for Name: sys_dict; Type: TABLE DATA; Schema: system; Owner: pineapple
--

INSERT INTO system.sys_dict (id, type_code, type_name, dict_code, dict_name, add_time, edit_time, dict_sort) VALUES (73436733278130176, 'menu_type', '菜单类型字典', 'catalog', '目录', '2023-03-03 15:31:21.602', '2023-03-03 15:31:21.602', 10);
INSERT INTO system.sys_dict (id, type_code, type_name, dict_code, dict_name, add_time, edit_time, dict_sort) VALUES (73436964883402752, 'menu_type', '菜单类型字典', 'menu', '菜单', '2023-03-03 15:32:16.821', '2023-03-03 15:32:16.821', 20);
INSERT INTO system.sys_dict (id, type_code, type_name, dict_code, dict_name, add_time, edit_time, dict_sort) VALUES (73437069699059712, 'menu_type', '菜单类型字典', 'button', '按钮', '2023-03-03 15:32:41.812', '2023-03-03 15:32:41.812', 30);
INSERT INTO system.sys_dict (id, type_code, type_name, dict_code, dict_name, add_time, edit_time, dict_sort) VALUES (73437127513346048, 'menu_type', '菜单类型字典', 'resource', '资源', '2023-03-03 15:32:55.595', '2023-03-03 15:32:55.595', 40);
INSERT INTO system.sys_dict (id, type_code, type_name, dict_code, dict_name, add_time, edit_time, dict_sort) VALUES (73436117717880832, 'sex_code', '性别字典', 'male', '男性', '2023-03-03 15:28:54.841', '2023-03-03 15:28:54.841', 20);
INSERT INTO system.sys_dict (id, type_code, type_name, dict_code, dict_name, add_time, edit_time, dict_sort) VALUES (73435884879482880, 'sex_code', '性别字典', 'unknown', '未知', '2023-03-03 15:27:59.329', '2023-03-03 15:27:59.329', 10);
INSERT INTO system.sys_dict (id, type_code, type_name, dict_code, dict_name, add_time, edit_time, dict_sort) VALUES (73436380491026432, 'sex_code', '性别字典', 'female', '女性', '2023-03-03 15:29:57.491', '2023-03-03 15:29:57.491', 30);
INSERT INTO system.sys_dict (id, type_code, type_name, dict_code, dict_name, add_time, edit_time, dict_sort) VALUES (73437569488130048, 'user_type', '用户类型字典', 'register', '注册用户', '2023-03-03 15:34:40.971', '2023-03-03 15:34:40.971', 10);
INSERT INTO system.sys_dict (id, type_code, type_name, dict_code, dict_name, add_time, edit_time, dict_sort) VALUES (73437604279881728, 'user_type', '用户类型字典', 'inner', '内部用户', '2023-03-03 15:34:49.265', '2023-03-03 15:34:49.265', 20);
INSERT INTO system.sys_dict (id, type_code, type_name, dict_code, dict_name, add_time, edit_time, dict_sort) VALUES (73437813990887424, 'user_status', '用户状态字典', 'active', '已激活', '2023-03-03 15:35:39.264', '2023-03-03 15:35:39.264', 10);
INSERT INTO system.sys_dict (id, type_code, type_name, dict_code, dict_name, add_time, edit_time, dict_sort) VALUES (73437901320491008, 'user_status', '用户状态字典', 'locked', '已锁定', '2023-03-03 15:36:00.085', '2023-03-03 15:36:00.085', 20);
INSERT INTO system.sys_dict (id, type_code, type_name, dict_code, dict_name, add_time, edit_time, dict_sort) VALUES (73438048800608256, 'user_status', '用户状态字典', 'expired', '已过期', '2023-03-03 15:36:35.247', '2023-03-03 15:36:35.247', 30);
INSERT INTO system.sys_dict (id, type_code, type_name, dict_code, dict_name, add_time, edit_time, dict_sort) VALUES (73438408902578176, 'user_status', '用户状态字典', 'will-active', '待激活', '2023-03-03 15:38:01.103', '2023-03-03 15:38:01.103', 40);
INSERT INTO system.sys_dict (id, type_code, type_name, dict_code, dict_name, add_time, edit_time, dict_sort) VALUES (77077408997707776, 'test', 'test', 'string', 'string', '2023-03-13 16:38:06.334', '2023-03-13 16:38:06.334', 99999);


--
-- Data for Name: sys_menu; Type: TABLE DATA; Schema: system; Owner: pineapple
--

INSERT INTO system.sys_menu (id, parent_id, menu_code, menu_name, menu_title, menu_type, menu_icon, api_uri, view_page_uri, view_page_location, menu_sort, menu_desc, add_time, edit_time) VALUES (79977543612239872, 0, 'system:*:*', '系统管理', '系统管理', 'catalog', '', '', '/system/user', 'views/system/user', 10, '系统管理', '2023-03-21 16:42:12.308', '2023-03-21 16:42:12.308');
INSERT INTO system.sys_menu (id, parent_id, menu_code, menu_name, menu_title, menu_type, menu_icon, api_uri, view_page_uri, view_page_location, menu_sort, menu_desc, add_time, edit_time) VALUES (79977981388525568, 79977543612239872, 'system:role:*', '角色管理', '角色管理', 'menu', '', '', '/system/role', 'views/system/role', 20, '角色管理', '2023-03-21 16:43:56.682', '2023-03-21 16:43:56.682');
INSERT INTO system.sys_menu (id, parent_id, menu_code, menu_name, menu_title, menu_type, menu_icon, api_uri, view_page_uri, view_page_location, menu_sort, menu_desc, add_time, edit_time) VALUES (79978107834208256, 79977543612239872, 'system:menu:*', '菜单管理', '菜单管理', 'menu', '', '', '/system/menu', 'views/system/menu', 30, '菜单管理', '2023-03-21 16:44:26.829', '2023-03-21 16:44:26.829');
INSERT INTO system.sys_menu (id, parent_id, menu_code, menu_name, menu_title, menu_type, menu_icon, api_uri, view_page_uri, view_page_location, menu_sort, menu_desc, add_time, edit_time) VALUES (79977811615682560, 79977543612239872, 'system:user:*', '用户管理', '用户管理', 'menu', '', '', '/system/user', 'views/system/user', 10, '用户管理', '2023-03-21 16:43:16.205', '2023-03-21 16:43:16.206');


--
-- Data for Name: sys_param; Type: TABLE DATA; Schema: system; Owner: pineapple
--

INSERT INTO system.sys_param (id, group_code, param_code, param_name, param_desc, param_sort, add_time, edit_time, param_value) VALUES (1, 'DEFAULT', 'USER_PASSWORD_CRYPTO_STRATEGY', '用户密码加解密策略器', '用户密码加解密策略器', 10, '2023-03-16 06:53:12.173204', '2023-03-16 06:53:12.173204', 'md5SaltCrypto');
INSERT INTO system.sys_param (id, group_code, param_code, param_name, param_desc, param_sort, add_time, edit_time, param_value) VALUES (2, 'DEFAULT', 'TOKEN_EXPIRE_TIME_HOUR', '登录令牌时效(小时)', '登录令牌时效(小时)', 20, '2023-03-17 01:48:53.259847', '2023-03-17 01:48:53.259847', '2');


--
-- Data for Name: sys_role; Type: TABLE DATA; Schema: system; Owner: pineapple
--

INSERT INTO system.sys_role (id, role_code, role_name, role_sort, role_desc, add_time, edit_time) VALUES (1, 'ROLE_ADMIN', '超级管理员', 10, '超级管理员', '2023-03-21 08:45:26.414007', '2023-03-21 08:45:26.414007');
INSERT INTO system.sys_role (id, role_code, role_name, role_sort, role_desc, add_time, edit_time) VALUES (2, 'ROLE_TEST', '测试', 20, '测试', '2023-03-24 02:09:51.548766', '2023-03-24 02:09:51.548766');


--
-- Data for Name: sys_role_menu; Type: TABLE DATA; Schema: system; Owner: pineapple
--

INSERT INTO system.sys_role_menu (role_id, menu_id) VALUES (1, 79977543612239872);
INSERT INTO system.sys_role_menu (role_id, menu_id) VALUES (1, 79977811615682560);
INSERT INTO system.sys_role_menu (role_id, menu_id) VALUES (1, 79977981388525568);
INSERT INTO system.sys_role_menu (role_id, menu_id) VALUES (1, 79978107834208256);


--
-- Data for Name: sys_user; Type: TABLE DATA; Schema: system; Owner: pineapple
--

INSERT INTO system.sys_user (id, login_id, login_password, nickname, last_name, first_name, avatar_url, sex_code, user_type, user_status, birthday, add_time, edit_time) VALUES (1, 'admin', 'a66abb5684c45962d887564f08346e8d', 'admin', 'admin', 'admin', '', 'male', 'inner', 'active', '2023-03-15', '2023-03-15 11:24:35.38697', '2023-03-15 11:24:35.38697');


--
-- Data for Name: sys_user_role; Type: TABLE DATA; Schema: system; Owner: pineapple
--

INSERT INTO system.sys_user_role (user_id, role_id) VALUES (1, 1);


--
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE SET; Schema: flow; Owner: pineapple
--

SELECT pg_catalog.setval('flow.act_evt_log_log_nr__seq', 1, false);


--
-- Name: act_hi_tsk_log_id__seq; Type: SEQUENCE SET; Schema: flow; Owner: pineapple
--

SELECT pg_catalog.setval('flow.act_hi_tsk_log_id__seq', 1, false);


--
-- Name: config_info_aggr_id_seq; Type: SEQUENCE SET; Schema: nacos; Owner: pineapple
--

SELECT pg_catalog.setval('nacos.config_info_aggr_id_seq', 1, false);


--
-- Name: config_info_beta_id_seq; Type: SEQUENCE SET; Schema: nacos; Owner: pineapple
--

SELECT pg_catalog.setval('nacos.config_info_beta_id_seq', 1, false);


--
-- Name: config_info_id_seq; Type: SEQUENCE SET; Schema: nacos; Owner: pineapple
--

SELECT pg_catalog.setval('nacos.config_info_id_seq', 1, false);


--
-- Name: config_info_tag_id_seq; Type: SEQUENCE SET; Schema: nacos; Owner: pineapple
--

SELECT pg_catalog.setval('nacos.config_info_tag_id_seq', 1, false);


--
-- Name: config_tags_relation_nid_seq; Type: SEQUENCE SET; Schema: nacos; Owner: pineapple
--

SELECT pg_catalog.setval('nacos.config_tags_relation_nid_seq', 1, false);


--
-- Name: group_capacity_id_seq; Type: SEQUENCE SET; Schema: nacos; Owner: pineapple
--

SELECT pg_catalog.setval('nacos.group_capacity_id_seq', 1, false);


--
-- Name: his_config_info_nid_seq; Type: SEQUENCE SET; Schema: nacos; Owner: pineapple
--

SELECT pg_catalog.setval('nacos.his_config_info_nid_seq', 1, false);


--
-- Name: tenant_capacity_id_seq; Type: SEQUENCE SET; Schema: nacos; Owner: pineapple
--

SELECT pg_catalog.setval('nacos.tenant_capacity_id_seq', 1, false);


--
-- Name: tenant_info_id_seq; Type: SEQUENCE SET; Schema: nacos; Owner: pineapple
--

SELECT pg_catalog.setval('nacos.tenant_info_id_seq', 1, true);


--
-- Name: act_evt_log_log_nr__seq; Type: SEQUENCE SET; Schema: public; Owner: pineapple
--

SELECT pg_catalog.setval('public.act_evt_log_log_nr__seq', 1, false);


--
-- Name: act_hi_tsk_log_id__seq; Type: SEQUENCE SET; Schema: public; Owner: pineapple
--

SELECT pg_catalog.setval('public.act_hi_tsk_log_id__seq', 1, false);


--
-- Name: oauth_access_token oauth_access_token_pk; Type: CONSTRAINT; Schema: authorization; Owner: pineapple
--

ALTER TABLE ONLY "authorization".oauth_access_token
    ADD CONSTRAINT oauth_access_token_pk PRIMARY KEY (authentication_id);


--
-- Name: oauth_client_details oauth_client_details_pk; Type: CONSTRAINT; Schema: authorization; Owner: pineapple
--

ALTER TABLE ONLY "authorization".oauth_client_details
    ADD CONSTRAINT oauth_client_details_pk PRIMARY KEY (client_id);


--
-- Name: flw_channel_definition FLW_CHANNEL_DEFINITION_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.flw_channel_definition
    ADD CONSTRAINT "FLW_CHANNEL_DEFINITION_pkey" PRIMARY KEY (id_);


--
-- Name: flw_event_definition FLW_EVENT_DEFINITION_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.flw_event_definition
    ADD CONSTRAINT "FLW_EVENT_DEFINITION_pkey" PRIMARY KEY (id_);


--
-- Name: flw_event_deployment FLW_EVENT_DEPLOYMENT_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.flw_event_deployment
    ADD CONSTRAINT "FLW_EVENT_DEPLOYMENT_pkey" PRIMARY KEY (id_);


--
-- Name: flw_event_resource FLW_EVENT_RESOURCE_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.flw_event_resource
    ADD CONSTRAINT "FLW_EVENT_RESOURCE_pkey" PRIMARY KEY (id_);


--
-- Name: act_evt_log act_evt_log_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_evt_log
    ADD CONSTRAINT act_evt_log_pkey PRIMARY KEY (log_nr_);


--
-- Name: act_ge_bytearray act_ge_bytearray_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ge_bytearray
    ADD CONSTRAINT act_ge_bytearray_pkey PRIMARY KEY (id_);


--
-- Name: act_ge_property act_ge_property_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ge_property
    ADD CONSTRAINT act_ge_property_pkey PRIMARY KEY (name_);


--
-- Name: act_hi_actinst act_hi_actinst_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_hi_actinst
    ADD CONSTRAINT act_hi_actinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_attachment act_hi_attachment_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_hi_attachment
    ADD CONSTRAINT act_hi_attachment_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_comment act_hi_comment_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_hi_comment
    ADD CONSTRAINT act_hi_comment_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_detail act_hi_detail_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_hi_detail
    ADD CONSTRAINT act_hi_detail_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_entitylink act_hi_entitylink_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_hi_entitylink
    ADD CONSTRAINT act_hi_entitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_identitylink act_hi_identitylink_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_hi_identitylink
    ADD CONSTRAINT act_hi_identitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_procinst act_hi_procinst_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_hi_procinst
    ADD CONSTRAINT act_hi_procinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_procinst act_hi_procinst_proc_inst_id__key; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_hi_procinst
    ADD CONSTRAINT act_hi_procinst_proc_inst_id__key UNIQUE (proc_inst_id_);


--
-- Name: act_hi_taskinst act_hi_taskinst_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_hi_taskinst
    ADD CONSTRAINT act_hi_taskinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_tsk_log act_hi_tsk_log_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_hi_tsk_log
    ADD CONSTRAINT act_hi_tsk_log_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_varinst act_hi_varinst_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_hi_varinst
    ADD CONSTRAINT act_hi_varinst_pkey PRIMARY KEY (id_);


--
-- Name: act_id_bytearray act_id_bytearray_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_id_bytearray
    ADD CONSTRAINT act_id_bytearray_pkey PRIMARY KEY (id_);


--
-- Name: act_id_group act_id_group_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_id_group
    ADD CONSTRAINT act_id_group_pkey PRIMARY KEY (id_);


--
-- Name: act_id_info act_id_info_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_id_info
    ADD CONSTRAINT act_id_info_pkey PRIMARY KEY (id_);


--
-- Name: act_id_membership act_id_membership_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_id_membership
    ADD CONSTRAINT act_id_membership_pkey PRIMARY KEY (user_id_, group_id_);


--
-- Name: act_id_priv_mapping act_id_priv_mapping_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_id_priv_mapping
    ADD CONSTRAINT act_id_priv_mapping_pkey PRIMARY KEY (id_);


--
-- Name: act_id_priv act_id_priv_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_id_priv
    ADD CONSTRAINT act_id_priv_pkey PRIMARY KEY (id_);


--
-- Name: act_id_property act_id_property_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_id_property
    ADD CONSTRAINT act_id_property_pkey PRIMARY KEY (name_);


--
-- Name: act_id_token act_id_token_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_id_token
    ADD CONSTRAINT act_id_token_pkey PRIMARY KEY (id_);


--
-- Name: act_id_user act_id_user_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_id_user
    ADD CONSTRAINT act_id_user_pkey PRIMARY KEY (id_);


--
-- Name: act_procdef_info act_procdef_info_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_procdef_info
    ADD CONSTRAINT act_procdef_info_pkey PRIMARY KEY (id_);


--
-- Name: act_re_deployment act_re_deployment_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_re_deployment
    ADD CONSTRAINT act_re_deployment_pkey PRIMARY KEY (id_);


--
-- Name: act_re_model act_re_model_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_re_model
    ADD CONSTRAINT act_re_model_pkey PRIMARY KEY (id_);


--
-- Name: act_re_procdef act_re_procdef_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_re_procdef
    ADD CONSTRAINT act_re_procdef_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_actinst act_ru_actinst_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_actinst
    ADD CONSTRAINT act_ru_actinst_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_deadletter_job act_ru_deadletter_job_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_deadletter_job
    ADD CONSTRAINT act_ru_deadletter_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_entitylink act_ru_entitylink_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_entitylink
    ADD CONSTRAINT act_ru_entitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_event_subscr act_ru_event_subscr_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_event_subscr
    ADD CONSTRAINT act_ru_event_subscr_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_execution act_ru_execution_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_execution
    ADD CONSTRAINT act_ru_execution_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_external_job act_ru_external_job_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_external_job
    ADD CONSTRAINT act_ru_external_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_history_job act_ru_history_job_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_history_job
    ADD CONSTRAINT act_ru_history_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_identitylink act_ru_identitylink_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_identitylink
    ADD CONSTRAINT act_ru_identitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_job act_ru_job_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_job
    ADD CONSTRAINT act_ru_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_suspended_job act_ru_suspended_job_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_suspended_job
    ADD CONSTRAINT act_ru_suspended_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_task act_ru_task_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_task
    ADD CONSTRAINT act_ru_task_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_timer_job act_ru_timer_job_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_timer_job
    ADD CONSTRAINT act_ru_timer_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_variable act_ru_variable_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_variable
    ADD CONSTRAINT act_ru_variable_pkey PRIMARY KEY (id_);


--
-- Name: act_procdef_info act_uniq_info_procdef; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_procdef_info
    ADD CONSTRAINT act_uniq_info_procdef UNIQUE (proc_def_id_);


--
-- Name: act_id_priv act_uniq_priv_name; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_id_priv
    ADD CONSTRAINT act_uniq_priv_name UNIQUE (name_);


--
-- Name: act_re_procdef act_uniq_procdef; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_re_procdef
    ADD CONSTRAINT act_uniq_procdef UNIQUE (key_, version_, derived_version_, tenant_id_);


--
-- Name: flw_ev_databasechangeloglock flw_ev_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.flw_ev_databasechangeloglock
    ADD CONSTRAINT flw_ev_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: flw_ru_batch_part flw_ru_batch_part_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.flw_ru_batch_part
    ADD CONSTRAINT flw_ru_batch_part_pkey PRIMARY KEY (id_);


--
-- Name: flw_ru_batch flw_ru_batch_pkey; Type: CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.flw_ru_batch
    ADD CONSTRAINT flw_ru_batch_pkey PRIMARY KEY (id_);


--
-- Name: config_info_aggr config_info_aggr_pkey; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_info_aggr
    ADD CONSTRAINT config_info_aggr_pkey PRIMARY KEY (id);


--
-- Name: config_info_beta config_info_beta_pkey; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_info_beta
    ADD CONSTRAINT config_info_beta_pkey PRIMARY KEY (id);


--
-- Name: config_info config_info_pkey; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_info
    ADD CONSTRAINT config_info_pkey PRIMARY KEY (id);


--
-- Name: config_info_tag config_info_tag_pkey; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_info_tag
    ADD CONSTRAINT config_info_tag_pkey PRIMARY KEY (id);


--
-- Name: config_tags_relation config_tags_relation_pkey; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_tags_relation
    ADD CONSTRAINT config_tags_relation_pkey PRIMARY KEY (nid);


--
-- Name: group_capacity group_capacity_pkey; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.group_capacity
    ADD CONSTRAINT group_capacity_pkey PRIMARY KEY (id);


--
-- Name: his_config_info his_config_info_pkey; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.his_config_info
    ADD CONSTRAINT his_config_info_pkey PRIMARY KEY (nid);


--
-- Name: tenant_capacity tenant_capacity_pkey; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.tenant_capacity
    ADD CONSTRAINT tenant_capacity_pkey PRIMARY KEY (id);


--
-- Name: tenant_info tenant_info_pkey; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.tenant_info
    ADD CONSTRAINT tenant_info_pkey PRIMARY KEY (id);


--
-- Name: config_info uk_configinfo_datagrouptenant; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_info
    ADD CONSTRAINT uk_configinfo_datagrouptenant UNIQUE (data_id, group_id, tenant_id);


--
-- Name: config_info_aggr uk_configinfoaggr_datagrouptenantdatum; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_info_aggr
    ADD CONSTRAINT uk_configinfoaggr_datagrouptenantdatum UNIQUE (data_id, group_id, tenant_id, datum_id);


--
-- Name: config_info_beta uk_configinfobeta_datagrouptenant; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_info_beta
    ADD CONSTRAINT uk_configinfobeta_datagrouptenant UNIQUE (data_id, group_id, tenant_id);


--
-- Name: config_info_tag uk_configinfotag_datagrouptenanttag; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_info_tag
    ADD CONSTRAINT uk_configinfotag_datagrouptenanttag UNIQUE (data_id, group_id, tenant_id, tag_id);


--
-- Name: config_tags_relation uk_configtagrelation_configidtag; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.config_tags_relation
    ADD CONSTRAINT uk_configtagrelation_configidtag UNIQUE (id, tag_name, tag_type);


--
-- Name: group_capacity uk_group_id; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.group_capacity
    ADD CONSTRAINT uk_group_id UNIQUE (group_id);


--
-- Name: tenant_capacity uk_tenant_id; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.tenant_capacity
    ADD CONSTRAINT uk_tenant_id UNIQUE (tenant_id);


--
-- Name: tenant_info uk_tenant_info_kptenantid; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.tenant_info
    ADD CONSTRAINT uk_tenant_info_kptenantid UNIQUE (kp, tenant_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: nacos; Owner: pineapple
--

ALTER TABLE ONLY nacos.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


--
-- Name: act_app_appdef ACT_APP_APPDEF_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_app_appdef
    ADD CONSTRAINT "ACT_APP_APPDEF_pkey" PRIMARY KEY (id_);


--
-- Name: act_app_deployment ACT_APP_DEPLOYMENT_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_app_deployment
    ADD CONSTRAINT "ACT_APP_DEPLOYMENT_pkey" PRIMARY KEY (id_);


--
-- Name: act_cmmn_casedef ACT_CMMN_CASEDEF_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_casedef
    ADD CONSTRAINT "ACT_CMMN_CASEDEF_pkey" PRIMARY KEY (id_);


--
-- Name: act_cmmn_deployment ACT_CMMN_DEPLOYMENT_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_deployment
    ADD CONSTRAINT "ACT_CMMN_DEPLOYMENT_pkey" PRIMARY KEY (id_);


--
-- Name: act_cmmn_hi_case_inst ACT_CMMN_HI_CASE_INST_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_hi_case_inst
    ADD CONSTRAINT "ACT_CMMN_HI_CASE_INST_pkey" PRIMARY KEY (id_);


--
-- Name: act_cmmn_hi_mil_inst ACT_CMMN_HI_MIL_INST_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_hi_mil_inst
    ADD CONSTRAINT "ACT_CMMN_HI_MIL_INST_pkey" PRIMARY KEY (id_);


--
-- Name: act_cmmn_hi_plan_item_inst ACT_CMMN_HI_PLAN_ITEM_INST_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_hi_plan_item_inst
    ADD CONSTRAINT "ACT_CMMN_HI_PLAN_ITEM_INST_pkey" PRIMARY KEY (id_);


--
-- Name: act_cmmn_ru_case_inst ACT_CMMN_RU_CASE_INST_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_ru_case_inst
    ADD CONSTRAINT "ACT_CMMN_RU_CASE_INST_pkey" PRIMARY KEY (id_);


--
-- Name: act_cmmn_ru_mil_inst ACT_CMMN_RU_MIL_INST_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_ru_mil_inst
    ADD CONSTRAINT "ACT_CMMN_RU_MIL_INST_pkey" PRIMARY KEY (id_);


--
-- Name: act_co_content_item ACT_CO_CONTENT_ITEM_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_co_content_item
    ADD CONSTRAINT "ACT_CO_CONTENT_ITEM_pkey" PRIMARY KEY (id_);


--
-- Name: act_dmn_decision ACT_DMN_DECISION_TABLE_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_dmn_decision
    ADD CONSTRAINT "ACT_DMN_DECISION_TABLE_pkey" PRIMARY KEY (id_);


--
-- Name: act_dmn_deployment_resource ACT_DMN_DEPLOYMENT_RESOURCE_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_dmn_deployment_resource
    ADD CONSTRAINT "ACT_DMN_DEPLOYMENT_RESOURCE_pkey" PRIMARY KEY (id_);


--
-- Name: act_dmn_deployment ACT_DMN_DEPLOYMENT_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_dmn_deployment
    ADD CONSTRAINT "ACT_DMN_DEPLOYMENT_pkey" PRIMARY KEY (id_);


--
-- Name: act_dmn_hi_decision_execution ACT_DMN_HI_DECISION_EXECUTION_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_dmn_hi_decision_execution
    ADD CONSTRAINT "ACT_DMN_HI_DECISION_EXECUTION_pkey" PRIMARY KEY (id_);


--
-- Name: act_fo_form_definition ACT_FO_FORM_DEFINITION_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_fo_form_definition
    ADD CONSTRAINT "ACT_FO_FORM_DEFINITION_pkey" PRIMARY KEY (id_);


--
-- Name: act_fo_form_deployment ACT_FO_FORM_DEPLOYMENT_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_fo_form_deployment
    ADD CONSTRAINT "ACT_FO_FORM_DEPLOYMENT_pkey" PRIMARY KEY (id_);


--
-- Name: act_fo_form_instance ACT_FO_FORM_INSTANCE_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_fo_form_instance
    ADD CONSTRAINT "ACT_FO_FORM_INSTANCE_pkey" PRIMARY KEY (id_);


--
-- Name: act_fo_form_resource ACT_FO_FORM_RESOURCE_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_fo_form_resource
    ADD CONSTRAINT "ACT_FO_FORM_RESOURCE_pkey" PRIMARY KEY (id_);


--
-- Name: flw_channel_definition FLW_CHANNEL_DEFINITION_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.flw_channel_definition
    ADD CONSTRAINT "FLW_CHANNEL_DEFINITION_pkey" PRIMARY KEY (id_);


--
-- Name: flw_event_definition FLW_EVENT_DEFINITION_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.flw_event_definition
    ADD CONSTRAINT "FLW_EVENT_DEFINITION_pkey" PRIMARY KEY (id_);


--
-- Name: flw_event_deployment FLW_EVENT_DEPLOYMENT_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.flw_event_deployment
    ADD CONSTRAINT "FLW_EVENT_DEPLOYMENT_pkey" PRIMARY KEY (id_);


--
-- Name: flw_event_resource FLW_EVENT_RESOURCE_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.flw_event_resource
    ADD CONSTRAINT "FLW_EVENT_RESOURCE_pkey" PRIMARY KEY (id_);


--
-- Name: act_app_databasechangeloglock act_app_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_app_databasechangeloglock
    ADD CONSTRAINT act_app_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: act_cmmn_databasechangeloglock act_cmmn_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_databasechangeloglock
    ADD CONSTRAINT act_cmmn_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: act_co_databasechangeloglock act_co_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_co_databasechangeloglock
    ADD CONSTRAINT act_co_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: act_dmn_databasechangeloglock act_dmn_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_dmn_databasechangeloglock
    ADD CONSTRAINT act_dmn_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: act_evt_log act_evt_log_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_evt_log
    ADD CONSTRAINT act_evt_log_pkey PRIMARY KEY (log_nr_);


--
-- Name: act_fo_databasechangeloglock act_fo_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_fo_databasechangeloglock
    ADD CONSTRAINT act_fo_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: act_ge_bytearray act_ge_bytearray_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ge_bytearray
    ADD CONSTRAINT act_ge_bytearray_pkey PRIMARY KEY (id_);


--
-- Name: act_ge_property act_ge_property_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ge_property
    ADD CONSTRAINT act_ge_property_pkey PRIMARY KEY (name_);


--
-- Name: act_hi_actinst act_hi_actinst_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_hi_actinst
    ADD CONSTRAINT act_hi_actinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_attachment act_hi_attachment_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_hi_attachment
    ADD CONSTRAINT act_hi_attachment_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_comment act_hi_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_hi_comment
    ADD CONSTRAINT act_hi_comment_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_detail act_hi_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_hi_detail
    ADD CONSTRAINT act_hi_detail_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_entitylink act_hi_entitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_hi_entitylink
    ADD CONSTRAINT act_hi_entitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_identitylink act_hi_identitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_hi_identitylink
    ADD CONSTRAINT act_hi_identitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_procinst act_hi_procinst_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_hi_procinst
    ADD CONSTRAINT act_hi_procinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_procinst act_hi_procinst_proc_inst_id__key; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_hi_procinst
    ADD CONSTRAINT act_hi_procinst_proc_inst_id__key UNIQUE (proc_inst_id_);


--
-- Name: act_hi_taskinst act_hi_taskinst_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_hi_taskinst
    ADD CONSTRAINT act_hi_taskinst_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_tsk_log act_hi_tsk_log_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_hi_tsk_log
    ADD CONSTRAINT act_hi_tsk_log_pkey PRIMARY KEY (id_);


--
-- Name: act_hi_varinst act_hi_varinst_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_hi_varinst
    ADD CONSTRAINT act_hi_varinst_pkey PRIMARY KEY (id_);


--
-- Name: act_id_bytearray act_id_bytearray_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_id_bytearray
    ADD CONSTRAINT act_id_bytearray_pkey PRIMARY KEY (id_);


--
-- Name: act_id_group act_id_group_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_id_group
    ADD CONSTRAINT act_id_group_pkey PRIMARY KEY (id_);


--
-- Name: act_id_info act_id_info_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_id_info
    ADD CONSTRAINT act_id_info_pkey PRIMARY KEY (id_);


--
-- Name: act_id_membership act_id_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_id_membership
    ADD CONSTRAINT act_id_membership_pkey PRIMARY KEY (user_id_, group_id_);


--
-- Name: act_id_priv_mapping act_id_priv_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_id_priv_mapping
    ADD CONSTRAINT act_id_priv_mapping_pkey PRIMARY KEY (id_);


--
-- Name: act_id_priv act_id_priv_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_id_priv
    ADD CONSTRAINT act_id_priv_pkey PRIMARY KEY (id_);


--
-- Name: act_id_property act_id_property_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_id_property
    ADD CONSTRAINT act_id_property_pkey PRIMARY KEY (name_);


--
-- Name: act_id_token act_id_token_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_id_token
    ADD CONSTRAINT act_id_token_pkey PRIMARY KEY (id_);


--
-- Name: act_id_user act_id_user_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_id_user
    ADD CONSTRAINT act_id_user_pkey PRIMARY KEY (id_);


--
-- Name: act_procdef_info act_procdef_info_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_procdef_info
    ADD CONSTRAINT act_procdef_info_pkey PRIMARY KEY (id_);


--
-- Name: act_re_deployment act_re_deployment_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_re_deployment
    ADD CONSTRAINT act_re_deployment_pkey PRIMARY KEY (id_);


--
-- Name: act_re_model act_re_model_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_re_model
    ADD CONSTRAINT act_re_model_pkey PRIMARY KEY (id_);


--
-- Name: act_re_procdef act_re_procdef_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_re_procdef
    ADD CONSTRAINT act_re_procdef_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_actinst act_ru_actinst_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_actinst
    ADD CONSTRAINT act_ru_actinst_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_deadletter_job act_ru_deadletter_job_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_deadletter_job
    ADD CONSTRAINT act_ru_deadletter_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_entitylink act_ru_entitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_entitylink
    ADD CONSTRAINT act_ru_entitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_event_subscr act_ru_event_subscr_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_event_subscr
    ADD CONSTRAINT act_ru_event_subscr_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_execution act_ru_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_execution
    ADD CONSTRAINT act_ru_execution_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_external_job act_ru_external_job_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_external_job
    ADD CONSTRAINT act_ru_external_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_history_job act_ru_history_job_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_history_job
    ADD CONSTRAINT act_ru_history_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_identitylink act_ru_identitylink_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_identitylink
    ADD CONSTRAINT act_ru_identitylink_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_job act_ru_job_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_job
    ADD CONSTRAINT act_ru_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_suspended_job act_ru_suspended_job_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_suspended_job
    ADD CONSTRAINT act_ru_suspended_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_task act_ru_task_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_task
    ADD CONSTRAINT act_ru_task_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_timer_job act_ru_timer_job_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_timer_job
    ADD CONSTRAINT act_ru_timer_job_pkey PRIMARY KEY (id_);


--
-- Name: act_ru_variable act_ru_variable_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_variable
    ADD CONSTRAINT act_ru_variable_pkey PRIMARY KEY (id_);


--
-- Name: act_procdef_info act_uniq_info_procdef; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_procdef_info
    ADD CONSTRAINT act_uniq_info_procdef UNIQUE (proc_def_id_);


--
-- Name: act_id_priv act_uniq_priv_name; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_id_priv
    ADD CONSTRAINT act_uniq_priv_name UNIQUE (name_);


--
-- Name: act_re_procdef act_uniq_procdef; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_re_procdef
    ADD CONSTRAINT act_uniq_procdef UNIQUE (key_, version_, derived_version_, tenant_id_);


--
-- Name: flw_ev_databasechangeloglock flw_ev_databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.flw_ev_databasechangeloglock
    ADD CONSTRAINT flw_ev_databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: flw_ru_batch_part flw_ru_batch_part_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.flw_ru_batch_part
    ADD CONSTRAINT flw_ru_batch_part_pkey PRIMARY KEY (id_);


--
-- Name: flw_ru_batch flw_ru_batch_pkey; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.flw_ru_batch
    ADD CONSTRAINT flw_ru_batch_pkey PRIMARY KEY (id_);


--
-- Name: act_app_deployment_resource pk_app_deployment_resource; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_app_deployment_resource
    ADD CONSTRAINT pk_app_deployment_resource PRIMARY KEY (id_);


--
-- Name: act_cmmn_deployment_resource pk_cmmn_deployment_resource; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_deployment_resource
    ADD CONSTRAINT pk_cmmn_deployment_resource PRIMARY KEY (id_);


--
-- Name: act_cmmn_ru_plan_item_inst pk_cmmn_plan_item_inst; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_ru_plan_item_inst
    ADD CONSTRAINT pk_cmmn_plan_item_inst PRIMARY KEY (id_);


--
-- Name: act_cmmn_ru_sentry_part_inst pk_cmmn_sentry_part_inst; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_ru_sentry_part_inst
    ADD CONSTRAINT pk_cmmn_sentry_part_inst PRIMARY KEY (id_);


--
-- Name: sys_dict sys_dict_pk; Type: CONSTRAINT; Schema: system; Owner: pineapple
--

ALTER TABLE ONLY system.sys_dict
    ADD CONSTRAINT sys_dict_pk PRIMARY KEY (id);


--
-- Name: CONSTRAINT sys_dict_pk ON sys_dict; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT sys_dict_pk ON system.sys_dict IS '系统数据字典表主键';


--
-- Name: sys_menu sys_menu_pk; Type: CONSTRAINT; Schema: system; Owner: pineapple
--

ALTER TABLE ONLY system.sys_menu
    ADD CONSTRAINT sys_menu_pk PRIMARY KEY (id);


--
-- Name: CONSTRAINT sys_menu_pk ON sys_menu; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT sys_menu_pk ON system.sys_menu IS '系统菜单表主键';


--
-- Name: sys_param sys_param_pk; Type: CONSTRAINT; Schema: system; Owner: pineapple
--

ALTER TABLE ONLY system.sys_param
    ADD CONSTRAINT sys_param_pk PRIMARY KEY (id);


--
-- Name: CONSTRAINT sys_param_pk ON sys_param; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT sys_param_pk ON system.sys_param IS '系统参数信息表主键';


--
-- Name: sys_role_menu sys_role_menu_pk; Type: CONSTRAINT; Schema: system; Owner: pineapple
--

ALTER TABLE ONLY system.sys_role_menu
    ADD CONSTRAINT sys_role_menu_pk PRIMARY KEY (menu_id, role_id);


--
-- Name: CONSTRAINT sys_role_menu_pk ON sys_role_menu; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT sys_role_menu_pk ON system.sys_role_menu IS '系统角色菜单关系映射表主键';


--
-- Name: sys_role sys_role_pk; Type: CONSTRAINT; Schema: system; Owner: pineapple
--

ALTER TABLE ONLY system.sys_role
    ADD CONSTRAINT sys_role_pk PRIMARY KEY (id);


--
-- Name: CONSTRAINT sys_role_pk ON sys_role; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT sys_role_pk ON system.sys_role IS '系统角色表主键';


--
-- Name: sys_user sys_user_pk; Type: CONSTRAINT; Schema: system; Owner: pineapple
--

ALTER TABLE ONLY system.sys_user
    ADD CONSTRAINT sys_user_pk PRIMARY KEY (id);


--
-- Name: CONSTRAINT sys_user_pk ON sys_user; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT sys_user_pk ON system.sys_user IS '系统用户信息表主键';


--
-- Name: sys_user_role sys_user_role_pk; Type: CONSTRAINT; Schema: system; Owner: pineapple
--

ALTER TABLE ONLY system.sys_user_role
    ADD CONSTRAINT sys_user_role_pk PRIMARY KEY (user_id, role_id);


--
-- Name: CONSTRAINT sys_user_role_pk ON sys_user_role; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT sys_user_role_pk ON system.sys_user_role IS '系统用户角色关系映射表主键';


--
-- Name: act_idx_athrz_procedef; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_athrz_procedef ON flow.act_ru_identitylink USING btree (proc_def_id_);


--
-- Name: act_idx_bytear_depl; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_bytear_depl ON flow.act_ge_bytearray USING btree (deployment_id_);


--
-- Name: act_idx_channel_def_uniq; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE UNIQUE INDEX act_idx_channel_def_uniq ON flow.flw_channel_definition USING btree (key_, version_, tenant_id_);


--
-- Name: act_idx_deadletter_job_correlation_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_deadletter_job_correlation_id ON flow.act_ru_deadletter_job USING btree (correlation_id_);


--
-- Name: act_idx_deadletter_job_custom_values_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_deadletter_job_custom_values_id ON flow.act_ru_deadletter_job USING btree (custom_values_id_);


--
-- Name: act_idx_deadletter_job_exception_stack_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_deadletter_job_exception_stack_id ON flow.act_ru_deadletter_job USING btree (exception_stack_id_);


--
-- Name: act_idx_deadletter_job_execution_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_deadletter_job_execution_id ON flow.act_ru_deadletter_job USING btree (execution_id_);


--
-- Name: act_idx_deadletter_job_proc_def_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_deadletter_job_proc_def_id ON flow.act_ru_deadletter_job USING btree (proc_def_id_);


--
-- Name: act_idx_deadletter_job_process_instance_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_deadletter_job_process_instance_id ON flow.act_ru_deadletter_job USING btree (process_instance_id_);


--
-- Name: act_idx_djob_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_djob_scope ON flow.act_ru_deadletter_job USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_djob_scope_def; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_djob_scope_def ON flow.act_ru_deadletter_job USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_djob_sub_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_djob_sub_scope ON flow.act_ru_deadletter_job USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_ejob_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ejob_scope ON flow.act_ru_external_job USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_ejob_scope_def; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ejob_scope_def ON flow.act_ru_external_job USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_ejob_sub_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ejob_sub_scope ON flow.act_ru_external_job USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_ent_lnk_root_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ent_lnk_root_scope ON flow.act_ru_entitylink USING btree (root_scope_id_, root_scope_type_, link_type_);


--
-- Name: act_idx_ent_lnk_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ent_lnk_scope ON flow.act_ru_entitylink USING btree (scope_id_, scope_type_, link_type_);


--
-- Name: act_idx_ent_lnk_scope_def; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ent_lnk_scope_def ON flow.act_ru_entitylink USING btree (scope_definition_id_, scope_type_, link_type_);


--
-- Name: act_idx_event_def_uniq; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE UNIQUE INDEX act_idx_event_def_uniq ON flow.flw_event_definition USING btree (key_, version_, tenant_id_);


--
-- Name: act_idx_event_subscr; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_event_subscr ON flow.act_ru_event_subscr USING btree (execution_id_);


--
-- Name: act_idx_event_subscr_config_; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_event_subscr_config_ ON flow.act_ru_event_subscr USING btree (configuration_);


--
-- Name: act_idx_exe_parent; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_exe_parent ON flow.act_ru_execution USING btree (parent_id_);


--
-- Name: act_idx_exe_procdef; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_exe_procdef ON flow.act_ru_execution USING btree (proc_def_id_);


--
-- Name: act_idx_exe_procinst; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_exe_procinst ON flow.act_ru_execution USING btree (proc_inst_id_);


--
-- Name: act_idx_exe_root; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_exe_root ON flow.act_ru_execution USING btree (root_proc_inst_id_);


--
-- Name: act_idx_exe_super; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_exe_super ON flow.act_ru_execution USING btree (super_exec_);


--
-- Name: act_idx_exec_buskey; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_exec_buskey ON flow.act_ru_execution USING btree (business_key_);


--
-- Name: act_idx_external_job_correlation_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_external_job_correlation_id ON flow.act_ru_external_job USING btree (correlation_id_);


--
-- Name: act_idx_external_job_custom_values_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_external_job_custom_values_id ON flow.act_ru_external_job USING btree (custom_values_id_);


--
-- Name: act_idx_external_job_exception_stack_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_external_job_exception_stack_id ON flow.act_ru_external_job USING btree (exception_stack_id_);


--
-- Name: act_idx_hi_act_inst_end; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_act_inst_end ON flow.act_hi_actinst USING btree (end_time_);


--
-- Name: act_idx_hi_act_inst_exec; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_act_inst_exec ON flow.act_hi_actinst USING btree (execution_id_, act_id_);


--
-- Name: act_idx_hi_act_inst_procinst; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_act_inst_procinst ON flow.act_hi_actinst USING btree (proc_inst_id_, act_id_);


--
-- Name: act_idx_hi_act_inst_start; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_act_inst_start ON flow.act_hi_actinst USING btree (start_time_);


--
-- Name: act_idx_hi_detail_act_inst; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_detail_act_inst ON flow.act_hi_detail USING btree (act_inst_id_);


--
-- Name: act_idx_hi_detail_name; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_detail_name ON flow.act_hi_detail USING btree (name_);


--
-- Name: act_idx_hi_detail_proc_inst; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_detail_proc_inst ON flow.act_hi_detail USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_detail_task_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_detail_task_id ON flow.act_hi_detail USING btree (task_id_);


--
-- Name: act_idx_hi_detail_time; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_detail_time ON flow.act_hi_detail USING btree (time_);


--
-- Name: act_idx_hi_ent_lnk_root_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_ent_lnk_root_scope ON flow.act_hi_entitylink USING btree (root_scope_id_, root_scope_type_, link_type_);


--
-- Name: act_idx_hi_ent_lnk_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_ent_lnk_scope ON flow.act_hi_entitylink USING btree (scope_id_, scope_type_, link_type_);


--
-- Name: act_idx_hi_ent_lnk_scope_def; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_ent_lnk_scope_def ON flow.act_hi_entitylink USING btree (scope_definition_id_, scope_type_, link_type_);


--
-- Name: act_idx_hi_ident_lnk_procinst; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_ident_lnk_procinst ON flow.act_hi_identitylink USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_ident_lnk_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_ident_lnk_scope ON flow.act_hi_identitylink USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_hi_ident_lnk_scope_def; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_ident_lnk_scope_def ON flow.act_hi_identitylink USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_hi_ident_lnk_sub_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_ident_lnk_sub_scope ON flow.act_hi_identitylink USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_hi_ident_lnk_task; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_ident_lnk_task ON flow.act_hi_identitylink USING btree (task_id_);


--
-- Name: act_idx_hi_ident_lnk_user; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_ident_lnk_user ON flow.act_hi_identitylink USING btree (user_id_);


--
-- Name: act_idx_hi_pro_i_buskey; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_pro_i_buskey ON flow.act_hi_procinst USING btree (business_key_);


--
-- Name: act_idx_hi_pro_inst_end; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_pro_inst_end ON flow.act_hi_procinst USING btree (end_time_);


--
-- Name: act_idx_hi_procvar_exe; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_procvar_exe ON flow.act_hi_varinst USING btree (execution_id_);


--
-- Name: act_idx_hi_procvar_name_type; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_procvar_name_type ON flow.act_hi_varinst USING btree (name_, var_type_);


--
-- Name: act_idx_hi_procvar_proc_inst; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_procvar_proc_inst ON flow.act_hi_varinst USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_procvar_task_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_procvar_task_id ON flow.act_hi_varinst USING btree (task_id_);


--
-- Name: act_idx_hi_task_inst_procinst; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_task_inst_procinst ON flow.act_hi_taskinst USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_task_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_task_scope ON flow.act_hi_taskinst USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_hi_task_scope_def; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_task_scope_def ON flow.act_hi_taskinst USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_hi_task_sub_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_task_sub_scope ON flow.act_hi_taskinst USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_hi_var_scope_id_type; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_var_scope_id_type ON flow.act_hi_varinst USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_hi_var_sub_id_type; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_hi_var_sub_id_type ON flow.act_hi_varinst USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_ident_lnk_group; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ident_lnk_group ON flow.act_ru_identitylink USING btree (group_id_);


--
-- Name: act_idx_ident_lnk_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ident_lnk_scope ON flow.act_ru_identitylink USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_ident_lnk_scope_def; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ident_lnk_scope_def ON flow.act_ru_identitylink USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_ident_lnk_sub_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ident_lnk_sub_scope ON flow.act_ru_identitylink USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_ident_lnk_user; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ident_lnk_user ON flow.act_ru_identitylink USING btree (user_id_);


--
-- Name: act_idx_idl_procinst; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_idl_procinst ON flow.act_ru_identitylink USING btree (proc_inst_id_);


--
-- Name: act_idx_job_correlation_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_job_correlation_id ON flow.act_ru_job USING btree (correlation_id_);


--
-- Name: act_idx_job_custom_values_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_job_custom_values_id ON flow.act_ru_job USING btree (custom_values_id_);


--
-- Name: act_idx_job_exception_stack_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_job_exception_stack_id ON flow.act_ru_job USING btree (exception_stack_id_);


--
-- Name: act_idx_job_execution_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_job_execution_id ON flow.act_ru_job USING btree (execution_id_);


--
-- Name: act_idx_job_proc_def_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_job_proc_def_id ON flow.act_ru_job USING btree (proc_def_id_);


--
-- Name: act_idx_job_process_instance_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_job_process_instance_id ON flow.act_ru_job USING btree (process_instance_id_);


--
-- Name: act_idx_job_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_job_scope ON flow.act_ru_job USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_job_scope_def; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_job_scope_def ON flow.act_ru_job USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_job_sub_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_job_sub_scope ON flow.act_ru_job USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_memb_group; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_memb_group ON flow.act_id_membership USING btree (group_id_);


--
-- Name: act_idx_memb_user; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_memb_user ON flow.act_id_membership USING btree (user_id_);


--
-- Name: act_idx_model_deployment; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_model_deployment ON flow.act_re_model USING btree (deployment_id_);


--
-- Name: act_idx_model_source; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_model_source ON flow.act_re_model USING btree (editor_source_value_id_);


--
-- Name: act_idx_model_source_extra; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_model_source_extra ON flow.act_re_model USING btree (editor_source_extra_value_id_);


--
-- Name: act_idx_priv_group; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_priv_group ON flow.act_id_priv_mapping USING btree (group_id_);


--
-- Name: act_idx_priv_mapping; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_priv_mapping ON flow.act_id_priv_mapping USING btree (priv_id_);


--
-- Name: act_idx_priv_user; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_priv_user ON flow.act_id_priv_mapping USING btree (user_id_);


--
-- Name: act_idx_procdef_info_json; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_procdef_info_json ON flow.act_procdef_info USING btree (info_json_id_);


--
-- Name: act_idx_procdef_info_proc; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_procdef_info_proc ON flow.act_procdef_info USING btree (proc_def_id_);


--
-- Name: act_idx_ru_acti_end; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ru_acti_end ON flow.act_ru_actinst USING btree (end_time_);


--
-- Name: act_idx_ru_acti_exec; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ru_acti_exec ON flow.act_ru_actinst USING btree (execution_id_);


--
-- Name: act_idx_ru_acti_exec_act; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ru_acti_exec_act ON flow.act_ru_actinst USING btree (execution_id_, act_id_);


--
-- Name: act_idx_ru_acti_proc; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ru_acti_proc ON flow.act_ru_actinst USING btree (proc_inst_id_);


--
-- Name: act_idx_ru_acti_proc_act; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ru_acti_proc_act ON flow.act_ru_actinst USING btree (proc_inst_id_, act_id_);


--
-- Name: act_idx_ru_acti_start; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ru_acti_start ON flow.act_ru_actinst USING btree (start_time_);


--
-- Name: act_idx_ru_var_scope_id_type; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ru_var_scope_id_type ON flow.act_ru_variable USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_ru_var_sub_id_type; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_ru_var_sub_id_type ON flow.act_ru_variable USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_sjob_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_sjob_scope ON flow.act_ru_suspended_job USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_sjob_scope_def; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_sjob_scope_def ON flow.act_ru_suspended_job USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_sjob_sub_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_sjob_sub_scope ON flow.act_ru_suspended_job USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_suspended_job_correlation_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_suspended_job_correlation_id ON flow.act_ru_suspended_job USING btree (correlation_id_);


--
-- Name: act_idx_suspended_job_custom_values_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_suspended_job_custom_values_id ON flow.act_ru_suspended_job USING btree (custom_values_id_);


--
-- Name: act_idx_suspended_job_exception_stack_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_suspended_job_exception_stack_id ON flow.act_ru_suspended_job USING btree (exception_stack_id_);


--
-- Name: act_idx_suspended_job_execution_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_suspended_job_execution_id ON flow.act_ru_suspended_job USING btree (execution_id_);


--
-- Name: act_idx_suspended_job_proc_def_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_suspended_job_proc_def_id ON flow.act_ru_suspended_job USING btree (proc_def_id_);


--
-- Name: act_idx_suspended_job_process_instance_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_suspended_job_process_instance_id ON flow.act_ru_suspended_job USING btree (process_instance_id_);


--
-- Name: act_idx_task_create; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_task_create ON flow.act_ru_task USING btree (create_time_);


--
-- Name: act_idx_task_exec; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_task_exec ON flow.act_ru_task USING btree (execution_id_);


--
-- Name: act_idx_task_procdef; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_task_procdef ON flow.act_ru_task USING btree (proc_def_id_);


--
-- Name: act_idx_task_procinst; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_task_procinst ON flow.act_ru_task USING btree (proc_inst_id_);


--
-- Name: act_idx_task_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_task_scope ON flow.act_ru_task USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_task_scope_def; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_task_scope_def ON flow.act_ru_task USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_task_sub_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_task_sub_scope ON flow.act_ru_task USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_timer_job_correlation_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_timer_job_correlation_id ON flow.act_ru_timer_job USING btree (correlation_id_);


--
-- Name: act_idx_timer_job_custom_values_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_timer_job_custom_values_id ON flow.act_ru_timer_job USING btree (custom_values_id_);


--
-- Name: act_idx_timer_job_exception_stack_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_timer_job_exception_stack_id ON flow.act_ru_timer_job USING btree (exception_stack_id_);


--
-- Name: act_idx_timer_job_execution_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_timer_job_execution_id ON flow.act_ru_timer_job USING btree (execution_id_);


--
-- Name: act_idx_timer_job_proc_def_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_timer_job_proc_def_id ON flow.act_ru_timer_job USING btree (proc_def_id_);


--
-- Name: act_idx_timer_job_process_instance_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_timer_job_process_instance_id ON flow.act_ru_timer_job USING btree (process_instance_id_);


--
-- Name: act_idx_tjob_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_tjob_scope ON flow.act_ru_timer_job USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_tjob_scope_def; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_tjob_scope_def ON flow.act_ru_timer_job USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_tjob_sub_scope; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_tjob_sub_scope ON flow.act_ru_timer_job USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_tskass_task; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_tskass_task ON flow.act_ru_identitylink USING btree (task_id_);


--
-- Name: act_idx_var_bytearray; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_var_bytearray ON flow.act_ru_variable USING btree (bytearray_id_);


--
-- Name: act_idx_var_exe; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_var_exe ON flow.act_ru_variable USING btree (execution_id_);


--
-- Name: act_idx_var_procinst; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_var_procinst ON flow.act_ru_variable USING btree (proc_inst_id_);


--
-- Name: act_idx_variable_task_id; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX act_idx_variable_task_id ON flow.act_ru_variable USING btree (task_id_);


--
-- Name: flw_idx_batch_part; Type: INDEX; Schema: flow; Owner: pineapple
--

CREATE INDEX flw_idx_batch_part ON flow.flw_ru_batch_part USING btree (batch_id_);


--
-- Name: idx_did; Type: INDEX; Schema: nacos; Owner: pineapple
--

CREATE INDEX idx_did ON nacos.his_config_info USING btree (data_id);


--
-- Name: idx_gmt_create; Type: INDEX; Schema: nacos; Owner: pineapple
--

CREATE INDEX idx_gmt_create ON nacos.his_config_info USING btree (gmt_create);


--
-- Name: idx_gmt_modified; Type: INDEX; Schema: nacos; Owner: pineapple
--

CREATE INDEX idx_gmt_modified ON nacos.his_config_info USING btree (gmt_modified);


--
-- Name: idx_tenant_id; Type: INDEX; Schema: nacos; Owner: pineapple
--

CREATE INDEX idx_tenant_id ON nacos.config_tags_relation USING btree (tenant_id);


--
-- Name: idx_tenant_info_tenant_id; Type: INDEX; Schema: nacos; Owner: pineapple
--

CREATE INDEX idx_tenant_info_tenant_id ON nacos.tenant_info USING btree (tenant_id);


--
-- Name: idx_user_role; Type: INDEX; Schema: nacos; Owner: pineapple
--

CREATE INDEX idx_user_role ON nacos.roles USING btree (username, role);


--
-- Name: uk_role_permission; Type: INDEX; Schema: nacos; Owner: pineapple
--

CREATE INDEX uk_role_permission ON nacos.permissions USING btree (role, resource, action);


--
-- Name: act_idx_app_def_dply; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_app_def_dply ON public.act_app_appdef USING btree (deployment_id_);


--
-- Name: act_idx_app_def_uniq; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE UNIQUE INDEX act_idx_app_def_uniq ON public.act_app_appdef USING btree (key_, version_, tenant_id_);


--
-- Name: act_idx_app_rsrc_dpl; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_app_rsrc_dpl ON public.act_app_deployment_resource USING btree (deployment_id_);


--
-- Name: act_idx_athrz_procedef; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_athrz_procedef ON public.act_ru_identitylink USING btree (proc_def_id_);


--
-- Name: act_idx_bytear_depl; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_bytear_depl ON public.act_ge_bytearray USING btree (deployment_id_);


--
-- Name: act_idx_case_def_dply; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_case_def_dply ON public.act_cmmn_casedef USING btree (deployment_id_);


--
-- Name: act_idx_case_def_uniq; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE UNIQUE INDEX act_idx_case_def_uniq ON public.act_cmmn_casedef USING btree (key_, version_, tenant_id_);


--
-- Name: act_idx_case_inst_case_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_case_inst_case_def ON public.act_cmmn_ru_case_inst USING btree (case_def_id_);


--
-- Name: act_idx_case_inst_parent; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_case_inst_parent ON public.act_cmmn_ru_case_inst USING btree (parent_id_);


--
-- Name: act_idx_case_inst_ref_id_; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_case_inst_ref_id_ ON public.act_cmmn_ru_case_inst USING btree (reference_id_);


--
-- Name: act_idx_channel_def_uniq; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE UNIQUE INDEX act_idx_channel_def_uniq ON public.flw_channel_definition USING btree (key_, version_, tenant_id_);


--
-- Name: act_idx_cmmn_rsrc_dpl; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_cmmn_rsrc_dpl ON public.act_cmmn_deployment_resource USING btree (deployment_id_);


--
-- Name: act_idx_deadletter_job_correlation_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_deadletter_job_correlation_id ON public.act_ru_deadletter_job USING btree (correlation_id_);


--
-- Name: act_idx_deadletter_job_custom_values_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_deadletter_job_custom_values_id ON public.act_ru_deadletter_job USING btree (custom_values_id_);


--
-- Name: act_idx_deadletter_job_exception_stack_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_deadletter_job_exception_stack_id ON public.act_ru_deadletter_job USING btree (exception_stack_id_);


--
-- Name: act_idx_deadletter_job_execution_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_deadletter_job_execution_id ON public.act_ru_deadletter_job USING btree (execution_id_);


--
-- Name: act_idx_deadletter_job_proc_def_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_deadletter_job_proc_def_id ON public.act_ru_deadletter_job USING btree (proc_def_id_);


--
-- Name: act_idx_deadletter_job_process_instance_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_deadletter_job_process_instance_id ON public.act_ru_deadletter_job USING btree (process_instance_id_);


--
-- Name: act_idx_djob_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_djob_scope ON public.act_ru_deadletter_job USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_djob_scope_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_djob_scope_def ON public.act_ru_deadletter_job USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_djob_sub_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_djob_sub_scope ON public.act_ru_deadletter_job USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_dmn_dec_uniq; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE UNIQUE INDEX act_idx_dmn_dec_uniq ON public.act_dmn_decision USING btree (key_, version_, tenant_id_);


--
-- Name: act_idx_ejob_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ejob_scope ON public.act_ru_external_job USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_ejob_scope_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ejob_scope_def ON public.act_ru_external_job USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_ejob_sub_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ejob_sub_scope ON public.act_ru_external_job USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_ent_lnk_root_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ent_lnk_root_scope ON public.act_ru_entitylink USING btree (root_scope_id_, root_scope_type_, link_type_);


--
-- Name: act_idx_ent_lnk_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ent_lnk_scope ON public.act_ru_entitylink USING btree (scope_id_, scope_type_, link_type_);


--
-- Name: act_idx_ent_lnk_scope_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ent_lnk_scope_def ON public.act_ru_entitylink USING btree (scope_definition_id_, scope_type_, link_type_);


--
-- Name: act_idx_event_def_uniq; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE UNIQUE INDEX act_idx_event_def_uniq ON public.flw_event_definition USING btree (key_, version_, tenant_id_);


--
-- Name: act_idx_event_subscr; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_event_subscr ON public.act_ru_event_subscr USING btree (execution_id_);


--
-- Name: act_idx_event_subscr_config_; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_event_subscr_config_ ON public.act_ru_event_subscr USING btree (configuration_);


--
-- Name: act_idx_exe_parent; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_exe_parent ON public.act_ru_execution USING btree (parent_id_);


--
-- Name: act_idx_exe_procdef; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_exe_procdef ON public.act_ru_execution USING btree (proc_def_id_);


--
-- Name: act_idx_exe_procinst; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_exe_procinst ON public.act_ru_execution USING btree (proc_inst_id_);


--
-- Name: act_idx_exe_root; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_exe_root ON public.act_ru_execution USING btree (root_proc_inst_id_);


--
-- Name: act_idx_exe_super; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_exe_super ON public.act_ru_execution USING btree (super_exec_);


--
-- Name: act_idx_exec_buskey; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_exec_buskey ON public.act_ru_execution USING btree (business_key_);


--
-- Name: act_idx_external_job_correlation_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_external_job_correlation_id ON public.act_ru_external_job USING btree (correlation_id_);


--
-- Name: act_idx_external_job_custom_values_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_external_job_custom_values_id ON public.act_ru_external_job USING btree (custom_values_id_);


--
-- Name: act_idx_external_job_exception_stack_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_external_job_exception_stack_id ON public.act_ru_external_job USING btree (exception_stack_id_);


--
-- Name: act_idx_form_def_uniq; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE UNIQUE INDEX act_idx_form_def_uniq ON public.act_fo_form_definition USING btree (key_, version_, tenant_id_);


--
-- Name: act_idx_hi_act_inst_end; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_act_inst_end ON public.act_hi_actinst USING btree (end_time_);


--
-- Name: act_idx_hi_act_inst_exec; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_act_inst_exec ON public.act_hi_actinst USING btree (execution_id_, act_id_);


--
-- Name: act_idx_hi_act_inst_procinst; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_act_inst_procinst ON public.act_hi_actinst USING btree (proc_inst_id_, act_id_);


--
-- Name: act_idx_hi_act_inst_start; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_act_inst_start ON public.act_hi_actinst USING btree (start_time_);


--
-- Name: act_idx_hi_detail_act_inst; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_detail_act_inst ON public.act_hi_detail USING btree (act_inst_id_);


--
-- Name: act_idx_hi_detail_name; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_detail_name ON public.act_hi_detail USING btree (name_);


--
-- Name: act_idx_hi_detail_proc_inst; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_detail_proc_inst ON public.act_hi_detail USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_detail_task_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_detail_task_id ON public.act_hi_detail USING btree (task_id_);


--
-- Name: act_idx_hi_detail_time; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_detail_time ON public.act_hi_detail USING btree (time_);


--
-- Name: act_idx_hi_ent_lnk_root_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_ent_lnk_root_scope ON public.act_hi_entitylink USING btree (root_scope_id_, root_scope_type_, link_type_);


--
-- Name: act_idx_hi_ent_lnk_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_ent_lnk_scope ON public.act_hi_entitylink USING btree (scope_id_, scope_type_, link_type_);


--
-- Name: act_idx_hi_ent_lnk_scope_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_ent_lnk_scope_def ON public.act_hi_entitylink USING btree (scope_definition_id_, scope_type_, link_type_);


--
-- Name: act_idx_hi_ident_lnk_procinst; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_ident_lnk_procinst ON public.act_hi_identitylink USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_ident_lnk_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_ident_lnk_scope ON public.act_hi_identitylink USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_hi_ident_lnk_scope_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_ident_lnk_scope_def ON public.act_hi_identitylink USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_hi_ident_lnk_sub_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_ident_lnk_sub_scope ON public.act_hi_identitylink USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_hi_ident_lnk_task; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_ident_lnk_task ON public.act_hi_identitylink USING btree (task_id_);


--
-- Name: act_idx_hi_ident_lnk_user; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_ident_lnk_user ON public.act_hi_identitylink USING btree (user_id_);


--
-- Name: act_idx_hi_pro_i_buskey; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_pro_i_buskey ON public.act_hi_procinst USING btree (business_key_);


--
-- Name: act_idx_hi_pro_inst_end; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_pro_inst_end ON public.act_hi_procinst USING btree (end_time_);


--
-- Name: act_idx_hi_procvar_exe; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_procvar_exe ON public.act_hi_varinst USING btree (execution_id_);


--
-- Name: act_idx_hi_procvar_name_type; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_procvar_name_type ON public.act_hi_varinst USING btree (name_, var_type_);


--
-- Name: act_idx_hi_procvar_proc_inst; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_procvar_proc_inst ON public.act_hi_varinst USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_procvar_task_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_procvar_task_id ON public.act_hi_varinst USING btree (task_id_);


--
-- Name: act_idx_hi_task_inst_procinst; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_task_inst_procinst ON public.act_hi_taskinst USING btree (proc_inst_id_);


--
-- Name: act_idx_hi_task_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_task_scope ON public.act_hi_taskinst USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_hi_task_scope_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_task_scope_def ON public.act_hi_taskinst USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_hi_task_sub_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_task_sub_scope ON public.act_hi_taskinst USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_hi_var_scope_id_type; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_var_scope_id_type ON public.act_hi_varinst USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_hi_var_sub_id_type; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_hi_var_sub_id_type ON public.act_hi_varinst USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_ident_lnk_group; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ident_lnk_group ON public.act_ru_identitylink USING btree (group_id_);


--
-- Name: act_idx_ident_lnk_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ident_lnk_scope ON public.act_ru_identitylink USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_ident_lnk_scope_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ident_lnk_scope_def ON public.act_ru_identitylink USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_ident_lnk_sub_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ident_lnk_sub_scope ON public.act_ru_identitylink USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_ident_lnk_user; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ident_lnk_user ON public.act_ru_identitylink USING btree (user_id_);


--
-- Name: act_idx_idl_procinst; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_idl_procinst ON public.act_ru_identitylink USING btree (proc_inst_id_);


--
-- Name: act_idx_job_correlation_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_job_correlation_id ON public.act_ru_job USING btree (correlation_id_);


--
-- Name: act_idx_job_custom_values_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_job_custom_values_id ON public.act_ru_job USING btree (custom_values_id_);


--
-- Name: act_idx_job_exception_stack_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_job_exception_stack_id ON public.act_ru_job USING btree (exception_stack_id_);


--
-- Name: act_idx_job_execution_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_job_execution_id ON public.act_ru_job USING btree (execution_id_);


--
-- Name: act_idx_job_proc_def_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_job_proc_def_id ON public.act_ru_job USING btree (proc_def_id_);


--
-- Name: act_idx_job_process_instance_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_job_process_instance_id ON public.act_ru_job USING btree (process_instance_id_);


--
-- Name: act_idx_job_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_job_scope ON public.act_ru_job USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_job_scope_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_job_scope_def ON public.act_ru_job USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_job_sub_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_job_sub_scope ON public.act_ru_job USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_memb_group; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_memb_group ON public.act_id_membership USING btree (group_id_);


--
-- Name: act_idx_memb_user; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_memb_user ON public.act_id_membership USING btree (user_id_);


--
-- Name: act_idx_mil_case_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_mil_case_def ON public.act_cmmn_ru_mil_inst USING btree (case_def_id_);


--
-- Name: act_idx_mil_case_inst; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_mil_case_inst ON public.act_cmmn_ru_mil_inst USING btree (case_inst_id_);


--
-- Name: act_idx_model_deployment; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_model_deployment ON public.act_re_model USING btree (deployment_id_);


--
-- Name: act_idx_model_source; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_model_source ON public.act_re_model USING btree (editor_source_value_id_);


--
-- Name: act_idx_model_source_extra; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_model_source_extra ON public.act_re_model USING btree (editor_source_extra_value_id_);


--
-- Name: act_idx_plan_item_case_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_plan_item_case_def ON public.act_cmmn_ru_plan_item_inst USING btree (case_def_id_);


--
-- Name: act_idx_plan_item_case_inst; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_plan_item_case_inst ON public.act_cmmn_ru_plan_item_inst USING btree (case_inst_id_);


--
-- Name: act_idx_plan_item_stage_inst; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_plan_item_stage_inst ON public.act_cmmn_ru_plan_item_inst USING btree (stage_inst_id_);


--
-- Name: act_idx_priv_group; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_priv_group ON public.act_id_priv_mapping USING btree (group_id_);


--
-- Name: act_idx_priv_mapping; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_priv_mapping ON public.act_id_priv_mapping USING btree (priv_id_);


--
-- Name: act_idx_priv_user; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_priv_user ON public.act_id_priv_mapping USING btree (user_id_);


--
-- Name: act_idx_procdef_info_json; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_procdef_info_json ON public.act_procdef_info USING btree (info_json_id_);


--
-- Name: act_idx_procdef_info_proc; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_procdef_info_proc ON public.act_procdef_info USING btree (proc_def_id_);


--
-- Name: act_idx_ru_acti_end; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ru_acti_end ON public.act_ru_actinst USING btree (end_time_);


--
-- Name: act_idx_ru_acti_exec; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ru_acti_exec ON public.act_ru_actinst USING btree (execution_id_);


--
-- Name: act_idx_ru_acti_exec_act; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ru_acti_exec_act ON public.act_ru_actinst USING btree (execution_id_, act_id_);


--
-- Name: act_idx_ru_acti_proc; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ru_acti_proc ON public.act_ru_actinst USING btree (proc_inst_id_);


--
-- Name: act_idx_ru_acti_proc_act; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ru_acti_proc_act ON public.act_ru_actinst USING btree (proc_inst_id_, act_id_);


--
-- Name: act_idx_ru_acti_start; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ru_acti_start ON public.act_ru_actinst USING btree (start_time_);


--
-- Name: act_idx_ru_var_scope_id_type; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ru_var_scope_id_type ON public.act_ru_variable USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_ru_var_sub_id_type; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_ru_var_sub_id_type ON public.act_ru_variable USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_sentry_case_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_sentry_case_def ON public.act_cmmn_ru_sentry_part_inst USING btree (case_def_id_);


--
-- Name: act_idx_sentry_case_inst; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_sentry_case_inst ON public.act_cmmn_ru_sentry_part_inst USING btree (case_inst_id_);


--
-- Name: act_idx_sentry_plan_item; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_sentry_plan_item ON public.act_cmmn_ru_sentry_part_inst USING btree (plan_item_inst_id_);


--
-- Name: act_idx_sjob_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_sjob_scope ON public.act_ru_suspended_job USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_sjob_scope_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_sjob_scope_def ON public.act_ru_suspended_job USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_sjob_sub_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_sjob_sub_scope ON public.act_ru_suspended_job USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_suspended_job_correlation_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_suspended_job_correlation_id ON public.act_ru_suspended_job USING btree (correlation_id_);


--
-- Name: act_idx_suspended_job_custom_values_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_suspended_job_custom_values_id ON public.act_ru_suspended_job USING btree (custom_values_id_);


--
-- Name: act_idx_suspended_job_exception_stack_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_suspended_job_exception_stack_id ON public.act_ru_suspended_job USING btree (exception_stack_id_);


--
-- Name: act_idx_suspended_job_execution_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_suspended_job_execution_id ON public.act_ru_suspended_job USING btree (execution_id_);


--
-- Name: act_idx_suspended_job_proc_def_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_suspended_job_proc_def_id ON public.act_ru_suspended_job USING btree (proc_def_id_);


--
-- Name: act_idx_suspended_job_process_instance_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_suspended_job_process_instance_id ON public.act_ru_suspended_job USING btree (process_instance_id_);


--
-- Name: act_idx_task_create; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_task_create ON public.act_ru_task USING btree (create_time_);


--
-- Name: act_idx_task_exec; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_task_exec ON public.act_ru_task USING btree (execution_id_);


--
-- Name: act_idx_task_procdef; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_task_procdef ON public.act_ru_task USING btree (proc_def_id_);


--
-- Name: act_idx_task_procinst; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_task_procinst ON public.act_ru_task USING btree (proc_inst_id_);


--
-- Name: act_idx_task_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_task_scope ON public.act_ru_task USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_task_scope_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_task_scope_def ON public.act_ru_task USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_task_sub_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_task_sub_scope ON public.act_ru_task USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_timer_job_correlation_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_timer_job_correlation_id ON public.act_ru_timer_job USING btree (correlation_id_);


--
-- Name: act_idx_timer_job_custom_values_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_timer_job_custom_values_id ON public.act_ru_timer_job USING btree (custom_values_id_);


--
-- Name: act_idx_timer_job_exception_stack_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_timer_job_exception_stack_id ON public.act_ru_timer_job USING btree (exception_stack_id_);


--
-- Name: act_idx_timer_job_execution_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_timer_job_execution_id ON public.act_ru_timer_job USING btree (execution_id_);


--
-- Name: act_idx_timer_job_proc_def_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_timer_job_proc_def_id ON public.act_ru_timer_job USING btree (proc_def_id_);


--
-- Name: act_idx_timer_job_process_instance_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_timer_job_process_instance_id ON public.act_ru_timer_job USING btree (process_instance_id_);


--
-- Name: act_idx_tjob_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_tjob_scope ON public.act_ru_timer_job USING btree (scope_id_, scope_type_);


--
-- Name: act_idx_tjob_scope_def; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_tjob_scope_def ON public.act_ru_timer_job USING btree (scope_definition_id_, scope_type_);


--
-- Name: act_idx_tjob_sub_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_tjob_sub_scope ON public.act_ru_timer_job USING btree (sub_scope_id_, scope_type_);


--
-- Name: act_idx_tskass_task; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_tskass_task ON public.act_ru_identitylink USING btree (task_id_);


--
-- Name: act_idx_var_bytearray; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_var_bytearray ON public.act_ru_variable USING btree (bytearray_id_);


--
-- Name: act_idx_var_exe; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_var_exe ON public.act_ru_variable USING btree (execution_id_);


--
-- Name: act_idx_var_procinst; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_var_procinst ON public.act_ru_variable USING btree (proc_inst_id_);


--
-- Name: act_idx_variable_task_id; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX act_idx_variable_task_id ON public.act_ru_variable USING btree (task_id_);


--
-- Name: flw_idx_batch_part; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX flw_idx_batch_part ON public.flw_ru_batch_part USING btree (batch_id_);


--
-- Name: idx_contitem_procid; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX idx_contitem_procid ON public.act_co_content_item USING btree (proc_inst_id_);


--
-- Name: idx_contitem_scope; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX idx_contitem_scope ON public.act_co_content_item USING btree (scope_id_, scope_type_);


--
-- Name: idx_contitem_taskid; Type: INDEX; Schema: public; Owner: pineapple
--

CREATE INDEX idx_contitem_taskid ON public.act_co_content_item USING btree (task_id_);


--
-- Name: sys_dict_type_code_dict_code_dict_sort_index; Type: INDEX; Schema: system; Owner: pineapple
--

CREATE INDEX sys_dict_type_code_dict_code_dict_sort_index ON system.sys_dict USING btree (type_code, dict_code, dict_sort);


--
-- Name: sys_dict_type_code_dict_code_uindex; Type: INDEX; Schema: system; Owner: pineapple
--

CREATE UNIQUE INDEX sys_dict_type_code_dict_code_uindex ON system.sys_dict USING btree (type_code, dict_code);


--
-- Name: INDEX sys_dict_type_code_dict_code_uindex; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON INDEX system.sys_dict_type_code_dict_code_uindex IS '数据字典表唯一索引(type_code,dict_code)';


--
-- Name: sys_menu_menu_code_uindex; Type: INDEX; Schema: system; Owner: pineapple
--

CREATE UNIQUE INDEX sys_menu_menu_code_uindex ON system.sys_menu USING btree (menu_code);


--
-- Name: sys_param_param_code_uindex; Type: INDEX; Schema: system; Owner: pineapple
--

CREATE UNIQUE INDEX sys_param_param_code_uindex ON system.sys_param USING btree (param_code);


--
-- Name: INDEX sys_param_param_code_uindex; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON INDEX system.sys_param_param_code_uindex IS '系统参数表唯一索引(param_code)';


--
-- Name: sys_role_role_code_uindex; Type: INDEX; Schema: system; Owner: pineapple
--

CREATE UNIQUE INDEX sys_role_role_code_uindex ON system.sys_role USING btree (role_code);


--
-- Name: sys_user_login_id_uindex; Type: INDEX; Schema: system; Owner: pineapple
--

CREATE UNIQUE INDEX sys_user_login_id_uindex ON system.sys_user USING btree (login_id);


--
-- Name: INDEX sys_user_login_id_uindex; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON INDEX system.sys_user_login_id_uindex IS '系统用户表唯一索引(login_id)';


--
-- Name: sys_user_login_id_user_status_user_type_sex_code_index; Type: INDEX; Schema: system; Owner: pineapple
--

CREATE INDEX sys_user_login_id_user_status_user_type_sex_code_index ON system.sys_user USING btree (login_id, user_status, user_type, sex_code);


--
-- Name: act_ru_identitylink act_fk_athrz_procedef; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_identitylink
    ADD CONSTRAINT act_fk_athrz_procedef FOREIGN KEY (proc_def_id_) REFERENCES flow.act_re_procdef(id_);


--
-- Name: act_ge_bytearray act_fk_bytearr_depl; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ge_bytearray
    ADD CONSTRAINT act_fk_bytearr_depl FOREIGN KEY (deployment_id_) REFERENCES flow.act_re_deployment(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_custom_values; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES flow.act_ge_bytearray(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_exception; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES flow.act_ge_bytearray(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_execution; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_execution FOREIGN KEY (execution_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_proc_def; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES flow.act_re_procdef(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_process_instance; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_ru_event_subscr act_fk_event_exec; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_event_subscr
    ADD CONSTRAINT act_fk_event_exec FOREIGN KEY (execution_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_ru_execution act_fk_exe_parent; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_execution
    ADD CONSTRAINT act_fk_exe_parent FOREIGN KEY (parent_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_ru_execution act_fk_exe_procdef; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_execution
    ADD CONSTRAINT act_fk_exe_procdef FOREIGN KEY (proc_def_id_) REFERENCES flow.act_re_procdef(id_);


--
-- Name: act_ru_execution act_fk_exe_procinst; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_execution
    ADD CONSTRAINT act_fk_exe_procinst FOREIGN KEY (proc_inst_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_ru_execution act_fk_exe_super; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_execution
    ADD CONSTRAINT act_fk_exe_super FOREIGN KEY (super_exec_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_ru_external_job act_fk_external_job_custom_values; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_external_job
    ADD CONSTRAINT act_fk_external_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES flow.act_ge_bytearray(id_);


--
-- Name: act_ru_external_job act_fk_external_job_exception; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_external_job
    ADD CONSTRAINT act_fk_external_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES flow.act_ge_bytearray(id_);


--
-- Name: act_ru_identitylink act_fk_idl_procinst; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_identitylink
    ADD CONSTRAINT act_fk_idl_procinst FOREIGN KEY (proc_inst_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_procdef_info act_fk_info_json_ba; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_procdef_info
    ADD CONSTRAINT act_fk_info_json_ba FOREIGN KEY (info_json_id_) REFERENCES flow.act_ge_bytearray(id_);


--
-- Name: act_procdef_info act_fk_info_procdef; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_procdef_info
    ADD CONSTRAINT act_fk_info_procdef FOREIGN KEY (proc_def_id_) REFERENCES flow.act_re_procdef(id_);


--
-- Name: act_ru_job act_fk_job_custom_values; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_job
    ADD CONSTRAINT act_fk_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES flow.act_ge_bytearray(id_);


--
-- Name: act_ru_job act_fk_job_exception; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_job
    ADD CONSTRAINT act_fk_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES flow.act_ge_bytearray(id_);


--
-- Name: act_ru_job act_fk_job_execution; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_job
    ADD CONSTRAINT act_fk_job_execution FOREIGN KEY (execution_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_ru_job act_fk_job_proc_def; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_job
    ADD CONSTRAINT act_fk_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES flow.act_re_procdef(id_);


--
-- Name: act_ru_job act_fk_job_process_instance; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_job
    ADD CONSTRAINT act_fk_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_id_membership act_fk_memb_group; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_id_membership
    ADD CONSTRAINT act_fk_memb_group FOREIGN KEY (group_id_) REFERENCES flow.act_id_group(id_);


--
-- Name: act_id_membership act_fk_memb_user; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_id_membership
    ADD CONSTRAINT act_fk_memb_user FOREIGN KEY (user_id_) REFERENCES flow.act_id_user(id_);


--
-- Name: act_re_model act_fk_model_deployment; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_re_model
    ADD CONSTRAINT act_fk_model_deployment FOREIGN KEY (deployment_id_) REFERENCES flow.act_re_deployment(id_);


--
-- Name: act_re_model act_fk_model_source; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_re_model
    ADD CONSTRAINT act_fk_model_source FOREIGN KEY (editor_source_value_id_) REFERENCES flow.act_ge_bytearray(id_);


--
-- Name: act_re_model act_fk_model_source_extra; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_re_model
    ADD CONSTRAINT act_fk_model_source_extra FOREIGN KEY (editor_source_extra_value_id_) REFERENCES flow.act_ge_bytearray(id_);


--
-- Name: act_id_priv_mapping act_fk_priv_mapping; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_id_priv_mapping
    ADD CONSTRAINT act_fk_priv_mapping FOREIGN KEY (priv_id_) REFERENCES flow.act_id_priv(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_custom_values; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES flow.act_ge_bytearray(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_exception; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES flow.act_ge_bytearray(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_execution; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_execution FOREIGN KEY (execution_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_proc_def; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES flow.act_re_procdef(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_process_instance; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_ru_task act_fk_task_exe; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_task
    ADD CONSTRAINT act_fk_task_exe FOREIGN KEY (execution_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_ru_task act_fk_task_procdef; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_task
    ADD CONSTRAINT act_fk_task_procdef FOREIGN KEY (proc_def_id_) REFERENCES flow.act_re_procdef(id_);


--
-- Name: act_ru_task act_fk_task_procinst; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_task
    ADD CONSTRAINT act_fk_task_procinst FOREIGN KEY (proc_inst_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_custom_values; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES flow.act_ge_bytearray(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_exception; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES flow.act_ge_bytearray(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_execution; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_execution FOREIGN KEY (execution_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_proc_def; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES flow.act_re_procdef(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_process_instance; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_ru_identitylink act_fk_tskass_task; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_identitylink
    ADD CONSTRAINT act_fk_tskass_task FOREIGN KEY (task_id_) REFERENCES flow.act_ru_task(id_);


--
-- Name: act_ru_variable act_fk_var_bytearray; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_variable
    ADD CONSTRAINT act_fk_var_bytearray FOREIGN KEY (bytearray_id_) REFERENCES flow.act_ge_bytearray(id_);


--
-- Name: act_ru_variable act_fk_var_exe; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_variable
    ADD CONSTRAINT act_fk_var_exe FOREIGN KEY (execution_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: act_ru_variable act_fk_var_procinst; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.act_ru_variable
    ADD CONSTRAINT act_fk_var_procinst FOREIGN KEY (proc_inst_id_) REFERENCES flow.act_ru_execution(id_);


--
-- Name: flw_ru_batch_part flw_fk_batch_part_parent; Type: FK CONSTRAINT; Schema: flow; Owner: pineapple
--

ALTER TABLE ONLY flow.flw_ru_batch_part
    ADD CONSTRAINT flw_fk_batch_part_parent FOREIGN KEY (batch_id_) REFERENCES flow.flw_ru_batch(id_);


--
-- Name: act_app_appdef act_fk_app_def_dply; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_app_appdef
    ADD CONSTRAINT act_fk_app_def_dply FOREIGN KEY (deployment_id_) REFERENCES public.act_app_deployment(id_);


--
-- Name: act_app_deployment_resource act_fk_app_rsrc_dpl; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_app_deployment_resource
    ADD CONSTRAINT act_fk_app_rsrc_dpl FOREIGN KEY (deployment_id_) REFERENCES public.act_app_deployment(id_);


--
-- Name: act_ru_identitylink act_fk_athrz_procedef; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_identitylink
    ADD CONSTRAINT act_fk_athrz_procedef FOREIGN KEY (proc_def_id_) REFERENCES public.act_re_procdef(id_);


--
-- Name: act_ge_bytearray act_fk_bytearr_depl; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ge_bytearray
    ADD CONSTRAINT act_fk_bytearr_depl FOREIGN KEY (deployment_id_) REFERENCES public.act_re_deployment(id_);


--
-- Name: act_cmmn_casedef act_fk_case_def_dply; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_casedef
    ADD CONSTRAINT act_fk_case_def_dply FOREIGN KEY (deployment_id_) REFERENCES public.act_cmmn_deployment(id_);


--
-- Name: act_cmmn_ru_case_inst act_fk_case_inst_case_def; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_ru_case_inst
    ADD CONSTRAINT act_fk_case_inst_case_def FOREIGN KEY (case_def_id_) REFERENCES public.act_cmmn_casedef(id_);


--
-- Name: act_cmmn_deployment_resource act_fk_cmmn_rsrc_dpl; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_deployment_resource
    ADD CONSTRAINT act_fk_cmmn_rsrc_dpl FOREIGN KEY (deployment_id_) REFERENCES public.act_cmmn_deployment(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_custom_values; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES public.act_ge_bytearray(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES public.act_ge_bytearray(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_execution; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_execution FOREIGN KEY (execution_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_proc_def; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES public.act_re_procdef(id_);


--
-- Name: act_ru_deadletter_job act_fk_deadletter_job_process_instance; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_deadletter_job
    ADD CONSTRAINT act_fk_deadletter_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_ru_event_subscr act_fk_event_exec; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_event_subscr
    ADD CONSTRAINT act_fk_event_exec FOREIGN KEY (execution_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_ru_execution act_fk_exe_parent; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_execution
    ADD CONSTRAINT act_fk_exe_parent FOREIGN KEY (parent_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_ru_execution act_fk_exe_procdef; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_execution
    ADD CONSTRAINT act_fk_exe_procdef FOREIGN KEY (proc_def_id_) REFERENCES public.act_re_procdef(id_);


--
-- Name: act_ru_execution act_fk_exe_procinst; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_execution
    ADD CONSTRAINT act_fk_exe_procinst FOREIGN KEY (proc_inst_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_ru_execution act_fk_exe_super; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_execution
    ADD CONSTRAINT act_fk_exe_super FOREIGN KEY (super_exec_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_ru_external_job act_fk_external_job_custom_values; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_external_job
    ADD CONSTRAINT act_fk_external_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES public.act_ge_bytearray(id_);


--
-- Name: act_ru_external_job act_fk_external_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_external_job
    ADD CONSTRAINT act_fk_external_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES public.act_ge_bytearray(id_);


--
-- Name: act_ru_identitylink act_fk_idl_procinst; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_identitylink
    ADD CONSTRAINT act_fk_idl_procinst FOREIGN KEY (proc_inst_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_procdef_info act_fk_info_json_ba; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_procdef_info
    ADD CONSTRAINT act_fk_info_json_ba FOREIGN KEY (info_json_id_) REFERENCES public.act_ge_bytearray(id_);


--
-- Name: act_procdef_info act_fk_info_procdef; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_procdef_info
    ADD CONSTRAINT act_fk_info_procdef FOREIGN KEY (proc_def_id_) REFERENCES public.act_re_procdef(id_);


--
-- Name: act_ru_job act_fk_job_custom_values; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_job
    ADD CONSTRAINT act_fk_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES public.act_ge_bytearray(id_);


--
-- Name: act_ru_job act_fk_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_job
    ADD CONSTRAINT act_fk_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES public.act_ge_bytearray(id_);


--
-- Name: act_ru_job act_fk_job_execution; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_job
    ADD CONSTRAINT act_fk_job_execution FOREIGN KEY (execution_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_ru_job act_fk_job_proc_def; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_job
    ADD CONSTRAINT act_fk_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES public.act_re_procdef(id_);


--
-- Name: act_ru_job act_fk_job_process_instance; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_job
    ADD CONSTRAINT act_fk_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_id_membership act_fk_memb_group; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_id_membership
    ADD CONSTRAINT act_fk_memb_group FOREIGN KEY (group_id_) REFERENCES public.act_id_group(id_);


--
-- Name: act_id_membership act_fk_memb_user; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_id_membership
    ADD CONSTRAINT act_fk_memb_user FOREIGN KEY (user_id_) REFERENCES public.act_id_user(id_);


--
-- Name: act_cmmn_ru_mil_inst act_fk_mil_case_def; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_ru_mil_inst
    ADD CONSTRAINT act_fk_mil_case_def FOREIGN KEY (case_def_id_) REFERENCES public.act_cmmn_casedef(id_);


--
-- Name: act_cmmn_ru_mil_inst act_fk_mil_case_inst; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_ru_mil_inst
    ADD CONSTRAINT act_fk_mil_case_inst FOREIGN KEY (case_inst_id_) REFERENCES public.act_cmmn_ru_case_inst(id_);


--
-- Name: act_re_model act_fk_model_deployment; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_re_model
    ADD CONSTRAINT act_fk_model_deployment FOREIGN KEY (deployment_id_) REFERENCES public.act_re_deployment(id_);


--
-- Name: act_re_model act_fk_model_source; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_re_model
    ADD CONSTRAINT act_fk_model_source FOREIGN KEY (editor_source_value_id_) REFERENCES public.act_ge_bytearray(id_);


--
-- Name: act_re_model act_fk_model_source_extra; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_re_model
    ADD CONSTRAINT act_fk_model_source_extra FOREIGN KEY (editor_source_extra_value_id_) REFERENCES public.act_ge_bytearray(id_);


--
-- Name: act_cmmn_ru_plan_item_inst act_fk_plan_item_case_def; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_ru_plan_item_inst
    ADD CONSTRAINT act_fk_plan_item_case_def FOREIGN KEY (case_def_id_) REFERENCES public.act_cmmn_casedef(id_);


--
-- Name: act_cmmn_ru_plan_item_inst act_fk_plan_item_case_inst; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_ru_plan_item_inst
    ADD CONSTRAINT act_fk_plan_item_case_inst FOREIGN KEY (case_inst_id_) REFERENCES public.act_cmmn_ru_case_inst(id_);


--
-- Name: act_id_priv_mapping act_fk_priv_mapping; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_id_priv_mapping
    ADD CONSTRAINT act_fk_priv_mapping FOREIGN KEY (priv_id_) REFERENCES public.act_id_priv(id_);


--
-- Name: act_cmmn_ru_sentry_part_inst act_fk_sentry_case_def; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_ru_sentry_part_inst
    ADD CONSTRAINT act_fk_sentry_case_def FOREIGN KEY (case_def_id_) REFERENCES public.act_cmmn_casedef(id_);


--
-- Name: act_cmmn_ru_sentry_part_inst act_fk_sentry_case_inst; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_ru_sentry_part_inst
    ADD CONSTRAINT act_fk_sentry_case_inst FOREIGN KEY (case_inst_id_) REFERENCES public.act_cmmn_ru_case_inst(id_);


--
-- Name: act_cmmn_ru_sentry_part_inst act_fk_sentry_plan_item; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_cmmn_ru_sentry_part_inst
    ADD CONSTRAINT act_fk_sentry_plan_item FOREIGN KEY (plan_item_inst_id_) REFERENCES public.act_cmmn_ru_plan_item_inst(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_custom_values; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES public.act_ge_bytearray(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES public.act_ge_bytearray(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_execution; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_execution FOREIGN KEY (execution_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_proc_def; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES public.act_re_procdef(id_);


--
-- Name: act_ru_suspended_job act_fk_suspended_job_process_instance; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_suspended_job
    ADD CONSTRAINT act_fk_suspended_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_ru_task act_fk_task_exe; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_task
    ADD CONSTRAINT act_fk_task_exe FOREIGN KEY (execution_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_ru_task act_fk_task_procdef; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_task
    ADD CONSTRAINT act_fk_task_procdef FOREIGN KEY (proc_def_id_) REFERENCES public.act_re_procdef(id_);


--
-- Name: act_ru_task act_fk_task_procinst; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_task
    ADD CONSTRAINT act_fk_task_procinst FOREIGN KEY (proc_inst_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_custom_values; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_custom_values FOREIGN KEY (custom_values_id_) REFERENCES public.act_ge_bytearray(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_exception; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_exception FOREIGN KEY (exception_stack_id_) REFERENCES public.act_ge_bytearray(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_execution; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_execution FOREIGN KEY (execution_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_proc_def; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_proc_def FOREIGN KEY (proc_def_id_) REFERENCES public.act_re_procdef(id_);


--
-- Name: act_ru_timer_job act_fk_timer_job_process_instance; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_timer_job
    ADD CONSTRAINT act_fk_timer_job_process_instance FOREIGN KEY (process_instance_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_ru_identitylink act_fk_tskass_task; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_identitylink
    ADD CONSTRAINT act_fk_tskass_task FOREIGN KEY (task_id_) REFERENCES public.act_ru_task(id_);


--
-- Name: act_ru_variable act_fk_var_bytearray; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_variable
    ADD CONSTRAINT act_fk_var_bytearray FOREIGN KEY (bytearray_id_) REFERENCES public.act_ge_bytearray(id_);


--
-- Name: act_ru_variable act_fk_var_exe; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_variable
    ADD CONSTRAINT act_fk_var_exe FOREIGN KEY (execution_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: act_ru_variable act_fk_var_procinst; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.act_ru_variable
    ADD CONSTRAINT act_fk_var_procinst FOREIGN KEY (proc_inst_id_) REFERENCES public.act_ru_execution(id_);


--
-- Name: flw_ru_batch_part flw_fk_batch_part_parent; Type: FK CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.flw_ru_batch_part
    ADD CONSTRAINT flw_fk_batch_part_parent FOREIGN KEY (batch_id_) REFERENCES public.flw_ru_batch(id_);


--
-- Name: sys_role_menu sys_role_menu_fk1; Type: FK CONSTRAINT; Schema: system; Owner: pineapple
--

ALTER TABLE ONLY system.sys_role_menu
    ADD CONSTRAINT sys_role_menu_fk1 FOREIGN KEY (role_id) REFERENCES system.sys_role(id);


--
-- Name: CONSTRAINT sys_role_menu_fk1 ON sys_role_menu; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT sys_role_menu_fk1 ON system.sys_role_menu IS '系统角色菜单关系映射表角色id映射';


--
-- Name: sys_role_menu sys_role_menu_fk2; Type: FK CONSTRAINT; Schema: system; Owner: pineapple
--

ALTER TABLE ONLY system.sys_role_menu
    ADD CONSTRAINT sys_role_menu_fk2 FOREIGN KEY (menu_id) REFERENCES system.sys_menu(id);


--
-- Name: CONSTRAINT sys_role_menu_fk2 ON sys_role_menu; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT sys_role_menu_fk2 ON system.sys_role_menu IS '系统角色菜单关系映射表菜单映射';


--
-- Name: sys_user_role sys_user_role_fk1; Type: FK CONSTRAINT; Schema: system; Owner: pineapple
--

ALTER TABLE ONLY system.sys_user_role
    ADD CONSTRAINT sys_user_role_fk1 FOREIGN KEY (user_id) REFERENCES system.sys_user(id);


--
-- Name: CONSTRAINT sys_user_role_fk1 ON sys_user_role; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT sys_user_role_fk1 ON system.sys_user_role IS '系统用户角色关系映射表用户id映射';


--
-- Name: sys_user_role sys_user_role_fk2; Type: FK CONSTRAINT; Schema: system; Owner: pineapple
--

ALTER TABLE ONLY system.sys_user_role
    ADD CONSTRAINT sys_user_role_fk2 FOREIGN KEY (role_id) REFERENCES system.sys_role(id);


--
-- Name: CONSTRAINT sys_user_role_fk2 ON sys_user_role; Type: COMMENT; Schema: system; Owner: pineapple
--

COMMENT ON CONSTRAINT sys_user_role_fk2 ON system.sys_user_role IS '系统用户角色关系映射表角色映射';


--
-- PostgreSQL database dump complete
--

