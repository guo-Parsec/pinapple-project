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
-- Name: flow; Type: SCHEMA; Schema: -; Owner: pineapple
--

CREATE SCHEMA flow;


ALTER SCHEMA flow OWNER TO pineapple;

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
-- Name: t_template; Type: TABLE; Schema: public; Owner: pineapple
--

CREATE TABLE public.t_template (
    id bigint NOT NULL,
    add_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    edit_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.t_template OWNER TO pineapple;

--
-- Name: TABLE t_template; Type: COMMENT; Schema: public; Owner: pineapple
--

COMMENT ON TABLE public.t_template IS '模板表';


--
-- Name: COLUMN t_template.id; Type: COMMENT; Schema: public; Owner: pineapple
--

COMMENT ON COLUMN public.t_template.id IS '主键';


--
-- Name: COLUMN t_template.add_time; Type: COMMENT; Schema: public; Owner: pineapple
--

COMMENT ON COLUMN public.t_template.add_time IS '新增时间';


--
-- Name: COLUMN t_template.edit_time; Type: COMMENT; Schema: public; Owner: pineapple
--

COMMENT ON COLUMN public.t_template.edit_time IS '编辑时间';


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
    menu_icon character varying(64) DEFAULT ''::character varying NOT NULL,
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
-- Data for Name: act_evt_log; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_ge_bytearray; Type: TABLE DATA; Schema: flow; Owner: pineapple
--

INSERT INTO flow.act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) VALUES ('2', 1, 'flows/common-two-step-processc.bpmn20.xml', '1', '\x3c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d225554462d38223f3e0a3c646566696e6974696f6e7320786d6c6e733d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f4d4f44454c2220786d6c6e733a7873693d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612d696e7374616e63652220786d6c6e733a7873643d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d612220786d6c6e733a666c6f7761626c653d22687474703a2f2f666c6f7761626c652e6f72672f62706d6e2220786d6c6e733a62706d6e64693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f42504d4e2f32303130303532342f44492220786d6c6e733a6f6d6764633d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44432220786d6c6e733a6f6d6764693d22687474703a2f2f7777772e6f6d672e6f72672f737065632f44442f32303130303532342f44492220747970654c616e67756167653d22687474703a2f2f7777772e77332e6f72672f323030312f584d4c536368656d61222065787072657373696f6e4c616e67756167653d22687474703a2f2f7777772e77332e6f72672f313939392f585061746822207461726765744e616d6573706163653d22687474703a2f2f7777772e666c6f7761626c652e6f72672f70726f63657373646566223e0a20203c70726f636573732069643d22636f6d6d6f6e2d74776f2d737465702d70726f6365737322206e616d653d22e9809ae794a8e4b8a4e6ada5e5aea1e6a0b8e6b581e7a88b2220697345786563757461626c653d2274727565223e0a202020203c646f63756d656e746174696f6e3ee9809ae794a8e4b8a4e6ada5e5aea1e6a0b8e6b581e7a88b3c2f646f63756d656e746174696f6e3e0a202020203c73746172744576656e742069643d2273746172744576656e743122206e616d653d22e5bc80e5a78b223e3c2f73746172744576656e743e0a202020203c757365725461736b2069643d227369642d33433542413045322d453435452d343242382d424233352d36424431363537363034463022206e616d653d22e68f90e4baa4e794b3e8afb7223e3c2f757365725461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d43344231333735422d383041342d343643342d414136462d3430333432383545443641372220736f757263655265663d2273746172744576656e743122207461726765745265663d227369642d33433542413045322d453435452d343242382d424233352d364244313635373630344630223e3c2f73657175656e6365466c6f773e0a202020203c757365725461736b2069643d227369642d30453631464646412d433833332d343931332d393337332d32383830383941334539344422206e616d653d22e794b3e8afb7e7a1aee8aea42220666c6f7761626c653a63616e64696461746555736572733d22247b636f6e6669726d526f6c657d223e3c2f757365725461736b3e0a202020203c73657175656e6365466c6f772069643d227369642d30363844443541452d423031422d344339442d394531462d3337363039453545374337332220736f757263655265663d227369642d33433542413045322d453435452d343242382d424233352d36424431363537363034463022207461726765745265663d227369642d30453631464646412d433833332d343931332d393337332d323838303839413345393444223e3c2f73657175656e6365466c6f773e0a202020203c6578636c7573697665476174657761792069643d227369642d44394545323834422d463333352d343344372d393143322d363338303634393736423834223e3c2f6578636c7573697665476174657761793e0a202020203c757365725461736b2069643d227369642d39464336393144452d353236362d343536352d423237332d45323533383241383835454122206e616d653d22e69c80e7bb88e5aea1e689b92220666c6f7761626c653a63616e64696461746555736572733d22247b617070726f7665526f6c657d223e3c2f757365725461736b3e0a202020203c6578636c7573697665476174657761792069643d227369642d30344243464644412d364343362d344633392d424645342d424331353132424136353836223e3c2f6578636c7573697665476174657761793e0a202020203c73657175656e6365466c6f772069643d227369642d37444437334335462d433139312d343935312d423331322d4634423137463746443534382220736f757263655265663d227369642d39464336393144452d353236362d343536352d423237332d45323533383241383835454122207461726765745265663d227369642d30344243464644412d364343362d344633392d424645342d424331353132424136353836223e3c2f73657175656e6365466c6f773e0a202020203c656e644576656e742069643d227369642d41434141413646332d443133392d343445342d413530462d35334634313934314242323722206e616d653d22e7bb93e69d9f223e3c2f656e644576656e743e0a202020203c656e644576656e742069643d227369642d38413044463536412d424642442d344539382d394544312d36303337413241384343383522206e616d653d22e7bb93e69d9f223e3c2f656e644576656e743e0a202020203c73657175656e6365466c6f772069643d227369642d34444237393135382d313231422d343535432d383837382d3933423532323738303238322220736f757263655265663d227369642d30453631464646412d433833332d343931332d393337332d32383830383941334539344422207461726765745265663d227369642d44394545323834422d463333352d343344372d393143322d363338303634393736423834223e3c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d34354335463131372d313246312d344234352d423331442d36464346413135313937393822206e616d653d22e98080e59b9ee794b3e8afb72220736f757263655265663d227369642d44394545323834422d463333352d343344372d393143322d36333830363439373642383422207461726765745265663d227369642d33433542413045322d453435452d343242382d424233352d364244313635373630344630223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b636f6e6669726d3d3d2772656170706c79277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d32304546323932342d373742442d343131442d423646362d35363644433137454442453922206e616d653d22e7a1aee8aea4e68f90e4baa42220736f757263655265663d227369642d44394545323834422d463333352d343344372d393143322d36333830363439373642383422207461726765745265663d227369642d39464336393144452d353236362d343536352d423237332d453235333832413838354541223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b636f6e6669726d3d3d2770617373277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d39333542364231362d324234322d343935352d423838432d45384334344135383330433922206e616d653d22e5aea1e689b9e9809ae8bf872220736f757263655265663d227369642d30344243464644412d364343362d344633392d424645342d42433135313242413635383622207461726765745265663d227369642d41434141413646332d443133392d343445342d413530462d353346343139343142423237223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b617070726f76653d3d2770617373277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a202020203c73657175656e6365466c6f772069643d227369642d46423143384341452d303944312d343343352d393645442d32384541463939373338333222206e616d653d22e5aea1e689b9e68b92e7bb9d2220736f757263655265663d227369642d30344243464644412d364343362d344633392d424645342d42433135313242413635383622207461726765745265663d227369642d38413044463536412d424642442d344539382d394544312d363033374132413843433835223e0a2020202020203c636f6e646974696f6e45787072657373696f6e207873693a747970653d2274466f726d616c45787072657373696f6e223e3c215b43444154415b247b617070726f76653d3d2772656a656374277d5d5d3e3c2f636f6e646974696f6e45787072657373696f6e3e0a202020203c2f73657175656e6365466c6f773e0a20203c2f70726f636573733e0a20203c62706d6e64693a42504d4e4469616772616d2069643d2242504d4e4469616772616d5f636f6d6d6f6e2d74776f2d737465702d70726f63657373223e0a202020203c62706d6e64693a42504d4e506c616e652062706d6e456c656d656e743d22636f6d6d6f6e2d74776f2d737465702d70726f63657373222069643d2242504d4e506c616e655f636f6d6d6f6e2d74776f2d737465702d70726f63657373223e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d2273746172744576656e7431222069643d2242504d4e53686170655f73746172744576656e7431223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2233302e30222077696474683d2233302e302220783d2237342e39393939393838383234313239322220793d223238342e3939393937353332333637383236223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d33433542413045322d453435452d343242382d424233352d364244313635373630344630222069643d2242504d4e53686170655f7369642d33433542413045322d453435452d343242382d424233352d364244313635373630344630223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d2239392e39393939393939393939393939342220783d223230392e393939393936383730373536322220793d223235392e39393939393138373838363733223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d30453631464646412d433833332d343931332d393337332d323838303839413345393444222069643d2242504d4e53686170655f7369642d30453631464646412d433833332d343931332d393337332d323838303839413345393444223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223430342e39393939393339363530323938332220793d223235392e39393939383830303435363536223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d44394545323834422d463333352d343344372d393143322d363338303634393736423834222069643d2242504d4e53686170655f7369642d44394545323834422d463333352d343344372d393143322d363338303634393736423834223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2234302e30222077696474683d2234302e302220783d223536392e393939393931353036333338322220793d223237392e3939393938373730363534323336223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d39464336393144452d353236362d343536352d423237332d453235333832413838354541222069643d2242504d4e53686170655f7369642d39464336393144452d353236362d343536352d423237332d453235333832413838354541223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2238302e30222077696474683d223130302e302220783d223730342e393939393839343934363831352220793d223235392e39393939393138373838363733223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d30344243464644412d364343362d344633392d424645342d424331353132424136353836222069643d2242504d4e53686170655f7369642d30344243464644412d364343362d344633392d424645342d424331353132424136353836223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2234302e30222077696474683d2234302e302220783d223836392e39393939383730333539392220793d223237392e3939393937393537303530383836223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d41434141413646332d443133392d343445342d413530462d353346343139343142423237222069643d2242504d4e53686170655f7369642d41434141413646332d443133392d343445342d413530462d353346343139343142423237223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2232382e30222077696474683d2232382e302220783d223938392e393939393835323437383530362220793d223238352e39393939383337343238333337223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e53686170652062706d6e456c656d656e743d227369642d38413044463536412d424642442d344539382d394544312d363033374132413843433835222069643d2242504d4e53686170655f7369642d38413044463536412d424642442d344539382d394544312d363033374132413843433835223e0a20202020202020203c6f6d6764633a426f756e6473206865696768743d2232382e30222077696474683d2232382e302220783d223837352e393939393733393832353733312220793d223431392e39393939393337343135313234223e3c2f6f6d6764633a426f756e64733e0a2020202020203c2f62706d6e64693a42504d4e53686170653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d34354335463131372d313246312d344234352d423331442d364643464131353139373938222069643d2242504d4e456467655f7369642d34354335463131372d313246312d344234352d423331442d364643464131353139373938223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223539302e343939393931353036333338312220793d223238302e3439393938373730363534323336223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223539302e343939393931353036333338322220793d223137342e3739393938383235343930343735223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223235392e39393939393638373037353631352220793d223137342e3739393938383235343930343735223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223235392e39393939393638373037353631352220793d223235392e39393939393138373838363733223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d37444437334335462d433139312d343935312d423331322d463442313746374644353438222069643d2242504d4e456467655f7369642d37444437334335462d433139312d343935312d423331322d463442313746374644353438223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223830342e393439393839343934363831342220793d223330302e31383433303436383830393733223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223837302e343235393134373930373830382220793d223330302e34323539303733323532393937223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d30363844443541452d423031422d344339442d394531462d333736303945354537433733222069643d2242504d4e456467655f7369642d30363844443541452d423031422d344339442d394531462d333736303945354537433733223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223330392e393439393936383730363637322220793d223239392e39393939393038383534353636223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223430342e39393939393339363439353637332220793d223239392e39393939383839393639383239223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d39333542364231362d324234322d343935352d423838432d453843343441353833304339222069643d2242504d4e456467655f7369642d39333542364231362d324234322d343935352d423838432d453843343441353833304339223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223930392e353235333834323133333038312220793d223330302e34313539303934373733363338223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223939302e303030313135353331333935322220793d223330302e3036313433363531333233313734223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d43344231333735422d383041342d343643342d414136462d343033343238354544364137222069643d2242504d4e456467655f7369642d43344231333735422d383041342d343643342d414136462d343033343238354544364137223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223130342e39343939393832343935353438382220793d223239392e3939393937363737393536313137223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223230392e39393939393637343133363939382220793d223239392e393939393837303039363934223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d34444237393135382d313231422d343535432d383837382d393342353232373830323832222069643d2242504d4e456467655f7369642d34444237393135382d313231422d343535432d383837382d393342353232373830323832223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223530342e39343939393339363530323237372220793d223330302e31383433303532343132323138223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223537302e343235393137343735323036312220793d223330302e3432353931333637353433343233223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d32304546323932342d373742442d343131442d423646362d353636444331374544424539222069643d2242504d4e456467655f7369642d32304546323932342d373742442d343131442d423646362d353636444331374544424539223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223630392e353031393536323838393139392220793d223330302e34343230363133363134313634223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223730342e393939393839343934363830322220793d223330302e3135313831343332323031343936223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a2020202020203c62706d6e64693a42504d4e456467652062706d6e456c656d656e743d227369642d46423143384341452d303944312d343343352d393645442d323845414639393733383332222069643d2242504d4e456467655f7369642d46423143384341452d303944312d343343352d393645442d323845414639393733383332223e0a20202020202020203c6f6d6764693a776179706f696e7420783d223839302e343238353536363030333837382220793d223331392e353134303439373938303837223e3c2f6f6d6764693a776179706f696e743e0a20202020202020203c6f6d6764693a776179706f696e7420783d223839302e303532323232313731333336312220793d223432302e3030303039303430353735373635223e3c2f6f6d6764693a776179706f696e743e0a2020202020203c2f62706d6e64693a42504d4e456467653e0a202020203c2f62706d6e64693a42504d4e506c616e653e0a20203c2f62706d6e64693a42504d4e4469616772616d3e0a3c2f646566696e6974696f6e733e', false);
INSERT INTO flow.act_ge_bytearray (id_, rev_, name_, deployment_id_, bytes_, generated_) VALUES ('3', 1, 'flows/common-two-step-processc.common-two-step-process.png', '1', '\x89504e470d0a1a0a0000000d4948445200000403000001c90806000000f0f5f05b00002d3749444154785eeddd0b946465752860c38d89c12c13939b98484c341013574c34263e1213810463ee35c607e93e540fafe1e520034b235723480489828f68f4c6f8c017be825703019301950119507450e30350441814111186013182c24cddb32b7dba6afeae9aaeeeae53e7d4a9ef5b6bafeefeebd4a95a55f5efdeffae53a7ee773f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060050e38e080b6104288a523cd9f000030b1f20277fbc9279fbc5b3a0e4097660000008d9217b83f3aeaa8a3ee9f8e03d0a519000040a3e405eedd871e7ae803d27100ba340300006894bcc0fdfe41071df4c0741c802ecd0000001a252f70ef5cb366cd83d27100ba340300006894bcc0bd7d6e6eeec1e938005d9a010000344a5ee0deda6ab5fe673a0e4097660000008d9217b8df69b55a0f49c701e8d20c0000a051f202f7a63c1e9a8e03d0a519000040a3e405ee37f378583a0e4097660000008d9217b85bf278783a0e4097660000008d9217b85fcfb26ccf741c802ecd0000001a252f70afc9b2ec91e938005d9a010000344a5ee05e9d65d9a3d27100ba340300006894bcc0fd7296658f4ec701e8d20c0000a051f202f70b59963d261d07a04b3300008046c90bdccf6559f6b8741c802ecd0000001a252f70376759f6f8741c802ecd0000001a252f702fcfb2ec49e938005d9a010000344a5ee05e363b3bfbe4741c802ecd0000001aa5d56a5d323b3bfb94741c802ecd0000001aa5d56a5d343b3bbb6f3a0e4097660000008dd26ab53e3e3b3bbb5f3a0e4097660000008d9265d9057373734f4bc701e8d20c0000a051b22cfb8fb9b9b9ff9d8e03d0a519000040a36459765eabd57a463a0e4097660000008d9265d939ad56eb59e938005d9a010000344a96651f6eb55afba7e3007469060000d0287981fbc156ab359b8e03d0a519000040a3e405ee075ab9741c802ecd0000001a252f70dfdb6ab50e4cc701e8d20c0000a0515aadd699791c928e03d0a519000040a3b45aad776659b6361d07a04b3300008046c9b2ec8c56ab75443a0e4097660000008d9265d95b5aadd673d37100ba3403000068942ccbded46ab59e978e03d0a519000040a36459f6c656ab756c3a0e4097660000008d9265d9eb5badd6f3d37100ba3403000068942ccb5edb6ab55e988e03d0a519000040a36459f6aa56abf5a2741c802ecd0000001a252f705fd96ab55e928e03d0a519000040a3e405eea979bc341d07a04b3300008046c90bdc93f378593a0e4097660000008d9217b827e5f1f2741c802ecd0000001a252f704fc8e315e938005d9a010000344a5ee0be388fd3d37100ba340300006894bcc03d3e8fd7a4e3007469060000d0287981fb823c5e978e03d0a519000040a3e405ee7179bc211d07a04b3300008046c90bdc63f2f8a7741c802ecd0000001a252f70d7e5f1e6741c802ecd0000001a252f708fcce36de938005d9a010000344a5ee01e96c73bd27100ba34030000689456ab75485ee4be3b1d07a04b330000804669b55a07e645ee7bd37100ba340300006894562e2f723f908e03d0a519000040a3b45aadd9bcc8fd603a0e4097660000008dd26ab5f6cfb2ecc3e938005d9a010000344aabd57a569665e7a4e3007469060000d028ad56eb1959969d978e03d0a519000040a3cccdcdfdef2ccbfe231d07a04b3300008046999b9b7b5a966517a4e3007469060000d028b3b3b3fbb55aad8fa7e3007469060000d028b3b3b3fbb65aad8bd27100ba340300006894d9d9d9a7b45aad4bd27100ba340300006894d9d9d927e745ee65e938005d9a010000344a96654fca8bdccbd37100ba3403000068942ccb1e9f17b99bd37100ba3403000068942ccb1e9717b99f4bc701e8d20c0000a051b22c7b4c5ee47e211d07a04b3300008046c9b2ecd17991fbe5741c802ecd0000001a25cbb247e545eed5e938005d9a010000344a96658fcc8bdc6bd27100ba3403000068942ccbf6cc8bdcafa7e3007469060000d0283333338fc88bdc2de938005d9a0100004caca38e3aeafe79417b5d14b54bc4dbd3eb024c33cd000000265aabd53aa4cfe2bf37ee9d9999d92bbd1ec034d30c000060a2e50bfdffd16ab5bedaa70950c47bd3eb004c3bcd000000265e966507f46902446c8faf1a4cb70798769a01000034c18fe58bfe2ff569067c28dd1000cd0000001aa2d56a3d2b6904ec989b9b7b6cba1d009a01000034c78fe5c5ed15453320cbb2f3d20d00f86f9a01000034469665ffab6806cccdcd3d21bd1c80ffa619000040a3e405ee27f3d89e8e03d0a51900004047bbddfe89ebafbffeff5d7ef9e53fdab87163fbe31ffff844c699679ed93932201daf7be48ff98e4d9b367dfba28b2e7a66fadc305e4d990b931ce643f934039a41beaa3ee42b00265e5e4c7c28ff67d6bee5965bda77df7d77fb873ffce1c446abd55a3456f788c73c1efb4f7ce21377e6c5c5d3d3e787f169d25c98d4301fcaa719d00cf255f5215f0130f1e25d85f86796fe9313e38d9b6fbef9b6bc98d89c3e3f8c8fb9509f301fcaa319d00cf2557d42be026062c5e185de55a83ee239c88b897bd2e787f13117ea13e6437934039a41beaa4fc857004cacf8dc5bfa8f4d5413f15ca4cf0fe3632ed42bcc8772680634837c55af90af009848c31614dfbfe3e6f6f557bcab7dd5852fef44fc1e63e97662e5a198a896b950af301fcaa119d00cf255bd42be0260220d5350dcb5eda6f6951f3da9fdc5fff83f3b458cc565e9f66265a198a896b950af301fcaa119d00cf255bd42be0260220d5350dc78d5798b8a8922be75d547166d2f56168a896a990bf50af3a11c9a01cd205fd52be42b0026d23005c5572e7ed5a242a288b82cdd5eac2c1413d53217ea15e6433934039a41beaa57c857004ca4610a8a2b3f7ef2a242a288b82cdd5eac2c1413d53217ea15e6433934039a41beaa57c857004c2405457d4231512d73a15e613e944333a019e4ab7a857c05c0441aa6a0883310a78544117159babd58592826aa652ed42bcc8772680634837c55af90af009848c31414d77ef29f16151245c465e9f66265a198a896b950af301fcaa119d00cf255bd42be0260220d53506cbde94bed2b3ff6b245c5448cc565e9f66265a198a896b950af301fcaa119d00cf255bd42be0260220d5350446cf9ec7b16151431966e27561e8a896a990bf50af3a11c9a01cd205fd52be42b0026d25005c53df7b4affdd49b1715143116972dda5eac281413d53217ea15e6433934039a41beaa57c857004ca4a50a8abbb6ddd4feda27ffefa262a288b82cb649af27961f8a896a990bf50af3a11c9a01cd205fd52be42b0026d2c082e29e7bda375f7b51fbcb179cb0a8884823b6896dbdd3b0ba504c54cb5ca857980fe5d00c6806f9aa5e215f013091fa15144bbda33028bcd3b0ba504c54cb5ca857980fe5d00c6806f9aa5e215f013091fa1514c3bca33028e2bae9fec470a198a896b950af301f4ab1bb664033c857f50af9aa14bba703008c58bf82222d12961be9fec470a198a896b950af301f466eef3c6ed10c6806f9aa5e215f8d5c275fcdff04a02cfd0a0a514d2826aa652ed42bcc87912a0aebe3e79b010aec09275fd52be4ab915ac857f33fe52b80b22828ea138a896a990bf50af36164d277d8d2bf9940f255bd42be1a99343fa57f03304a0a8afa8462a25ae642bdc27c18894185f4a07126847c55af90af4662505e1a340ec06a2928ea138a896a990bf50af361d5962aa097ba9c1a93afea15f2d5aa2d958f96ba1c18859999993d0e38e0807559969d97ffdc9cc78df1f9c2f99f9be7c7d7c576e975994c0a8afa8462a25ae642bdc27c5895610be761b7a366e4ab7a857cb52ac3e6a161b7a322d691136c767676dffcc9d994c76dc71e7becf9fff66fff76ee55575df5d9ef7ef7bbd7b7dbedbb6ebbedb6ef5f73cd35dfdcb871e395279f7cf297d7ac5973676c1fd74bf7c5645150d4271413d53217ea15e6c38a2db7605eeef6d4807c55af90af566cb9f967b9db33063debc858f80f1bd691759065d99ef993717e1ed79e75d659efdfbe7dfb2ded21e4dbb52fbbecb23b8e38e2885be7e6e63e1afb49f7cd645050d4271413d53217ea15e6c38aacb4505ee9f5a8887c55af90af5664a57967a5d763c47ad691e9427f3971be756445666767f7cb9f80efbcfad5af7ed77df7dd7763bae01f467ebdf6b9e79ebbeda0830eda16fb4b6f83fa5350d4271413d53217ea15e6c3b2adb6405eedf51923f9aa5e215f2ddb6af3cd6aafcf2acdaf236fef5dd81f78e0813b4e3bedb4f6c68d1bdbd75d775d7bebd6ad9df562fc8cbf633c2ecfd78d6943e076ebc831cb1ff4c3f2b8e9924b2e393359dfafc857bffad5f6dab56bbf37373777787a5bd49b82a23ea198a896b950af301f96655485f1a8f643c9e4ab7a857cb52ca3ca33a3da0fcb34bf8ebcb758cce7ebbf1d679c71467bdbb66de912b1afd82eb65fb3664d6f4320f677587a5b9460be93f3ed1b6eb8e123e993b31ab7dc724bfbb0c30efb41abd57a6a7a9bd49782a23ea198a896b950af301f8636ea8278d4fba304f255bd42be1adaa8f3cba8f7c712e6d7910b8d80638e3966fb962d5bd265e150e27aebd7afdfa921e0088192cdccccec953fd0378fea8880d4fc110277c5eda4b74d3d2928ea138a896a990bf50af361286921fc63791c32ff7339d2eba5fba566e4ab7a857c359434afa4796758e9f5d2fd5292f975e4d662f17ec20927ecb8f3ce3bd3e5e0b2c4f54f3cf1c4de86c056ebc812e50ff086384740fed8ef489f8c51d9b061c38ef5ebd77f3ebd6dea4941519f504c54cb5ca857980f4b4a0be0288cdf91473c6ef173d8027bd0f5d2fd5323f255bd42be5a529a4f06e59da50cba5eba7f4a10ebc8de230256db0828c47e92230436a4b7cd08cc7fedc3b52b3d59e0b0e2a482c71d77dcbd471e79e4d3d2fb40fd2828ea138a896a990bf50af36197fa15be87dcefbf0be4228629b07b0beb220eeeb9bcdfed5003f255bd42bedaa57e7944be9a30f3ebc8857304acf4a30183c4fe7acf21e06b074b903fb0979e75d659ef4b1ffc325c7ef9e5ed638f3d764b7a1fa81f05457d4231512d73a15e613e0c34a8e0ed5728efaac0eeb7fddbe7c77b0dba3d2a245fd52be4ab8106e58f7ef947beaab15847160bf538f95f1962bf3d47075c9ade0756616666668ffc41bd75fbf6eddf491ff832e4b7d33ee28823b6af5dbbf661e97da15e1414f509c544b5cc857a85f9d0d752856ebf82b95f81dd6fbb7e857561a9db65cce4ab7a857cd5d75279a35f1e92af6a687e1db92316e9f1f581c37e6bc072c57e7bbe767047dc6e7a5f58a12ccb8e5ebf7efd86f4412fd33ffff33fb74f39e594d7a6f785f1c927d2c579ec938ef75250d4271413e53117262f9a3e1f86794d26862d70fb15cebd0576bfcb7755581786bd7d566998d7867c55af90af1619365ff4cb47f2d5982df5fcc63a727e81de3efdf4d3d325df48c5fe8bdb8adb4def0b2b943fa0679f73ce39e7a50f7899e2a302279c70c2d7d2fbc2f814936957935c41519f687a3151257361f2a2e9f36198d7648fe516b6fd0ae8f87bb73ee3c314d685e5de0f566098d7867c55af90af76b2dc3c215f556ca9e7371f3bbbd8e6c20b2f4c977c2315fbefb93f67a7f78515ca1fcc2baebefaeacfa60f7899aebffefaf60b5ff8c2efa5f785f1e9994c0327b982a23ed1f462a24ae6c2e445d3e7c330afc9792b2d68fb15d8d7247f2fa7b02eacf4fe30a4615e1bf255bd42be5ab0d2fc205f5568a9e737fffd8ae2b258df9529f6df733faee8b99bac46fe60de74ebadb77e3d7dc0cb74fbedb7b79ffbdce7de9bde17c6a7cfe45e34c9ab28283ef399cf2cfcfe831ffca0efef697ce52b5f69df72cb2d8bc67715975c7249fb7bdffbdea2f141f1f9cf7fbef3f526e9f8b8a2e9c54495facc815acc857e51e6ebf6b39ffdeca2b1de88bcddfbf7e6cd9b77392fcb8ca6cf873eafc545afc9fbadbe90ed5760afa6b02eacf67eb10b7d5e138b5e1b55e5ab7beeb967d158c4e73ef7b94563dffad6b7da37de78e3c2dfbdfffb07c5d7bef6b59dae3328faedebd24b2f5d56ee1c65c8571dabcd0bf25545fa3caf3b3dbf79dc548c459d50a6d87fcfeddf94de5756287f30efb9f7de7bbf973ee065ca6faf731288f4be303e7d26751a17575150fcfeefff7efbacb3ceeafcfe84273ca17de4914776e2f18f7f7cfb3def79cfa2ed23a2d078d8c31ed6fed297beb43076f5d557efb44dba68f9c33ffcc3f6073ef081ceefdffffef777baec2d6f794bfb1ffee11f761a7be94b5f1a5f97d2f9fdb6db6edbe9b27144d38b892af579eda751c95c8818c7eb369a0537df7c73fb810f7c60fbdc73cf6ddf7df7dd8bb689227fefbdf7eebc0e8bb1d9d9d9f82ee145db8e239a3e1ffabc06778afdf7df7fd36ebbedb62ddff4f8f4bacb1487daa6efb0c5df31be1a71bfa2c0de3dbd80d5495f0b7da2b27cf5ee77bfbbfd9ce73ca7bd76edda8538f8e083db3ff3333fd3c931bddb9e7cf2c9eda73ce5299ddfa36919f9e7ca2baf6cffd77ffdd74edb45f15f8c5d7bedb5ed5ff9955f69df71c71d0b97f7cb574f7ef2933be7a6fac8473ed2a91fa209f0cc673eb3930fd36dc711f2957c35c9d2e7338d56abb5bdf83dd677658afdf7dcf63de97d6585f207f3a6ad5bb7de953ee0658ae4be6eddbace9927457da38a82e2894f7c6267511f8b8f073ff8c10b05c55e7bedd5f9c71edbc43b98871d7658673cee67fccc5fca9d4642fc1e8da6fbdffffeed57bdea550bfbfde217bfd8293c8ae6c22ffdd22f758a96f8fdcffeeccfe21b2e16b6bdf5d65bdb3ff9933fd939b7c551471db5d08cf8833ff883ce760f7ad083da679e79e6a2fb5e6614c544fa1c89f144157321a28cd76d5c5eec2fe64b14d751b0ffd44ffd54e7efdffeeddf6ebfed6d6f5b745fa2d9f0e77ffee70b7ffff55fff75fb8d6f7ce3a2edc611f17ca4cfd1b4c59ffee99fb61ff08007445e58e93b5abb7aa7adf7245dcb15f7a7f34e5b7a9fc578a2aa7cf5fef7bfbffdc8473e72a76640dc9f5ffff55fdf69bb58cc3fea518f6a5f73cd359d46c0dffffddfb77ff5577fb5b37de4ac7ffcc77f5cd8f694534ee9e49ac861871f7e78e7f579c821872cd400b19f2f7ce10b3bed7f9f7df6695f7cf1c5edf3ce3baffd977ff9979db1999999f639e79cd339b2e0aebbee5a74dfcb0cf94abe9a967064c084ca1fcc2bf2847c43fa8097293ef3f1a217bde8eef4be303ee904ee898b0fa8e050c38b2ebaa8f38ffd177ff117db8f7ef4a33bfff81ff290872c5c1e0bfc78d7b2f8fba69b6eeafc5cb3664dfb052f78c1c23ea248488f0a88b8eaaaab3a454af1772cb0e230e7f83dce4e7ae28927eeb4fdbffffbbf777ebee635afe9dcaf58503dee718feb2cc0fef88fff78ec871b36fd9d852af5990395ce85de28eb75fb8d6f7ca3fd9bbff99b9d8fd7c4bb713ffdd33fdd2996a3608bf1c73ce631edf3cf3f7fa77d7fe73bdfd9a9e87efad39fde7ec52b5eb1d336e38aa6cf873eafc545afc9790b856ccfd830fa15d6e93b6e2b29b0577a7f18529fd7c4a2d74655f92a9a8dfd9a01b1d0fffad7bfbeb05dfccf7efbdbdfde7edffbded7b9ec777ee777a226ec14fad1f88f8f1014db3ee2118fd8e97ffacffddccf2de4a168469e74d2490bf5402cfea3c9b9c71e7bb47febb77eabb3af673deb599dc57fe4b77ffdd77fede4b8b85fe97d2f33e4ab052bcd0ff25585fa3caf3b3dbf073867c0e4cb1fccb32fbcf0c2abd207bc4cf1ced4a9a79e7a6b7a5f189f4193ba779b711714b150f9a33ffaa3ce3ffe383c3a0e2d2c0a8af8a71e8720f67e2631de4d8877358bcf10c602e70d6f7843a7a1f0d6b7be75a77dc7670d7bf7178d86386cb07827a2387c308a992826a2a089c3185bad56e770e8625115dbffeeeffe6e679bf4fe97194d2f26aa54c7b9504459afdb38f7406cbbdf7efb758ea28977d762deedbbefbe9ddb7cea539fbad07438fbecb33bd78b23068a8ff0443ce9494f6a3ffff9cf5f749fc7114d9f0fc3bc267b2cb7a0ed5758c7676efb9d9d7b3905f672ef072b30cc6b63dcf92ade858f1c114dc4588417471e456459d639caef277ee227da2f7bd9cbda175c7041e7f778c73efe7fc7e571d45fbcfbff577ff557ed37bde94d3bed3b9a90d1cc2cf6b7fbeebb2ffcfef0873f7ca72643d40db1f08ffcb569d3a6ce7e7fedd77eadd370f8f99ffff9ce1b0d2f79c94b863e8fcaa842bedac972f3847c55b1a59edf037c9bc0e48bef693ce59453ae4c1ff032c567b9f2e2f5e3e97d617c064dea5ee32e282262811185c38ffff88f77927bb1088a7fe65138c4a181f159e9bff99bbfe9bcbb109dfe6812c475a311108b9a385431baffbdfbbdeebaeb76f90e6bb1a88a86c477bffbddcebb0ff17b9ca720de51288a8f583c9d7aeaa98bee77d9d1f462a24a759d0b1165bd6e8f3beeb8ce75fff66fffb6938fe333b6fbefbf7ffb977ff9973bd78b77d68adb89cfebc6f9068a02bbd8c7431ffad0cec70bd2fb3c8e68fa7c18e6359918b6b01d5458170574bfcb8729b087bd7d566998d7c6b8f35534e9e3d0ff685cc6517d912b7ee1177e6121ff1c7ae8a19d7300c5223cb68dfc14ffbf5ffbdad7768e7e8ab138ff483426dff5ae772dda7fecab386f40e49d623c1affe9b6511fc49b0af15181c869cf7ef6b33be391d7e2688474fb71847cb5c8b0f9a25f3e92afc66ca9e737d691c53651979429f65fdc56dc6e7a5f58a13c41eeb166cd9a3bb66fdf9e3ee6a588db897f0e9ffad4a79e9dde17c667d0a4ee35ce82220e6f8e7715a2eb9fbf36daaf7ce52bdbcf7bdef3da9ffce427dbcf78c6333adb149ff38b43088bc304e39d8058f8c765f12e681c2618e3e9c9d5e2ddce5d2daa7a0fb78ea223de4588dfe33386715442d19488776363fbde7d8f239a5e4c54a96e73a137ca78ddc6913471fe80a219f0e637bfb93377e2b6fa1d195044d10c883919efeec5e1bb51e4f71ed23bae68fa7c18e635d9c752056ebfc2b9df59b8fb6db7ab027ba9db658486796d5495afa2191079e8431ffa5027efbcf0852fec1c71144710f59ebcef831ffc60279f7cf4a31f6dbffad5afee1c1510392adef5fbbddffbbdce51482f7ef18b17b68f73a544ae897d468d50e4b5f8bdf7f6dff18e77741a073ffbb33fdbd9777cd4a9b719107931bdcfe308f9aaafa5f246bf3c245f5560a9e737d691f9e59df3c0c5477ab76ddb962efd4622f61bfb9f6f06ec88db4def0bab903fa8975e76d96577a40f7c19e22302f93f851fe5bfaef6ec9f946c9c05c5b7bffdedce217dc5c704a27888cf024663a038b1507c6340fe3a5d74ddd7bdee75edbdf7debb535ca49715115f3fb8abc3ade3f38ac5b6c5a22a1a0ef1ce67249fe2b2585069064c9f71ce85de28e3751b1f2938e18413763a3260cf3df7ec7caca0df910145c4fcfabbbffbbb4ee11e73338ece89e23bc6d2fb5d76980f030d2a74fb15ccfd0aeb42bfedfb15d8836e8f0a5595af7a8f0c889fb1f8fe8bbff88b4e3e89c3fd639b388220ded17fec631fdb7ef9cb5fde39cfcf57bffad54e2e897397c4223edec1ef3d4f40e4b5d85fbc9114df3a501c711027a4ebfdc69538074abcb150342efb350322a70efa66a2b242be1a6850fee8977fe4ab1a8b75e4fc22bd7dc61967a44bbf9188fd16b711b797de0756292f02f7cd13edadf7dd775ffad88f54ec3f167979827e6b7a1fa89f2a0a8a6806c409cde25dcdbdf3057e7c5eb938326050c4e266b7dd76eb2c8cfa7dcd50441400bd675eef7d87353e6af0b18f7d6ce1b238aa208a8cb82ffff22fff32f01dd6718662a25a55cc8588b25eb7516c47311e47e3c45138c5a1b7bb3a3220bed6309a06f1559ef1b9e03822203af5f1b9ddf8868ff4be9719e6c32ef52b780fb9dff08575a15f817d70cfe5fd6e871a1877be8a8f26455e8885fa37bff9cd4e4e89239a6281ff1bbff11b9d8ff7f56eff9ffff99f9d8f35bdf39defec9c4720ce3910b92e7ef67e14a988387aa0385f501c25508cc74703fbfdcfef6d0644fd10e7178a6f4b897a226e239aa1e975ca0cf96a97fae511f96ac2c43ab258a8c789bdb76cd9922e015725f617fb2d6e236e2fbd0f8cc0dcdcdc05e79e7b6e39c776ccdbb0614324e5bbf35f1f90de3ef533ce822226faeb5ffffacec2224ef0139f278c4306e370e63ff9933fe9bc73108b8f2f7ff9cb0bd7897740e35dca4810f1d9ea3811515c3fae1b5f8db6ab43026351f5e94f7f7ad178449c8830dea188a358621fc53bac575c7145a79915676a4faf53762826aa35ceb9b0ab18d5eb368e06882303e270dd3822203ebb1be3d10c88c23b1a0551dcf7eefff8e38fef7c9e37be95203e2a508cc7c70ce25c05d18048ef5359613e2c292d7c7b0be5610aebc2a0eba5fba746c69dafe27f711c9e7fecb1c776eabcf7bef7bd9d06407cc5691c4514e70b889303c60948e31dff385a201a8bd12c88c57c7c9d707c0c20c68a5c3428e276d2b122e2ab0ae348c1f8469438aa30ea8078a3204e281c472144d3338e52c8ebdd45d72d33e4ab25a5f96450de59caa0eba5fba704f9227d43b1585fbf7e7de71c21a310fb89fdf51c15b021bd6d4664666666af830f3e785bbee8da913e11a3108bb975ebd645823e26bd6dea699c054574fde3ddca38a42f267d71e85ffc438faf068a8f08c41988630113470e4491118b9328227af713ef664633e0894f7c62a7d0486fa788f8bef47877221d2f228a8af8199f7d8ce644fc1e67398eaf40eaf7d585658762a25ae39c0bbb8a51bd6e63a11f0db8681cf47e36374e2c188d82a73ded698bcebb115fdd19e7f188a6437abbf14ee0381f23f3612869011c8571bc53366c615d48af97ee979a19e75c2ce2d65b6f5df8fdc31ffe7067d11d87fcc7dff1d1807837fed24b2fedfc6f3ffae8a377dabe88685cc6f94bd2f1de8846653a5644d411f175a771c2d4c85f37dc70c392cd8571847c359434afa4796758e9f5d2fd52925847e60bf5adc5a23dce69b4da86405c3ff653ec736e6e6e5bdc4e7adb8cd0ececec7e6bd7aebd2b3e77354ab1bf6804e4ff18de9fde26f555454131aee8776861bf1876bbb2433151adbacc85615f8fc36e37a9613e0c6dd485f0a8f74709aace57bd9fe31f752cb5ef3ae63ef96a68a3ce2fa3de1f4b887564be68bfb7f70881957e6420aed77b4440abd5ba2ff69fde2625989b9b3bfc88238ef841bc933f0ab19fe8029f7df6d99fc9ff5c6e878f0a555d50886e2826aa652ed42bcc87651955413caafd5032f9aa5e215f2dcba8f2cca8f6c332e50bf7c37a1b02f151de38f9dfb0df3210dbc5f6bde708884640ec37bd2d4a943fe84f3df4d043bf1f9ffd5ae94905e37a71fde73ef7b99d2302da1a01134741519f504c54cb5ca857980fcbb6dac278b5d7678ce4ab7a857cb56cabcd37abbd3eab347f84c0edc5623e22ce6374da69a7b5376edcd839cfd7d6ad5b3bebc5f8197fc7785cdef3f5814523e00e47045424cbb23d9ff7bce77dfeb8e38ebb373e57ba7dfbf69d57fb03c476b17d9cb0ead4534fbdfbd39ffeb473044c2805457d4231512d73a15e613eacc84a0be4955e8f8ac857f50af96a45569a77567a3d462cd691f962fefcde85fd0ae2fcd84fba6fc6ecc8238f7cdab1c71e7bfde1871fbe3d4e2c1567b2eed7d189f1b83cbe06eba4934efad105175cf0b6b66f0d98680a8afa8462a25ae642bdc27c58b1e516cacbdd9e1a90afea15f2d58a2d37ff2c777bc660fe6b0737f559e8ef2a36f9fac01a5abb76edc34e3df5d4d7bef8c52ffefaf1c71fffbd75ebd6753e0f72f4d147efc8c7ee3ee594536e7bcf7bdef3b1cb2fbffc39ed767bb7f4fa4c1e05457d4231512d73a15e613eaccab005f3b0db5133f255bd42be5a9561f3d0b0db51919999993df275e3ba2ccbcecb7f6ecee3c6f9857ffcdc3c3fbe2eb64baf0b544441519f504c54cb5ca857980fabb654e1bcd4e5d4987c55af90af566da97cb4d4e500ac8482a23ea198a896b950af301f466250013d689c09215fd52be4ab91189497068d03b05a0a8afa8462a25ae642bdc27c1899b4904eff6602c957f50af96a64d2fc94fe0dc0282928ea138a896a990bf50af361a48a82faf8f99f0aeb09275fd52be4ab9192af00c64541519f504c54cb5ca857980f23e71db60691afea15f2d5c8c95700e3a0a0a84f2826aa652ed42bcc8752ec9e0e3099e4ab7a857c558adde34cf4e9200023a4a0a84f2826aa652ed42bcc07184cbeaa57c857e5d00c00289982a23ea198a896b950af301f6030f9aa5e215f95433300a0640a8afa8462a25ae642bdc27c80c1e4ab7a857c550ecd0080922928ea138a896a990bf50af3010693afea15f255393403004aa6a0a84f2826aa652ed42bcc07184cbeaa57c857e5d00c00289982a23ea198a896b950af301f6030f9aa5e215f95433300a0640a8afa8462a25ae642bdc27c80c1e4ab7a857c550ecd0080922928ea138a896a990bf50af3010693afea15f255393403004aa6a0a84f2826aa652ed42bcc07184cbeaa57c857e5d00c00289982a23ea198a896b950af301f6030f9aa5e215f95433300a0640a8afa8462a25ae642bdc27c80c1e4ab7a857c550ecd0080922928ea138a896a990bf50af3010693afea15f255393403004aa6a0a84f2826aa652ed42bcc07184cbeaa57c857e5d00c00289982a23ea198a896b950af301f6030f9aa5e215f95433300a0640a8afa8462a25ae642bdc27c80c1e4ab7a857c550ecd0080926ddcb871c7dd77dfbde81f9b186fe4cfc1b7f362e29ef4f9617ccc85fa84f900bb265fd527e4abf2680600946cd3a64ddfbee5965b16fd7313e38d6f7ce31b67e5c5c4e6f4f9617ccc85fa84f900bb265fd527e4abf268060094eca28b2e7ae6273ef1893b6fbef9e6dbbccb30fec81ff39b6fb8e1860fe485c437f3787afafc303ee642f5613ec070e4abea43be2a9f6600c018c43fb1e86ae7f1c3f8dc9b186bc4631e8fbd42a206e279987f3ecc856ac27c8021c53c999f2ff25535215f954c3300000000a68c66000000004c19cd0000000098329a010000003065340300000060ca6806000000c094d10c0000008029a3190000000053463300000000a68c66000000004c19cd0000000098329a010000003065340300000060ca6806000000c094d10c0000008029a3190000000053463300000000a68c66000000004c19cd0000000098329a010000003065340300000060ca6806000000c094d10c0000008029a3190000000053463300000000a68c66000000004c19cd0000000098329a010000003065340300000060ca6806000000c094d10c0000008029a3190000000053463300000000a68c66000000004c19cd0000000098329a010000003065340300000060ca6806000000c094d10c0000008029a3190000000053463300000000a68c66000000004c19cd0000000098329a010000003065340300000060ca6806000000c094d10c0000008029a3190000000053463300000000a68c66000000004c19cd0000000098329a010000003065340300000060ca6806000000c094d10c0000008029a3190000000053463300000000a68c66000000004c19cd0000000098329a010000003065340300000060ca6806000000c094d10c0000008029a3190000000053463300000000a68c66000000004c19cd0000000098329a010000003065340300000060ca6806000000c094d10c0000008006cb17fe17c7e27f89b838bd1e00000030a1f285fe3e7d16ff69ec935e0f0000009860f1ce7f9f0680a302000000a0a9e29dff3e4d00470500000040930d383ac05101000000d054038e0ed827dd0e0000006890e4e800470500000040d3254707ec935e0e0000004cb89999993df245ffba2ccbcecb7f6ecee3c69e66c0e6f9f175b15d7a5d0000006082ccceceee9b2ff237f52cfc87894d71bd745f000000408d6559b667bea83fbfcf427f39717eec27dd370000005033b3b3b3fbe50bf9db7b17f6071e78e08ed34e3badbd71e3c6f675d75dd7deba756b3bc4cff83bc6e3f2830e3a286d08dc1efb4b6f03000000a8897cf17e581ef7168bf9b9b9b91d679c71467bdbb66d9dc5ff5262bbd87ecd9a35bd0d81d8df61e96d01000000159b3f2260a11170cc31c76cdfb2654bbade1f4a5c6ffdfaf53b35041c210000000035323333b357be60df5a2cde4f38e1841d77de7967bac65f96b8fe89279ed8db10d81ab793de3600000050817ca1bea1f78880d536020ab19fe408810de96d030000006336fff5810be70858e947030689fdf59e43c0d70e02000040c5f205faa5c5423d4efe5786d86fcfd10197a6f70100000018939999993df2c5f98e58a4c7d7070efbad01cb15fbedf9dac11d71bbe97d01000000c620cbb2a38b77ec4f3ffdf4740d3f52b1ffe2b6e276d3fb020000008c41be303fbb58a05f78e185e9fa7da462ff3d1f15383bbd2f000000c018e48bf22b8a05faf5d75f9faedf472af6dfd30cb822bd2f000000c018e48bf29b8a05faedb7df9eaedf472af6dfd30cb829bd2f000000c018e48bf27b8a05fabdf7de9baedf472af6dfd30cb827bd2f000000c018383200000000a6cc01ce1900000000d3e500df2600000000d325cbb2a38b05fae9a79f9eaedf472af65fdc56dc6e7a5f0000008031989999d9235f9cef8805fa41071dd4deb66d5bba861f89d86fec7fbe19b0236e37bd2f000000c098e48bf34b8b77eccf38e38c741d3f12b1df9e8f085c9ade07000000608c666767f72d16ea6bd6ac696fd9b2255dcbaf4aec2ff65bdc46dc5e7a1f0000008031cb17e91b8ac5fafaf5ebdb77de7967baa65f91d84fecafe7a8800de96d0300000015989999d92b5fa86f2d16ed279e78e2aa1b0271fdd84fb1cfb9b9b96d713be96d0300000015999d9ddd2f5fb4dfdb7b84c04a3f3210d7eb3d22a0d56add17fb4f6f13000000a858be703facb721109ff58f93ff0dfb2d03b15d6cdf7b8e806804c47ed3db020000006a62fe0881db8bc57c447c2de069a79dd6deb87163fbbaebae6b6fddbab5b3f88f9ff1778cc7e53d5f1f583402ee7044000000004c802ccbf6cc17f3e7f72eec5710e7c77ed27d030000003536ffb5839bfa2cf477159b7c7d200000004cb89999993df245feba2ccbcecb7f6ecee3c6f9857ffcdc3c3fbe2eb64baf0b00000000000000000000000000000000000000000000000000000000000000c078fc7f6594c7956d147b4a0000000049454e44ae426082', true);


