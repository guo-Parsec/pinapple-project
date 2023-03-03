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

