--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: aix_alerts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE aix_alerts (
    id integer NOT NULL,
    alert_type character varying(255),
    "check" character varying(255),
    valid_status character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: aix_alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE aix_alerts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aix_alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE aix_alerts_id_seq OWNED BY aix_alerts.id;


--
-- Name: aix_paths; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE aix_paths (
    id integer NOT NULL,
    adapter character varying(255),
    state character varying(255),
    mode character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    server_id integer,
    path integer
);


--
-- Name: aix_paths_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE aix_paths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aix_paths_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE aix_paths_id_seq OWNED BY aix_paths.id;


--
-- Name: aix_ports; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE aix_ports (
    id integer NOT NULL,
    port character varying(255),
    server_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: aix_ports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE aix_ports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: aix_ports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE aix_ports_id_seq OWNED BY aix_ports.id;


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0,
    attempts integer DEFAULT 0,
    handler text,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    queue character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: firmwares; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE firmwares (
    id integer NOT NULL,
    model character varying(255),
    recommended character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: firmwares_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE firmwares_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: firmwares_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE firmwares_id_seq OWNED BY firmwares.id;


--
-- Name: hardwares; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE hardwares (
    id integer NOT NULL,
    sys_model character varying(255),
    firmware character varying(255),
    serial character varying(255),
    server_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: hardwares_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hardwares_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hardwares_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE hardwares_id_seq OWNED BY hardwares.id;


--
-- Name: health_checks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE health_checks (
    id integer NOT NULL,
    name character varying(255),
    description text,
    return_code integer,
    output text,
    hc_errors text,
    server_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    info text
);


--
-- Name: health_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE health_checks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: health_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE health_checks_id_seq OWNED BY health_checks.id;


--
-- Name: healthcheck_versions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE healthcheck_versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    object_changes text,
    created_at timestamp without time zone
);


--
-- Name: healthcheck_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE healthcheck_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: healthcheck_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE healthcheck_versions_id_seq OWNED BY healthcheck_versions.id;


--
-- Name: import_logs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE import_logs (
    id integer NOT NULL,
    upload_id integer,
    result character varying(255),
    content text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    success_count integer,
    error_count integer
);


--
-- Name: import_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE import_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: import_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE import_logs_id_seq OWNED BY import_logs.id;


--
-- Name: lparstat_versions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lparstat_versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    object_changes text,
    created_at timestamp without time zone
);


--
-- Name: lparstat_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lparstat_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lparstat_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lparstat_versions_id_seq OWNED BY lparstat_versions.id;


--
-- Name: lparstats; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE lparstats (
    id integer NOT NULL,
    node_name character varying(255),
    partition_name character varying(255),
    partition_number integer,
    entitled_capacity double precision,
    partition_group integer,
    shared_pool integer,
    online_virtual_cpus integer,
    maximum_virtual_cpus integer,
    minimum_virtual_cpus integer,
    online_memory character varying(255),
    maximum_memory character varying(255),
    minimum_memory character varying(255),
    variable_capacity_weight integer,
    minimum_capacity double precision,
    maximum_capacity double precision,
    capacity_increment double precision,
    maximum_physical_cpus_in_system integer,
    active_physical_cpus_in_system integer,
    active_cpus_in_pool integer,
    shared_physical_cpus_in_system integer,
    maximum_capacity_of_pool double precision,
    entitled_capacity_of_pool double precision,
    unallocated_capacity double precision,
    physical_cpu_percentage double precision,
    unallocated_weight double precision,
    memory_mode character varying(255),
    variable_memory_capacity_weight character varying(255),
    memory_pool character varying(255),
    physical_memory_in_the_pool character varying(255),
    hypervisor_page_size character varying(255),
    unallocated_variable_memory_capacity_weight character varying(255),
    unallocated_io_memory_entitlement character varying(255),
    memory_group_id_of_lpar character varying(255),
    desired_virtual_cpus integer,
    desired_memory character varying(255),
    desired_variable_capacity_weight double precision,
    desired_capacity double precision,
    target_memory_expansion_factor character varying(255),
    target_memory_expansion_size character varying(255),
    power_saving_mode character varying(255),
    server_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    mode character varying(255),
    total_io_memory_entitlement character varying(255),
    lpar_type character varying(255)
);


--
-- Name: lparstats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE lparstats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lparstats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE lparstats_id_seq OWNED BY lparstats.id;


--
-- Name: san_alerts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE san_alerts (
    id integer NOT NULL,
    alert_type character varying(255),
    fabric1 character varying(255),
    fabric2 character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: san_alerts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE san_alerts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: san_alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE san_alerts_id_seq OWNED BY san_alerts.id;


--
-- Name: san_infras; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE san_infras (
    id integer NOT NULL,
    infra character varying(15),
    fabric character varying(15),
    switch character varying(15),
    port character varying(10),
    speed character varying(5),
    status character varying(15),
    portname character varying(15),
    mode character varying(15),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: san_infras_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE san_infras_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: san_infras_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE san_infras_id_seq OWNED BY san_infras.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: server_attributes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE server_attributes (
    id integer NOT NULL,
    name character varying(255),
    category character varying(255),
    description text,
    output text,
    conf_errors text,
    return_code integer,
    server_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: server_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE server_attributes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: server_attributes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE server_attributes_id_seq OWNED BY server_attributes.id;


--
-- Name: server_versions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE server_versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    created_at timestamp without time zone,
    object_changes text
);


--
-- Name: server_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE server_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: server_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE server_versions_id_seq OWNED BY server_versions.id;


--
-- Name: servers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE servers (
    id integer NOT NULL,
    customer character varying(255),
    hostname character varying(255),
    os_type character varying(255),
    os_version character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    run_date date,
    hardware_id integer,
    properties hstore
);


--
-- Name: servers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE servers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: servers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE servers_id_seq OWNED BY servers.id;


--
-- Name: software_deployment_versions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE software_deployment_versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    object_changes text,
    created_at timestamp without time zone
);


--
-- Name: software_deployment_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE software_deployment_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: software_deployment_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE software_deployment_versions_id_seq OWNED BY software_deployment_versions.id;


--
-- Name: software_deployments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE software_deployments (
    id integer NOT NULL,
    software_id integer,
    server_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: software_deployments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE software_deployments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: software_deployments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE software_deployments_id_seq OWNED BY software_deployments.id;


--
-- Name: softwares; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE softwares (
    id integer NOT NULL,
    name character varying(255),
    version character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: softwares_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE softwares_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: softwares_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE softwares_id_seq OWNED BY softwares.id;


--
-- Name: switch_ports; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE switch_ports (
    id integer NOT NULL,
    fabric character varying(255),
    domain character varying(255),
    port character varying(255),
    wwpn character varying(255),
    port_alias character varying(255),
    aix_port_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: switch_ports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE switch_ports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: switch_ports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE switch_ports_id_seq OWNED BY switch_ports.id;


--
-- Name: uploads; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE uploads (
    id integer NOT NULL,
    upload_file_name character varying(255),
    upload_content_type character varying(255),
    upload_file_size integer,
    upload_updated_at character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    import_type character varying(255),
    workflow_state character varying(255)
);


--
-- Name: uploads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE uploads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uploads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE uploads_id_seq OWNED BY uploads.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    username character varying(255),
    approved boolean DEFAULT false NOT NULL,
    role character varying(255),
    customer_scope character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    created_at timestamp without time zone
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: wwpns; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE wwpns (
    id integer NOT NULL,
    aix_port_id integer,
    san_infra_id integer,
    sod_infra_id integer,
    wwpn character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: wwpns_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE wwpns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wwpns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE wwpns_id_seq OWNED BY wwpns.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY aix_alerts ALTER COLUMN id SET DEFAULT nextval('aix_alerts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY aix_paths ALTER COLUMN id SET DEFAULT nextval('aix_paths_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY aix_ports ALTER COLUMN id SET DEFAULT nextval('aix_ports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY firmwares ALTER COLUMN id SET DEFAULT nextval('firmwares_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY hardwares ALTER COLUMN id SET DEFAULT nextval('hardwares_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY health_checks ALTER COLUMN id SET DEFAULT nextval('health_checks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY healthcheck_versions ALTER COLUMN id SET DEFAULT nextval('healthcheck_versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY import_logs ALTER COLUMN id SET DEFAULT nextval('import_logs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lparstat_versions ALTER COLUMN id SET DEFAULT nextval('lparstat_versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY lparstats ALTER COLUMN id SET DEFAULT nextval('lparstats_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY san_alerts ALTER COLUMN id SET DEFAULT nextval('san_alerts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY san_infras ALTER COLUMN id SET DEFAULT nextval('san_infras_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY server_attributes ALTER COLUMN id SET DEFAULT nextval('server_attributes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY server_versions ALTER COLUMN id SET DEFAULT nextval('server_versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY servers ALTER COLUMN id SET DEFAULT nextval('servers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY software_deployment_versions ALTER COLUMN id SET DEFAULT nextval('software_deployment_versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY software_deployments ALTER COLUMN id SET DEFAULT nextval('software_deployments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY softwares ALTER COLUMN id SET DEFAULT nextval('softwares_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY switch_ports ALTER COLUMN id SET DEFAULT nextval('switch_ports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY uploads ALTER COLUMN id SET DEFAULT nextval('uploads_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY wwpns ALTER COLUMN id SET DEFAULT nextval('wwpns_id_seq'::regclass);


--
-- Name: aix_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY aix_alerts
    ADD CONSTRAINT aix_alerts_pkey PRIMARY KEY (id);


--
-- Name: aix_paths_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY aix_paths
    ADD CONSTRAINT aix_paths_pkey PRIMARY KEY (id);


--
-- Name: aix_ports_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY aix_ports
    ADD CONSTRAINT aix_ports_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: firmwares_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY firmwares
    ADD CONSTRAINT firmwares_pkey PRIMARY KEY (id);


--
-- Name: hardwares_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY hardwares
    ADD CONSTRAINT hardwares_pkey PRIMARY KEY (id);


--
-- Name: health_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY health_checks
    ADD CONSTRAINT health_checks_pkey PRIMARY KEY (id);


--
-- Name: healthcheck_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY healthcheck_versions
    ADD CONSTRAINT healthcheck_versions_pkey PRIMARY KEY (id);


--
-- Name: import_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY import_logs
    ADD CONSTRAINT import_logs_pkey PRIMARY KEY (id);


--
-- Name: lparstat_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lparstat_versions
    ADD CONSTRAINT lparstat_versions_pkey PRIMARY KEY (id);


--
-- Name: lparstats_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lparstats
    ADD CONSTRAINT lparstats_pkey PRIMARY KEY (id);


--
-- Name: san_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY san_alerts
    ADD CONSTRAINT san_alerts_pkey PRIMARY KEY (id);


--
-- Name: san_infras_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY san_infras
    ADD CONSTRAINT san_infras_pkey PRIMARY KEY (id);


--
-- Name: server_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY server_attributes
    ADD CONSTRAINT server_attributes_pkey PRIMARY KEY (id);


--
-- Name: server_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY server_versions
    ADD CONSTRAINT server_versions_pkey PRIMARY KEY (id);


--
-- Name: servers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY servers
    ADD CONSTRAINT servers_pkey PRIMARY KEY (id);


--
-- Name: software_deployment_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY software_deployment_versions
    ADD CONSTRAINT software_deployment_versions_pkey PRIMARY KEY (id);


--
-- Name: software_deployments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY software_deployments
    ADD CONSTRAINT software_deployments_pkey PRIMARY KEY (id);


--
-- Name: softwares_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY softwares
    ADD CONSTRAINT softwares_pkey PRIMARY KEY (id);


--
-- Name: switch_ports_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY switch_ports
    ADD CONSTRAINT switch_ports_pkey PRIMARY KEY (id);


--
-- Name: uploads_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY uploads
    ADD CONSTRAINT uploads_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: wwpns_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY wwpns
    ADD CONSTRAINT wwpns_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: index_aix_paths_on_server_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_aix_paths_on_server_id ON aix_paths USING btree (server_id);


--
-- Name: index_aix_paths_on_server_id_and_adapter; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_aix_paths_on_server_id_and_adapter ON aix_paths USING btree (server_id, adapter);


--
-- Name: index_aix_ports_on_server_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_aix_ports_on_server_id ON aix_ports USING btree (server_id);


--
-- Name: index_healthcheck_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_healthcheck_versions_on_item_type_and_item_id ON healthcheck_versions USING btree (item_type, item_id);


--
-- Name: index_lparstat_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_lparstat_versions_on_item_type_and_item_id ON lparstat_versions USING btree (item_type, item_id);


--
-- Name: index_server_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_server_versions_on_item_type_and_item_id ON server_versions USING btree (item_type, item_id);


--
-- Name: index_servers_on_customer_and_hostname; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_servers_on_customer_and_hostname ON servers USING btree (customer, hostname);


--
-- Name: index_software_deployment_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_software_deployment_versions_on_item_type_and_item_id ON software_deployment_versions USING btree (item_type, item_id);


--
-- Name: index_software_deployments_on_server_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_software_deployments_on_server_id ON software_deployments USING btree (server_id);


--
-- Name: index_software_deployments_on_software_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_software_deployments_on_software_id ON software_deployments USING btree (software_id);


--
-- Name: index_switch_ports_on_san_port_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_switch_ports_on_san_port_id ON switch_ports USING btree (aix_port_id);


--
-- Name: index_switch_ports_on_wwpn; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_switch_ports_on_wwpn ON switch_ports USING btree (wwpn);


--
-- Name: index_users_on_approved; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_approved ON users USING btree (approved);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_versions_on_item_type_and_item_id ON versions USING btree (item_type, item_id);


--
-- Name: servers_properties; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX servers_properties ON servers USING gin (properties);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130311205719');

INSERT INTO schema_migrations (version) VALUES ('20130313001757');

INSERT INTO schema_migrations (version) VALUES ('20130313090325');

INSERT INTO schema_migrations (version) VALUES ('20130313094126');

INSERT INTO schema_migrations (version) VALUES ('20130313190412');

INSERT INTO schema_migrations (version) VALUES ('20130313230718');

INSERT INTO schema_migrations (version) VALUES ('20130314130314');

INSERT INTO schema_migrations (version) VALUES ('20130314183219');

INSERT INTO schema_migrations (version) VALUES ('20130314190026');

INSERT INTO schema_migrations (version) VALUES ('20130314220839');

INSERT INTO schema_migrations (version) VALUES ('20130316163052');

INSERT INTO schema_migrations (version) VALUES ('20130316163950');

INSERT INTO schema_migrations (version) VALUES ('20130316164615');

INSERT INTO schema_migrations (version) VALUES ('20130317174934');

INSERT INTO schema_migrations (version) VALUES ('20130318130111');

INSERT INTO schema_migrations (version) VALUES ('20130325174823');

INSERT INTO schema_migrations (version) VALUES ('20130726100655');

INSERT INTO schema_migrations (version) VALUES ('20130726123505');

INSERT INTO schema_migrations (version) VALUES ('20130728193703');

INSERT INTO schema_migrations (version) VALUES ('20130730160530');

INSERT INTO schema_migrations (version) VALUES ('20130730164212');

INSERT INTO schema_migrations (version) VALUES ('20130908145747');

INSERT INTO schema_migrations (version) VALUES ('20130908150654');

INSERT INTO schema_migrations (version) VALUES ('20130909130132');

INSERT INTO schema_migrations (version) VALUES ('20130910123753');