--
-- Data for Name: act_ge_property; Type: TABLE DATA; Schema: flow; Owner: pineapple
--

INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('common.schema.version', '6.6.0.0', 1);
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
INSERT INTO flow.act_ge_property (name_, value_, rev_) VALUES ('next.dbid', '27501', 12);


--
-- Data for Name: act_hi_actinst; Type: TABLE DATA; Schema: flow; Owner: pineapple
--

INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('2504', 1, 'common-two-step-process:1:4', '2501', '2503', 'startEvent1', NULL, NULL, '开始', 'startEvent', NULL, '2023-03-11 00:23:10.81', '2023-03-11 00:23:10.81', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('2505', 1, 'common-two-step-process:1:4', '2501', '2503', 'sid-C4B1375B-80A4-46C4-AA6F-4034285ED6A7', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-11 00:23:10.815', '2023-03-11 00:23:10.815', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('2511', 1, 'common-two-step-process:1:4', '2508', '2510', 'startEvent1', NULL, NULL, '开始', 'startEvent', NULL, '2023-03-11 00:27:04.681', '2023-03-11 00:27:04.681', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('2512', 1, 'common-two-step-process:1:4', '2508', '2510', 'sid-C4B1375B-80A4-46C4-AA6F-4034285ED6A7', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-11 00:27:04.681', '2023-03-11 00:27:04.681', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('5004', 1, 'common-two-step-process:1:4', '5001', '5003', 'startEvent1', NULL, NULL, '开始', 'startEvent', NULL, '2023-03-11 00:35:35.43', '2023-03-11 00:35:35.43', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('5005', 1, 'common-two-step-process:1:4', '5001', '5003', 'sid-C4B1375B-80A4-46C4-AA6F-4034285ED6A7', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-11 00:35:35.436', '2023-03-11 00:35:35.436', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25009', 3, 'common-two-step-process:1:4', '2501', '2503', 'sid-0E61FFFA-C833-4913-9373-288089A3E94D', '25010', NULL, '申请确认', 'userTask', 'user1', '2023-03-12 16:57:47.575', '2023-03-12 17:00:28.099', 2, 160524, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('10003', 1, 'common-two-step-process:1:4', '10001', '10002', 'startEvent1', NULL, NULL, '开始', 'startEvent', NULL, '2023-03-11 23:47:27.487', '2023-03-11 23:47:27.489', 1, 2, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('10004', 1, 'common-two-step-process:1:4', '10001', '10002', 'sid-C4B1375B-80A4-46C4-AA6F-4034285ED6A7', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-11 23:47:27.489', '2023-03-11 23:47:27.489', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('10018', 1, 'common-two-step-process:1:4', '10016', '10017', 'startEvent1', NULL, NULL, '开始', 'startEvent', NULL, '2023-03-11 23:49:04.812', '2023-03-11 23:49:04.812', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('10019', 1, 'common-two-step-process:1:4', '10016', '10017', 'sid-C4B1375B-80A4-46C4-AA6F-4034285ED6A7', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-11 23:49:04.812', '2023-03-11 23:49:04.812', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25084', 1, 'common-two-step-process:1:4', '5001', '5003', 'sid-4DB79158-121B-455C-8878-93B522780282', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 17:00:39.917', '2023-03-12 17:00:39.917', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('5006', 3, 'common-two-step-process:1:4', '5001', '5003', 'sid-3C5BA0E2-E45E-42B8-BB35-6BD1657604F0', '5007', NULL, '提交申请', 'userTask', 'user3', '2023-03-11 00:35:35.436', '2023-03-12 16:58:10.561', 3, 145355125, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('15002', 1, 'common-two-step-process:1:4', '10001', '10002', 'sid-068DD5AE-B01B-4C9D-9E1F-37609E5E7C73', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 16:26:17.266', '2023-03-12 16:26:17.266', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('10005', 3, 'common-two-step-process:1:4', '10001', '10002', 'sid-3C5BA0E2-E45E-42B8-BB35-6BD1657604F0', '10006', NULL, '提交申请', 'userTask', 'user1', '2023-03-11 23:47:27.489', '2023-03-12 16:26:17.262', 3, 59929773, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25048', 1, 'common-two-step-process:1:4', '10016', '10017', 'sid-068DD5AE-B01B-4C9D-9E1F-37609E5E7C73', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 16:58:16.712', '2023-03-12 16:58:16.712', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('22503', 1, 'common-two-step-process:1:4', '10001', '10002', 'sid-4DB79158-121B-455C-8878-93B522780282', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 16:48:59.68', '2023-03-12 16:48:59.68', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('22504', 1, 'common-two-step-process:1:4', '10001', '10002', 'sid-D9EE284B-F335-43D7-91C2-638064976B84', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-03-12 16:48:59.68', '2023-03-12 16:48:59.698', 2, 18, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('22505', 1, 'common-two-step-process:1:4', '10001', '10002', 'sid-20EF2924-77BD-411D-B6F6-566DC17EDBE9', NULL, NULL, '确认提交', 'sequenceFlow', NULL, '2023-03-12 16:48:59.698', '2023-03-12 16:48:59.698', 3, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('15003', 3, 'common-two-step-process:1:4', '10001', '10002', 'sid-0E61FFFA-C833-4913-9373-288089A3E94D', '15004', NULL, '申请确认', 'userTask', 'user2', '2023-03-12 16:26:17.267', '2023-03-12 16:48:59.674', 2, 1362407, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25004', 1, 'common-two-step-process:1:4', '10001', '10002', 'sid-7DD73C5F-C191-4951-B312-F4B17F7FD548', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 16:56:23.888', '2023-03-12 16:56:23.888', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25005', 1, 'common-two-step-process:1:4', '10001', '10002', 'sid-04BCFFDA-6CC6-4F39-BFE4-BC1512BA6586', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-03-12 16:56:23.888', '2023-03-12 16:56:23.912', 2, 24, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25006', 1, 'common-two-step-process:1:4', '10001', '10002', 'sid-935B6B16-2B42-4955-B88C-E8C44A5830C9', NULL, NULL, '审批通过', 'sequenceFlow', NULL, '2023-03-12 16:56:23.912', '2023-03-12 16:56:23.912', 3, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25007', 1, 'common-two-step-process:1:4', '10001', '10002', 'sid-ACAAA6F3-D139-44E4-A50F-53F41941BB27', NULL, NULL, '结束', 'endEvent', NULL, '2023-03-12 16:56:23.913', '2023-03-12 16:56:23.913', 4, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('22506', 3, 'common-two-step-process:1:4', '10001', '10002', 'sid-9FC691DE-5266-4565-B273-E25382A885EA', '22507', NULL, '最终审批', 'userTask', 'user3', '2023-03-12 16:48:59.698', '2023-03-12 16:56:23.888', 4, 444190, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25008', 1, 'common-two-step-process:1:4', '2501', '2503', 'sid-068DD5AE-B01B-4C9D-9E1F-37609E5E7C73', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 16:57:47.574', '2023-03-12 16:57:47.574', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('2506', 2, 'common-two-step-process:1:4', '2501', '2503', 'sid-3C5BA0E2-E45E-42B8-BB35-6BD1657604F0', '2507', NULL, '提交申请', 'userTask', NULL, '2023-03-11 00:23:10.816', '2023-03-12 16:57:47.574', 3, 146076758, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25022', 1, 'common-two-step-process:1:4', '2508', '2510', 'sid-068DD5AE-B01B-4C9D-9E1F-37609E5E7C73', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 16:58:06.291', '2023-03-12 16:58:06.291', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('2513', 2, 'common-two-step-process:1:4', '2508', '2510', 'sid-3C5BA0E2-E45E-42B8-BB35-6BD1657604F0', '2514', NULL, '提交申请', 'userTask', NULL, '2023-03-11 00:27:04.681', '2023-03-12 16:58:06.291', 3, 145861610, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25036', 1, 'common-two-step-process:1:4', '5001', '5003', 'sid-068DD5AE-B01B-4C9D-9E1F-37609E5E7C73', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 16:58:10.562', '2023-03-12 16:58:10.562', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('10020', 3, 'common-two-step-process:1:4', '10016', '10017', 'sid-3C5BA0E2-E45E-42B8-BB35-6BD1657604F0', '10021', NULL, '提交申请', 'userTask', 'user1', '2023-03-11 23:49:04.812', '2023-03-12 16:58:16.712', 3, 61751900, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25037', 3, 'common-two-step-process:1:4', '5001', '5003', 'sid-0E61FFFA-C833-4913-9373-288089A3E94D', '25038', NULL, '申请确认', 'userTask', 'user1', '2023-03-12 16:58:10.562', '2023-03-12 17:00:39.917', 2, 149355, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25023', 3, 'common-two-step-process:1:4', '2508', '2510', 'sid-0E61FFFA-C833-4913-9373-288089A3E94D', '25024', NULL, '申请确认', 'userTask', 'user3', '2023-03-12 16:58:06.291', '2023-03-12 17:01:32.946', 2, 206655, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25087', 3, 'common-two-step-process:1:4', '5001', '5003', 'sid-9FC691DE-5266-4565-B273-E25382A885EA', '25088', NULL, '最终审批', 'userTask', 'user1', '2023-03-12 17:00:39.918', '2023-03-12 17:03:26.359', 4, 166441, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25099', 1, 'common-two-step-process:1:4', '10016', '10017', 'sid-4DB79158-121B-455C-8878-93B522780282', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 17:01:16.063', '2023-03-12 17:01:16.063', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25069', 1, 'common-two-step-process:1:4', '2501', '2503', 'sid-4DB79158-121B-455C-8878-93B522780282', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 17:00:28.099', '2023-03-12 17:00:28.099', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25070', 1, 'common-two-step-process:1:4', '2501', '2503', 'sid-D9EE284B-F335-43D7-91C2-638064976B84', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-03-12 17:00:28.099', '2023-03-12 17:00:28.099', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25071', 1, 'common-two-step-process:1:4', '2501', '2503', 'sid-20EF2924-77BD-411D-B6F6-566DC17EDBE9', NULL, NULL, '确认提交', 'sequenceFlow', NULL, '2023-03-12 17:00:28.099', '2023-03-12 17:00:28.099', 3, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25085', 1, 'common-two-step-process:1:4', '5001', '5003', 'sid-D9EE284B-F335-43D7-91C2-638064976B84', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-03-12 17:00:39.917', '2023-03-12 17:00:39.917', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25086', 1, 'common-two-step-process:1:4', '5001', '5003', 'sid-20EF2924-77BD-411D-B6F6-566DC17EDBE9', NULL, NULL, '确认提交', 'sequenceFlow', NULL, '2023-03-12 17:00:39.917', '2023-03-12 17:00:39.917', 3, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25100', 1, 'common-two-step-process:1:4', '10016', '10017', 'sid-D9EE284B-F335-43D7-91C2-638064976B84', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-03-12 17:01:16.063', '2023-03-12 17:01:16.063', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25072', 3, 'common-two-step-process:1:4', '2501', '2503', 'sid-9FC691DE-5266-4565-B273-E25382A885EA', '25073', NULL, '最终审批', 'userTask', 'user1', '2023-03-12 17:00:28.099', '2023-03-12 17:03:06.845', 4, 158746, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25101', 1, 'common-two-step-process:1:4', '10016', '10017', 'sid-20EF2924-77BD-411D-B6F6-566DC17EDBE9', NULL, NULL, '确认提交', 'sequenceFlow', NULL, '2023-03-12 17:01:16.063', '2023-03-12 17:01:16.063', 3, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25049', 3, 'common-two-step-process:1:4', '10016', '10017', 'sid-0E61FFFA-C833-4913-9373-288089A3E94D', '25050', NULL, '申请确认', 'userTask', 'user2', '2023-03-12 16:58:16.712', '2023-03-12 17:01:16.062', 2, 179350, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25114', 1, 'common-two-step-process:1:4', '2508', '2510', 'sid-4DB79158-121B-455C-8878-93B522780282', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 17:01:32.946', '2023-03-12 17:01:32.946', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25115', 1, 'common-two-step-process:1:4', '2508', '2510', 'sid-D9EE284B-F335-43D7-91C2-638064976B84', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-03-12 17:01:32.946', '2023-03-12 17:01:32.946', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25116', 1, 'common-two-step-process:1:4', '2508', '2510', 'sid-20EF2924-77BD-411D-B6F6-566DC17EDBE9', NULL, NULL, '确认提交', 'sequenceFlow', NULL, '2023-03-12 17:01:32.946', '2023-03-12 17:01:32.946', 3, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25197', 3, 'common-two-step-process:1:4', '25156', '25157', 'sid-0E61FFFA-C833-4913-9373-288089A3E94D', '25198', NULL, '申请确认', 'userTask', 'user2', '2023-03-12 17:07:15.807', '2023-03-12 17:08:05.528', 2, 49721, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25196', 1, 'common-two-step-process:1:4', '25156', '25157', 'sid-068DD5AE-B01B-4C9D-9E1F-37609E5E7C73', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 17:07:15.807', '2023-03-12 17:07:15.807', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25136', 1, 'common-two-step-process:1:4', '2501', '2503', 'sid-7DD73C5F-C191-4951-B312-F4B17F7FD548', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 17:03:06.845', '2023-03-12 17:03:06.845', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25137', 1, 'common-two-step-process:1:4', '2501', '2503', 'sid-04BCFFDA-6CC6-4F39-BFE4-BC1512BA6586', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-03-12 17:03:06.845', '2023-03-12 17:03:06.846', 2, 1, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25138', 1, 'common-two-step-process:1:4', '2501', '2503', 'sid-935B6B16-2B42-4955-B88C-E8C44A5830C9', NULL, NULL, '审批通过', 'sequenceFlow', NULL, '2023-03-12 17:03:06.846', '2023-03-12 17:03:06.846', 3, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25139', 1, 'common-two-step-process:1:4', '2501', '2503', 'sid-ACAAA6F3-D139-44E4-A50F-53F41941BB27', NULL, NULL, '结束', 'endEvent', NULL, '2023-03-12 17:03:06.846', '2023-03-12 17:03:06.846', 4, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25141', 1, 'common-two-step-process:1:4', '5001', '5003', 'sid-7DD73C5F-C191-4951-B312-F4B17F7FD548', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 17:03:26.359', '2023-03-12 17:03:26.359', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25142', 1, 'common-two-step-process:1:4', '5001', '5003', 'sid-04BCFFDA-6CC6-4F39-BFE4-BC1512BA6586', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-03-12 17:03:26.359', '2023-03-12 17:03:26.359', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25143', 1, 'common-two-step-process:1:4', '5001', '5003', 'sid-935B6B16-2B42-4955-B88C-E8C44A5830C9', NULL, NULL, '审批通过', 'sequenceFlow', NULL, '2023-03-12 17:03:26.359', '2023-03-12 17:03:26.359', 3, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25144', 1, 'common-two-step-process:1:4', '5001', '5003', 'sid-ACAAA6F3-D139-44E4-A50F-53F41941BB27', NULL, NULL, '结束', 'endEvent', NULL, '2023-03-12 17:03:26.359', '2023-03-12 17:03:26.359', 4, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25147', 1, 'common-two-step-process:1:4', '2508', '2510', 'sid-7DD73C5F-C191-4951-B312-F4B17F7FD548', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 17:03:53.304', '2023-03-12 17:03:53.304', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25148', 1, 'common-two-step-process:1:4', '2508', '2510', 'sid-04BCFFDA-6CC6-4F39-BFE4-BC1512BA6586', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-03-12 17:03:53.304', '2023-03-12 17:03:53.304', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25149', 1, 'common-two-step-process:1:4', '2508', '2510', 'sid-935B6B16-2B42-4955-B88C-E8C44A5830C9', NULL, NULL, '审批通过', 'sequenceFlow', NULL, '2023-03-12 17:03:53.304', '2023-03-12 17:03:53.304', 3, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25150', 1, 'common-two-step-process:1:4', '2508', '2510', 'sid-ACAAA6F3-D139-44E4-A50F-53F41941BB27', NULL, NULL, '结束', 'endEvent', NULL, '2023-03-12 17:03:53.304', '2023-03-12 17:03:53.304', 4, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25117', 3, 'common-two-step-process:1:4', '2508', '2510', 'sid-9FC691DE-5266-4565-B273-E25382A885EA', '25118', NULL, '最终审批', 'userTask', 'user1', '2023-03-12 17:01:32.946', '2023-03-12 17:03:53.303', 4, 140357, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25152', 1, 'common-two-step-process:1:4', '10016', '10017', 'sid-7DD73C5F-C191-4951-B312-F4B17F7FD548', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 17:03:59.391', '2023-03-12 17:03:59.391', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25153', 1, 'common-two-step-process:1:4', '10016', '10017', 'sid-04BCFFDA-6CC6-4F39-BFE4-BC1512BA6586', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-03-12 17:03:59.391', '2023-03-12 17:03:59.391', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25154', 1, 'common-two-step-process:1:4', '10016', '10017', 'sid-935B6B16-2B42-4955-B88C-E8C44A5830C9', NULL, NULL, '审批通过', 'sequenceFlow', NULL, '2023-03-12 17:03:59.391', '2023-03-12 17:03:59.391', 3, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25155', 1, 'common-two-step-process:1:4', '10016', '10017', 'sid-ACAAA6F3-D139-44E4-A50F-53F41941BB27', NULL, NULL, '结束', 'endEvent', NULL, '2023-03-12 17:03:59.391', '2023-03-12 17:03:59.391', 4, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25102', 3, 'common-two-step-process:1:4', '10016', '10017', 'sid-9FC691DE-5266-4565-B273-E25382A885EA', '25103', NULL, '最终审批', 'userTask', 'user1', '2023-03-12 17:01:16.063', '2023-03-12 17:03:59.391', 4, 163328, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25158', 1, 'common-two-step-process:1:4', '25156', '25157', 'startEvent1', NULL, NULL, '开始', 'startEvent', NULL, '2023-03-12 17:04:45.092', '2023-03-12 17:04:45.092', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25159', 1, 'common-two-step-process:1:4', '25156', '25157', 'sid-C4B1375B-80A4-46C4-AA6F-4034285ED6A7', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 17:04:45.092', '2023-03-12 17:04:45.092', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25166', 1, 'common-two-step-process:1:4', '25156', '25157', 'sid-068DD5AE-B01B-4C9D-9E1F-37609E5E7C73', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 17:04:45.106', '2023-03-12 17:04:45.106', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25160', 3, 'common-two-step-process:1:4', '25156', '25157', 'sid-3C5BA0E2-E45E-42B8-BB35-6BD1657604F0', '25161', NULL, '提交申请', 'userTask', 'user1', '2023-03-12 17:04:45.092', '2023-03-12 17:04:45.106', 3, 14, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25186', 3, 'common-two-step-process:1:4', '25156', '25157', 'sid-3C5BA0E2-E45E-42B8-BB35-6BD1657604F0', '25187', NULL, '提交申请', 'userTask', 'user2', '2023-03-12 17:06:29.777', '2023-03-12 17:07:15.807', 4, 46030, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25183', 1, 'common-two-step-process:1:4', '25156', '25157', 'sid-4DB79158-121B-455C-8878-93B522780282', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 17:06:29.777', '2023-03-12 17:06:29.777', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25184', 1, 'common-two-step-process:1:4', '25156', '25157', 'sid-D9EE284B-F335-43D7-91C2-638064976B84', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-03-12 17:06:29.777', '2023-03-12 17:06:29.777', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25185', 1, 'common-two-step-process:1:4', '25156', '25157', 'sid-45C5F117-12F1-4B45-B31D-6FCFA1519798', NULL, NULL, '退回申请', 'sequenceFlow', NULL, '2023-03-12 17:06:29.777', '2023-03-12 17:06:29.777', 3, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25167', 3, 'common-two-step-process:1:4', '25156', '25157', 'sid-0E61FFFA-C833-4913-9373-288089A3E94D', '25168', NULL, '申请确认', 'userTask', 'user3', '2023-03-12 17:04:45.106', '2023-03-12 17:06:29.777', 2, 104671, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25208', 1, 'common-two-step-process:1:4', '25156', '25157', 'sid-4DB79158-121B-455C-8878-93B522780282', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 17:08:05.528', '2023-03-12 17:08:05.528', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25209', 1, 'common-two-step-process:1:4', '25156', '25157', 'sid-D9EE284B-F335-43D7-91C2-638064976B84', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-03-12 17:08:05.528', '2023-03-12 17:08:05.528', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25210', 1, 'common-two-step-process:1:4', '25156', '25157', 'sid-20EF2924-77BD-411D-B6F6-566DC17EDBE9', NULL, NULL, '确认提交', 'sequenceFlow', NULL, '2023-03-12 17:08:05.528', '2023-03-12 17:08:05.528', 3, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25224', 1, 'common-two-step-process:1:4', '25156', '25157', 'sid-7DD73C5F-C191-4951-B312-F4B17F7FD548', NULL, NULL, NULL, 'sequenceFlow', NULL, '2023-03-12 17:08:56.476', '2023-03-12 17:08:56.476', 1, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25225', 1, 'common-two-step-process:1:4', '25156', '25157', 'sid-04BCFFDA-6CC6-4F39-BFE4-BC1512BA6586', NULL, NULL, NULL, 'exclusiveGateway', NULL, '2023-03-12 17:08:56.477', '2023-03-12 17:08:56.477', 2, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25226', 1, 'common-two-step-process:1:4', '25156', '25157', 'sid-FB1C8CAE-09D1-43C5-96ED-28EAF9973832', NULL, NULL, '审批拒绝', 'sequenceFlow', NULL, '2023-03-12 17:08:56.477', '2023-03-12 17:08:56.477', 3, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25227', 1, 'common-two-step-process:1:4', '25156', '25157', 'sid-8A0DF56A-BFBD-4E98-9ED1-6037A2A8CC85', NULL, NULL, '结束', 'endEvent', NULL, '2023-03-12 17:08:56.477', '2023-03-12 17:08:56.477', 4, 0, NULL, '');
INSERT INTO flow.act_hi_actinst (id_, rev_, proc_def_id_, proc_inst_id_, execution_id_, act_id_, task_id_, call_proc_inst_id_, act_name_, act_type_, assignee_, start_time_, end_time_, transaction_order_, duration_, delete_reason_, tenant_id_) VALUES ('25211', 3, 'common-two-step-process:1:4', '25156', '25157', 'sid-9FC691DE-5266-4565-B273-E25382A885EA', '25212', NULL, '最终审批', 'userTask', 'user1', '2023-03-12 17:08:05.528', '2023-03-12 17:08:56.476', 4, 50948, NULL, '');


--
-- Data for Name: act_hi_attachment; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_hi_comment; Type: TABLE DATA; Schema: flow; Owner: pineapple
--

INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('5010', 'event', '2023-03-11 00:35:46.501', NULL, '5007', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('5013', 'event', '2023-03-11 00:35:47.1', NULL, '5007', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('5016', 'event', '2023-03-11 00:35:51.477', NULL, '5007', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('7502', 'event', '2023-03-11 00:52:27.709', NULL, '5007', NULL, 'AddUserLink', 'user3_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('10009', 'event', '2023-03-11 23:47:27.561', NULL, '10006', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('10012', 'event', '2023-03-11 23:47:27.58', NULL, '10006', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('10015', 'event', '2023-03-11 23:47:27.586', NULL, '10006', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('10024', 'event', '2023-03-11 23:49:04.817', NULL, '10021', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('10027', 'event', '2023-03-11 23:49:04.822', NULL, '10021', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('10030', 'event', '2023-03-11 23:49:04.828', NULL, '10021', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('10032', 'event', '2023-03-11 23:49:41.997', NULL, '10021', NULL, 'AddUserLink', 'user1_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('10034', 'event', '2023-03-11 23:49:53.747', NULL, '10006', NULL, 'AddUserLink', 'user1_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('15008', 'event', '2023-03-12 16:26:17.324', NULL, '15004', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('15010', 'event', '2023-03-12 16:26:17.333', NULL, '15004', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('15012', 'event', '2023-03-12 16:26:17.338', NULL, '15004', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('17502', 'event', '2023-03-12 16:45:00.012', NULL, '15004', NULL, 'AddUserLink', 'user2_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('22511', 'event', '2023-03-12 16:48:59.729', NULL, '22507', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('22513', 'event', '2023-03-12 16:48:59.741', NULL, '22507', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('22515', 'event', '2023-03-12 16:48:59.746', NULL, '22507', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25002', 'event', '2023-03-12 16:55:42.617', NULL, '22507', NULL, 'AddUserLink', 'user3_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25015', 'event', '2023-03-12 16:57:47.591', NULL, '25010', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25018', 'event', '2023-03-12 16:57:47.595', NULL, '25010', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25021', 'event', '2023-03-12 16:57:47.602', NULL, '25010', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25029', 'event', '2023-03-12 16:58:06.301', NULL, '25024', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25032', 'event', '2023-03-12 16:58:06.305', NULL, '25024', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25035', 'event', '2023-03-12 16:58:06.308', NULL, '25024', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25042', 'event', '2023-03-12 16:58:10.572', NULL, '25038', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25044', 'event', '2023-03-12 16:58:10.576', NULL, '25038', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25046', 'event', '2023-03-12 16:58:10.579', NULL, '25038', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25054', 'event', '2023-03-12 16:58:16.724', NULL, '25050', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25056', 'event', '2023-03-12 16:58:16.725', NULL, '25050', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25058', 'event', '2023-03-12 16:58:16.725', NULL, '25050', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25060', 'event', '2023-03-12 16:58:39.247', NULL, '25010', NULL, 'AddUserLink', 'user1_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25062', 'event', '2023-03-12 16:59:01.015', NULL, '25050', NULL, 'AddUserLink', 'user2_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25064', 'event', '2023-03-12 16:59:07.524', NULL, '25024', NULL, 'AddUserLink', 'user3_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25066', 'event', '2023-03-12 16:59:15.675', NULL, '25038', NULL, 'AddUserLink', 'user1_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25077', 'event', '2023-03-12 17:00:28.124', NULL, '25073', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25079', 'event', '2023-03-12 17:00:28.127', NULL, '25073', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25081', 'event', '2023-03-12 17:00:28.13', NULL, '25073', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25092', 'event', '2023-03-12 17:00:39.925', NULL, '25088', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25094', 'event', '2023-03-12 17:00:39.925', NULL, '25088', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25096', 'event', '2023-03-12 17:00:39.931', NULL, '25088', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25107', 'event', '2023-03-12 17:01:16.075', NULL, '25103', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25109', 'event', '2023-03-12 17:01:16.075', NULL, '25103', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25111', 'event', '2023-03-12 17:01:16.075', NULL, '25103', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25122', 'event', '2023-03-12 17:01:32.96', NULL, '25118', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25124', 'event', '2023-03-12 17:01:32.962', NULL, '25118', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25126', 'event', '2023-03-12 17:01:32.964', NULL, '25118', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25128', 'event', '2023-03-12 17:01:57.605', NULL, '25073', NULL, 'AddUserLink', 'user1_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25130', 'event', '2023-03-12 17:02:05.4', NULL, '25088', NULL, 'AddUserLink', 'user1_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25132', 'event', '2023-03-12 17:02:13.532', NULL, '25103', NULL, 'AddUserLink', 'user1_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25134', 'event', '2023-03-12 17:02:22.135', NULL, '25118', NULL, 'AddUserLink', 'user1_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25145', 'event', '2023-03-12 17:03:40.681', NULL, '25103', NULL, 'AddUserLink', 'user1_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25164', 'event', '2023-03-12 17:04:45.101', NULL, '25161', NULL, 'AddUserLink', 'user1_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25172', 'event', '2023-03-12 17:04:45.111', NULL, '25168', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25175', 'event', '2023-03-12 17:04:45.118', NULL, '25168', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25178', 'event', '2023-03-12 17:04:45.118', NULL, '25168', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25180', 'event', '2023-03-12 17:05:24.042', NULL, '25168', NULL, 'AddUserLink', 'user3_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25189', 'event', '2023-03-12 17:06:29.788', NULL, '25187', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25191', 'event', '2023-03-12 17:06:29.788', NULL, '25187', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25193', 'event', '2023-03-12 17:06:29.788', NULL, '25187', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25195', 'event', '2023-03-12 17:07:03.523', NULL, '25187', NULL, 'AddUserLink', 'user2_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25201', 'event', '2023-03-12 17:07:15.813', NULL, '25198', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25203', 'event', '2023-03-12 17:07:15.813', NULL, '25198', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25205', 'event', '2023-03-12 17:07:15.813', NULL, '25198', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25207', 'event', '2023-03-12 17:08:03.128', NULL, '25198', NULL, 'AddUserLink', 'user2_|_assignee', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25216', 'event', '2023-03-12 17:08:05.534', NULL, '25212', NULL, 'AddUserLink', 'user1_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25218', 'event', '2023-03-12 17:08:05.534', NULL, '25212', NULL, 'AddUserLink', 'user2_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25220', 'event', '2023-03-12 17:08:05.54', NULL, '25212', NULL, 'AddUserLink', 'user3_|_candidate', NULL);
INSERT INTO flow.act_hi_comment (id_, type_, time_, user_id_, task_id_, proc_inst_id_, action_, message_, full_msg_) VALUES ('25222', 'event', '2023-03-12 17:08:33.861', NULL, '25212', NULL, 'AddUserLink', 'user1_|_assignee', NULL);


--
-- Data for Name: act_hi_detail; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_hi_entitylink; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_hi_identitylink; Type: TABLE DATA; Schema: flow; Owner: pineapple
--

INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('5008', NULL, 'candidate', 'user1', '5007', '2023-03-11 00:35:46.488', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('5009', NULL, 'participant', 'user1', NULL, '2023-03-11 00:35:46.501', '5001', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('5011', NULL, 'candidate', 'user2', '5007', '2023-03-11 00:35:47.089', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('5012', NULL, 'participant', 'user2', NULL, '2023-03-11 00:35:47.1', '5001', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('5014', NULL, 'candidate', 'user3', '5007', '2023-03-11 00:35:51.469', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('5015', NULL, 'participant', 'user3', NULL, '2023-03-11 00:35:51.477', '5001', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('7501', NULL, 'assignee', 'user3', '5007', '2023-03-11 00:52:27.642', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('10007', NULL, 'candidate', 'user1', '10006', '2023-03-11 23:47:27.555', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('10008', NULL, 'participant', 'user1', NULL, '2023-03-11 23:47:27.561', '10001', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('10010', NULL, 'candidate', 'user2', '10006', '2023-03-11 23:47:27.574', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('10011', NULL, 'participant', 'user2', NULL, '2023-03-11 23:47:27.58', '10001', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('10013', NULL, 'candidate', 'user3', '10006', '2023-03-11 23:47:27.586', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('10014', NULL, 'participant', 'user3', NULL, '2023-03-11 23:47:27.586', '10001', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('10022', NULL, 'candidate', 'user1', '10021', '2023-03-11 23:49:04.817', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('10023', NULL, 'participant', 'user1', NULL, '2023-03-11 23:49:04.817', '10016', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('10025', NULL, 'candidate', 'user2', '10021', '2023-03-11 23:49:04.822', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('10026', NULL, 'participant', 'user2', NULL, '2023-03-11 23:49:04.822', '10016', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('10028', NULL, 'candidate', 'user3', '10021', '2023-03-11 23:49:04.822', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('10029', NULL, 'participant', 'user3', NULL, '2023-03-11 23:49:04.828', '10016', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('10031', NULL, 'assignee', 'user1', '10021', '2023-03-11 23:49:41.995', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('10033', NULL, 'assignee', 'user1', '10006', '2023-03-11 23:49:53.745', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('15005', NULL, 'candidate', 'roleTest', '15004', '2023-03-12 16:26:17.283', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('15006', NULL, 'participant', 'roleTest', NULL, '2023-03-12 16:26:17.284', '10001', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('15007', NULL, 'candidate', 'user1', '15004', '2023-03-12 16:26:17.323', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('15009', NULL, 'candidate', 'user2', '15004', '2023-03-12 16:26:17.328', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('15011', NULL, 'candidate', 'user3', '15004', '2023-03-12 16:26:17.336', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('17501', NULL, 'assignee', 'user2', '15004', '2023-03-12 16:44:59.945', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('22508', NULL, 'candidate', 'approveRole', '22507', '2023-03-12 16:48:59.698', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('22509', NULL, 'participant', 'approveRole', NULL, '2023-03-12 16:48:59.698', '10001', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('22510', NULL, 'candidate', 'user1', '22507', '2023-03-12 16:48:59.729', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('22512', NULL, 'candidate', 'user2', '22507', '2023-03-12 16:48:59.736', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('22514', NULL, 'candidate', 'user3', '22507', '2023-03-12 16:48:59.742', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25001', NULL, 'assignee', 'user3', '22507', '2023-03-12 16:55:42.554', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25011', NULL, 'candidate', 'roleTest', '25010', '2023-03-12 16:57:47.577', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25012', NULL, 'participant', 'roleTest', NULL, '2023-03-12 16:57:47.577', '2501', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25013', NULL, 'candidate', 'user1', '25010', '2023-03-12 16:57:47.59', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25014', NULL, 'participant', 'user1', NULL, '2023-03-12 16:57:47.591', '2501', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25016', NULL, 'candidate', 'user2', '25010', '2023-03-12 16:57:47.591', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25017', NULL, 'participant', 'user2', NULL, '2023-03-12 16:57:47.595', '2501', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25019', NULL, 'candidate', 'user3', '25010', '2023-03-12 16:57:47.601', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25020', NULL, 'participant', 'user3', NULL, '2023-03-12 16:57:47.602', '2501', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25025', NULL, 'candidate', 'roleTest', '25024', '2023-03-12 16:58:06.292', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25026', NULL, 'participant', 'roleTest', NULL, '2023-03-12 16:58:06.292', '2508', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25027', NULL, 'candidate', 'user1', '25024', '2023-03-12 16:58:06.3', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25028', NULL, 'participant', 'user1', NULL, '2023-03-12 16:58:06.301', '2508', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25030', NULL, 'candidate', 'user2', '25024', '2023-03-12 16:58:06.304', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25031', NULL, 'participant', 'user2', NULL, '2023-03-12 16:58:06.305', '2508', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25033', NULL, 'candidate', 'user3', '25024', '2023-03-12 16:58:06.307', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25034', NULL, 'participant', 'user3', NULL, '2023-03-12 16:58:06.308', '2508', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25039', NULL, 'candidate', 'roleTest', '25038', '2023-03-12 16:58:10.562', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25040', NULL, 'participant', 'roleTest', NULL, '2023-03-12 16:58:10.562', '5001', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25041', NULL, 'candidate', 'user1', '25038', '2023-03-12 16:58:10.571', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25043', NULL, 'candidate', 'user2', '25038', '2023-03-12 16:58:10.575', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25045', NULL, 'candidate', 'user3', '25038', '2023-03-12 16:58:10.578', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25051', NULL, 'candidate', 'roleTest', '25050', '2023-03-12 16:58:16.712', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25052', NULL, 'participant', 'roleTest', NULL, '2023-03-12 16:58:16.712', '10016', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25053', NULL, 'candidate', 'user1', '25050', '2023-03-12 16:58:16.712', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25055', NULL, 'candidate', 'user2', '25050', '2023-03-12 16:58:16.725', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25057', NULL, 'candidate', 'user3', '25050', '2023-03-12 16:58:16.725', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25059', NULL, 'assignee', 'user1', '25010', '2023-03-12 16:58:39.245', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25061', NULL, 'assignee', 'user2', '25050', '2023-03-12 16:59:01.014', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25063', NULL, 'assignee', 'user3', '25024', '2023-03-12 16:59:07.524', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25065', NULL, 'assignee', 'user1', '25038', '2023-03-12 16:59:15.675', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25074', NULL, 'candidate', 'approveRole', '25073', '2023-03-12 17:00:28.104', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25075', NULL, 'participant', 'approveRole', NULL, '2023-03-12 17:00:28.104', '2501', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25076', NULL, 'candidate', 'user1', '25073', '2023-03-12 17:00:28.124', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25078', NULL, 'candidate', 'user2', '25073', '2023-03-12 17:00:28.127', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25080', NULL, 'candidate', 'user3', '25073', '2023-03-12 17:00:28.129', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25089', NULL, 'candidate', 'approveRole', '25088', '2023-03-12 17:00:39.918', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25090', NULL, 'participant', 'approveRole', NULL, '2023-03-12 17:00:39.918', '5001', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25091', NULL, 'candidate', 'user1', '25088', '2023-03-12 17:00:39.925', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25093', NULL, 'candidate', 'user2', '25088', '2023-03-12 17:00:39.925', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25095', NULL, 'candidate', 'user3', '25088', '2023-03-12 17:00:39.925', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25104', NULL, 'candidate', 'approveRole', '25103', '2023-03-12 17:01:16.063', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25105', NULL, 'participant', 'approveRole', NULL, '2023-03-12 17:01:16.064', '10016', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25106', NULL, 'candidate', 'user1', '25103', '2023-03-12 17:01:16.075', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25108', NULL, 'candidate', 'user2', '25103', '2023-03-12 17:01:16.075', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25110', NULL, 'candidate', 'user3', '25103', '2023-03-12 17:01:16.075', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25119', NULL, 'candidate', 'approveRole', '25118', '2023-03-12 17:01:32.946', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25120', NULL, 'participant', 'approveRole', NULL, '2023-03-12 17:01:32.946', '2508', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25121', NULL, 'candidate', 'user1', '25118', '2023-03-12 17:01:32.96', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25123', NULL, 'candidate', 'user2', '25118', '2023-03-12 17:01:32.962', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25125', NULL, 'candidate', 'user3', '25118', '2023-03-12 17:01:32.964', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25127', NULL, 'assignee', 'user1', '25073', '2023-03-12 17:01:57.605', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25129', NULL, 'assignee', 'user1', '25088', '2023-03-12 17:02:05.399', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25131', NULL, 'assignee', 'user1', '25103', '2023-03-12 17:02:13.532', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25133', NULL, 'assignee', 'user1', '25118', '2023-03-12 17:02:22.134', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25162', NULL, 'assignee', 'user1', '25161', '2023-03-12 17:04:45.099', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25163', NULL, 'participant', 'user1', NULL, '2023-03-12 17:04:45.101', '25156', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25169', NULL, 'candidate', 'roleTest', '25168', '2023-03-12 17:04:45.106', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25170', NULL, 'participant', 'roleTest', NULL, '2023-03-12 17:04:45.106', '25156', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25171', NULL, 'candidate', 'user1', '25168', '2023-03-12 17:04:45.111', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25173', NULL, 'candidate', 'user2', '25168', '2023-03-12 17:04:45.111', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25174', NULL, 'participant', 'user2', NULL, '2023-03-12 17:04:45.118', '25156', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25176', NULL, 'candidate', 'user3', '25168', '2023-03-12 17:04:45.118', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25177', NULL, 'participant', 'user3', NULL, '2023-03-12 17:04:45.118', '25156', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25179', NULL, 'assignee', 'user3', '25168', '2023-03-12 17:05:24.042', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25188', NULL, 'candidate', 'user1', '25187', '2023-03-12 17:06:29.788', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25190', NULL, 'candidate', 'user2', '25187', '2023-03-12 17:06:29.788', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25192', NULL, 'candidate', 'user3', '25187', '2023-03-12 17:06:29.788', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25194', NULL, 'assignee', 'user2', '25187', '2023-03-12 17:07:03.523', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25199', NULL, 'candidate', 'roleTest', '25198', '2023-03-12 17:07:15.807', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25200', NULL, 'candidate', 'user1', '25198', '2023-03-12 17:07:15.813', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25202', NULL, 'candidate', 'user2', '25198', '2023-03-12 17:07:15.813', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25204', NULL, 'candidate', 'user3', '25198', '2023-03-12 17:07:15.813', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25206', NULL, 'assignee', 'user2', '25198', '2023-03-12 17:08:03.128', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25217', NULL, 'candidate', 'user2', '25212', '2023-03-12 17:08:05.534', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25213', NULL, 'candidate', 'approveRole', '25212', '2023-03-12 17:08:05.528', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25214', NULL, 'participant', 'approveRole', NULL, '2023-03-12 17:08:05.528', '25156', NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25215', NULL, 'candidate', 'user1', '25212', '2023-03-12 17:08:05.534', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25219', NULL, 'candidate', 'user3', '25212', '2023-03-12 17:08:05.534', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_identitylink (id_, group_id_, type_, user_id_, task_id_, create_time_, proc_inst_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_) VALUES ('25221', NULL, 'assignee', 'user1', '25212', '2023-03-12 17:08:33.86', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: act_hi_procinst; Type: TABLE DATA; Schema: flow; Owner: pineapple
--

INSERT INTO flow.act_hi_procinst (id_, rev_, proc_inst_id_, business_key_, proc_def_id_, start_time_, end_time_, duration_, start_user_id_, start_act_id_, end_act_id_, super_process_instance_id_, delete_reason_, tenant_id_, name_, callback_id_, callback_type_, reference_id_, reference_type_) VALUES ('10001', 2, '10001', NULL, 'common-two-step-process:1:4', '2023-03-11 23:47:27.421', '2023-03-12 16:56:23.949', 61736528, NULL, 'startEvent1', 'sid-ACAAA6F3-D139-44E4-A50F-53F41941BB27', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_procinst (id_, rev_, proc_inst_id_, business_key_, proc_def_id_, start_time_, end_time_, duration_, start_user_id_, start_act_id_, end_act_id_, super_process_instance_id_, delete_reason_, tenant_id_, name_, callback_id_, callback_type_, reference_id_, reference_type_) VALUES ('2501', 2, '2501', NULL, 'common-two-step-process:1:4', '2023-03-11 00:23:10.742', '2023-03-12 17:03:06.855', 146396113, NULL, 'startEvent1', 'sid-ACAAA6F3-D139-44E4-A50F-53F41941BB27', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_procinst (id_, rev_, proc_inst_id_, business_key_, proc_def_id_, start_time_, end_time_, duration_, start_user_id_, start_act_id_, end_act_id_, super_process_instance_id_, delete_reason_, tenant_id_, name_, callback_id_, callback_type_, reference_id_, reference_type_) VALUES ('5001', 2, '5001', NULL, 'common-two-step-process:1:4', '2023-03-11 00:35:35.357', '2023-03-12 17:03:26.363', 145671006, NULL, 'startEvent1', 'sid-ACAAA6F3-D139-44E4-A50F-53F41941BB27', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_procinst (id_, rev_, proc_inst_id_, business_key_, proc_def_id_, start_time_, end_time_, duration_, start_user_id_, start_act_id_, end_act_id_, super_process_instance_id_, delete_reason_, tenant_id_, name_, callback_id_, callback_type_, reference_id_, reference_type_) VALUES ('2508', 2, '2508', NULL, 'common-two-step-process:1:4', '2023-03-11 00:27:04.681', '2023-03-12 17:03:53.304', 146208623, NULL, 'startEvent1', 'sid-ACAAA6F3-D139-44E4-A50F-53F41941BB27', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_procinst (id_, rev_, proc_inst_id_, business_key_, proc_def_id_, start_time_, end_time_, duration_, start_user_id_, start_act_id_, end_act_id_, super_process_instance_id_, delete_reason_, tenant_id_, name_, callback_id_, callback_type_, reference_id_, reference_type_) VALUES ('10016', 2, '10016', NULL, 'common-two-step-process:1:4', '2023-03-11 23:49:04.812', '2023-03-12 17:03:59.393', 62094581, NULL, 'startEvent1', 'sid-ACAAA6F3-D139-44E4-A50F-53F41941BB27', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO flow.act_hi_procinst (id_, rev_, proc_inst_id_, business_key_, proc_def_id_, start_time_, end_time_, duration_, start_user_id_, start_act_id_, end_act_id_, super_process_instance_id_, delete_reason_, tenant_id_, name_, callback_id_, callback_type_, reference_id_, reference_type_) VALUES ('25156', 2, '25156', NULL, 'common-two-step-process:1:4', '2023-03-12 17:04:45.092', '2023-03-12 17:08:56.48', 251388, NULL, 'startEvent1', 'sid-8A0DF56A-BFBD-4E98-9ED1-6037A2A8CC85', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL);


--
-- Data for Name: act_hi_taskinst; Type: TABLE DATA; Schema: flow; Owner: pineapple
--

INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('25118', 3, 'common-two-step-process:1:4', NULL, 'sid-9FC691DE-5266-4565-B273-E25382A885EA', '2508', '2510', NULL, NULL, NULL, NULL, NULL, '最终审批', NULL, NULL, NULL, 'user1', '2023-03-12 17:01:32.946', '2023-03-12 17:02:22.133', '2023-03-12 17:03:53.303', 140357, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 17:03:53.303');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('25103', 4, 'common-two-step-process:1:4', NULL, 'sid-9FC691DE-5266-4565-B273-E25382A885EA', '10016', '10017', NULL, NULL, NULL, NULL, NULL, '最终审批', NULL, NULL, NULL, 'user1', '2023-03-12 17:01:16.063', '2023-03-12 17:03:40.681', '2023-03-12 17:03:59.39', 163327, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 17:03:59.39');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('10006', 3, 'common-two-step-process:1:4', NULL, 'sid-3C5BA0E2-E45E-42B8-BB35-6BD1657604F0', '10001', '10002', NULL, NULL, NULL, NULL, NULL, '提交申请', NULL, NULL, NULL, 'user1', '2023-03-11 23:47:27.489', '2023-03-11 23:49:53.741', '2023-03-12 16:26:17.255', 59929766, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 16:26:17.255');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('15004', 3, 'common-two-step-process:1:4', NULL, 'sid-0E61FFFA-C833-4913-9373-288089A3E94D', '10001', '10002', NULL, NULL, NULL, NULL, NULL, '申请确认', NULL, NULL, NULL, 'user2', '2023-03-12 16:26:17.267', '2023-03-12 16:44:59.94', '2023-03-12 16:48:59.668', 1362401, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 16:48:59.668');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('22507', 3, 'common-two-step-process:1:4', NULL, 'sid-9FC691DE-5266-4565-B273-E25382A885EA', '10001', '10002', NULL, NULL, NULL, NULL, NULL, '最终审批', NULL, NULL, NULL, 'user3', '2023-03-12 16:48:59.698', '2023-03-12 16:55:42.546', '2023-03-12 16:56:23.884', 444186, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 16:56:23.884');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('2507', 2, 'common-two-step-process:1:4', NULL, 'sid-3C5BA0E2-E45E-42B8-BB35-6BD1657604F0', '2501', '2503', NULL, NULL, NULL, NULL, NULL, '提交申请', NULL, NULL, NULL, NULL, '2023-03-11 00:23:10.816', NULL, '2023-03-12 16:57:47.571', 146076755, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 16:57:47.571');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('2514', 2, 'common-two-step-process:1:4', NULL, 'sid-3C5BA0E2-E45E-42B8-BB35-6BD1657604F0', '2508', '2510', NULL, NULL, NULL, NULL, NULL, '提交申请', NULL, NULL, NULL, NULL, '2023-03-11 00:27:04.681', NULL, '2023-03-12 16:58:06.287', 145861606, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 16:58:06.287');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('5007', 3, 'common-two-step-process:1:4', NULL, 'sid-3C5BA0E2-E45E-42B8-BB35-6BD1657604F0', '5001', '5003', NULL, NULL, NULL, NULL, NULL, '提交申请', NULL, NULL, NULL, 'user3', '2023-03-11 00:35:35.436', '2023-03-11 00:52:27.631', '2023-03-12 16:58:10.56', 145355124, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 16:58:10.56');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('10021', 3, 'common-two-step-process:1:4', NULL, 'sid-3C5BA0E2-E45E-42B8-BB35-6BD1657604F0', '10016', '10017', NULL, NULL, NULL, NULL, NULL, '提交申请', NULL, NULL, NULL, 'user1', '2023-03-11 23:49:04.812', '2023-03-11 23:49:41.993', '2023-03-12 16:58:16.711', 61751899, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 16:58:16.711');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('25161', 3, 'common-two-step-process:1:4', NULL, 'sid-3C5BA0E2-E45E-42B8-BB35-6BD1657604F0', '25156', '25157', NULL, NULL, NULL, NULL, NULL, '提交申请', NULL, NULL, NULL, 'user1', '2023-03-12 17:04:45.092', NULL, '2023-03-12 17:04:45.106', 14, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 17:04:45.106');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('25010', 3, 'common-two-step-process:1:4', NULL, 'sid-0E61FFFA-C833-4913-9373-288089A3E94D', '2501', '2503', NULL, NULL, NULL, NULL, NULL, '申请确认', NULL, NULL, NULL, 'user1', '2023-03-12 16:57:47.575', '2023-03-12 16:58:39.244', '2023-03-12 17:00:28.097', 160522, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 17:00:28.097');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('25038', 3, 'common-two-step-process:1:4', NULL, 'sid-0E61FFFA-C833-4913-9373-288089A3E94D', '5001', '5003', NULL, NULL, NULL, NULL, NULL, '申请确认', NULL, NULL, NULL, 'user1', '2023-03-12 16:58:10.562', '2023-03-12 16:59:15.674', '2023-03-12 17:00:39.915', 149353, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 17:00:39.915');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('25050', 3, 'common-two-step-process:1:4', NULL, 'sid-0E61FFFA-C833-4913-9373-288089A3E94D', '10016', '10017', NULL, NULL, NULL, NULL, NULL, '申请确认', NULL, NULL, NULL, 'user2', '2023-03-12 16:58:16.712', '2023-03-12 16:59:01.013', '2023-03-12 17:01:16.059', 179347, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 17:01:16.059');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('25024', 3, 'common-two-step-process:1:4', NULL, 'sid-0E61FFFA-C833-4913-9373-288089A3E94D', '2508', '2510', NULL, NULL, NULL, NULL, NULL, '申请确认', NULL, NULL, NULL, 'user3', '2023-03-12 16:58:06.291', '2023-03-12 16:59:07.522', '2023-03-12 17:01:32.944', 206653, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 17:01:32.944');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('25168', 3, 'common-two-step-process:1:4', NULL, 'sid-0E61FFFA-C833-4913-9373-288089A3E94D', '25156', '25157', NULL, NULL, NULL, NULL, NULL, '申请确认', NULL, NULL, NULL, 'user3', '2023-03-12 17:04:45.106', '2023-03-12 17:05:24.041', '2023-03-12 17:06:29.777', 104671, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 17:06:29.777');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('25073', 3, 'common-two-step-process:1:4', NULL, 'sid-9FC691DE-5266-4565-B273-E25382A885EA', '2501', '2503', NULL, NULL, NULL, NULL, NULL, '最终审批', NULL, NULL, NULL, 'user1', '2023-03-12 17:00:28.099', '2023-03-12 17:01:57.604', '2023-03-12 17:03:06.844', 158745, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 17:03:06.844');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('25088', 3, 'common-two-step-process:1:4', NULL, 'sid-9FC691DE-5266-4565-B273-E25382A885EA', '5001', '5003', NULL, NULL, NULL, NULL, NULL, '最终审批', NULL, NULL, NULL, 'user1', '2023-03-12 17:00:39.918', '2023-03-12 17:02:05.396', '2023-03-12 17:03:26.359', 166441, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 17:03:26.359');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('25187', 3, 'common-two-step-process:1:4', NULL, 'sid-3C5BA0E2-E45E-42B8-BB35-6BD1657604F0', '25156', '25157', NULL, NULL, NULL, NULL, NULL, '提交申请', NULL, NULL, NULL, 'user2', '2023-03-12 17:06:29.777', '2023-03-12 17:07:03.522', '2023-03-12 17:07:15.806', 46029, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 17:07:15.806');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('25198', 3, 'common-two-step-process:1:4', NULL, 'sid-0E61FFFA-C833-4913-9373-288089A3E94D', '25156', '25157', NULL, NULL, NULL, NULL, NULL, '申请确认', NULL, NULL, NULL, 'user2', '2023-03-12 17:07:15.807', '2023-03-12 17:08:03.126', '2023-03-12 17:08:05.524', 49717, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 17:08:05.524');
INSERT INTO flow.act_hi_taskinst (id_, rev_, proc_def_id_, task_def_id_, task_def_key_, proc_inst_id_, execution_id_, scope_id_, sub_scope_id_, scope_type_, scope_definition_id_, propagated_stage_inst_id_, name_, parent_task_id_, description_, owner_, assignee_, start_time_, claim_time_, end_time_, duration_, delete_reason_, priority_, due_date_, form_key_, category_, tenant_id_, last_updated_time_) VALUES ('25212', 3, 'common-two-step-process:1:4', NULL, 'sid-9FC691DE-5266-4565-B273-E25382A885EA', '25156', '25157', NULL, NULL, NULL, NULL, NULL, '最终审批', NULL, NULL, NULL, 'user1', '2023-03-12 17:08:05.528', '2023-03-12 17:08:33.859', '2023-03-12 17:08:56.47', 50942, NULL, 50, NULL, NULL, NULL, '', '2023-03-12 17:08:56.47');


--
-- Data for Name: act_hi_tsk_log; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_hi_varinst; Type: TABLE DATA; Schema: flow; Owner: pineapple
--

INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('15001', 0, '10001', '10001', NULL, 'confirmRole', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'roleTest', NULL, '2023-03-12 16:26:17.251', '2023-03-12 16:26:17.251');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('22501', 0, '10001', '10001', NULL, 'confirm', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'pass', NULL, '2023-03-12 16:48:59.662', '2023-03-12 16:48:59.662');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('22502', 0, '10001', '10001', NULL, 'approveRole', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'approveRole', NULL, '2023-03-12 16:48:59.662', '2023-03-12 16:48:59.662');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25003', 0, '10001', '10001', NULL, 'approve', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'pass', NULL, '2023-03-12 16:56:23.882', '2023-03-12 16:56:23.882');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('2502', 1, '2501', '2501', NULL, 'confirmRole', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'roleTest', NULL, '2023-03-11 00:23:10.81', '2023-03-12 16:57:47.57');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('2509', 1, '2508', '2508', NULL, 'confirmRole', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'roleTest', NULL, '2023-03-11 00:27:04.681', '2023-03-12 16:58:06.285');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('5002', 1, '5001', '5001', NULL, 'confirmRole', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'roleTest', NULL, '2023-03-11 00:35:35.43', '2023-03-12 16:58:10.56');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25047', 0, '10016', '10016', NULL, 'confirmRole', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'roleTest', NULL, '2023-03-12 16:58:16.71', '2023-03-12 16:58:16.71');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25067', 0, '2501', '2501', NULL, 'confirm', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'pass', NULL, '2023-03-12 17:00:28.097', '2023-03-12 17:00:28.097');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25068', 0, '2501', '2501', NULL, 'approveRole', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'approveRole', NULL, '2023-03-12 17:00:28.097', '2023-03-12 17:00:28.097');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25082', 0, '5001', '5001', NULL, 'confirm', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'pass', NULL, '2023-03-12 17:00:39.915', '2023-03-12 17:00:39.915');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25083', 0, '5001', '5001', NULL, 'approveRole', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'approveRole', NULL, '2023-03-12 17:00:39.915', '2023-03-12 17:00:39.915');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25097', 0, '10016', '10016', NULL, 'confirm', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'pass', NULL, '2023-03-12 17:01:16.059', '2023-03-12 17:01:16.059');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25098', 0, '10016', '10016', NULL, 'approveRole', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'approveRole', NULL, '2023-03-12 17:01:16.059', '2023-03-12 17:01:16.059');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25112', 0, '2508', '2508', NULL, 'confirm', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'pass', NULL, '2023-03-12 17:01:32.944', '2023-03-12 17:01:32.944');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25113', 0, '2508', '2508', NULL, 'approveRole', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'approveRole', NULL, '2023-03-12 17:01:32.944', '2023-03-12 17:01:32.944');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25135', 0, '2501', '2501', NULL, 'approve', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'pass', NULL, '2023-03-12 17:03:06.844', '2023-03-12 17:03:06.844');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25140', 0, '5001', '5001', NULL, 'approve', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'pass', NULL, '2023-03-12 17:03:26.358', '2023-03-12 17:03:26.358');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25146', 0, '2508', '2508', NULL, 'approve', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'pass', NULL, '2023-03-12 17:03:53.302', '2023-03-12 17:03:53.302');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25151', 0, '10016', '10016', NULL, 'approve', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'pass', NULL, '2023-03-12 17:03:59.39', '2023-03-12 17:03:59.39');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25165', 0, '25156', '25156', NULL, 'confirmRole', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'roleTest', NULL, '2023-03-12 17:04:45.106', '2023-03-12 17:04:45.106');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25182', 2, '25156', '25156', NULL, 'approveRole', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'approveRole', NULL, '2023-03-12 17:06:29.777', '2023-03-12 17:08:05.524');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25181', 2, '25156', '25156', NULL, 'confirm', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'pass', NULL, '2023-03-12 17:06:29.777', '2023-03-12 17:08:05.524');
INSERT INTO flow.act_hi_varinst (id_, rev_, proc_inst_id_, execution_id_, task_id_, name_, var_type_, scope_id_, sub_scope_id_, scope_type_, bytearray_id_, double_, long_, text_, text2_, create_time_, last_updated_time_) VALUES ('25223', 0, '25156', '25156', NULL, 'approve', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'reject', NULL, '2023-03-12 17:08:56.47', '2023-03-12 17:08:56.47');


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

INSERT INTO flow.act_re_deployment (id_, name_, category_, key_, tenant_id_, deploy_time_, derived_from_, derived_from_root_, parent_deployment_id_, engine_version_) VALUES ('1', '通用两步审核流程', NULL, 'common-two-step-process', '', '2023-03-11 00:09:05.357', NULL, NULL, '1', NULL);


--
-- Data for Name: act_re_model; Type: TABLE DATA; Schema: flow; Owner: pineapple
--



--
-- Data for Name: act_re_procdef; Type: TABLE DATA; Schema: flow; Owner: pineapple
--

INSERT INTO flow.act_re_procdef (id_, rev_, category_, name_, key_, version_, deployment_id_, resource_name_, dgrm_resource_name_, description_, has_start_form_key_, has_graphical_notation_, suspension_state_, tenant_id_, derived_from_, derived_from_root_, derived_version_, engine_version_) VALUES ('common-two-step-process:1:4', 1, 'http://www.flowable.org/processdef', '通用两步审核流程', 'common-two-step-process', 1, '1', 'flows/common-two-step-processc.bpmn20.xml', 'flows/common-two-step-processc.common-two-step-process.png', '通用两步审核流程', false, true, 1, '', NULL, NULL, 0, NULL);


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

INSERT INTO flow.flw_ev_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-11 00:05:28.987663', 1, 'EXECUTED', '8:1b0c48c9cf7945be799d868a2626d687', 'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...', '', NULL, '4.9.1', NULL, NULL, '8464328918');


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

INSERT INTO public.act_app_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2023-03-10 23:33:03.083735', 1, 'EXECUTED', '8:496fc778bdf2ab13f2e1926d0e63e0a2', 'createTable tableName=ACT_APP_DEPLOYMENT; createTable tableName=ACT_APP_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_APP_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_APP_RSRC_DPL, referencedTableName=ACT_APP_DEPLOYMENT; createIndex...', '', NULL, '4.9.1', NULL, NULL, '8462383061');
INSERT INTO public.act_app_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3', 'flowable', 'org/flowable/app/db/liquibase/flowable-app-db-changelog.xml', '2023-03-10 23:33:03.087518', 2, 'EXECUTED', '8:f1f8aff320aade831944ebad24355f3d', 'createIndex indexName=ACT_IDX_APP_DEF_UNIQ, tableName=ACT_APP_APPDEF', '', NULL, '4.9.1', NULL, NULL, '8462383061');


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

INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-10 23:33:02.967694', 1, 'EXECUTED', '8:8b4b922d90b05ff27483abefc9597aa6', 'createTable tableName=ACT_CMMN_DEPLOYMENT; createTable tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addForeignKeyConstraint baseTableName=ACT_CMMN_DEPLOYMENT_RESOURCE, constraintName=ACT_FK_CMMN_RSRC_DPL, referencedTableName=ACT_CMMN_DEPLOYMENT; create...', '', NULL, '4.9.1', NULL, NULL, '8462382845');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-10 23:33:02.97455', 2, 'EXECUTED', '8:65e39b3d385706bb261cbeffe7533cbe', 'addColumn tableName=ACT_CMMN_CASEDEF; addColumn tableName=ACT_CMMN_DEPLOYMENT_RESOURCE; addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '8462382845');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-10 23:33:02.981194', 3, 'EXECUTED', '8:c01f6e802b49436b4489040da3012359', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_PLAN_ITEM_STAGE_INST, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableNam...', '', NULL, '4.9.1', NULL, NULL, '8462382845');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-10 23:33:02.989841', 4, 'EXECUTED', '8:e40d29cb79345b7fb5afd38a7f0ba8fc', 'createTable tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_MIL_INST; addColumn tableName=ACT_CMMN_HI_MIL_INST', '', NULL, '4.9.1', NULL, NULL, '8462382845');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('6', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-10 23:33:02.993736', 5, 'EXECUTED', '8:10e82e26a7fee94c32a92099c059c18c', 'createIndex indexName=ACT_IDX_CASE_DEF_UNIQ, tableName=ACT_CMMN_CASEDEF', '', NULL, '4.9.1', NULL, NULL, '8462382845');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('7', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-10 23:33:03.00463', 6, 'EXECUTED', '8:530bc81a1e30618ccf4a2da1f7c6c043', 'renameColumn newColumnName=CREATE_TIME_, oldColumnName=START_TIME_, tableName=ACT_CMMN_RU_PLAN_ITEM_INST; renameColumn newColumnName=CREATE_TIME_, oldColumnName=CREATED_TIME_, tableName=ACT_CMMN_HI_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_RU_P...', '', NULL, '4.9.1', NULL, NULL, '8462382845');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-10 23:33:03.006618', 7, 'EXECUTED', '8:e8c2eb1ce28bc301efe07e0e29757781', 'addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '8462382845');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-10 23:33:03.008903', 8, 'EXECUTED', '8:4cb4782b9bdec5ced2a64c525aa7b3a0', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '8462382845');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('10', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-10 23:33:03.014681', 9, 'EXECUTED', '8:341c16be247f5d17badc9809da8691f9', 'addColumn tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_RU_CASE_INST; createIndex indexName=ACT_IDX_CASE_INST_REF_ID_, tableName=ACT_CMMN_RU_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE_INST; addColumn tableName=ACT_CMMN_HI_CASE...', '', NULL, '4.9.1', NULL, NULL, '8462382845');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('11', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-10 23:33:03.017155', 10, 'EXECUTED', '8:d7c4da9276bcfffbfb0ebfb25e3f7b05', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '8462382845');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('12', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-10 23:33:03.018882', 11, 'EXECUTED', '8:adf4ecc45f2aa9a44a5626b02e1d6f98', 'addColumn tableName=ACT_CMMN_RU_CASE_INST', '', NULL, '4.9.1', NULL, NULL, '8462382845');
INSERT INTO public.act_cmmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13', 'flowable', 'org/flowable/cmmn/db/liquibase/flowable-cmmn-db-changelog.xml', '2023-03-10 23:33:03.021087', 12, 'EXECUTED', '8:7550626f964ab5518464709408333ec1', 'addColumn tableName=ACT_CMMN_RU_PLAN_ITEM_INST; addColumn tableName=ACT_CMMN_HI_PLAN_ITEM_INST', '', NULL, '4.9.1', NULL, NULL, '8462382845');


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

INSERT INTO public.act_co_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'activiti', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2023-03-10 23:33:02.721405', 1, 'EXECUTED', '8:7644d7165cfe799200a2abdd3419e8b6', 'createTable tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_taskid, tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_procid, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '4.9.1', NULL, NULL, '8462382707');
INSERT INTO public.act_co_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2', 'flowable', 'org/flowable/content/db/liquibase/flowable-content-db-changelog.xml', '2023-03-10 23:33:02.728005', 2, 'EXECUTED', '8:fe7b11ac7dbbf9c43006b23bbab60bab', 'addColumn tableName=ACT_CO_CONTENT_ITEM; createIndex indexName=idx_contitem_scope, tableName=ACT_CO_CONTENT_ITEM', '', NULL, '4.9.1', NULL, NULL, '8462382707');


--
-- Data for Name: act_co_databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.act_co_databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);


--
-- Data for Name: act_dmn_databasechangelog; Type: TABLE DATA; Schema: public; Owner: pineapple
--

INSERT INTO public.act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'activiti', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-10 23:33:02.522969', 1, 'EXECUTED', '8:c8701f1c71018b55029f450b2e9a10a1', 'createTable tableName=ACT_DMN_DEPLOYMENT; createTable tableName=ACT_DMN_DEPLOYMENT_RESOURCE; createTable tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.9.1', NULL, NULL, '8462382484');
INSERT INTO public.act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-10 23:33:02.531762', 2, 'EXECUTED', '8:47f94b27feb7df8a30d4e338c7bd5fb8', 'createTable tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.9.1', NULL, NULL, '8462382484');
INSERT INTO public.act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-10 23:33:02.534627', 3, 'EXECUTED', '8:ac17eae89fbdccb6e08daf3c7797b579', 'addColumn tableName=ACT_DMN_HI_DECISION_EXECUTION', '', NULL, '4.9.1', NULL, NULL, '8462382484');
INSERT INTO public.act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-10 23:33:02.537266', 4, 'EXECUTED', '8:f73aabc4529e7292c2942073d1cff6f9', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.9.1', NULL, NULL, '8462382484');
INSERT INTO public.act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('6', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-10 23:33:02.541701', 5, 'EXECUTED', '8:646c6a061e0b6e8a62e69844ff96abb0', 'createIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE', '', NULL, '4.9.1', NULL, NULL, '8462382484');
INSERT INTO public.act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('7', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-10 23:33:02.548516', 6, 'EXECUTED', '8:215a499ff7ae77685b55355245b8b708', 'dropIndex indexName=ACT_IDX_DEC_TBL_UNIQ, tableName=ACT_DMN_DECISION_TABLE; renameTable newTableName=ACT_DMN_DECISION, oldTableName=ACT_DMN_DECISION_TABLE; createIndex indexName=ACT_IDX_DMN_DEC_UNIQ, tableName=ACT_DMN_DECISION', '', NULL, '4.9.1', NULL, NULL, '8462382484');
INSERT INTO public.act_dmn_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8', 'flowable', 'org/flowable/dmn/db/liquibase/flowable-dmn-db-changelog.xml', '2023-03-10 23:33:02.551479', 7, 'EXECUTED', '8:5355bee389318afed91a11702f2df032', 'addColumn tableName=ACT_DMN_DECISION', '', NULL, '4.9.1', NULL, NULL, '8462382484');


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

INSERT INTO public.act_fo_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'activiti', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-10 23:33:02.624041', 1, 'EXECUTED', '8:033ebf9380889aed7c453927ecc3250d', 'createTable tableName=ACT_FO_FORM_DEPLOYMENT; createTable tableName=ACT_FO_FORM_RESOURCE; createTable tableName=ACT_FO_FORM_DEFINITION; createTable tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.9.1', NULL, NULL, '8462382600');
INSERT INTO public.act_fo_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-10 23:33:02.627506', 2, 'EXECUTED', '8:986365ceb40445ce3b27a8e6b40f159b', 'addColumn tableName=ACT_FO_FORM_INSTANCE', '', NULL, '4.9.1', NULL, NULL, '8462382600');
INSERT INTO public.act_fo_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-10 23:33:02.629511', 3, 'EXECUTED', '8:abf482518ceb09830ef674e52c06bf15', 'dropColumn columnName=PARENT_DEPLOYMENT_ID_, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '4.9.1', NULL, NULL, '8462382600');
INSERT INTO public.act_fo_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('5', 'flowable', 'org/flowable/form/db/liquibase/flowable-form-db-changelog.xml', '2023-03-10 23:33:02.633135', 4, 'EXECUTED', '8:b4be732b89e5ca028bdd520c6ad4d446', 'createIndex indexName=ACT_IDX_FORM_DEF_UNIQ, tableName=ACT_FO_FORM_DEFINITION', '', NULL, '4.9.1', NULL, NULL, '8462382600');


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

INSERT INTO public.flw_ev_databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1', 'flowable', 'org/flowable/eventregistry/db/liquibase/flowable-eventregistry-db-changelog.xml', '2023-03-10 23:33:02.367394', 1, 'EXECUTED', '8:1b0c48c9cf7945be799d868a2626d687', 'createTable tableName=FLW_EVENT_DEPLOYMENT; createTable tableName=FLW_EVENT_RESOURCE; createTable tableName=FLW_EVENT_DEFINITION; createIndex indexName=ACT_IDX_EVENT_DEF_UNIQ, tableName=FLW_EVENT_DEFINITION; createTable tableName=FLW_CHANNEL_DEFIN...', '', NULL, '4.9.1', NULL, NULL, '8462382288');


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
-- Data for Name: t_template; Type: TABLE DATA; Schema: public; Owner: pineapple
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


--
-- Data for Name: sys_menu; Type: TABLE DATA; Schema: system; Owner: pineapple
--



--
-- Data for Name: sys_param; Type: TABLE DATA; Schema: system; Owner: pineapple
--



--
-- Data for Name: sys_role; Type: TABLE DATA; Schema: system; Owner: pineapple
--



--
-- Data for Name: sys_role_menu; Type: TABLE DATA; Schema: system; Owner: pineapple
--



--
-- Data for Name: sys_user; Type: TABLE DATA; Schema: system; Owner: pineapple
--



--
-- Data for Name: sys_user_role; Type: TABLE DATA; Schema: system; Owner: pineapple
--



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
-- Name: t_template t_template_pk; Type: CONSTRAINT; Schema: public; Owner: pineapple
--

ALTER TABLE ONLY public.t_template
    ADD CONSTRAINT t_template_pk PRIMARY KEY (id);


--
-- Name: CONSTRAINT t_template_pk ON t_template; Type: COMMENT; Schema: public; Owner: pineapple
--

COMMENT ON CONSTRAINT t_template_pk ON public.t_template IS '模板表主键';


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

