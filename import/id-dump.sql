--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.4

-- Started on 2025-07-30 12:01:08

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16384)
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO admin_temporary;

--
-- TOC entry 218 (class 1259 OID 16389)
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO admin_temporary;

--
-- TOC entry 219 (class 1259 OID 16392)
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO admin_temporary;

--
-- TOC entry 220 (class 1259 OID 16396)
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO admin_temporary;

--
-- TOC entry 221 (class 1259 OID 16404)
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO admin_temporary;

--
-- TOC entry 222 (class 1259 OID 16407)
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO admin_temporary;

--
-- TOC entry 223 (class 1259 OID 16412)
-- Name: broker_link; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO admin_temporary;

--
-- TOC entry 224 (class 1259 OID 16417)
-- Name: client; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO admin_temporary;

--
-- TOC entry 225 (class 1259 OID 16435)
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO admin_temporary;

--
-- TOC entry 226 (class 1259 OID 16440)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO admin_temporary;

--
-- TOC entry 227 (class 1259 OID 16443)
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO admin_temporary;

--
-- TOC entry 228 (class 1259 OID 16446)
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO admin_temporary;

--
-- TOC entry 229 (class 1259 OID 16449)
-- Name: client_scope; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO admin_temporary;

--
-- TOC entry 230 (class 1259 OID 16454)
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO admin_temporary;

--
-- TOC entry 231 (class 1259 OID 16459)
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO admin_temporary;

--
-- TOC entry 232 (class 1259 OID 16465)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO admin_temporary;

--
-- TOC entry 233 (class 1259 OID 16468)
-- Name: component; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO admin_temporary;

--
-- TOC entry 234 (class 1259 OID 16473)
-- Name: component_config; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO admin_temporary;

--
-- TOC entry 235 (class 1259 OID 16478)
-- Name: composite_role; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO admin_temporary;

--
-- TOC entry 236 (class 1259 OID 16481)
-- Name: credential; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer,
    version integer DEFAULT 0
);


ALTER TABLE public.credential OWNER TO admin_temporary;

--
-- TOC entry 237 (class 1259 OID 16487)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.databasechangelog (
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


ALTER TABLE public.databasechangelog OWNER TO admin_temporary;

--
-- TOC entry 238 (class 1259 OID 16492)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO admin_temporary;

--
-- TOC entry 239 (class 1259 OID 16495)
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO admin_temporary;

--
-- TOC entry 240 (class 1259 OID 16499)
-- Name: event_entity; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO admin_temporary;

--
-- TOC entry 241 (class 1259 OID 16504)
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO admin_temporary;

--
-- TOC entry 242 (class 1259 OID 16509)
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO admin_temporary;

--
-- TOC entry 243 (class 1259 OID 16514)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO admin_temporary;

--
-- TOC entry 244 (class 1259 OID 16517)
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO admin_temporary;

--
-- TOC entry 245 (class 1259 OID 16522)
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO admin_temporary;

--
-- TOC entry 246 (class 1259 OID 16525)
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO admin_temporary;

--
-- TOC entry 247 (class 1259 OID 16531)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO admin_temporary;

--
-- TOC entry 248 (class 1259 OID 16534)
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO admin_temporary;

--
-- TOC entry 249 (class 1259 OID 16539)
-- Name: federated_user; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO admin_temporary;

--
-- TOC entry 250 (class 1259 OID 16544)
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO admin_temporary;

--
-- TOC entry 251 (class 1259 OID 16550)
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO admin_temporary;

--
-- TOC entry 252 (class 1259 OID 16553)
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO admin_temporary;

--
-- TOC entry 253 (class 1259 OID 16565)
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO admin_temporary;

--
-- TOC entry 254 (class 1259 OID 16570)
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO admin_temporary;

--
-- TOC entry 255 (class 1259 OID 16575)
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO admin_temporary;

--
-- TOC entry 256 (class 1259 OID 16580)
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO admin_temporary;

--
-- TOC entry 257 (class 1259 OID 16585)
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO admin_temporary;

--
-- TOC entry 258 (class 1259 OID 16589)
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO admin_temporary;

--
-- TOC entry 259 (class 1259 OID 16595)
-- Name: migration_model; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO admin_temporary;

--
-- TOC entry 260 (class 1259 OID 16599)
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO admin_temporary;

--
-- TOC entry 261 (class 1259 OID 16607)
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO admin_temporary;

--
-- TOC entry 262 (class 1259 OID 16614)
-- Name: org; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO admin_temporary;

--
-- TOC entry 263 (class 1259 OID 16619)
-- Name: org_domain; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO admin_temporary;

--
-- TOC entry 264 (class 1259 OID 16624)
-- Name: policy_config; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO admin_temporary;

--
-- TOC entry 265 (class 1259 OID 16629)
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO admin_temporary;

--
-- TOC entry 266 (class 1259 OID 16634)
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO admin_temporary;

--
-- TOC entry 267 (class 1259 OID 16639)
-- Name: realm; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO admin_temporary;

--
-- TOC entry 268 (class 1259 OID 16672)
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO admin_temporary;

--
-- TOC entry 269 (class 1259 OID 16677)
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO admin_temporary;

--
-- TOC entry 270 (class 1259 OID 16680)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO admin_temporary;

--
-- TOC entry 271 (class 1259 OID 16683)
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO admin_temporary;

--
-- TOC entry 272 (class 1259 OID 16686)
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO admin_temporary;

--
-- TOC entry 273 (class 1259 OID 16691)
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO admin_temporary;

--
-- TOC entry 274 (class 1259 OID 16698)
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO admin_temporary;

--
-- TOC entry 275 (class 1259 OID 16703)
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO admin_temporary;

--
-- TOC entry 276 (class 1259 OID 16706)
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO admin_temporary;

--
-- TOC entry 277 (class 1259 OID 16709)
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO admin_temporary;

--
-- TOC entry 278 (class 1259 OID 16714)
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO admin_temporary;

--
-- TOC entry 279 (class 1259 OID 16721)
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO admin_temporary;

--
-- TOC entry 280 (class 1259 OID 16727)
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO admin_temporary;

--
-- TOC entry 281 (class 1259 OID 16730)
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO admin_temporary;

--
-- TOC entry 282 (class 1259 OID 16733)
-- Name: resource_server; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO admin_temporary;

--
-- TOC entry 283 (class 1259 OID 16738)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO admin_temporary;

--
-- TOC entry 284 (class 1259 OID 16743)
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO admin_temporary;

--
-- TOC entry 285 (class 1259 OID 16748)
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO admin_temporary;

--
-- TOC entry 286 (class 1259 OID 16754)
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO admin_temporary;

--
-- TOC entry 287 (class 1259 OID 16759)
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO admin_temporary;

--
-- TOC entry 288 (class 1259 OID 16762)
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO admin_temporary;

--
-- TOC entry 289 (class 1259 OID 16765)
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO admin_temporary;

--
-- TOC entry 290 (class 1259 OID 16770)
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO admin_temporary;

--
-- TOC entry 291 (class 1259 OID 16773)
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO admin_temporary;

--
-- TOC entry 292 (class 1259 OID 16776)
-- Name: server_config; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.server_config (
    server_config_key character varying(255) NOT NULL,
    value text NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.server_config OWNER TO admin_temporary;

--
-- TOC entry 293 (class 1259 OID 16782)
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO admin_temporary;

--
-- TOC entry 294 (class 1259 OID 16788)
-- Name: user_consent; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO admin_temporary;

--
-- TOC entry 295 (class 1259 OID 16793)
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO admin_temporary;

--
-- TOC entry 296 (class 1259 OID 16796)
-- Name: user_entity; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO admin_temporary;

--
-- TOC entry 297 (class 1259 OID 16804)
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO admin_temporary;

--
-- TOC entry 298 (class 1259 OID 16809)
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO admin_temporary;

--
-- TOC entry 299 (class 1259 OID 16814)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO admin_temporary;

--
-- TOC entry 300 (class 1259 OID 16819)
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO admin_temporary;

--
-- TOC entry 301 (class 1259 OID 16824)
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO admin_temporary;

--
-- TOC entry 302 (class 1259 OID 16827)
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO admin_temporary;

--
-- TOC entry 303 (class 1259 OID 16831)
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO admin_temporary;

--
-- TOC entry 304 (class 1259 OID 16834)
-- Name: web_origins; Type: TABLE; Schema: public; Owner: admin_temporary
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO admin_temporary;

--
-- TOC entry 4149 (class 0 OID 16384)
-- Dependencies: 217
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- TOC entry 4150 (class 0 OID 16389)
-- Dependencies: 218
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- TOC entry 4151 (class 0 OID 16392)
-- Dependencies: 219
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
be8c7577-7bb7-4132-aa19-020f2b1629a9	\N	auth-cookie	c59dea27-0f0a-4d7e-9d51-e1017680e812	9714ba60-63f3-4730-a9b9-32a75922bd4f	2	10	f	\N	\N
7d4e02df-8ea4-4630-810d-4752bbadd9a3	\N	auth-spnego	c59dea27-0f0a-4d7e-9d51-e1017680e812	9714ba60-63f3-4730-a9b9-32a75922bd4f	3	20	f	\N	\N
b92971bd-450a-4666-869d-aa24ad8d4ddb	\N	identity-provider-redirector	c59dea27-0f0a-4d7e-9d51-e1017680e812	9714ba60-63f3-4730-a9b9-32a75922bd4f	2	25	f	\N	\N
d2981bf3-9fad-4d65-9963-e58ec3f77db7	\N	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	9714ba60-63f3-4730-a9b9-32a75922bd4f	2	30	t	58d92df4-5abf-4836-82a8-6cb875b7827b	\N
0773d116-d606-4b3c-8bf4-844a64a34b80	\N	auth-username-password-form	c59dea27-0f0a-4d7e-9d51-e1017680e812	58d92df4-5abf-4836-82a8-6cb875b7827b	0	10	f	\N	\N
e039592f-5e64-4b6e-bb5b-b786fc95e721	\N	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	58d92df4-5abf-4836-82a8-6cb875b7827b	1	20	t	8bab3b95-d888-4c50-9d61-604c1d55cc6f	\N
00e7d108-dccc-4b12-a198-d5b58600ac59	\N	conditional-user-configured	c59dea27-0f0a-4d7e-9d51-e1017680e812	8bab3b95-d888-4c50-9d61-604c1d55cc6f	0	10	f	\N	\N
525a2f7a-1150-423d-beea-bb776c311a6c	\N	auth-otp-form	c59dea27-0f0a-4d7e-9d51-e1017680e812	8bab3b95-d888-4c50-9d61-604c1d55cc6f	0	20	f	\N	\N
29369560-3d3f-4bf8-ac7b-6ec7c11a0006	\N	direct-grant-validate-username	c59dea27-0f0a-4d7e-9d51-e1017680e812	90e3da48-9779-4507-bde5-ae0883c37d7b	0	10	f	\N	\N
46c4f52d-b942-45de-a3f8-d54d5802a1fc	\N	direct-grant-validate-password	c59dea27-0f0a-4d7e-9d51-e1017680e812	90e3da48-9779-4507-bde5-ae0883c37d7b	0	20	f	\N	\N
5b9781df-f92f-46a3-9bd2-5a6788500027	\N	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	90e3da48-9779-4507-bde5-ae0883c37d7b	1	30	t	07b4965c-e93f-45af-b09c-9642fb076236	\N
6d646f11-d64b-4769-a265-6a1ae1ee4fee	\N	conditional-user-configured	c59dea27-0f0a-4d7e-9d51-e1017680e812	07b4965c-e93f-45af-b09c-9642fb076236	0	10	f	\N	\N
fcc344f3-77ac-4029-b7d0-26eda77b2937	\N	direct-grant-validate-otp	c59dea27-0f0a-4d7e-9d51-e1017680e812	07b4965c-e93f-45af-b09c-9642fb076236	0	20	f	\N	\N
1fbc1bf6-af00-46c9-9d58-581bea3381ce	\N	registration-page-form	c59dea27-0f0a-4d7e-9d51-e1017680e812	cec96a14-62a4-4f25-809c-50f4e72709f7	0	10	t	11a7231d-e5b7-4327-8700-f97437487e36	\N
eb4e43f0-a210-4117-b1ee-38eede7f84af	\N	registration-user-creation	c59dea27-0f0a-4d7e-9d51-e1017680e812	11a7231d-e5b7-4327-8700-f97437487e36	0	20	f	\N	\N
f54a8d9d-17e0-41ae-8ae1-fe91134f7322	\N	registration-password-action	c59dea27-0f0a-4d7e-9d51-e1017680e812	11a7231d-e5b7-4327-8700-f97437487e36	0	50	f	\N	\N
77cd1bb2-ab51-43d9-ad9a-93f493201716	\N	registration-recaptcha-action	c59dea27-0f0a-4d7e-9d51-e1017680e812	11a7231d-e5b7-4327-8700-f97437487e36	3	60	f	\N	\N
17249f62-8eaa-4a2c-9553-fec3b4304463	\N	registration-terms-and-conditions	c59dea27-0f0a-4d7e-9d51-e1017680e812	11a7231d-e5b7-4327-8700-f97437487e36	3	70	f	\N	\N
6cae8f52-a624-4c46-9279-203f5cb52dac	\N	reset-credentials-choose-user	c59dea27-0f0a-4d7e-9d51-e1017680e812	ef411cfb-66d1-473b-996b-4ad8e583149c	0	10	f	\N	\N
282b4f1f-f46b-43dc-81ef-5211376ca596	\N	reset-credential-email	c59dea27-0f0a-4d7e-9d51-e1017680e812	ef411cfb-66d1-473b-996b-4ad8e583149c	0	20	f	\N	\N
05102576-a923-4a70-8469-4836267ac312	\N	reset-password	c59dea27-0f0a-4d7e-9d51-e1017680e812	ef411cfb-66d1-473b-996b-4ad8e583149c	0	30	f	\N	\N
f4b497ce-e492-4664-b3e0-f618179a86cf	\N	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	ef411cfb-66d1-473b-996b-4ad8e583149c	1	40	t	e86a5980-fd15-4ed5-90b1-669edd2b4f69	\N
a1ae1d54-c8cc-4e6e-8623-02d81705136b	\N	conditional-user-configured	c59dea27-0f0a-4d7e-9d51-e1017680e812	e86a5980-fd15-4ed5-90b1-669edd2b4f69	0	10	f	\N	\N
74544a58-82ea-4f80-8af1-517c322689b8	\N	reset-otp	c59dea27-0f0a-4d7e-9d51-e1017680e812	e86a5980-fd15-4ed5-90b1-669edd2b4f69	0	20	f	\N	\N
ff1b336f-f10a-43cb-9d81-5ef5d075834f	\N	client-secret	c59dea27-0f0a-4d7e-9d51-e1017680e812	a10420bc-df45-4a9b-a76a-6c534c258b84	2	10	f	\N	\N
1c00b2af-20a8-4aa1-90ee-b5820bed5a0a	\N	client-jwt	c59dea27-0f0a-4d7e-9d51-e1017680e812	a10420bc-df45-4a9b-a76a-6c534c258b84	2	20	f	\N	\N
6097c1e9-4d62-4783-8539-54b6ec9fc1ac	\N	client-secret-jwt	c59dea27-0f0a-4d7e-9d51-e1017680e812	a10420bc-df45-4a9b-a76a-6c534c258b84	2	30	f	\N	\N
528f58f8-2617-4525-b7f6-f5adf8bc70f0	\N	client-x509	c59dea27-0f0a-4d7e-9d51-e1017680e812	a10420bc-df45-4a9b-a76a-6c534c258b84	2	40	f	\N	\N
e01946b7-d7b8-478b-8e52-b3bfe5595970	\N	idp-review-profile	c59dea27-0f0a-4d7e-9d51-e1017680e812	e6a735b7-c9c8-4433-80ff-4c933216959a	0	10	f	\N	d01cdad8-4793-4d7d-9858-b63b442dfe4a
459906d9-6fbc-4f2d-9b9a-487bba238398	\N	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	e6a735b7-c9c8-4433-80ff-4c933216959a	0	20	t	d241fd75-4f21-4ef4-b78c-f86a72e49a63	\N
30b75803-dcd8-41b6-8617-9e5cf424cdef	\N	idp-create-user-if-unique	c59dea27-0f0a-4d7e-9d51-e1017680e812	d241fd75-4f21-4ef4-b78c-f86a72e49a63	2	10	f	\N	1915f566-c2a5-41c6-b13f-e8c938c1d9d8
4574354b-a052-4952-9bb5-5df84bde039f	\N	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	d241fd75-4f21-4ef4-b78c-f86a72e49a63	2	20	t	64281406-31b9-4900-b575-b113c0a8a8b3	\N
62cb2240-d006-4eb3-958f-f2570e2ff882	\N	idp-confirm-link	c59dea27-0f0a-4d7e-9d51-e1017680e812	64281406-31b9-4900-b575-b113c0a8a8b3	0	10	f	\N	\N
6d1d2b3e-ab76-49b3-baab-81021090e4a7	\N	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	64281406-31b9-4900-b575-b113c0a8a8b3	0	20	t	2f9c2880-196a-4f7e-b7c2-f9bc0bf921d0	\N
ea13c510-5188-453b-aba5-c0cc120694af	\N	idp-email-verification	c59dea27-0f0a-4d7e-9d51-e1017680e812	2f9c2880-196a-4f7e-b7c2-f9bc0bf921d0	2	10	f	\N	\N
9e474fda-8d21-4685-ab62-27fc230b8b2d	\N	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	2f9c2880-196a-4f7e-b7c2-f9bc0bf921d0	2	20	t	14fe958b-e965-4275-ab0c-cda917b55df1	\N
68043d5e-238d-4132-ae54-02569dc2021e	\N	idp-username-password-form	c59dea27-0f0a-4d7e-9d51-e1017680e812	14fe958b-e965-4275-ab0c-cda917b55df1	0	10	f	\N	\N
ad61bf77-eda2-45d6-8e26-572d78416f59	\N	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	14fe958b-e965-4275-ab0c-cda917b55df1	1	20	t	46c6253f-66cc-4c70-aeaf-0f506b02f3b7	\N
d0c48260-d560-4356-afdd-259fec3301ea	\N	conditional-user-configured	c59dea27-0f0a-4d7e-9d51-e1017680e812	46c6253f-66cc-4c70-aeaf-0f506b02f3b7	0	10	f	\N	\N
0ced42e3-cbda-4c37-91b4-47bbf5033a18	\N	auth-otp-form	c59dea27-0f0a-4d7e-9d51-e1017680e812	46c6253f-66cc-4c70-aeaf-0f506b02f3b7	0	20	f	\N	\N
4c75adb3-4573-428b-84e5-31745efddf9c	\N	http-basic-authenticator	c59dea27-0f0a-4d7e-9d51-e1017680e812	e8b1e87c-cfe7-4bfe-bd5e-7e29baefad84	0	10	f	\N	\N
5df75859-3dad-441c-8894-f3f07479b5a1	\N	docker-http-basic-authenticator	c59dea27-0f0a-4d7e-9d51-e1017680e812	38210274-0ac4-40d1-af5d-bc061b29c6f1	0	10	f	\N	\N
102a0ef2-dda2-4ac6-a1cc-08e5403c5f9a	\N	passkey-or-password-registration	041f8a3b-b936-410d-b423-b51f4cd23d7f	ff487f42-afe8-4127-94f3-6a49f9e17275	2	1	f	\N	\N
01f69c6f-1e65-4c62-93d8-5e48da4bf918	\N	password-registration	041f8a3b-b936-410d-b423-b51f4cd23d7f	ff487f42-afe8-4127-94f3-6a49f9e17275	2	2	f	\N	\N
b083601f-3b01-47a0-aabb-65c6aeb37b7f	\N	user-creation-no-account	041f8a3b-b936-410d-b423-b51f4cd23d7f	a580d03f-f0fb-4954-9bfe-6dd244ee020e	0	3	t	ff487f42-afe8-4127-94f3-6a49f9e17275	\N
d1bcd55b-a674-46d8-a9c5-547862e4867c	\N	webauthn-authenticator-passwordless	041f8a3b-b936-410d-b423-b51f4cd23d7f	24cdb1d8-941b-4e3c-a666-5688f1e32dfa	0	0	f	\N	\N
8e6be86f-6736-45d4-a2a7-884d467a0438	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	2682f1c6-1d98-42fd-b63d-24465affa118	0	5	t	5ca2fced-5865-41b6-8331-b70361cf8868	\N
01d9d4e2-9265-46db-b1cd-bf93c1063624	\N	registration-page-form	041f8a3b-b936-410d-b423-b51f4cd23d7f	a580d03f-f0fb-4954-9bfe-6dd244ee020e	0	2	t	9866558f-1e32-41c2-a262-fda458239093	\N
35af1776-575f-4de1-aa68-b72f9dd76c3f	\N	user-creation-no-account	041f8a3b-b936-410d-b423-b51f4cd23d7f	9866558f-1e32-41c2-a262-fda458239093	0	0	f	\N	\N
4593465a-1802-4527-84fd-b96a15856ea1	\N	auth-cookie	041f8a3b-b936-410d-b423-b51f4cd23d7f	973eea2f-4967-472f-b2de-7dd850fa7e3b	2	10	f	\N	\N
d68c16d7-030d-41c3-8fe4-04a6c010221d	\N	auth-spnego	041f8a3b-b936-410d-b423-b51f4cd23d7f	973eea2f-4967-472f-b2de-7dd850fa7e3b	3	20	f	\N	\N
decec856-d060-4949-9729-7fa3f4e5e332	\N	identity-provider-redirector	041f8a3b-b936-410d-b423-b51f4cd23d7f	973eea2f-4967-472f-b2de-7dd850fa7e3b	2	25	f	\N	\N
2bb8bb4b-8c27-4b25-8eec-a0c137fd2faa	\N	auth-cookie	c59dea27-0f0a-4d7e-9d51-e1017680e812	57c9e91e-1532-4a66-989f-5739e2591b2a	2	10	f	\N	\N
1b11afe2-104c-4d09-9096-dcae8c3cbb38	\N	auth-spnego	c59dea27-0f0a-4d7e-9d51-e1017680e812	57c9e91e-1532-4a66-989f-5739e2591b2a	3	20	f	\N	\N
52a08949-cbc8-4f11-a3f4-eb0e3ef7734b	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	961e5721-8441-4f00-9be5-4d9b2d9f4340	0	3	t	a703c782-67d0-4833-b780-cf15691036f0	\N
05624a82-e5cb-4ac7-b5d6-e528cecfe151	\N	identity-provider-redirector	c59dea27-0f0a-4d7e-9d51-e1017680e812	57c9e91e-1532-4a66-989f-5739e2591b2a	2	25	f	\N	\N
f549fd89-0865-4d7c-a38e-de76012f34eb	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	973eea2f-4967-472f-b2de-7dd850fa7e3b	0	26	t	961e5721-8441-4f00-9be5-4d9b2d9f4340	\N
668e2215-c091-4800-89f6-935377ec02ca	\N	auth-username-form	041f8a3b-b936-410d-b423-b51f4cd23d7f	961e5721-8441-4f00-9be5-4d9b2d9f4340	0	0	f	\N	\N
c77d5e8c-4b72-490f-9648-e75f548d82d6	\N	reset-credentials-choose-user	041f8a3b-b936-410d-b423-b51f4cd23d7f	b7595a84-e813-4ce9-876a-55463ab779ea	0	10	f	\N	\N
d76e0ec1-7c29-4e77-b580-c39a93c1bf3e	\N	conditional-user-configured	041f8a3b-b936-410d-b423-b51f4cd23d7f	74687f50-ea73-4a8b-9058-75950b8bd00b	0	10	f	\N	\N
507f0e15-aaa0-49fb-9903-c489b3d06bcd	\N	reset-otp	041f8a3b-b936-410d-b423-b51f4cd23d7f	74687f50-ea73-4a8b-9058-75950b8bd00b	0	20	f	\N	\N
cbd8e37e-0d74-4b13-b1ee-33f31fb5c27e	\N	auth-username-password-form	c59dea27-0f0a-4d7e-9d51-e1017680e812	db7200e3-67a8-444a-8cf6-fb16103bbc21	0	10	f	\N	\N
ad810825-90ac-4f9c-8521-67eb49e1df4d	\N	auth-cookie	041f8a3b-b936-410d-b423-b51f4cd23d7f	43819bd0-8929-44fb-aac7-4c452463cf42	2	10	f	\N	\N
131979c8-7780-4e47-bcf9-f263fb690f43	\N	auth-spnego	041f8a3b-b936-410d-b423-b51f4cd23d7f	43819bd0-8929-44fb-aac7-4c452463cf42	3	20	f	\N	\N
9445d48f-5a26-4d51-a505-03357cd48cf6	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	b7595a84-e813-4ce9-876a-55463ab779ea	1	43	t	74687f50-ea73-4a8b-9058-75950b8bd00b	\N
40f03f2b-863e-40fa-8596-54acbac53807	\N	reset-password	041f8a3b-b936-410d-b423-b51f4cd23d7f	b7595a84-e813-4ce9-876a-55463ab779ea	0	41	f	\N	\N
b590656d-d1cd-4159-bc54-f5be789d4a06	\N	identity-provider-redirector	041f8a3b-b936-410d-b423-b51f4cd23d7f	43819bd0-8929-44fb-aac7-4c452463cf42	2	25	f	\N	\N
35833790-25ca-40f9-8bd8-e2eb43ae3f68	\N	auth-username-password-form	041f8a3b-b936-410d-b423-b51f4cd23d7f	8001610b-a86f-4422-8ee1-434669b51960	0	0	f	\N	\N
bb077a94-8ec2-4bfa-b7c3-bb2a4476ded5	\N	conditional-user-configured	041f8a3b-b936-410d-b423-b51f4cd23d7f	7ea0f920-a81e-474f-be0b-422307711abe	0	0	f	\N	\N
36faa8f0-5054-4ad7-9e71-2af8dcf554e5	\N	auth-otp-form	041f8a3b-b936-410d-b423-b51f4cd23d7f	7ea0f920-a81e-474f-be0b-422307711abe	0	1	f	\N	\N
8ed1c9a6-683a-4dad-99a9-c595bed41277	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	8001610b-a86f-4422-8ee1-434669b51960	0	1	t	7ea0f920-a81e-474f-be0b-422307711abe	\N
d017ccd8-6d9f-4183-8dcf-96c2d9a145f0	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	43819bd0-8929-44fb-aac7-4c452463cf42	2	26	t	8001610b-a86f-4422-8ee1-434669b51960	\N
5f31ee06-ae57-4db9-b29f-6f1a5d28a42c	\N	auth-cookie	041f8a3b-b936-410d-b423-b51f4cd23d7f	ced9ebfe-9689-489a-a821-1a4acf77b0ae	2	10	f	\N	\N
d2e029df-2319-419b-bf37-a13b7c374cfd	\N	auth-spnego	041f8a3b-b936-410d-b423-b51f4cd23d7f	ced9ebfe-9689-489a-a821-1a4acf77b0ae	3	20	f	\N	\N
2fc3c58b-617f-4903-ab89-785f2a067aab	\N	identity-provider-redirector	041f8a3b-b936-410d-b423-b51f4cd23d7f	ced9ebfe-9689-489a-a821-1a4acf77b0ae	2	25	f	\N	\N
45423120-af8f-4af1-af92-5d15342504dc	\N	auth-username-password-form	041f8a3b-b936-410d-b423-b51f4cd23d7f	2682f1c6-1d98-42fd-b63d-24465affa118	0	0	f	\N	\N
f8b04ebe-67ff-4ff1-90ec-3b9f762bad26	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	ced9ebfe-9689-489a-a821-1a4acf77b0ae	2	26	t	2682f1c6-1d98-42fd-b63d-24465affa118	\N
0d6bed5c-71a3-438c-b773-688c9a778cde	\N	auth-password-form	041f8a3b-b936-410d-b423-b51f4cd23d7f	a703c782-67d0-4833-b780-cf15691036f0	2	0	f	\N	\N
3d9332fc-c05c-418f-90a8-70945a6e6923	\N	webauthn-authenticator-passwordless	041f8a3b-b936-410d-b423-b51f4cd23d7f	a703c782-67d0-4833-b780-cf15691036f0	2	1	f	\N	\N
ce1f49a4-7d31-48a2-8e4c-a09ac62f240f	\N	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	57c9e91e-1532-4a66-989f-5739e2591b2a	2	30	t	db7200e3-67a8-444a-8cf6-fb16103bbc21	\N
4c0d6a2c-28a5-42ae-b893-82386272ee92	\N	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	db7200e3-67a8-444a-8cf6-fb16103bbc21	0	20	t	71e2f58e-37d0-47a1-9aab-d7540ae4a5e7	\N
daf1f006-490c-4abb-b16e-e3f743d0c6f7	\N	auth-username-form	041f8a3b-b936-410d-b423-b51f4cd23d7f	24cdb1d8-941b-4e3c-a666-5688f1e32dfa	0	0	f	\N	\N
ce1b1df1-962a-4bb5-83b5-347ae646f0db	\N	idp-email-verification	041f8a3b-b936-410d-b423-b51f4cd23d7f	c38cd010-ba0f-4ea9-a726-0ef4713176f3	2	10	f	\N	\N
c76421d9-e1db-41ae-8ded-14727feea4a5	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	c38cd010-ba0f-4ea9-a726-0ef4713176f3	2	20	t	59f63a10-6996-4f6b-ba85-59ad8cd5530f	\N
6b2babcd-76df-4133-8b68-3c876923418f	\N	conditional-user-configured	041f8a3b-b936-410d-b423-b51f4cd23d7f	84b61c59-528b-4a21-a181-2fa09f7ee7e1	0	10	f	\N	\N
a6e05a3a-dc7c-40a6-927a-bdc1e832b7c0	\N	auth-otp-form	041f8a3b-b936-410d-b423-b51f4cd23d7f	84b61c59-528b-4a21-a181-2fa09f7ee7e1	0	20	f	\N	\N
36bddfbe-e763-48ce-aaa4-8578dca1e2af	\N	conditional-user-configured	041f8a3b-b936-410d-b423-b51f4cd23d7f	e0e8ca48-931c-40ec-93bf-e976a47bcbf1	0	10	f	\N	\N
68286d99-02e8-40c2-8994-a62afb19b83b	\N	organization	041f8a3b-b936-410d-b423-b51f4cd23d7f	e0e8ca48-931c-40ec-93bf-e976a47bcbf1	2	20	f	\N	\N
b70c0dcd-41fe-4329-97b1-aeb1b03c90e7	\N	conditional-user-configured	041f8a3b-b936-410d-b423-b51f4cd23d7f	0ac85a24-17d4-4113-a3a5-37781d9aa421	0	10	f	\N	\N
94aecc13-bd4a-4582-a400-51f95693e9c5	\N	direct-grant-validate-otp	041f8a3b-b936-410d-b423-b51f4cd23d7f	0ac85a24-17d4-4113-a3a5-37781d9aa421	0	20	f	\N	\N
b6ebee19-e2ec-46bb-ae18-1cbca190a560	\N	conditional-user-configured	041f8a3b-b936-410d-b423-b51f4cd23d7f	2c2645e8-5fc3-4af1-ae76-8340d2ec1d18	0	10	f	\N	\N
5a63efb2-1b0e-40d9-9566-00802f2629c8	\N	idp-add-organization-member	041f8a3b-b936-410d-b423-b51f4cd23d7f	2c2645e8-5fc3-4af1-ae76-8340d2ec1d18	0	20	f	\N	\N
cd9b53d1-e26e-482f-af63-baff4243efbb	\N	conditional-user-configured	041f8a3b-b936-410d-b423-b51f4cd23d7f	68118a93-f395-406e-a05d-5b91cd07e211	0	10	f	\N	\N
f2d6fdf0-b1cc-4b18-981e-d6edb5fc35f4	\N	auth-otp-form	041f8a3b-b936-410d-b423-b51f4cd23d7f	68118a93-f395-406e-a05d-5b91cd07e211	0	20	f	\N	\N
7d635f0b-3168-45f2-9070-67f229b366a0	\N	idp-confirm-link	041f8a3b-b936-410d-b423-b51f4cd23d7f	5579d775-a74b-4672-bc9e-e5247620c7ba	0	10	f	\N	\N
28eeb98f-18da-418f-b259-6ec5b6b32476	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	5579d775-a74b-4672-bc9e-e5247620c7ba	0	20	t	c38cd010-ba0f-4ea9-a726-0ef4713176f3	\N
796a5a3f-8736-4642-81b2-62c923a90053	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	7a7c9438-479e-4095-847c-39f57d7a27e8	1	10	t	e0e8ca48-931c-40ec-93bf-e976a47bcbf1	\N
349fe9a3-d62c-41c8-9e0b-8f2af8ffd1f8	\N	conditional-user-configured	041f8a3b-b936-410d-b423-b51f4cd23d7f	7e3316ba-45f1-4987-8e8e-c223c8a94072	0	10	f	\N	\N
cc1f194f-9443-40c1-8441-ea91784c1131	\N	reset-otp	041f8a3b-b936-410d-b423-b51f4cd23d7f	7e3316ba-45f1-4987-8e8e-c223c8a94072	0	20	f	\N	\N
08daec7a-aac5-48af-a815-ee7f24a34e81	\N	idp-create-user-if-unique	041f8a3b-b936-410d-b423-b51f4cd23d7f	b35f9628-8c43-4e8a-9733-1875a7a01703	2	10	f	\N	62503c49-3456-4fa1-802f-ca8c0f9272c4
f87967c7-2b34-42f5-ac7d-248d94f5c5a8	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	b35f9628-8c43-4e8a-9733-1875a7a01703	2	20	t	5579d775-a74b-4672-bc9e-e5247620c7ba	\N
9e5de519-a64c-4764-97ee-76f65ae279f2	\N	idp-username-password-form	041f8a3b-b936-410d-b423-b51f4cd23d7f	59f63a10-6996-4f6b-ba85-59ad8cd5530f	0	10	f	\N	\N
f571d225-f368-42ed-aae4-54fd51df77d6	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	59f63a10-6996-4f6b-ba85-59ad8cd5530f	1	20	t	68118a93-f395-406e-a05d-5b91cd07e211	\N
39dfd9a3-b6f2-4c0c-bff0-bf193292cf2e	\N	auth-cookie	041f8a3b-b936-410d-b423-b51f4cd23d7f	815c5d29-7e5e-491e-a9f7-f23895533948	2	10	f	\N	\N
680967e7-ab3b-43fc-8933-db658a4100ce	\N	auth-spnego	041f8a3b-b936-410d-b423-b51f4cd23d7f	815c5d29-7e5e-491e-a9f7-f23895533948	3	20	f	\N	\N
9f252dd9-c95d-45ba-8fa4-a917c804cb98	\N	identity-provider-redirector	041f8a3b-b936-410d-b423-b51f4cd23d7f	815c5d29-7e5e-491e-a9f7-f23895533948	2	25	f	\N	\N
33a2f598-ce6b-4898-9728-62d77bf83b83	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	815c5d29-7e5e-491e-a9f7-f23895533948	2	26	t	7a7c9438-479e-4095-847c-39f57d7a27e8	\N
b3a76efa-63d7-4604-9a15-d0b96c986628	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	815c5d29-7e5e-491e-a9f7-f23895533948	2	30	t	ac1982c4-db12-4e92-a5a5-a5d6965a2b5f	\N
e41135f7-0000-46c6-b524-3b2168e5d319	\N	client-secret	041f8a3b-b936-410d-b423-b51f4cd23d7f	0f830992-1d44-49d3-ba8b-bcded6dd11e2	2	10	f	\N	\N
99fac130-802d-430e-8dc3-9a14260d1f69	\N	client-jwt	041f8a3b-b936-410d-b423-b51f4cd23d7f	0f830992-1d44-49d3-ba8b-bcded6dd11e2	2	20	f	\N	\N
a7ddcb7e-f1c3-4f7b-8891-0973e072608a	\N	client-secret-jwt	041f8a3b-b936-410d-b423-b51f4cd23d7f	0f830992-1d44-49d3-ba8b-bcded6dd11e2	2	30	f	\N	\N
b5423481-d3f5-4bcc-97f9-1c7a7bc82276	\N	client-x509	041f8a3b-b936-410d-b423-b51f4cd23d7f	0f830992-1d44-49d3-ba8b-bcded6dd11e2	2	40	f	\N	\N
2d0e8030-583a-40dd-aac0-741ab4b21bb3	\N	direct-grant-validate-username	041f8a3b-b936-410d-b423-b51f4cd23d7f	4b0c98c6-22d5-42b3-abef-69961d2f5db3	0	10	f	\N	\N
dd4d63e9-08c3-4372-ac14-f1b35ba8bb3f	\N	direct-grant-validate-password	041f8a3b-b936-410d-b423-b51f4cd23d7f	4b0c98c6-22d5-42b3-abef-69961d2f5db3	0	20	f	\N	\N
098e19a9-789a-4edf-91c9-3028720700de	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	4b0c98c6-22d5-42b3-abef-69961d2f5db3	1	30	t	0ac85a24-17d4-4113-a3a5-37781d9aa421	\N
8f0f6cf1-15c8-4471-9f13-c83906a19d37	\N	docker-http-basic-authenticator	041f8a3b-b936-410d-b423-b51f4cd23d7f	a1a2070d-a16f-4bb2-ba75-eb0794751ad7	0	10	f	\N	\N
dc0a2124-6947-44e8-a358-5b997ba3ca90	\N	idp-review-profile	041f8a3b-b936-410d-b423-b51f4cd23d7f	97c789fb-2e97-4d63-b34f-c0f2da0f7c62	0	10	f	\N	2948056b-8eb5-4e43-b7b6-a2c4ddecea5f
c72e1d76-7cfd-4fcc-b3e8-e7d9893e499e	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	97c789fb-2e97-4d63-b34f-c0f2da0f7c62	0	20	t	b35f9628-8c43-4e8a-9733-1875a7a01703	\N
69c68d58-8937-4afe-8e5d-15cfda3f2f9a	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	97c789fb-2e97-4d63-b34f-c0f2da0f7c62	1	50	t	2c2645e8-5fc3-4af1-ae76-8340d2ec1d18	\N
cfc11889-c826-496d-b3fc-955df7ff6bb6	\N	auth-username-password-form	041f8a3b-b936-410d-b423-b51f4cd23d7f	ac1982c4-db12-4e92-a5a5-a5d6965a2b5f	0	10	f	\N	\N
f5462525-719c-42be-b428-dbdc3657793b	\N	registration-page-form	041f8a3b-b936-410d-b423-b51f4cd23d7f	d3ae413b-8592-4bb9-ada7-674a051fe01a	0	10	t	48b12f22-4b46-47b2-a808-0537eb3f7ff1	\N
036c5994-22e2-4d9a-b244-17df55b7b614	\N	registration-user-creation	041f8a3b-b936-410d-b423-b51f4cd23d7f	48b12f22-4b46-47b2-a808-0537eb3f7ff1	0	20	f	\N	\N
092f238a-22e6-44d5-8d42-97f75eaea8fc	\N	registration-password-action	041f8a3b-b936-410d-b423-b51f4cd23d7f	48b12f22-4b46-47b2-a808-0537eb3f7ff1	0	50	f	\N	\N
30d25ba7-f88b-447c-b732-e1f91440cc5c	\N	registration-recaptcha-action	041f8a3b-b936-410d-b423-b51f4cd23d7f	48b12f22-4b46-47b2-a808-0537eb3f7ff1	3	60	f	\N	\N
df9c237e-233d-4120-86a2-93c19edd520f	\N	registration-terms-and-conditions	041f8a3b-b936-410d-b423-b51f4cd23d7f	48b12f22-4b46-47b2-a808-0537eb3f7ff1	3	70	f	\N	\N
d31aab92-7f0c-4640-8edb-921af506bd4f	\N	reset-credentials-choose-user	041f8a3b-b936-410d-b423-b51f4cd23d7f	8ba9f457-250f-4b11-b9d9-7be33e44313b	0	10	f	\N	\N
4a225247-4283-4556-af3c-8988abbf244b	\N	reset-credential-email	041f8a3b-b936-410d-b423-b51f4cd23d7f	8ba9f457-250f-4b11-b9d9-7be33e44313b	0	20	f	\N	\N
63da9170-3d83-482d-b66d-7374b4a41d14	\N	reset-password	041f8a3b-b936-410d-b423-b51f4cd23d7f	8ba9f457-250f-4b11-b9d9-7be33e44313b	0	30	f	\N	\N
19bd7bf4-f29f-48c1-8f03-3baea06adbfa	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	8ba9f457-250f-4b11-b9d9-7be33e44313b	1	40	t	7e3316ba-45f1-4987-8e8e-c223c8a94072	\N
497ac062-8865-446a-aa31-d06d98e52a70	\N	http-basic-authenticator	041f8a3b-b936-410d-b423-b51f4cd23d7f	af617097-f5f1-462f-aedf-b42499c05443	0	10	f	\N	\N
d8ce093f-a2f0-4673-9a41-9ea16864ade6	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	ac1982c4-db12-4e92-a5a5-a5d6965a2b5f	1	20	t	84b61c59-528b-4a21-a181-2fa09f7ee7e1	\N
5f707fb1-d873-4bb0-b6c1-1a864bd4f49d	\N	auth-otp-form	c59dea27-0f0a-4d7e-9d51-e1017680e812	ed0338ee-d6a8-4485-bc3b-e7273e7fa7b0	0	0	f	\N	\N
df0e0f85-3cd6-400a-ab82-0999e8ec0d04	\N	auth-username-form	c59dea27-0f0a-4d7e-9d51-e1017680e812	8299db38-6dd6-4536-853e-f67b12f6b665	0	1	f	\N	\N
686f04a1-4da9-408d-9c67-73faad07d7ef	\N	webauthn-authenticator-passwordless	c59dea27-0f0a-4d7e-9d51-e1017680e812	8299db38-6dd6-4536-853e-f67b12f6b665	0	0	f	\N	\N
67a6c896-4839-44aa-9c4a-5ce4fdff4ba2	\N	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	71e2f58e-37d0-47a1-9aab-d7540ae4a5e7	2	2	t	8299db38-6dd6-4536-853e-f67b12f6b665	\N
f9b26f17-02dd-4bce-8dc9-d1fc76c178cd	\N	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	71e2f58e-37d0-47a1-9aab-d7540ae4a5e7	2	1	t	ed0338ee-d6a8-4485-bc3b-e7273e7fa7b0	\N
0d9f4e20-d669-43f4-bc40-9f016ae780b5	\N	auth-otp-form	041f8a3b-b936-410d-b423-b51f4cd23d7f	6ad6764e-95aa-4c04-b650-32164a59d99c	0	0	f	\N	\N
ddc1d888-30f2-4463-b629-ca52cb720243	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	5ca2fced-5865-41b6-8331-b70361cf8868	2	1	t	24cdb1d8-941b-4e3c-a666-5688f1e32dfa	\N
3c720e6f-6af3-4a5d-b14b-ba45c2c77157	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	5ca2fced-5865-41b6-8331-b70361cf8868	2	0	t	6ad6764e-95aa-4c04-b650-32164a59d99c	\N
\.


--
-- TOC entry 4152 (class 0 OID 16396)
-- Dependencies: 220
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
9714ba60-63f3-4730-a9b9-32a75922bd4f	browser	Browser based authentication	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	t	t
58d92df4-5abf-4836-82a8-6cb875b7827b	forms	Username, password, otp and other auth forms.	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	f	t
8bab3b95-d888-4c50-9d61-604c1d55cc6f	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	f	t
90e3da48-9779-4507-bde5-ae0883c37d7b	direct grant	OpenID Connect Resource Owner Grant	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	t	t
07b4965c-e93f-45af-b09c-9642fb076236	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	f	t
cec96a14-62a4-4f25-809c-50f4e72709f7	registration	Registration flow	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	t	t
11a7231d-e5b7-4327-8700-f97437487e36	registration form	Registration form	c59dea27-0f0a-4d7e-9d51-e1017680e812	form-flow	f	t
ef411cfb-66d1-473b-996b-4ad8e583149c	reset credentials	Reset credentials for a user if they forgot their password or something	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	t	t
e86a5980-fd15-4ed5-90b1-669edd2b4f69	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	f	t
a10420bc-df45-4a9b-a76a-6c534c258b84	clients	Base authentication for clients	c59dea27-0f0a-4d7e-9d51-e1017680e812	client-flow	t	t
e6a735b7-c9c8-4433-80ff-4c933216959a	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	t	t
d241fd75-4f21-4ef4-b78c-f86a72e49a63	User creation or linking	Flow for the existing/non-existing user alternatives	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	f	t
64281406-31b9-4900-b575-b113c0a8a8b3	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	f	t
2f9c2880-196a-4f7e-b7c2-f9bc0bf921d0	Account verification options	Method with which to verity the existing account	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	f	t
14fe958b-e965-4275-ab0c-cda917b55df1	Verify Existing Account by Re-authentication	Reauthentication of existing account	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	f	t
46c6253f-66cc-4c70-aeaf-0f506b02f3b7	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	f	t
e8b1e87c-cfe7-4bfe-bd5e-7e29baefad84	saml ecp	SAML ECP Profile Authentication Flow	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	t	t
38210274-0ac4-40d1-af5d-bc061b29c6f1	docker auth	Used by Docker clients to authenticate against the IDP	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	t	t
57c9e91e-1532-4a66-989f-5739e2591b2a	browser-passkey	Browser based authentication with 2FA/Passkey	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	t	f
db7200e3-67a8-444a-8cf6-fb16103bbc21	Login	Username, password, otp and other auth forms.	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	f	f
71e2f58e-37d0-47a1-9aab-d7540ae4a5e7	Multi-factor Authentication	Config 2FA and Passkey	c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	f	f
8299db38-6dd6-4536-853e-f67b12f6b665	Passkey Authenticator		c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	f	f
ed0338ee-d6a8-4485-bc3b-e7273e7fa7b0	2FA Authenticator		c59dea27-0f0a-4d7e-9d51-e1017680e812	basic-flow	f	f
5ca2fced-5865-41b6-8331-b70361cf8868	Choose MFA		041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	f
6ad6764e-95aa-4c04-b650-32164a59d99c	Confirm 2FA code		041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	f
24cdb1d8-941b-4e3c-a666-5688f1e32dfa	Confirm Passkey		041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	f
c38cd010-ba0f-4ea9-a726-0ef4713176f3	Account verification options	Method with which to verity the existing account	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	t
84b61c59-528b-4a21-a181-2fa09f7ee7e1	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	t
e0e8ca48-931c-40ec-93bf-e976a47bcbf1	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	t
0ac85a24-17d4-4113-a3a5-37781d9aa421	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	t
2c2645e8-5fc3-4af1-ae76-8340d2ec1d18	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	t
68118a93-f395-406e-a05d-5b91cd07e211	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	t
5579d775-a74b-4672-bc9e-e5247620c7ba	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	t
7a7c9438-479e-4095-847c-39f57d7a27e8	Organization	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	t
7e3316ba-45f1-4987-8e8e-c223c8a94072	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	t
b35f9628-8c43-4e8a-9733-1875a7a01703	User creation or linking	Flow for the existing/non-existing user alternatives	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	t
59f63a10-6996-4f6b-ba85-59ad8cd5530f	Verify Existing Account by Re-authentication	Reauthentication of existing account	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	t
815c5d29-7e5e-491e-a9f7-f23895533948	browser	Browser based authentication	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	t	t
0f830992-1d44-49d3-ba8b-bcded6dd11e2	clients	Base authentication for clients	041f8a3b-b936-410d-b423-b51f4cd23d7f	client-flow	t	t
4b0c98c6-22d5-42b3-abef-69961d2f5db3	direct grant	OpenID Connect Resource Owner Grant	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	t	t
a1a2070d-a16f-4bb2-ba75-eb0794751ad7	docker auth	Used by Docker clients to authenticate against the IDP	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	t	t
97c789fb-2e97-4d63-b34f-c0f2da0f7c62	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	t	t
ac1982c4-db12-4e92-a5a5-a5d6965a2b5f	forms	Username, password, otp and other auth forms.	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	t
d3ae413b-8592-4bb9-ada7-674a051fe01a	registration	Registration flow	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	t	t
48b12f22-4b46-47b2-a808-0537eb3f7ff1	registration form	Registration form	041f8a3b-b936-410d-b423-b51f4cd23d7f	form-flow	f	t
8ba9f457-250f-4b11-b9d9-7be33e44313b	reset credentials	Reset credentials for a user if they forgot their password or something	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	t	t
af617097-f5f1-462f-aedf-b42499c05443	saml ecp	SAML ECP Profile Authentication Flow	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	t	t
a580d03f-f0fb-4954-9bfe-6dd244ee020e	registration-passkey	Implementing passkey for register	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	t	f
ff487f42-afe8-4127-94f3-6a49f9e17275	Registration Options		041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	f
9866558f-1e32-41c2-a262-fda458239093	Registration Form		041f8a3b-b936-410d-b423-b51f4cd23d7f	form-flow	f	f
973eea2f-4967-472f-b2de-7dd850fa7e3b	FIDO browser	Custom browser based authentication	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	t	f
961e5721-8441-4f00-9be5-4d9b2d9f4340	FIDO Authentication		041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	f
74687f50-ea73-4a8b-9058-75950b8bd00b	FIDO reset credentials Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	f
b7595a84-e813-4ce9-876a-55463ab779ea	FIDO reset credentials	Custom reset credentials for a user if they forgot their password or something	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	t	f
a703c782-67d0-4833-b780-cf15691036f0	Confirm password		041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	f
8001610b-a86f-4422-8ee1-434669b51960	browser-2FA-code Copy of browser-passkey Login flow	Config 2FA and Passkey	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	f
7ea0f920-a81e-474f-be0b-422307711abe	browser-2FA-code Copy of browser-passkey 2FA and Passkey	Config 2FA and Passkey	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	f
43819bd0-8929-44fb-aac7-4c452463cf42	browser-2FA-code	Browser log in + 2FA code	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	t	f
ced9ebfe-9689-489a-a821-1a4acf77b0ae	browser-passkey	Browser log in + Passkey	041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	t	f
2682f1c6-1d98-42fd-b63d-24465affa118	Login flow		041f8a3b-b936-410d-b423-b51f4cd23d7f	basic-flow	f	f
\.


--
-- TOC entry 4153 (class 0 OID 16404)
-- Dependencies: 221
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
d01cdad8-4793-4d7d-9858-b63b442dfe4a	review profile config	c59dea27-0f0a-4d7e-9d51-e1017680e812
1915f566-c2a5-41c6-b13f-e8c938c1d9d8	create unique user config	c59dea27-0f0a-4d7e-9d51-e1017680e812
62503c49-3456-4fa1-802f-ca8c0f9272c4	create unique user config	041f8a3b-b936-410d-b423-b51f4cd23d7f
2948056b-8eb5-4e43-b7b6-a2c4ddecea5f	review profile config	041f8a3b-b936-410d-b423-b51f4cd23d7f
\.


--
-- TOC entry 4154 (class 0 OID 16407)
-- Dependencies: 222
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
1915f566-c2a5-41c6-b13f-e8c938c1d9d8	false	require.password.update.after.registration
d01cdad8-4793-4d7d-9858-b63b442dfe4a	missing	update.profile.on.first.login
2948056b-8eb5-4e43-b7b6-a2c4ddecea5f	missing	update.profile.on.first.login
62503c49-3456-4fa1-802f-ca8c0f9272c4	false	require.password.update.after.registration
\.


--
-- TOC entry 4155 (class 0 OID 16412)
-- Dependencies: 223
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 4156 (class 0 OID 16417)
-- Dependencies: 224
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	f	master-realm	0	f	\N	\N	t	\N	f	c59dea27-0f0a-4d7e-9d51-e1017680e812	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
9eee2754-cbf5-42b9-a7ea-d782447cc4f4	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	c59dea27-0f0a-4d7e-9d51-e1017680e812	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d8fa8480-9e7f-4fc2-bec5-8479023566c5	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	c59dea27-0f0a-4d7e-9d51-e1017680e812	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
c53d33f2-6196-4a0e-bb5b-5f6b2f49af07	t	f	broker	0	f	\N	\N	t	\N	f	c59dea27-0f0a-4d7e-9d51-e1017680e812	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
dbe09ae6-8593-4a11-9455-03f179bbae8c	t	f	fhir-realm-realm	0	f	\N	\N	t	\N	f	c59dea27-0f0a-4d7e-9d51-e1017680e812	\N	0	f	f	fhir-realm Realm	f	client-secret	\N	\N	\N	t	f	f	f
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	t	f	account	0	t	\N	/realms/fhir-realm/account/	f	\N	f	041f8a3b-b936-410d-b423-b51f4cd23d7f	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a7143ea8-7fcd-40a5-9b15-f417b9648c00	t	f	account-console	0	t	\N	/realms/fhir-realm/account/	f	\N	f	041f8a3b-b936-410d-b423-b51f4cd23d7f	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
b45b4d12-0a18-4c96-b1da-226175ba3a7b	t	t	admin-cli	0	t	\N	\N	f	\N	f	041f8a3b-b936-410d-b423-b51f4cd23d7f	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
f36c6fd0-b46c-43d5-9413-0e462e191822	t	t	apple-health	0	t	\N		f		f	041f8a3b-b936-410d-b423-b51f4cd23d7f	openid-connect	-1	t	f	Apple Health	f	client-secret			\N	t	f	t	f
14dca9b5-d63b-408f-be63-605611e53d4b	t	f	broker	0	f	\N	\N	t	\N	f	041f8a3b-b936-410d-b423-b51f4cd23d7f	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
636672b6-143d-4bf2-ac14-e0feade63dc6	t	t	clinic-A	0	f	4u04iT8wxA5iw4xJzlAr2yAdfUE65DVd		f		f	041f8a3b-b936-410d-b423-b51f4cd23d7f	openid-connect	-1	t	f	Clinic A	t	client-secret			\N	t	f	f	f
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	t	t	fhir-server	0	t	\N		f		f	041f8a3b-b936-410d-b423-b51f4cd23d7f	openid-connect	-1	t	f	FHIR server	f	client-secret			\N	t	f	t	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	t	t	inferno-ehr	0	f	XfccslJAZwBk1AT1JzdV2tee5rHEAzAG	http://localhost	f	http://localhost	f	041f8a3b-b936-410d-b423-b51f4cd23d7f	openid-connect	-1	t	f	Inferno Test EHR	t	client-secret	http://localhost	An Inferno test for EHR scenarios	\N	t	f	t	f
d0e81265-5646-4d25-9bb0-c689a2a61478	t	t	inferno-ehr-public	0	t	\N	http://localhost	f	http://localhost	f	041f8a3b-b936-410d-b423-b51f4cd23d7f	openid-connect	-1	t	f	Inferno EHR Public	f	client-secret	http://localhost		\N	t	f	t	f
363258bf-2231-431d-82ba-63c63ce82c2e	t	f	realm-management	0	f	\N	\N	t	\N	f	041f8a3b-b936-410d-b423-b51f4cd23d7f	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	t	t	validation-service	0	f	njCJu4HFSaB15rHCM5OY0llsO3OuHvNv		f		f	041f8a3b-b936-410d-b423-b51f4cd23d7f	openid-connect	-1	t	f	Validate token	t	client-secret			\N	t	f	t	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	t	t	inferno-ehr-asymmetric	0	t	\N		f		f	041f8a3b-b936-410d-b423-b51f4cd23d7f	openid-connect	-1	t	f		f	client-secret			\N	t	f	t	f
767d4eee-87ba-42cc-a25d-0d904138f24f	t	t	security-admin-console	0	t	\N	/admin/master/console/	f		f	c59dea27-0f0a-4d7e-9d51-e1017680e812	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}		\N	t	f	f	f
8c1a8594-ee37-49ad-9bc5-6db27db6a544	t	t	security-admin-console	0	t	\N	/admin/fhir-realm/console	f		f	041f8a3b-b936-410d-b423-b51f4cd23d7f	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}		\N	t	f	t	f
58d58f34-c0be-4479-b8d6-eedb5a5a3210	t	t	admin-cli	0	f	mwZZq1ovrwL4B9KEsCuHJFVs4a5h4iOD		f		f	c59dea27-0f0a-4d7e-9d51-e1017680e812	openid-connect	0	f	f	${client_admin-cli}	t	client-secret			\N	f	f	t	f
\.


--
-- TOC entry 4157 (class 0 OID 16435)
-- Dependencies: 225
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
9eee2754-cbf5-42b9-a7ea-d782447cc4f4	post.logout.redirect.uris	+
d8fa8480-9e7f-4fc2-bec5-8479023566c5	post.logout.redirect.uris	+
d8fa8480-9e7f-4fc2-bec5-8479023566c5	pkce.code.challenge.method	S256
767d4eee-87ba-42cc-a25d-0d904138f24f	post.logout.redirect.uris	+
767d4eee-87ba-42cc-a25d-0d904138f24f	pkce.code.challenge.method	S256
767d4eee-87ba-42cc-a25d-0d904138f24f	client.use.lightweight.access.token.enabled	true
58d58f34-c0be-4479-b8d6-eedb5a5a3210	client.use.lightweight.access.token.enabled	true
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	realm_client	false
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	post.logout.redirect.uris	+
a7143ea8-7fcd-40a5-9b15-f417b9648c00	realm_client	false
a7143ea8-7fcd-40a5-9b15-f417b9648c00	post.logout.redirect.uris	+
a7143ea8-7fcd-40a5-9b15-f417b9648c00	pkce.code.challenge.method	S256
b45b4d12-0a18-4c96-b1da-226175ba3a7b	realm_client	false
b45b4d12-0a18-4c96-b1da-226175ba3a7b	client.use.lightweight.access.token.enabled	true
b45b4d12-0a18-4c96-b1da-226175ba3a7b	post.logout.redirect.uris	+
f36c6fd0-b46c-43d5-9413-0e462e191822	request.object.signature.alg	any
f36c6fd0-b46c-43d5-9413-0e462e191822	request.object.encryption.alg	any
f36c6fd0-b46c-43d5-9413-0e462e191822	client.introspection.response.allow.jwt.claim.enabled	false
f36c6fd0-b46c-43d5-9413-0e462e191822	standard.token.exchange.enabled	false
f36c6fd0-b46c-43d5-9413-0e462e191822	frontchannel.logout.session.required	true
f36c6fd0-b46c-43d5-9413-0e462e191822	oauth2.device.authorization.grant.enabled	false
f36c6fd0-b46c-43d5-9413-0e462e191822	backchannel.logout.revoke.offline.tokens	false
f36c6fd0-b46c-43d5-9413-0e462e191822	use.refresh.tokens	true
f36c6fd0-b46c-43d5-9413-0e462e191822	realm_client	false
f36c6fd0-b46c-43d5-9413-0e462e191822	oidc.ciba.grant.enabled	false
f36c6fd0-b46c-43d5-9413-0e462e191822	client.use.lightweight.access.token.enabled	false
f36c6fd0-b46c-43d5-9413-0e462e191822	backchannel.logout.session.required	true
f36c6fd0-b46c-43d5-9413-0e462e191822	request.object.required	not required
f36c6fd0-b46c-43d5-9413-0e462e191822	client_credentials.use_refresh_token	false
f36c6fd0-b46c-43d5-9413-0e462e191822	access.token.header.type.rfc9068	false
f36c6fd0-b46c-43d5-9413-0e462e191822	tls.client.certificate.bound.access.tokens	false
f36c6fd0-b46c-43d5-9413-0e462e191822	require.pushed.authorization.requests	false
f36c6fd0-b46c-43d5-9413-0e462e191822	acr.loa.map	{}
f36c6fd0-b46c-43d5-9413-0e462e191822	display.on.consent.screen	false
f36c6fd0-b46c-43d5-9413-0e462e191822	request.object.encryption.enc	any
f36c6fd0-b46c-43d5-9413-0e462e191822	pkce.code.challenge.method	S256
f36c6fd0-b46c-43d5-9413-0e462e191822	token.response.type.bearer.lower-case	false
14dca9b5-d63b-408f-be63-605611e53d4b	realm_client	true
14dca9b5-d63b-408f-be63-605611e53d4b	post.logout.redirect.uris	+
636672b6-143d-4bf2-ac14-e0feade63dc6	client.secret.creation.time	1750327890
636672b6-143d-4bf2-ac14-e0feade63dc6	request.object.signature.alg	any
636672b6-143d-4bf2-ac14-e0feade63dc6	request.object.encryption.alg	any
636672b6-143d-4bf2-ac14-e0feade63dc6	client.introspection.response.allow.jwt.claim.enabled	false
636672b6-143d-4bf2-ac14-e0feade63dc6	standard.token.exchange.enabled	false
636672b6-143d-4bf2-ac14-e0feade63dc6	frontchannel.logout.session.required	true
636672b6-143d-4bf2-ac14-e0feade63dc6	oauth2.device.authorization.grant.enabled	false
636672b6-143d-4bf2-ac14-e0feade63dc6	use.jwks.url	false
636672b6-143d-4bf2-ac14-e0feade63dc6	backchannel.logout.revoke.offline.tokens	false
636672b6-143d-4bf2-ac14-e0feade63dc6	use.refresh.tokens	true
636672b6-143d-4bf2-ac14-e0feade63dc6	realm_client	false
636672b6-143d-4bf2-ac14-e0feade63dc6	oidc.ciba.grant.enabled	false
636672b6-143d-4bf2-ac14-e0feade63dc6	client.use.lightweight.access.token.enabled	false
636672b6-143d-4bf2-ac14-e0feade63dc6	backchannel.logout.session.required	true
636672b6-143d-4bf2-ac14-e0feade63dc6	request.object.required	not required
636672b6-143d-4bf2-ac14-e0feade63dc6	client_credentials.use_refresh_token	false
636672b6-143d-4bf2-ac14-e0feade63dc6	access.token.header.type.rfc9068	false
636672b6-143d-4bf2-ac14-e0feade63dc6	tls.client.certificate.bound.access.tokens	false
636672b6-143d-4bf2-ac14-e0feade63dc6	require.pushed.authorization.requests	false
636672b6-143d-4bf2-ac14-e0feade63dc6	acr.loa.map	{}
636672b6-143d-4bf2-ac14-e0feade63dc6	display.on.consent.screen	false
636672b6-143d-4bf2-ac14-e0feade63dc6	request.object.encryption.enc	any
636672b6-143d-4bf2-ac14-e0feade63dc6	token.response.type.bearer.lower-case	false
636672b6-143d-4bf2-ac14-e0feade63dc6	post.logout.redirect.uris	+
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	client.secret.creation.time	1750217884
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	request.object.signature.alg	any
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	request.object.encryption.alg	any
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	client.introspection.response.allow.jwt.claim.enabled	false
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	standard.token.exchange.enabled	false
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	frontchannel.logout.session.required	true
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	oauth2.device.authorization.grant.enabled	false
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	backchannel.logout.revoke.offline.tokens	false
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	use.refresh.tokens	true
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	realm_client	false
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	oidc.ciba.grant.enabled	false
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	client.use.lightweight.access.token.enabled	false
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	backchannel.logout.session.required	true
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	request.object.required	not required
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	client_credentials.use_refresh_token	false
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	access.token.header.type.rfc9068	false
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	tls.client.certificate.bound.access.tokens	false
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	require.pushed.authorization.requests	false
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	acr.loa.map	{}
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	display.on.consent.screen	false
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	request.object.encryption.enc	any
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	token.response.type.bearer.lower-case	false
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	post.logout.redirect.uris	+
d7f84708-6ae4-42ea-93d3-825c725f7d2c	client.secret.creation.time	1750653942
d7f84708-6ae4-42ea-93d3-825c725f7d2c	request.object.signature.alg	any
d7f84708-6ae4-42ea-93d3-825c725f7d2c	request.object.encryption.alg	any
d7f84708-6ae4-42ea-93d3-825c725f7d2c	client.introspection.response.allow.jwt.claim.enabled	false
d7f84708-6ae4-42ea-93d3-825c725f7d2c	standard.token.exchange.enabled	false
d7f84708-6ae4-42ea-93d3-825c725f7d2c	frontchannel.logout.session.required	true
d7f84708-6ae4-42ea-93d3-825c725f7d2c	oauth2.device.authorization.grant.enabled	false
d7f84708-6ae4-42ea-93d3-825c725f7d2c	use.jwks.url	false
d7f84708-6ae4-42ea-93d3-825c725f7d2c	backchannel.logout.revoke.offline.tokens	false
d7f84708-6ae4-42ea-93d3-825c725f7d2c	use.refresh.tokens	true
d7f84708-6ae4-42ea-93d3-825c725f7d2c	realm_client	false
d7f84708-6ae4-42ea-93d3-825c725f7d2c	oidc.ciba.grant.enabled	false
d7f84708-6ae4-42ea-93d3-825c725f7d2c	client.use.lightweight.access.token.enabled	false
d7f84708-6ae4-42ea-93d3-825c725f7d2c	backchannel.logout.session.required	true
d7f84708-6ae4-42ea-93d3-825c725f7d2c	request.object.required	not required
d7f84708-6ae4-42ea-93d3-825c725f7d2c	client_credentials.use_refresh_token	false
d7f84708-6ae4-42ea-93d3-825c725f7d2c	access.token.header.type.rfc9068	false
d7f84708-6ae4-42ea-93d3-825c725f7d2c	tls.client.certificate.bound.access.tokens	false
d7f84708-6ae4-42ea-93d3-825c725f7d2c	require.pushed.authorization.requests	false
d7f84708-6ae4-42ea-93d3-825c725f7d2c	acr.loa.map	{}
d7f84708-6ae4-42ea-93d3-825c725f7d2c	display.on.consent.screen	false
d7f84708-6ae4-42ea-93d3-825c725f7d2c	request.object.encryption.enc	any
d7f84708-6ae4-42ea-93d3-825c725f7d2c	token.response.type.bearer.lower-case	false
d7f84708-6ae4-42ea-93d3-825c725f7d2c	post.logout.redirect.uris	+
d0e81265-5646-4d25-9bb0-c689a2a61478	request.object.signature.alg	any
d0e81265-5646-4d25-9bb0-c689a2a61478	request.object.encryption.alg	any
d0e81265-5646-4d25-9bb0-c689a2a61478	client.introspection.response.allow.jwt.claim.enabled	false
d0e81265-5646-4d25-9bb0-c689a2a61478	standard.token.exchange.enabled	false
d0e81265-5646-4d25-9bb0-c689a2a61478	frontchannel.logout.session.required	true
d0e81265-5646-4d25-9bb0-c689a2a61478	oauth2.device.authorization.grant.enabled	false
d0e81265-5646-4d25-9bb0-c689a2a61478	backchannel.logout.revoke.offline.tokens	false
d0e81265-5646-4d25-9bb0-c689a2a61478	use.refresh.tokens	true
d0e81265-5646-4d25-9bb0-c689a2a61478	realm_client	false
d0e81265-5646-4d25-9bb0-c689a2a61478	oidc.ciba.grant.enabled	false
d0e81265-5646-4d25-9bb0-c689a2a61478	client.use.lightweight.access.token.enabled	false
d0e81265-5646-4d25-9bb0-c689a2a61478	backchannel.logout.session.required	true
d0e81265-5646-4d25-9bb0-c689a2a61478	request.object.required	not required
d0e81265-5646-4d25-9bb0-c689a2a61478	client_credentials.use_refresh_token	false
d0e81265-5646-4d25-9bb0-c689a2a61478	access.token.header.type.rfc9068	false
d0e81265-5646-4d25-9bb0-c689a2a61478	tls.client.certificate.bound.access.tokens	false
d0e81265-5646-4d25-9bb0-c689a2a61478	require.pushed.authorization.requests	false
d0e81265-5646-4d25-9bb0-c689a2a61478	acr.loa.map	{}
d0e81265-5646-4d25-9bb0-c689a2a61478	display.on.consent.screen	false
d0e81265-5646-4d25-9bb0-c689a2a61478	request.object.encryption.enc	any
d0e81265-5646-4d25-9bb0-c689a2a61478	token.response.type.bearer.lower-case	false
d0e81265-5646-4d25-9bb0-c689a2a61478	post.logout.redirect.uris	+
363258bf-2231-431d-82ba-63c63ce82c2e	realm_client	true
363258bf-2231-431d-82ba-63c63ce82c2e	post.logout.redirect.uris	+
8c1a8594-ee37-49ad-9bc5-6db27db6a544	realm_client	false
8c1a8594-ee37-49ad-9bc5-6db27db6a544	client.use.lightweight.access.token.enabled	true
8c1a8594-ee37-49ad-9bc5-6db27db6a544	post.logout.redirect.uris	+
8c1a8594-ee37-49ad-9bc5-6db27db6a544	pkce.code.challenge.method	S256
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	realm_client	false
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	oidc.ciba.grant.enabled	false
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	client.secret.creation.time	1750238484
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	backchannel.logout.session.required	true
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	standard.token.exchange.enabled	true
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	frontchannel.logout.session.required	true
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	oauth2.device.authorization.grant.enabled	true
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	display.on.consent.screen	false
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	backchannel.logout.revoke.offline.tokens	false
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	post.logout.redirect.uris	+
29c5bc63-ce60-4a06-883b-a66d156c84b5	standard.token.exchange.enabled	false
29c5bc63-ce60-4a06-883b-a66d156c84b5	oauth2.device.authorization.grant.enabled	false
29c5bc63-ce60-4a06-883b-a66d156c84b5	oidc.ciba.grant.enabled	false
29c5bc63-ce60-4a06-883b-a66d156c84b5	backchannel.logout.session.required	true
29c5bc63-ce60-4a06-883b-a66d156c84b5	backchannel.logout.revoke.offline.tokens	false
8c1a8594-ee37-49ad-9bc5-6db27db6a544	standard.token.exchange.enabled	false
8c1a8594-ee37-49ad-9bc5-6db27db6a544	oauth2.device.authorization.grant.enabled	false
8c1a8594-ee37-49ad-9bc5-6db27db6a544	oidc.ciba.grant.enabled	false
8c1a8594-ee37-49ad-9bc5-6db27db6a544	display.on.consent.screen	false
8c1a8594-ee37-49ad-9bc5-6db27db6a544	backchannel.logout.session.required	true
8c1a8594-ee37-49ad-9bc5-6db27db6a544	backchannel.logout.revoke.offline.tokens	false
767d4eee-87ba-42cc-a25d-0d904138f24f	realm_client	false
767d4eee-87ba-42cc-a25d-0d904138f24f	standard.token.exchange.enabled	false
767d4eee-87ba-42cc-a25d-0d904138f24f	oauth2.device.authorization.grant.enabled	false
767d4eee-87ba-42cc-a25d-0d904138f24f	oidc.ciba.grant.enabled	false
767d4eee-87ba-42cc-a25d-0d904138f24f	display.on.consent.screen	false
767d4eee-87ba-42cc-a25d-0d904138f24f	backchannel.logout.session.required	true
767d4eee-87ba-42cc-a25d-0d904138f24f	backchannel.logout.revoke.offline.tokens	false
767d4eee-87ba-42cc-a25d-0d904138f24f	client.secret.creation.time	1752547465
58d58f34-c0be-4479-b8d6-eedb5a5a3210	client.secret.creation.time	1753083921
58d58f34-c0be-4479-b8d6-eedb5a5a3210	realm_client	false
58d58f34-c0be-4479-b8d6-eedb5a5a3210	standard.token.exchange.enabled	false
58d58f34-c0be-4479-b8d6-eedb5a5a3210	oauth2.device.authorization.grant.enabled	false
58d58f34-c0be-4479-b8d6-eedb5a5a3210	oidc.ciba.grant.enabled	false
58d58f34-c0be-4479-b8d6-eedb5a5a3210	display.on.consent.screen	false
58d58f34-c0be-4479-b8d6-eedb5a5a3210	backchannel.logout.session.required	true
58d58f34-c0be-4479-b8d6-eedb5a5a3210	backchannel.logout.revoke.offline.tokens	false
\.


--
-- TOC entry 4158 (class 0 OID 16440)
-- Dependencies: 226
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- TOC entry 4159 (class 0 OID 16443)
-- Dependencies: 227
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- TOC entry 4160 (class 0 OID 16446)
-- Dependencies: 228
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- TOC entry 4161 (class 0 OID 16449)
-- Dependencies: 229
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
6178d2a9-a580-4906-bb8b-31990018282c	offline_access	c59dea27-0f0a-4d7e-9d51-e1017680e812	OpenID Connect built-in scope: offline_access	openid-connect
c5a655ce-c550-4608-9f85-819518464c45	role_list	c59dea27-0f0a-4d7e-9d51-e1017680e812	SAML role list	saml
6d6ce73e-3240-46a6-a155-566683389d24	saml_organization	c59dea27-0f0a-4d7e-9d51-e1017680e812	Organization Membership	saml
9989de32-22d3-4753-8d69-655da8e53ada	profile	c59dea27-0f0a-4d7e-9d51-e1017680e812	OpenID Connect built-in scope: profile	openid-connect
c5786f6a-0780-49f4-9481-1c1381acf9cc	email	c59dea27-0f0a-4d7e-9d51-e1017680e812	OpenID Connect built-in scope: email	openid-connect
a21eb8de-fb97-4e20-a427-8c3899be302d	address	c59dea27-0f0a-4d7e-9d51-e1017680e812	OpenID Connect built-in scope: address	openid-connect
aa9d5c9b-ea42-4a49-b554-fd32252f0886	phone	c59dea27-0f0a-4d7e-9d51-e1017680e812	OpenID Connect built-in scope: phone	openid-connect
3c0d71d0-b8f8-4a05-8943-67b65bb34bd7	roles	c59dea27-0f0a-4d7e-9d51-e1017680e812	OpenID Connect scope for add user roles to the access token	openid-connect
e28c5545-1ed1-45b0-8a4e-ac79b7bb6cc6	web-origins	c59dea27-0f0a-4d7e-9d51-e1017680e812	OpenID Connect scope for add allowed web origins to the access token	openid-connect
f710ee27-621f-420a-8073-f774b62572e4	microprofile-jwt	c59dea27-0f0a-4d7e-9d51-e1017680e812	Microprofile - JWT built-in scope	openid-connect
3456e0d7-ec64-4e6c-943d-b4d00b8e3ada	acr	c59dea27-0f0a-4d7e-9d51-e1017680e812	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
bf7a58fc-2d5b-4385-a218-7c194679733a	basic	c59dea27-0f0a-4d7e-9d51-e1017680e812	OpenID Connect scope for add all basic claims to the token	openid-connect
6c33f453-f9bb-4503-a667-1c2f5a77c0b7	service_account	c59dea27-0f0a-4d7e-9d51-e1017680e812	Specific scope for a client enabled for service accounts	openid-connect
e1c884bc-1acc-4801-b560-7b124a2012d3	organization	c59dea27-0f0a-4d7e-9d51-e1017680e812	Additional claims about the organization a subject belongs to	openid-connect
56e2aae1-4467-433a-af4e-c01c216dfab0	service_account	041f8a3b-b936-410d-b423-b51f4cd23d7f	Specific scope for a client enabled for service accounts	openid-connect
dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	acr	041f8a3b-b936-410d-b423-b51f4cd23d7f	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
de001381-7e44-4fa8-b49e-76a9263c3ee8	user/Specimen.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
196faef5-835f-4231-acb3-fcd3c661efa6	phone	041f8a3b-b936-410d-b423-b51f4cd23d7f	OpenID Connect built-in scope: phone	openid-connect
8ab38785-690e-4e8e-adf7-f74b99037080	patient/Location.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
2f483427-27c2-4f28-99e2-a0f1f110d89a	email	041f8a3b-b936-410d-b423-b51f4cd23d7f	OpenID Connect built-in scope: email	openid-connect
05dacaa7-30ea-4e5f-b440-efd8671626ac	patient/Provenance.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
06d8558e-68e6-4a67-af33-e77385cc7931	patient/MedicationDispense.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
ebe8188b-0c77-4993-995d-f7a99a578eb1	offline_access	041f8a3b-b936-410d-b423-b51f4cd23d7f	OpenID Connect built-in scope: offline_access	openid-connect
231c88af-23ce-4090-b1e3-968b9dfb4458	role_list	041f8a3b-b936-410d-b423-b51f4cd23d7f	SAML role list	saml
52609aff-9e18-4b71-9a21-1e04981e70fa	patient/Observation.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
48477b64-55e8-4121-92fe-edeabb65e724	user/Patient.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
ab22d27f-8bd7-4c00-8115-13b3d8613c6c	user/DiagnosticReport.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
5bde7941-4b13-4e13-ad0e-a395490dbc61	patient/*.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
669c24e0-9798-447a-95c7-2a55ac65b237	patient/AllergyIntolerance.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
d7311d75-34cb-4e2d-9d4d-c582260801ac	patient/CarePlan.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
ba3166fc-3636-4089-a02a-35553a6fbeae	patient/CareTeam.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
ab53250f-01a0-4b30-8329-23634f4fefcc	patient/Condition.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
fc422b68-82cf-4220-a937-13b3346eda41	patient/Device.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
faed5bbb-88c2-40c1-aa39-19ca7bfa95bf	patient/DiagnosticReport.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
483ecd4a-f176-411e-897a-1e6931bcfe5f	patient/DocumentReference.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
de5a2d52-38e3-4768-8f53-a46c5e8faf52	patient/Encounter.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
5298c4b4-a89c-4a18-83f4-76461e45ae99	patient/Goal.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
9731bdab-053e-48f6-8095-068677f9bf93	patient/Immunization.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
e366dc19-c0c3-484d-abe9-4df2c38d8f2d	patient/Location.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
d536ec69-7063-4d53-8376-26973d9922c6	patient/Medication.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
edfbac25-1fba-44ba-92a6-ed54a4223db1	patient/MedicationRequest.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
6eb12ac0-9deb-4e76-90a1-69764deec1b5	patient/Observation.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
32e5e12c-2c65-4e80-9be1-44fa2bf94028	patient/Organization.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
676a49c9-b132-4103-85cb-25cd59321af2	patient/Medication.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
62584a10-07a8-4e30-8cf9-28ca14ae516c	patient/Goal.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
0544d9aa-268d-4dbb-a91e-f44bdc594b62	user/MedicationDispense.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
eee47aba-f11c-451b-bb74-c301092240de	patient/DiagnosticReport.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
4bd9da86-ee45-44fe-982e-19d82c9a0f23	patient/Practitioner.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
52ef2827-5c48-448b-8975-40266cc64b66	patient/Patient.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
2b58b3b0-08d8-4dec-881f-19b8a551b2f0	patient/CareTeam.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
51670a24-22af-4044-a2c8-fa6f561cc77b	user/Coverage.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	profile	041f8a3b-b936-410d-b423-b51f4cd23d7f	OpenID Connect built-in scope: profile	openid-connect
bb0efd69-4acb-42c5-a498-346495c587bf	user/Procedure.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
678707fb-8938-48d9-a151-2c07ebce38bf	user/CareTeam.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
06f77d3c-cc1b-4d16-9201-2a1ec974551b	user/DocumentReference.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
be64a559-37eb-4a02-930a-75177c5e8f89	fhirUser	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
e02a4651-1176-4678-b9a2-80876e2dc2f2	roles	041f8a3b-b936-410d-b423-b51f4cd23d7f	OpenID Connect scope for add user roles to the access token	openid-connect
8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	web-origins	041f8a3b-b936-410d-b423-b51f4cd23d7f	OpenID Connect scope for add allowed web origins to the access token	openid-connect
2866ff77-6d11-4076-88b3-47ab819d4685	microprofile-jwt	041f8a3b-b936-410d-b423-b51f4cd23d7f	Microprofile - JWT built-in scope	openid-connect
c9469db6-d939-496e-bf11-02e2750f8a0c	patient-id	041f8a3b-b936-410d-b423-b51f4cd23d7f	A scope used to add patient id to Token	openid-connect
799a3332-71ee-462e-9ad8-9a2b590420b8	user/Practitioner.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
0851e7e7-c812-4fd3-98d5-10b39f394ea2	patient/ServiceRequest.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
7b625778-5ea8-4665-a489-5ac0d9011945	user/AllergyIntolerance.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
d195c82c-f5b7-4af3-89e9-639b337cb874	patient/Device.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
7bdbe596-0ed5-43be-9456-595f9312d706	system/*.*	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
0c3cb893-1132-4214-b00b-b6cf715a97a7	patient/Patient.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
feb7a0b9-e989-4366-8139-05d615a76c21	patient/Practitioner.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
c5328cf1-23a3-4ca3-accd-3b21720da4e2	patient/Procedure.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
fb813041-4997-4d95-b813-46d5ac27b91e	patient/Provenance.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
0f327441-f79e-4ccc-9894-4980d61a9aa6	patient/PractitionerRole.u	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
8c0bcf77-a888-4628-9800-065d5051380e	patient/VisionPrescription.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
45d729c0-ad88-4ed7-bc8c-ba40ac4ec757	patient/VisionPrescription.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
8e3f744f-58e9-410a-8e1b-8984b05f24df	patient/VisionPrescription.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
15563d48-df24-4c77-9074-bf9844f38ebf	patient/Account.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b1ee5ea8-d931-413f-96e1-eca7f6bd0ca2	patient/Account.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
75e00d92-a8c4-4f33-a314-3b2c488bdec7	patient/Account.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e2e759d0-9c92-432c-ab24-37054064b45c	patient/ActivityDefinition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
aace8c85-5c21-4335-a7dc-7b8f8e4f836b	patient/ActivityDefinition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
167ef9a5-4a07-4409-9275-b6b485f144fb	patient/ActivityDefinition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
34ca1dac-6788-4471-888e-b6afc9a151f9	patient/AdverseEvent.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
00ba2755-4a3d-41e5-963e-083defe6302f	patient/AdverseEvent.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
89bca4d6-d2d2-466d-be52-a671b9544a47	patient/AdverseEvent.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2a74ce54-806f-4185-b295-d0149f267339	patient/AllergyIntolerance.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
42b0d279-e28d-4300-9d1e-4b9c7823721d	patient/AllergyIntolerance.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d8315908-07f0-4f92-bf7d-3c1610a891d0	patient/Appointment.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
23054626-fb1b-4b58-b1e3-e155a3799d1b	patient/Appointment.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
440395ac-8f69-4973-adce-462fc4120522	patient/Appointment.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d7da8f38-8c27-4c82-8a96-fa0d416b544b	patient/AppointmentResponse.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ba75754a-52ca-40ef-b3f6-4a29f434a670	patient/Specimen.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
4422a95f-5255-494e-9db8-d3b0557e3de5	user/Organization.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
64bb1677-0898-479e-a67c-e43a31fac4cd	patient/AllergyIntolerance.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
e813ac68-f822-4ad0-ba6e-38813bdb6fb5	user/CarePlan.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
2d1ad2f3-dc40-488e-bf41-88e11bad2dac	system/*.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Access to all patient's data	openid-connect
90374560-2ca4-456d-8801-98ac06c8b0f5	basic	041f8a3b-b936-410d-b423-b51f4cd23d7f	OpenID Connect scope for add all basic claims to the token	openid-connect
9ad3f5c8-0343-488d-b1dc-077332dfcd7f	patient/DocumentReference.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
a5419278-ba86-4340-8edb-ee53c8633d85	patient/Organization.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
bfba13ac-edd0-4bae-a3fc-a03713ffbf5c	token-introspection	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
d145c4d7-c125-4d8c-ba5a-9a27a88005de	user/Goal.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
300fff2d-0cd9-4a6e-9704-e0230695e7d3	user/ServiceRequest.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
6aebfc9a-3c33-4f44-9719-c5a6c4a4c6a8	user/PractitionerRole.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
abde0849-08db-48ad-8443-7a7256b143be	user/Provenance.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
55b6e976-0954-4724-bff3-7e02d096ccdd	patient/CarePlan.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
1e359ee8-1ce0-4eac-bfd2-5651dc12c139	user/Location.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
286969a5-8a61-4c6b-947b-749d53439322	openid	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
d8e8fea8-e7f0-4867-8823-665cf98b3150	address	041f8a3b-b936-410d-b423-b51f4cd23d7f	OpenID Connect built-in scope: address	openid-connect
95bd554c-d279-4898-b145-14284b26d635	patient/Procedure.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
da108e30-fe60-411a-8f18-d8cdfd96bc7f	user/Immunization.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
eee90633-00a0-4c43-84f3-1e4418b77768	patient/AllergyIntolerance.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
8bdc24d1-60c3-49dc-8d9b-ed1dea10d7ed	patient/CarePlan.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
cf6e6dab-5dca-422d-aeca-07c9ee6c0f59	patient/CareTeam.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
1116408b-03c1-441e-92a6-f04b4be4a372	patient/Condition.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
ef68f01a-aa2f-4d46-835f-b18471f512e3	patient/Device.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
d2570df5-42e6-4a25-919b-78f1bb4bb74a	patient/DiagnosticReport.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
3bfa0776-9fff-4b4d-93d4-6f4a41cdc3cd	patient/DocumentReference.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
e835adcb-dd7e-414f-94e4-e3d0ca878075	patient/Encounter.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
595a0072-8691-4ce3-b8a9-6e41ae3af429	patient/Goal.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
125bb4be-470a-4b82-8b95-aa648432cc4d	patient/Immunization.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
5378990c-879c-4b3b-8076-011707faebf8	patient/Location.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
cca675a4-ebcc-4488-8f38-6b16e1d0e77c	patient/Medication.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
d2902ff9-2f92-4e77-b225-5838adf91fd9	patient/MedicationRequest.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
410b1e5f-2686-43f2-bbaa-b8fd3eedace1	patient/Observation.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
6f6ee623-c214-4af7-9e20-66cf5b26b3ce	patient/Organization.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
9de8b34d-2499-4b06-a0c9-8d453c1d52db	patient/Patient.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
4360735b-545e-4aaa-b69a-8fbc59d0114b	patient/Practitioner.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
43bba933-f048-4092-aa04-4d8d380ec896	patient/Procedure.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
dbb04868-6125-46de-9a5d-de8bedaac40e	patient/Provenance.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
e377d3df-ff4e-43b9-8b55-82cb4cafd891	patient/PractitionerRole.c	041f8a3b-b936-410d-b423-b51f4cd23d7f	Update only scope generated by REST API call	openid-connect
f0425add-100d-4570-9da1-a87ab4d182b8	user/Observation.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
3a11b03f-a652-4dba-9cc2-f76f7c916609	patient/Immunization.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
fc7b70e8-6c5d-4254-ad66-4432a61e73f5	patient/Encounter.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
3629ba2b-2071-403a-8d48-c56bf7e287f6	organization	041f8a3b-b936-410d-b423-b51f4cd23d7f	Additional claims about the organization a subject belongs to	openid-connect
f850dfd4-7f01-4d04-84e5-271530cf4c70	user/MedicationRequest.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
667c1f02-310a-43e7-8a25-68d6abc771d8	patient/Condition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
b2d3a92b-3b2f-4ba5-8478-6c44a9379989	user/Device.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
5774ea8c-8a74-46cc-8fc4-de6637936b45	user/Medication.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
9d4acc7c-a02b-46e1-b1e3-6228917f908d	patient/PractitionerRole.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
bfd7612d-abd5-4ed8-8ec4-04fc1ccea5a1	launch/patient	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
8f2ed22a-ea43-4a5d-935b-1e477d88bd00	user/Encounter.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
1bbe4253-bf7c-4f64-9a0a-a2d0bb505b15	patient/*.*	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
3e2b5486-649e-44e2-8090-31bd2e6e995e	patient/MedicationRequest.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
43cdff75-7926-4a08-bf2f-aa54a74202b2	patient/AppointmentResponse.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
79362aa9-9881-4ae6-bc51-44eb917f7554	patient/AppointmentResponse.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ed849d83-ef6e-4486-aae6-7e459c2d5825	patient/AuditEvent.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d9145244-3632-4b26-8476-c6878c3aa070	patient/AuditEvent.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
9b8f72ac-447f-4964-99f3-29b9582e4073	patient/AuditEvent.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2f99d979-17ef-4ed7-896c-833bc8bcc032	patient/Basic.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7806c004-bae3-4266-9da3-964c853e392e	patient/Basic.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
fd5aa840-8f62-4220-8043-f6a1f132cd3c	patient/Basic.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7efe80bb-8a8f-4339-80cb-20f378a8dc25	patient/Binary.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
a773e372-d826-4bd6-90f5-74caad26d3e7	patient/Binary.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5dfbd89f-8c18-474b-9539-f36907361f6f	patient/AllergyIntolerance.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
24f26bd5-0557-4bdb-a94e-334e2f73d9b0	patient/CarePlan.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
c61b6a0d-0a10-4beb-bf70-9602297ab94e	patient/CareTeam.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
c22ae79e-cff3-487e-b656-372bafd3d263	patient/Condition.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
89beb243-229b-4a8b-87da-b65106b65958	patient/Coverage.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
97dd5dc6-1099-4d37-9333-cb96f8f84ff3	saml_organization	041f8a3b-b936-410d-b423-b51f4cd23d7f	Organization Membership	saml
7e9eb8cf-b79a-4753-8015-ae415883a962	user/Condition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
2da98831-999b-4efb-a6a8-4d1007994038	launch	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
218c78c8-9bce-4424-896d-f98089f26e28	patient/Device.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
ae3acdee-5010-4564-86cf-3b4c709a7a38	patient/DiagnosticReport.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
90f601de-7e84-47a6-82c9-1b8847ef69a8	patient/DocumentReference.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
d2a8dd5b-b054-41c7-a50f-3a4f8f72679b	patient/Encounter.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
f9955ebd-bd00-42ca-97f0-10b6c4814450	patient/Goal.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
cf6c9831-fc67-4090-aa7e-7e136e323944	patient/Immunization.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
bf99f3b1-2e5b-4816-a5c9-7e12c545f114	patient/Location.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
c4dca583-56f4-4321-adc4-02b468f2e266	patient/Medication.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
e152de04-53be-4817-8fdd-5c5075350ce3	patient/MedicationRequest.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
2d0c315b-bfc0-487c-94c4-94016032e8cf	patient/Observation.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
63c987ed-5786-4f72-a2da-fda70991f508	patient/Organization.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
a7d92a94-bcf6-43c3-bb10-d4589e7b952a	patient/Patient.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
9be14563-01d2-4d25-a112-9b50166575cb	patient/Practitioner.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
992bdac6-8037-4ad8-b53c-772d6af5cb76	patient/Procedure.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
b0f63457-d304-4e49-9267-de55fc5cfec0	patient/Provenance.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
c21b2e25-4d80-4bbe-bfa5-08b7da303d9e	patient/PractitionerRole.rsw	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope generated by REST API call	openid-connect
9d2166fc-7317-4bec-9598-13e7b465f83f	patient/Binary.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
3c94272e-6893-47de-b5cb-b4aab715e0c5	patient/BiologicallyDerivedProduct.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
3c10842a-5b37-42a1-a02d-9f823662aca5	patient/BiologicallyDerivedProduct.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2f19a305-cd61-40d8-b993-8d5095a97b2c	patient/BiologicallyDerivedProduct.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
a0dfc118-a289-4775-84a2-15dbea1c4712	patient/BodyStructure.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f64306fa-62fb-4639-a705-c86a34508208	patient/BodyStructure.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7d86def0-7bf3-4926-a9f8-68adcbc35948	patient/BodyStructure.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
0fa7c25e-a976-46d6-875d-9d77358c3e80	patient/Bundle.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
1a39597e-362b-4e88-ad05-651b779da912	patient/Bundle.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
98765c9e-6963-4f34-8a09-6cb1c1eb5205	patient/Bundle.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
c656fcf0-42f1-4881-9f92-1bf5136fa564	patient/CapabilityStatement.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
495b0250-0c80-4699-a052-9bbba9c4647c	patient/CapabilityStatement.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ca476706-841c-4c50-a54c-c6050378d7d0	patient/CapabilityStatement.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
62ce435c-4667-4ab8-861d-fc0980cd7239	patient/CarePlan.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
126c40cb-d8d6-43ae-909e-a7b0529ffc02	patient/CarePlan.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d3c3e109-4d13-4299-a571-88415ede5353	patient/CareTeam.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
cc746370-f8a5-4d20-9098-9bc8453d0864	patient/CareTeam.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
10b797b0-a7f0-4f2d-a4a0-081944cfc5c8	patient/CatalogEntry.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b004642c-5b16-40ad-a114-f00fe31047b2	patient/CatalogEntry.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
cab246b5-6b29-4392-9b87-e2402376b074	patient/CatalogEntry.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
38a6d525-c7e5-42b3-ab34-61e257fbd790	patient/ChargeItem.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
56b8a484-3458-4243-8983-271114c84fb4	patient/ChargeItem.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
06c10cca-c56c-4f53-8984-be57d76c104e	patient/ChargeItem.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
c77a85d7-16b4-4391-a158-c7adb9de031f	patient/ChargeItemDefinition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
589aa2ed-f8c2-4725-8f01-58230fe81b17	patient/ChargeItemDefinition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d1a50d11-4596-47c1-814c-2c9384bcef9c	patient/ChargeItemDefinition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
45d69681-a209-450c-9cb8-39594ab9cf1a	patient/Claim.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5d30b4f0-ffa5-48cd-ae91-feaa250edfe4	patient/Claim.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b7f85c76-1ea9-41cb-a7be-c37fb9a7c407	patient/Claim.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
3d12b1b5-c4dd-4e47-a374-b8ddae055d9f	patient/ClaimResponse.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e5aa01cd-c0fb-4978-a511-f5525a4709b1	patient/ClaimResponse.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
eddfd122-c10d-419b-bbba-458346a08a59	patient/ClaimResponse.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7fe8d6a5-873b-4224-8f8a-c71833231740	patient/ClinicalImpression.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
68fa6700-665b-4a94-ac85-698b71e73084	patient/ClinicalImpression.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f9034ea0-6ec4-4862-87ea-74c6190e75ff	patient/ClinicalImpression.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7d47b3f9-22d3-4703-9011-901531865315	patient/CodeSystem.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d40ef658-1f34-4f29-88bd-b0307faa51e9	patient/CodeSystem.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b42fd6d7-9dcf-4339-8b2a-265634106299	patient/CodeSystem.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
4543a7e3-1639-4843-94be-f6b8512ece86	patient/Communication.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
fe3486fb-34c2-405a-920c-b1fd75c9502e	patient/Communication.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e84b9822-3907-4aec-adad-7afb1a692ea7	patient/Communication.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
19dc56e8-1893-4e46-a717-348335c6c3e6	patient/CommunicationRequest.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f2733f20-d455-4c83-848d-4c997b38d278	patient/CommunicationRequest.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
697554b3-091d-4b1d-91aa-fddbe7ea858d	patient/CommunicationRequest.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e30d3d7d-c75f-4577-90f8-befd832559ef	patient/CompartmentDefinition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d23843be-84de-4aba-8e50-7f2fbed3948a	patient/CompartmentDefinition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
84a2216f-f16a-4232-917a-177ae52e71e6	patient/CompartmentDefinition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
fdf80c5e-a0dd-4fac-8cbb-88d42547bb93	patient/Composition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
92bc7d80-762d-4d8f-8952-d188e1a8e699	patient/Composition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
32e91204-c5d1-4487-8024-60b4518c55f5	patient/Composition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
6843cf3a-b8fe-4b39-8c1f-1ef12c719a16	patient/ConceptMap.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d3eacc4e-9ad3-424c-aab4-0d402cd271e7	patient/ConceptMap.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7ac22702-ee30-4b0e-9ed9-5bf215e13ccc	patient/ConceptMap.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b98b8445-c3b8-4cf0-a9f0-cc810e45972b	patient/Condition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
15d5293a-d7b9-4911-a629-29ca6758f200	patient/Condition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
4fe14775-5f28-46f2-bec3-8b1e31d62163	patient/Consent.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
78cc0320-966b-4327-9715-e3c2269b8d5f	patient/Consent.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
a40a45aa-11f5-4a06-9c07-3807495083b5	patient/Consent.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
dcca1829-20b2-4026-b227-3c006e5bef4d	patient/Contract.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
36a70ed3-51ac-4a09-bb8d-5d478c80d359	patient/Contract.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
18bef4d5-77c4-414f-bd80-6efd2964ce7b	patient/Contract.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
77dc7cf8-525b-42d6-af90-b483d32bf9fc	patient/Coverage.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5e829fa1-9efb-4288-b8da-ad043fd91522	patient/Coverage.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
c05b536f-c72a-4d03-95c5-43dec6ead9e8	patient/CoverageEligibilityRequest.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
8ba948c5-faf8-424d-b3e8-37b62ad72703	patient/CoverageEligibilityRequest.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2b395db3-d4d6-4f39-a3f6-7eff536e78e0	patient/CoverageEligibilityRequest.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
90ad7e46-76f4-41c2-97a7-6b7dbe40c424	patient/CoverageEligibilityResponse.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
03535d38-0879-4cc6-b49f-bbb0b9f900e7	patient/CoverageEligibilityResponse.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
8d0c1740-07db-47ea-96c4-0e13cc23833e	patient/CoverageEligibilityResponse.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d0cc542a-6dcd-4e8b-8f9d-0320ce424f04	patient/DetectedIssue.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b918c43b-75d7-4e23-87ec-13ad3f714978	patient/DetectedIssue.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
47aac304-a931-497b-8102-15b07ce69435	patient/DetectedIssue.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7506e228-a453-4c1d-9d05-b6264a582a02	patient/Device.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
46cbbe7a-1dcc-4ed2-ac97-a8171114e3f1	patient/Device.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2bc65b7d-d801-4bd1-9211-81a1db0e26cd	patient/DeviceDefinition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
69e99b56-e872-47fe-8099-8f1e3073e046	patient/DeviceDefinition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
1646bc69-d18c-4bde-a1d8-e44910761093	patient/DeviceDefinition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
49b79e5f-199d-4113-b26e-c4f54c9abc0c	patient/DeviceMetric.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2974c445-8458-4bff-8507-7381e41715ff	patient/DeviceMetric.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
fe27ed2a-9a43-4460-b7fd-da3e758b21f0	patient/DeviceMetric.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b18798c5-a4ee-47d3-b46d-8e191ffee50d	patient/DeviceRequest.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5f701f98-4852-474a-8a41-9e0858f776b9	patient/DeviceRequest.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
98c091a3-e5be-45ef-97b2-a6718fa87eb7	patient/DeviceRequest.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
8693c08a-b7cb-4c03-b877-7c107d9a282b	patient/DeviceUseStatement.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e4203d44-8bd0-456e-bccf-d6c630e54f42	patient/DeviceUseStatement.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
9b63cd22-85c1-433a-81a7-69f9ff9e3eef	patient/DeviceUseStatement.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
0fcfc4a0-f0cf-4810-bc50-84602714dd98	patient/DiagnosticReport.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b161b13c-e918-42a2-9285-921be51cf44c	patient/DiagnosticReport.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
602e2722-37e9-4c98-be89-3299ef5136a0	patient/DocumentManifest.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
bd51fe55-bfc7-4e5a-939f-ee7802a863d3	patient/DocumentManifest.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d8c526b7-be21-4c8a-8702-9e005ec61f23	patient/DocumentManifest.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7572cdd4-bfd1-49a5-b605-5d8cbeff0078	patient/DocumentReference.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
cec6f7d8-25d4-4fd1-bf1a-45bdba9f8b93	patient/DocumentReference.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e143b4d8-5b4c-4122-9828-4e1f55282e03	patient/EffectEvidenceSynthesis.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2e9e0c64-2c71-4ff3-b068-fd1f81549fba	patient/EffectEvidenceSynthesis.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
840de913-f4e5-47b7-90ff-8e6233e259cf	patient/EffectEvidenceSynthesis.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2622d011-48ec-4500-a4f5-68587202015a	patient/Encounter.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
175fa0e8-33d8-4662-ae76-f77f9cbcd4dd	patient/Encounter.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
bfa73bf6-3da4-4ce3-8de5-837985a8e0f5	patient/Endpoint.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
a943333a-2352-4bb8-89b3-93140cea226e	patient/Endpoint.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f9c33f64-8292-4e5e-80c6-69baa9522a3b	patient/Endpoint.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
062477c6-4092-4de6-9eb1-497a78b9ab28	patient/EnrollmentRequest.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f08272e6-9979-4739-a032-a75038fb84e4	patient/EnrollmentRequest.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e64f65a7-8877-4c98-9f6a-c41156f6f424	patient/EnrollmentRequest.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
09c38d33-f251-4aec-b894-c4d3078704d0	patient/EnrollmentResponse.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
1b8399f0-ac55-4956-906f-2428ffd15d7b	patient/EnrollmentResponse.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ef3eb33d-4d95-48b6-bc71-418243a1b895	patient/EnrollmentResponse.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2a4f6e5d-687a-4c3a-aa98-f045339f3c46	patient/EpisodeOfCare.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
8ff66e08-647d-4880-8d7d-471ab03f36d7	patient/EpisodeOfCare.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f031feac-4931-4293-9f65-a9038f16b41e	patient/EpisodeOfCare.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5f1ea6cd-12a4-4852-8b0b-27ca6d402f67	patient/EventDefinition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e3b7e890-e2d6-4bcb-96c5-3f1a3c6d8dae	patient/EventDefinition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2bc9644e-da26-4d12-96af-d0e670172551	patient/EventDefinition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
6d41b446-4120-4a64-8fac-a8e1bc04753c	patient/Evidence.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
66ea5ae7-686e-4542-ba15-de99ce84f2df	patient/Evidence.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
50e0de09-4c75-4ee1-bd26-b4402344595a	patient/Evidence.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
a6902e53-4ccb-4dee-9db6-ffe2c7c3b9de	patient/EvidenceVariable.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
9082badf-6439-46fe-a7f4-238fc2399909	patient/EvidenceVariable.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
fed4ee2c-9a3f-41ba-a530-f55d120577c6	patient/EvidenceVariable.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
161fee46-6c21-48d8-8e4f-c0ed60e0c362	patient/ExampleScenario.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
87144a0a-66ab-411b-83cf-5b952d11b566	patient/ExampleScenario.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
c3c820ae-a077-4acd-99b2-a6896bf2c969	patient/ExampleScenario.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
765a1b2d-eb7b-4d11-83a8-0f5c1b464746	patient/ExplanationOfBenefit.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f8b3bca0-efca-4109-a331-d78bab2015fa	patient/ExplanationOfBenefit.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e21b1cd2-cddd-4797-b8d4-84c4eff8c6e4	patient/ExplanationOfBenefit.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
911dec12-7d97-445c-ac5d-9f024a4dee44	patient/FamilyMemberHistory.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
615d233c-d6bc-4cbc-ad50-783c0c81bde3	patient/FamilyMemberHistory.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
02bcc7d6-52b4-4ade-9b32-5fc17c471946	patient/FamilyMemberHistory.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7d3cd13f-3717-4f11-91ea-80d1d54b0edc	patient/Flag.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
6c0d9c3f-922d-4af9-85f2-09ae706888bf	patient/Flag.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
8169cee7-062e-4a92-91c4-45559b0b76e5	patient/Flag.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
84d89f09-c93e-4824-b81c-81b6cb42655e	patient/Goal.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b5319bc6-c001-44b3-a902-26e90b3c1860	patient/Goal.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b2ed7e22-8199-4cb6-9c31-c22a058072fc	patient/GraphDefinition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
eebc4edb-1a93-47b6-ae90-c096bd156b7e	patient/GraphDefinition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
cfd86529-151e-46dd-8a73-ccc0edf85b4d	patient/GraphDefinition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b4bbb475-7c61-45ba-9478-e68e00b4a47a	patient/Group.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
626ba1db-3599-4d0a-9649-2d9184cc321e	patient/Group.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
0df57532-0729-4e93-8e42-f8d484640ee5	patient/Group.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
6c34ecec-7cb4-4d68-ac7b-d68d24814fd1	patient/GuidanceResponse.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e3f8798d-6fa0-4ca8-9bae-1fd48024124d	patient/GuidanceResponse.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
64aba9a5-4a61-4190-b988-d957e4138b53	patient/GuidanceResponse.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ab221cbb-5b05-4cbd-8dd2-f6b6fdbd8657	patient/HealthcareService.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5bcc4d2e-b73d-4b2f-b9fa-707fdc83626b	patient/HealthcareService.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
79f24dd1-f9b7-4cd2-bef0-51b75e456dd9	patient/HealthcareService.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7cee404a-2d05-42fe-9b46-8aba52ed52a6	patient/ImagingStudy.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
a23b8937-5e80-482d-9ae9-198363c58ce5	patient/ImagingStudy.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
065f3e02-955c-4c3c-90ca-5907d87a578c	patient/ImagingStudy.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
4a73e312-ed5c-4e1b-9258-76340d6a57d7	patient/Immunization.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
047a5b9c-2e5f-460f-81df-195a2e8844f4	patient/Immunization.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f590c20b-5cd9-481d-8a3b-cc0de7687e22	patient/ImmunizationEvaluation.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
80d1399b-f866-4cfa-8d24-c209dbaac6b6	patient/ImmunizationEvaluation.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
0456d609-0eb7-447a-aa91-423523c38083	patient/ImmunizationEvaluation.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
bad9385d-d7d6-4def-8f2a-6c2bef1c3f18	patient/ImmunizationRecommendation.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
6fbc4d99-309e-477d-9b3c-892d54d25692	patient/ImmunizationRecommendation.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b4b198ed-5c3c-448d-8553-55d64f840935	patient/ImmunizationRecommendation.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
330fcba9-bcb4-4fe4-a287-bd4fe829dff4	patient/ImplementationGuide.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
18f53fb1-33c1-46b2-a95d-88a14d70eee4	patient/ImplementationGuide.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7af0e687-3df7-48be-b2fc-987aee850d0c	patient/ImplementationGuide.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d8794389-348e-4967-97b7-77cd27f3485d	patient/InsurancePlan.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
8a1399db-9669-4d43-a669-661f3ba788d5	patient/InsurancePlan.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
fde23630-7bd8-407e-8d1b-7da030fbc99a	patient/InsurancePlan.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f83ff40a-c1f5-408b-bbb4-e1ac2a9c737a	patient/Invoice.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
23ecc9dd-b0d6-4086-bdfe-698932f1917d	patient/Invoice.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
91b02d20-12da-4cb9-8d57-3bba7ef16c15	patient/Invoice.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
bed47e4c-58db-4fbb-9d06-14e115281a6a	patient/Library.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ba0f1727-cfb2-4d3e-a042-6b59bdd7fd5b	patient/Library.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f8ecadf7-6578-4099-9d85-6a79c2ecb77a	patient/Library.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
dc086e5b-00f9-4b1b-8862-bbe348973d08	patient/Linkage.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ed77978b-bec1-4c83-b889-77cb0bd005c8	patient/Linkage.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
8bda4041-e3aa-4182-ad24-43b36474b2f0	patient/Linkage.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e87e21b0-0a75-4b0d-9e2c-fd11d06625aa	patient/List.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ebf37fe5-d677-4e97-aa97-c0b3bf6e60dc	patient/List.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
caafd66b-04e3-44fc-9a88-726a796d37de	patient/List.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
de92985e-3441-4ced-8f59-b750de1badad	patient/Location.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2a2db87c-3834-4df7-a925-8174f92fcee3	patient/Location.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7da4bbee-cd9c-4548-b22e-ba2f7d6073d4	patient/Measure.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5b0b7eac-60c1-45f5-91b6-9ec5d3d8fb3f	patient/Measure.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e4a141d6-6ca5-498b-b3b9-bd4a0cb8c512	patient/Measure.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
9cbfe3aa-cadf-4e8d-bdc2-26362fd6f946	patient/MeasureReport.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2e082875-777a-4eb2-b519-f3edb591ddff	patient/MeasureReport.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
91493550-82bc-4b52-9fc8-7c0b708ea150	patient/MeasureReport.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
937c89a4-be98-43e4-8c00-f77005a0f954	patient/Media.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
c535a239-85e4-49aa-a3ff-5b4d928039bb	patient/Media.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
c25730c8-33b3-4b69-ad36-16e982e6e27e	patient/Media.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d53d083c-016b-4237-b864-c0453b2f793a	patient/Medication.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
0fc40810-8dfd-489c-a6b3-5798039afa62	patient/Medication.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
a9ef5350-c2c8-420f-a398-8e115adc33f8	patient/MedicationAdministration.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
72ec077c-7793-4577-8375-cd1ce329586d	patient/MedicationAdministration.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f1253bf1-b808-4297-bc77-a82d422976b8	patient/MedicationAdministration.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b056d7c0-bfab-4e6c-b1f5-8290a954724c	patient/MedicationDispense.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e354dc50-5fd1-4704-a47e-af97a32293e4	patient/MedicationDispense.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d2a22102-62ed-4aef-b05e-877d9673db30	patient/MedicationKnowledge.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5dfdba76-26c8-4bed-82f1-6f7726b02195	patient/MedicationKnowledge.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
bbb75f72-b0a5-4f31-bef4-6da1c1a8b337	patient/MedicationKnowledge.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2878ac9c-fd4c-485c-97e8-19a8057fefdc	patient/MedicationRequest.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
44a6438e-06a1-423c-9a9b-a5ee207f855d	patient/MedicationRequest.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5cdd8acf-0fa3-4c00-aa4e-6b645e9f60a4	patient/MedicationStatement.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
84d58747-dbf8-4ee4-9eab-46c6df76e847	user/*.*	041f8a3b-b936-410d-b423-b51f4cd23d7f		openid-connect
b074ef4c-6121-412a-9320-c667d12a9ed2	patient/MedicationStatement.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
355464d7-8e40-45b6-9b90-5a4fdfc493fa	patient/MedicationStatement.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
0764016a-0d06-414a-b249-645d0f59a187	patient/MedicinalProduct.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7f44a8fd-3526-47c3-be59-db4abb3de63d	patient/MedicinalProduct.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
1584385f-11fb-49ca-af35-fa31a08b356c	patient/MedicinalProduct.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
fb8c9076-47db-4c00-bb3c-40b49fa2d987	patient/MedicinalProductAuthorization.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
1870a570-47cd-4a90-b476-fa24fe7044ac	patient/MedicinalProductAuthorization.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
39d3a579-a584-4218-94d9-2e53dac98f28	patient/MedicinalProductAuthorization.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
3d06220b-a6b7-4b7b-994b-c4ddb5e7ad96	patient/MedicinalProductContraindication.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
1c3c40ad-6805-412a-ad4e-bc6e6ef2f34e	patient/MedicinalProductContraindication.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
42ed3d5b-916a-48b6-bb3b-006d9b187220	patient/MedicinalProductContraindication.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
abf88bfc-73de-44af-8e3d-d537c09ce287	patient/MedicinalProductIndication.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
729757fe-dea7-498c-80d5-0a6e589fbb88	patient/MedicinalProductIndication.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
da39d33e-351a-456d-8830-40af9d15d7e2	patient/MedicinalProductIndication.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ac5acb79-a9da-440f-ae32-9ae45a7067a6	patient/MedicinalProductIngredient.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
354422fc-b2f8-482e-9113-051e6e013b61	patient/MedicinalProductIngredient.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
061f2d22-ec9c-4dab-a393-7c8b17645cc3	patient/MedicinalProductIngredient.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
155ce536-c42d-456f-a67f-aa43dd459f58	patient/MedicinalProductInteraction.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
14c4d887-d0ba-474e-83d1-199eae7db1b4	patient/MedicinalProductInteraction.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
1abfaef9-ce3b-438b-afdf-fabf50d26eed	patient/MedicinalProductInteraction.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5a59fc4f-7d39-40cf-9526-235357c9b394	patient/MedicinalProductManufactured.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2783cedb-72f9-4483-b43b-1805a593c7c9	patient/MedicinalProductManufactured.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
76ca2fa7-6dcc-4293-9d53-c26e719659c3	patient/MedicinalProductManufactured.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
3ddb11c6-1c74-4838-ae31-67b2f70ad342	patient/MedicinalProductPackaged.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
67059fc6-7942-4ef0-b63b-02b8a5cb2280	patient/MedicinalProductPackaged.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
67c4dccc-5309-4040-acee-355c0fee26e8	patient/MedicinalProductPackaged.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
a3b4c5ba-e63c-4daf-863a-3addb3098f33	patient/MedicinalProductPharmaceutical.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
0a4b76c0-a0ec-4d8a-8865-921264098f30	patient/MedicinalProductPharmaceutical.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
bbcfed99-6b2b-4491-a392-60f6ddbe7c91	patient/MedicinalProductPharmaceutical.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
6a356c45-792e-40c6-ad11-1b276446d2cd	patient/MedicinalProductUndesirableEffect.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
4874f483-560f-48fa-9344-e0af44aac585	patient/MedicinalProductUndesirableEffect.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
4c89582f-b9f4-4455-8c54-948a722f9332	patient/MedicinalProductUndesirableEffect.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
30485bbd-157f-4c45-80f3-4f57604da7ac	patient/MessageDefinition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
19cf70dd-321c-4098-b74a-bde1baacc323	patient/MessageDefinition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e5a4c539-dd2b-4d47-83af-774847c3752b	patient/MessageDefinition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ab88fec5-dbde-49bb-93cf-eefeafee64e9	patient/MessageHeader.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
1d566409-443a-4096-9e16-4ec96ee5cd23	patient/MessageHeader.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
80c05831-092f-4049-9df1-df566b6a2698	patient/MessageHeader.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ece2fd04-57e5-4b03-a139-cdcb77d7dfee	patient/MolecularSequence.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
a32dc874-3acd-438d-ab1a-ba244dfabc2c	patient/MolecularSequence.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2ece843c-ae7d-454c-b166-db5f8ec93521	patient/MolecularSequence.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
c304ffd3-7dbc-4e66-a194-c80ffb7952c3	patient/NamingSystem.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
1be09541-39d4-4021-9232-214c00c0bd98	patient/NamingSystem.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e4606bcb-8cd4-42af-b2c3-c26057ab5e40	patient/NamingSystem.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b60ba2a4-a12b-4a1a-9422-963a930457c5	patient/NutritionOrder.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
830209e1-ff70-426d-9825-b37b4fe5044c	patient/NutritionOrder.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
9b451679-b8f4-4afa-8a27-0769787314c7	patient/NutritionOrder.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ddf13a3a-c2e0-4641-9820-8c76b1d83603	patient/Observation.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
45970c92-a1a0-4a3e-aa56-e6a79d5eec07	patient/Observation.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
097ac263-341e-4f60-af98-92b004c47eec	patient/ObservationDefinition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f52a92c1-ea91-4896-9e82-cdcab6ad8b9b	patient/ObservationDefinition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f1ae55eb-0110-4c56-9bb0-a7dc1951163a	patient/ObservationDefinition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
49485b76-b629-4eb9-bafe-ab5023ace8b3	patient/OperationDefinition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
55b83805-2e91-47a5-ae96-9f2c980c373a	patient/OperationDefinition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
c2e16739-e704-4fb5-9694-9c041a2e4773	patient/OperationDefinition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
fed26260-eb28-4c01-9e21-7159ba78253a	patient/OperationOutcome.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
a5a8530d-46c8-4119-8cf8-9bf08aed26f3	patient/OperationOutcome.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
9d092bd4-7a24-4c55-ab20-fd4198073ef0	patient/OperationOutcome.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b82a2f07-4318-429f-a713-0785b530a036	patient/Organization.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
fefba933-c1de-4f0f-88d0-0cbaaf288c9d	patient/Organization.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
50cfd70b-866e-484c-857a-abe1544f0fa2	patient/OrganizationAffiliation.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
533e9263-ab8f-4eff-b110-5415343d654e	patient/OrganizationAffiliation.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
dce5a8d5-83e5-4e5f-be55-6e8602f2de3c	patient/OrganizationAffiliation.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
a5811e5e-064a-4718-b67d-f176bd17c617	patient/Parameters.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
60aaefe8-5126-4c01-9cb1-ff300a3bccf4	patient/Parameters.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
63be8afc-7c04-47f0-aace-1befbcbaf491	patient/Parameters.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
a809ef25-089c-48ad-ac4f-e5c88996d0ff	patient/Patient.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
9b68ba20-c21d-4058-9f18-9b051b05eae8	patient/Patient.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
27d480ce-a7af-43c6-9f4d-dd591701a471	patient/PaymentNotice.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
05eea5d8-f24c-4238-951f-7e2157f7ce9b	patient/PaymentNotice.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
0da1ed0a-d556-4ee7-918e-f25fa0b07502	patient/PaymentNotice.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
68a71efd-07ac-4725-9cd6-eb5af6cf6f87	patient/PaymentReconciliation.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
e81aa034-ad18-4cc1-8410-19bbc3bd87bc	patient/PaymentReconciliation.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b1ac7d6d-8448-42be-93eb-2d5604dfb696	patient/PaymentReconciliation.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b5842ac9-099a-4315-9425-190ed9f6093e	patient/Person.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
8ece4421-afba-4d83-bf06-b3e121d12999	patient/Person.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
21cc9678-32f4-4307-b177-b5a6d0d27ec2	patient/Person.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
dc718b7e-7918-4fb7-a15d-f4a4d8566138	patient/PlanDefinition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
0cf3f16b-8e24-4a9e-b064-87ea7c2741de	patient/PlanDefinition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7faa433a-f5d7-43c1-af9d-c4c5cb8de237	patient/PlanDefinition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
273e009a-bed0-4995-80c1-3236bd78ef8c	patient/Practitioner.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7bf78fea-7ab5-4176-9ec0-7a0b9d3adecf	patient/Practitioner.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
0b7739aa-f62c-4e67-9c32-1c0fa4912f8f	patient/PractitionerRole.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
111c51db-f146-4831-961d-ecf8ce6cf188	patient/PractitionerRole.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
4808ee1e-c9ab-421d-82da-6b5bbd4780aa	patient/Procedure.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
001d65a0-366d-4d67-a8e8-f9b689b02de8	patient/Procedure.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ba7ec3c1-2161-403d-898a-1d964eedf23b	patient/Provenance.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
1dc3e712-31a1-432b-884a-7363a98da186	patient/Provenance.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
39c3d188-09e1-4ff9-a9e1-34dc7353b9e4	patient/Questionnaire.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ac5f36b1-6070-4b84-97b3-72078e051deb	patient/Questionnaire.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
9370d410-c486-4be0-aa9a-81c0ac4f9384	patient/Questionnaire.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b6c8884a-26c5-415d-818f-690fa99fd11b	patient/QuestionnaireResponse.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
093bdec8-d6c5-4cdd-8a9f-9cffa0ff3e89	patient/QuestionnaireResponse.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f3d58afa-c59a-49c4-9d1f-56fa8a8251af	patient/QuestionnaireResponse.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
107cca17-17c9-4ee9-bcb9-537525d9bf07	patient/RelatedPerson.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
647d9c71-93a3-4ac6-8497-fa64f9dae118	patient/RelatedPerson.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
6151aa22-02ab-4cd1-873c-c6203d60eb95	patient/RelatedPerson.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
17fca5f8-1ca1-41c7-bf3c-d4b8dd6dc159	patient/RequestGroup.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7130819b-fe55-4316-83cd-30d064a58d82	patient/RequestGroup.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
10c788f0-1ef9-440b-8d30-83917aa4addc	patient/RequestGroup.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
6ca86c95-e876-4f42-99a0-e2f3d572f897	patient/ResearchDefinition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
9437f7ea-9860-4dac-8661-97f7189bf97d	patient/ResearchDefinition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
97eb755d-d91b-4c71-ac1c-88158289bafc	patient/ResearchDefinition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ca51ebd0-68cb-4e8a-9bbd-34d9a6acf710	patient/ResearchElementDefinition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
99ad4f51-d0f2-4bb6-a4f9-21dbcdaa96eb	patient/ResearchElementDefinition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
41c6596c-6dce-4646-b974-a3a54eef84c7	patient/ResearchElementDefinition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
444d4984-223c-40d1-a431-5f437a204b11	patient/ResearchStudy.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
3f0fecf0-f9d8-48ee-a4c2-16eb827a14f8	patient/ResearchStudy.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
155119b7-f1f3-440c-b7d9-4af504760459	patient/ResearchStudy.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
611e4c87-c553-421c-8184-3b01f9194dee	patient/ResearchSubject.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
c4b925e0-a011-430d-91f7-776a5e3ccaf1	patient/ResearchSubject.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
59c26954-3efd-4346-aa7a-b43c328c3863	patient/ResearchSubject.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
083fe495-a579-41e1-a5c8-c0c0007164e8	patient/RiskAssessment.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f89b9061-6295-4165-a3d4-86f595a4d777	patient/RiskAssessment.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
357d441d-ed62-4087-ab5f-682b4b8933a7	patient/RiskAssessment.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
a0473064-d02c-4ec0-9cf3-1c8aea373b23	patient/RiskEvidenceSynthesis.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
483c41a1-4bb4-47aa-88ff-906fe7b1e56f	patient/RiskEvidenceSynthesis.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d42da595-97d7-4f3c-b9b3-12b437b8ea87	patient/RiskEvidenceSynthesis.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
db702915-1f42-4646-b24e-6dded2018740	patient/Schedule.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
981af595-4071-41ca-b589-5ce7d8fd7b38	patient/Schedule.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5860674f-c916-4cce-8b44-d05a2c489b90	patient/Schedule.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
43b2e26e-6d89-4a56-aa43-b1ab66816ab9	patient/SearchParameter.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
c60e3f55-f9b2-41f4-abb2-31542a76a00e	patient/SearchParameter.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
689642bb-fbfb-4eca-b420-2493294bdb39	patient/SearchParameter.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7c3541d4-1c94-4c6d-9683-2dd57b52b617	patient/ServiceRequest.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
3b60b1a5-6800-4b53-b3e4-223a22912772	patient/ServiceRequest.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b557a3e8-9893-4622-aff7-d6e0193e6466	patient/Slot.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
40aaf0be-7ebb-4754-9e2a-249f53a22769	patient/Slot.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
3ba2180b-5c15-4180-aea5-2e6b261a5764	patient/Slot.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
775eb05f-8d17-43ec-aa1b-98a2da388d63	patient/Specimen.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
de1be950-da9b-42fd-a1ac-27cbbee8879e	patient/Specimen.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
fa0ec7f2-3172-4955-bb58-c2025947eef4	patient/SpecimenDefinition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
945e6080-a69e-4949-9b54-3aa075bd7a4b	patient/SpecimenDefinition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
897aad7f-a9c2-4eb3-9d7f-f276ff93f0d3	patient/SpecimenDefinition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5931107d-8da3-48ab-a1c6-06ec9d141322	patient/StructureDefinition.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
fd67e6b9-e941-4fea-a380-3c470139d360	patient/StructureDefinition.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
4d9d97c5-042e-4bfe-b456-3a0566c25ac3	patient/StructureDefinition.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
848e1619-77dd-4d4b-80a3-356263134e2a	patient/StructureMap.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
88b827f5-466b-4e72-9ee5-51cd7272c69c	patient/StructureMap.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
54f0f7cf-8566-44e6-811d-b7cce260b1af	patient/StructureMap.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
785fc0c9-734e-4ed4-b0b5-e4c7d6ea97e1	patient/Subscription.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
8babf7ea-3c54-4957-a280-e79f4cf25550	patient/Subscription.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
3f7b9747-dfb2-4192-83da-39077468f5ca	patient/Subscription.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b7abd9b5-9d48-4137-a9ab-b95b1511e83f	patient/Substance.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5da60049-cd96-4b9f-9128-1326bbd5110b	patient/Substance.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
4997c643-1fd3-4461-8517-878de6673f68	patient/Substance.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ee248d08-0cc6-48d0-b6b4-e9555287a2be	patient/SubstanceNucleicAcid.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b8d9bdc8-1de6-4f35-a2d1-52a414c81648	patient/SubstanceNucleicAcid.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
798598b0-6434-4a40-a5ec-46d9af627a8e	patient/SubstanceNucleicAcid.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
1d92aec6-d2bc-42ae-a271-c06eaffc46af	patient/SubstancePolymer.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
fb78b3ad-9bdd-44ce-a90a-891513d27cf8	patient/SubstancePolymer.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f1b518d4-eead-4f5f-9b9d-6c73a58c8817	patient/SubstancePolymer.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ca864ce8-3822-47dc-bcd5-0ffbc36bfd06	patient/SubstanceProtein.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
98dcfc05-b8b6-4c80-932e-919c23fb7f11	patient/SubstanceProtein.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d1a45238-861e-4906-93ef-1cb7fa3eda23	patient/SubstanceProtein.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
8ba54ba4-2cd8-4471-b21c-1bffc2c6aacc	patient/SubstanceReferenceInformation.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
40b9a386-7501-4256-a8ac-0fb633309ec0	patient/SubstanceReferenceInformation.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ed294b65-4739-49af-9085-543a8de72426	patient/SubstanceReferenceInformation.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
df32c342-2d0c-491d-b1cf-376e97a3b76f	patient/SubstanceSourceMaterial.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ba47eb98-9ad8-4d08-829f-837a3635107b	patient/SubstanceSourceMaterial.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
a4df84be-6a73-4c42-b4a6-45e09d92811c	patient/SubstanceSourceMaterial.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
7de72220-6e79-4403-9e42-07fbe915779f	patient/SubstanceSpecification.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
0663f872-4c0a-4d77-94c3-4ba7a6dc3bc7	patient/SubstanceSpecification.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ab02b2e1-b2d0-442d-be36-84e19a1a74d8	patient/SubstanceSpecification.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
761aee43-26d5-4b25-9cf6-ac5c345f15ea	patient/SupplyDelivery.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
1f93aaa4-53aa-4cab-b59e-d0546dabf297	patient/SupplyDelivery.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
ccdf3be3-abe2-4918-b6dc-ef1b8a4b4001	patient/SupplyDelivery.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
6c49d235-f2af-4612-9700-23e146037042	patient/SupplyRequest.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
76a6a458-dddc-457b-8a06-c4b2b0c9eb94	patient/SupplyRequest.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
9480f6db-0d4c-4da9-a331-6462c3256673	patient/SupplyRequest.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b4c1be36-c580-496e-a011-541e0a91b2be	patient/Task.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b75ca386-6f97-4bc5-898b-fc608cb05cf1	patient/Task.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
9398e13c-56e9-428e-abf5-c78c60c531cf	patient/Task.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
d3295f6b-ab73-480c-b51a-b00c234fc638	patient/TerminologyCapabilities.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
2864a93e-95ff-41f1-86a2-27d64f1ad912	patient/TerminologyCapabilities.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
1909dd60-a1de-4d2d-80c3-302a8e54feab	patient/TerminologyCapabilities.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
1804592e-b533-464e-ae2b-bd3ff57d872c	patient/TestReport.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
f2c4e7ad-b721-4f68-813f-a57cca96bdd8	patient/TestReport.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5a828a51-dfc1-4d30-bc59-8c98d2610a61	patient/TestReport.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
36109312-2045-43f3-acb4-bd25cbcf14fd	patient/TestScript.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
bef4795b-098e-460b-b548-21dc91b5e052	patient/TestScript.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
b818d2c4-bc47-4076-a456-3d3c7e738891	patient/TestScript.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
dc16da7a-3d0c-4c54-926a-5f14bbe5ac41	patient/ValueSet.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
5f8932fa-1e66-40a3-b9bb-12d284cd1e7e	patient/ValueSet.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
4d756a92-25d5-4373-8782-0565e3fe09b2	patient/ValueSet.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
c10b6b22-4bef-4f21-a7be-5a851a7de576	patient/VerificationResult.rs	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
51646898-c510-4b71-a0ae-1156eadb4166	patient/VerificationResult.w	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
375a0678-e4a5-458b-8b27-f63ac3036db1	patient/VerificationResult.*	041f8a3b-b936-410d-b423-b51f4cd23d7f	Scope generated by REST API call	openid-connect
\.


--
-- TOC entry 4162 (class 0 OID 16454)
-- Dependencies: 230
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
6178d2a9-a580-4906-bb8b-31990018282c	true	display.on.consent.screen
6178d2a9-a580-4906-bb8b-31990018282c	${offlineAccessScopeConsentText}	consent.screen.text
c5a655ce-c550-4608-9f85-819518464c45	true	display.on.consent.screen
c5a655ce-c550-4608-9f85-819518464c45	${samlRoleListScopeConsentText}	consent.screen.text
6d6ce73e-3240-46a6-a155-566683389d24	false	display.on.consent.screen
9989de32-22d3-4753-8d69-655da8e53ada	true	display.on.consent.screen
9989de32-22d3-4753-8d69-655da8e53ada	${profileScopeConsentText}	consent.screen.text
9989de32-22d3-4753-8d69-655da8e53ada	true	include.in.token.scope
c5786f6a-0780-49f4-9481-1c1381acf9cc	true	display.on.consent.screen
c5786f6a-0780-49f4-9481-1c1381acf9cc	${emailScopeConsentText}	consent.screen.text
c5786f6a-0780-49f4-9481-1c1381acf9cc	true	include.in.token.scope
a21eb8de-fb97-4e20-a427-8c3899be302d	true	display.on.consent.screen
a21eb8de-fb97-4e20-a427-8c3899be302d	${addressScopeConsentText}	consent.screen.text
a21eb8de-fb97-4e20-a427-8c3899be302d	true	include.in.token.scope
aa9d5c9b-ea42-4a49-b554-fd32252f0886	true	display.on.consent.screen
aa9d5c9b-ea42-4a49-b554-fd32252f0886	${phoneScopeConsentText}	consent.screen.text
aa9d5c9b-ea42-4a49-b554-fd32252f0886	true	include.in.token.scope
3c0d71d0-b8f8-4a05-8943-67b65bb34bd7	true	display.on.consent.screen
3c0d71d0-b8f8-4a05-8943-67b65bb34bd7	${rolesScopeConsentText}	consent.screen.text
3c0d71d0-b8f8-4a05-8943-67b65bb34bd7	false	include.in.token.scope
e28c5545-1ed1-45b0-8a4e-ac79b7bb6cc6	false	display.on.consent.screen
e28c5545-1ed1-45b0-8a4e-ac79b7bb6cc6		consent.screen.text
e28c5545-1ed1-45b0-8a4e-ac79b7bb6cc6	false	include.in.token.scope
f710ee27-621f-420a-8073-f774b62572e4	false	display.on.consent.screen
f710ee27-621f-420a-8073-f774b62572e4	true	include.in.token.scope
3456e0d7-ec64-4e6c-943d-b4d00b8e3ada	false	display.on.consent.screen
3456e0d7-ec64-4e6c-943d-b4d00b8e3ada	false	include.in.token.scope
bf7a58fc-2d5b-4385-a218-7c194679733a	false	display.on.consent.screen
bf7a58fc-2d5b-4385-a218-7c194679733a	false	include.in.token.scope
6c33f453-f9bb-4503-a667-1c2f5a77c0b7	false	display.on.consent.screen
6c33f453-f9bb-4503-a667-1c2f5a77c0b7	false	include.in.token.scope
e1c884bc-1acc-4801-b560-7b124a2012d3	true	display.on.consent.screen
e1c884bc-1acc-4801-b560-7b124a2012d3	${organizationScopeConsentText}	consent.screen.text
e1c884bc-1acc-4801-b560-7b124a2012d3	true	include.in.token.scope
56e2aae1-4467-433a-af4e-c01c216dfab0	false	include.in.token.scope
56e2aae1-4467-433a-af4e-c01c216dfab0	false	display.on.consent.screen
dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	false	include.in.token.scope
dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	false	display.on.consent.screen
de001381-7e44-4fa8-b49e-76a9263c3ee8	true	include.in.token.scope
de001381-7e44-4fa8-b49e-76a9263c3ee8	true	display.on.consent.screen
de001381-7e44-4fa8-b49e-76a9263c3ee8		gui.order
de001381-7e44-4fa8-b49e-76a9263c3ee8		consent.screen.text
196faef5-835f-4231-acb3-fcd3c661efa6	true	include.in.token.scope
196faef5-835f-4231-acb3-fcd3c661efa6	${phoneScopeConsentText}	consent.screen.text
196faef5-835f-4231-acb3-fcd3c661efa6	true	display.on.consent.screen
8ab38785-690e-4e8e-adf7-f74b99037080	true	include.in.token.scope
8ab38785-690e-4e8e-adf7-f74b99037080	true	display.on.consent.screen
8ab38785-690e-4e8e-adf7-f74b99037080		gui.order
8ab38785-690e-4e8e-adf7-f74b99037080		consent.screen.text
2f483427-27c2-4f28-99e2-a0f1f110d89a	true	include.in.token.scope
2f483427-27c2-4f28-99e2-a0f1f110d89a	${emailScopeConsentText}	consent.screen.text
2f483427-27c2-4f28-99e2-a0f1f110d89a	true	display.on.consent.screen
05dacaa7-30ea-4e5f-b440-efd8671626ac	true	include.in.token.scope
05dacaa7-30ea-4e5f-b440-efd8671626ac	true	display.on.consent.screen
05dacaa7-30ea-4e5f-b440-efd8671626ac		gui.order
05dacaa7-30ea-4e5f-b440-efd8671626ac		consent.screen.text
06d8558e-68e6-4a67-af33-e77385cc7931	true	include.in.token.scope
06d8558e-68e6-4a67-af33-e77385cc7931	true	display.on.consent.screen
06d8558e-68e6-4a67-af33-e77385cc7931		gui.order
06d8558e-68e6-4a67-af33-e77385cc7931		consent.screen.text
ebe8188b-0c77-4993-995d-f7a99a578eb1	${offlineAccessScopeConsentText}	consent.screen.text
ebe8188b-0c77-4993-995d-f7a99a578eb1	true	display.on.consent.screen
231c88af-23ce-4090-b1e3-968b9dfb4458	${samlRoleListScopeConsentText}	consent.screen.text
231c88af-23ce-4090-b1e3-968b9dfb4458	true	display.on.consent.screen
52609aff-9e18-4b71-9a21-1e04981e70fa	true	include.in.token.scope
52609aff-9e18-4b71-9a21-1e04981e70fa	true	display.on.consent.screen
52609aff-9e18-4b71-9a21-1e04981e70fa		gui.order
52609aff-9e18-4b71-9a21-1e04981e70fa		consent.screen.text
48477b64-55e8-4121-92fe-edeabb65e724	true	include.in.token.scope
48477b64-55e8-4121-92fe-edeabb65e724	true	display.on.consent.screen
48477b64-55e8-4121-92fe-edeabb65e724		gui.order
48477b64-55e8-4121-92fe-edeabb65e724		consent.screen.text
ab22d27f-8bd7-4c00-8115-13b3d8613c6c	true	include.in.token.scope
ab22d27f-8bd7-4c00-8115-13b3d8613c6c	true	display.on.consent.screen
ab22d27f-8bd7-4c00-8115-13b3d8613c6c		gui.order
ab22d27f-8bd7-4c00-8115-13b3d8613c6c		consent.screen.text
676a49c9-b132-4103-85cb-25cd59321af2	true	include.in.token.scope
676a49c9-b132-4103-85cb-25cd59321af2	true	display.on.consent.screen
676a49c9-b132-4103-85cb-25cd59321af2		gui.order
676a49c9-b132-4103-85cb-25cd59321af2		consent.screen.text
62584a10-07a8-4e30-8cf9-28ca14ae516c	true	include.in.token.scope
62584a10-07a8-4e30-8cf9-28ca14ae516c	true	display.on.consent.screen
62584a10-07a8-4e30-8cf9-28ca14ae516c		gui.order
62584a10-07a8-4e30-8cf9-28ca14ae516c		consent.screen.text
0544d9aa-268d-4dbb-a91e-f44bdc594b62	true	include.in.token.scope
0544d9aa-268d-4dbb-a91e-f44bdc594b62	true	display.on.consent.screen
0544d9aa-268d-4dbb-a91e-f44bdc594b62		gui.order
0544d9aa-268d-4dbb-a91e-f44bdc594b62		consent.screen.text
eee47aba-f11c-451b-bb74-c301092240de	true	include.in.token.scope
eee47aba-f11c-451b-bb74-c301092240de	true	display.on.consent.screen
eee47aba-f11c-451b-bb74-c301092240de		gui.order
eee47aba-f11c-451b-bb74-c301092240de		consent.screen.text
4bd9da86-ee45-44fe-982e-19d82c9a0f23	true	include.in.token.scope
4bd9da86-ee45-44fe-982e-19d82c9a0f23	true	display.on.consent.screen
4bd9da86-ee45-44fe-982e-19d82c9a0f23		gui.order
4bd9da86-ee45-44fe-982e-19d82c9a0f23		consent.screen.text
52ef2827-5c48-448b-8975-40266cc64b66	true	include.in.token.scope
52ef2827-5c48-448b-8975-40266cc64b66	true	display.on.consent.screen
52ef2827-5c48-448b-8975-40266cc64b66		gui.order
52ef2827-5c48-448b-8975-40266cc64b66		consent.screen.text
2b58b3b0-08d8-4dec-881f-19b8a551b2f0	true	include.in.token.scope
2b58b3b0-08d8-4dec-881f-19b8a551b2f0	true	display.on.consent.screen
2b58b3b0-08d8-4dec-881f-19b8a551b2f0		gui.order
2b58b3b0-08d8-4dec-881f-19b8a551b2f0		consent.screen.text
51670a24-22af-4044-a2c8-fa6f561cc77b	true	include.in.token.scope
51670a24-22af-4044-a2c8-fa6f561cc77b	true	display.on.consent.screen
51670a24-22af-4044-a2c8-fa6f561cc77b		gui.order
51670a24-22af-4044-a2c8-fa6f561cc77b		consent.screen.text
55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	true	include.in.token.scope
55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	${profileScopeConsentText}	consent.screen.text
55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	true	display.on.consent.screen
bb0efd69-4acb-42c5-a498-346495c587bf	true	include.in.token.scope
bb0efd69-4acb-42c5-a498-346495c587bf	true	display.on.consent.screen
bb0efd69-4acb-42c5-a498-346495c587bf		gui.order
bb0efd69-4acb-42c5-a498-346495c587bf		consent.screen.text
678707fb-8938-48d9-a151-2c07ebce38bf	true	include.in.token.scope
678707fb-8938-48d9-a151-2c07ebce38bf	true	display.on.consent.screen
678707fb-8938-48d9-a151-2c07ebce38bf		gui.order
678707fb-8938-48d9-a151-2c07ebce38bf		consent.screen.text
06f77d3c-cc1b-4d16-9201-2a1ec974551b	true	include.in.token.scope
06f77d3c-cc1b-4d16-9201-2a1ec974551b	true	display.on.consent.screen
06f77d3c-cc1b-4d16-9201-2a1ec974551b		gui.order
06f77d3c-cc1b-4d16-9201-2a1ec974551b		consent.screen.text
be64a559-37eb-4a02-930a-75177c5e8f89	true	include.in.token.scope
be64a559-37eb-4a02-930a-75177c5e8f89	true	display.on.consent.screen
be64a559-37eb-4a02-930a-75177c5e8f89		gui.order
be64a559-37eb-4a02-930a-75177c5e8f89		consent.screen.text
e02a4651-1176-4678-b9a2-80876e2dc2f2	false	include.in.token.scope
e02a4651-1176-4678-b9a2-80876e2dc2f2	${rolesScopeConsentText}	consent.screen.text
e02a4651-1176-4678-b9a2-80876e2dc2f2	true	display.on.consent.screen
8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	false	include.in.token.scope
8bc27fbd-cbf6-4fe7-800c-4a6674b1e644		consent.screen.text
8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	false	display.on.consent.screen
2866ff77-6d11-4076-88b3-47ab819d4685	true	include.in.token.scope
2866ff77-6d11-4076-88b3-47ab819d4685	false	display.on.consent.screen
c9469db6-d939-496e-bf11-02e2750f8a0c	false	include.in.token.scope
c9469db6-d939-496e-bf11-02e2750f8a0c	true	display.on.consent.screen
c9469db6-d939-496e-bf11-02e2750f8a0c		gui.order
c9469db6-d939-496e-bf11-02e2750f8a0c		consent.screen.text
799a3332-71ee-462e-9ad8-9a2b590420b8	true	include.in.token.scope
799a3332-71ee-462e-9ad8-9a2b590420b8	true	display.on.consent.screen
799a3332-71ee-462e-9ad8-9a2b590420b8		gui.order
799a3332-71ee-462e-9ad8-9a2b590420b8		consent.screen.text
0851e7e7-c812-4fd3-98d5-10b39f394ea2	true	include.in.token.scope
0851e7e7-c812-4fd3-98d5-10b39f394ea2	true	display.on.consent.screen
0851e7e7-c812-4fd3-98d5-10b39f394ea2		gui.order
0851e7e7-c812-4fd3-98d5-10b39f394ea2		consent.screen.text
7b625778-5ea8-4665-a489-5ac0d9011945	true	include.in.token.scope
7b625778-5ea8-4665-a489-5ac0d9011945	true	display.on.consent.screen
7b625778-5ea8-4665-a489-5ac0d9011945		gui.order
7b625778-5ea8-4665-a489-5ac0d9011945		consent.screen.text
d195c82c-f5b7-4af3-89e9-639b337cb874	true	include.in.token.scope
d195c82c-f5b7-4af3-89e9-639b337cb874	true	display.on.consent.screen
d195c82c-f5b7-4af3-89e9-639b337cb874		gui.order
d195c82c-f5b7-4af3-89e9-639b337cb874		consent.screen.text
ba75754a-52ca-40ef-b3f6-4a29f434a670	true	include.in.token.scope
ba75754a-52ca-40ef-b3f6-4a29f434a670	true	display.on.consent.screen
ba75754a-52ca-40ef-b3f6-4a29f434a670		gui.order
ba75754a-52ca-40ef-b3f6-4a29f434a670		consent.screen.text
4422a95f-5255-494e-9db8-d3b0557e3de5	true	include.in.token.scope
4422a95f-5255-494e-9db8-d3b0557e3de5	true	display.on.consent.screen
4422a95f-5255-494e-9db8-d3b0557e3de5		gui.order
4422a95f-5255-494e-9db8-d3b0557e3de5		consent.screen.text
64bb1677-0898-479e-a67c-e43a31fac4cd	true	include.in.token.scope
64bb1677-0898-479e-a67c-e43a31fac4cd	true	display.on.consent.screen
64bb1677-0898-479e-a67c-e43a31fac4cd		gui.order
64bb1677-0898-479e-a67c-e43a31fac4cd		consent.screen.text
e813ac68-f822-4ad0-ba6e-38813bdb6fb5	true	include.in.token.scope
e813ac68-f822-4ad0-ba6e-38813bdb6fb5	true	display.on.consent.screen
e813ac68-f822-4ad0-ba6e-38813bdb6fb5		gui.order
e813ac68-f822-4ad0-ba6e-38813bdb6fb5		consent.screen.text
2d1ad2f3-dc40-488e-bf41-88e11bad2dac	true	include.in.token.scope
2d1ad2f3-dc40-488e-bf41-88e11bad2dac	true	display.on.consent.screen
2d1ad2f3-dc40-488e-bf41-88e11bad2dac		gui.order
2d1ad2f3-dc40-488e-bf41-88e11bad2dac	Access to all patient's data	consent.screen.text
90374560-2ca4-456d-8801-98ac06c8b0f5	false	include.in.token.scope
90374560-2ca4-456d-8801-98ac06c8b0f5	false	display.on.consent.screen
9ad3f5c8-0343-488d-b1dc-077332dfcd7f	true	include.in.token.scope
9ad3f5c8-0343-488d-b1dc-077332dfcd7f	true	display.on.consent.screen
9ad3f5c8-0343-488d-b1dc-077332dfcd7f		gui.order
9ad3f5c8-0343-488d-b1dc-077332dfcd7f		consent.screen.text
a5419278-ba86-4340-8edb-ee53c8633d85	true	include.in.token.scope
a5419278-ba86-4340-8edb-ee53c8633d85	true	display.on.consent.screen
a5419278-ba86-4340-8edb-ee53c8633d85		gui.order
a5419278-ba86-4340-8edb-ee53c8633d85		consent.screen.text
bfba13ac-edd0-4bae-a3fc-a03713ffbf5c	true	include.in.token.scope
bfba13ac-edd0-4bae-a3fc-a03713ffbf5c	false	display.on.consent.screen
bfba13ac-edd0-4bae-a3fc-a03713ffbf5c		gui.order
bfba13ac-edd0-4bae-a3fc-a03713ffbf5c		consent.screen.text
d145c4d7-c125-4d8c-ba5a-9a27a88005de	true	include.in.token.scope
d145c4d7-c125-4d8c-ba5a-9a27a88005de	true	display.on.consent.screen
d145c4d7-c125-4d8c-ba5a-9a27a88005de		gui.order
d145c4d7-c125-4d8c-ba5a-9a27a88005de		consent.screen.text
300fff2d-0cd9-4a6e-9704-e0230695e7d3	true	include.in.token.scope
300fff2d-0cd9-4a6e-9704-e0230695e7d3	true	display.on.consent.screen
300fff2d-0cd9-4a6e-9704-e0230695e7d3		gui.order
300fff2d-0cd9-4a6e-9704-e0230695e7d3		consent.screen.text
6aebfc9a-3c33-4f44-9719-c5a6c4a4c6a8	true	include.in.token.scope
6aebfc9a-3c33-4f44-9719-c5a6c4a4c6a8	true	display.on.consent.screen
6aebfc9a-3c33-4f44-9719-c5a6c4a4c6a8		gui.order
6aebfc9a-3c33-4f44-9719-c5a6c4a4c6a8		consent.screen.text
abde0849-08db-48ad-8443-7a7256b143be	true	include.in.token.scope
abde0849-08db-48ad-8443-7a7256b143be	true	display.on.consent.screen
abde0849-08db-48ad-8443-7a7256b143be		gui.order
abde0849-08db-48ad-8443-7a7256b143be		consent.screen.text
55b6e976-0954-4724-bff3-7e02d096ccdd	true	include.in.token.scope
55b6e976-0954-4724-bff3-7e02d096ccdd	true	display.on.consent.screen
55b6e976-0954-4724-bff3-7e02d096ccdd		gui.order
55b6e976-0954-4724-bff3-7e02d096ccdd		consent.screen.text
1e359ee8-1ce0-4eac-bfd2-5651dc12c139	true	include.in.token.scope
1e359ee8-1ce0-4eac-bfd2-5651dc12c139	true	display.on.consent.screen
1e359ee8-1ce0-4eac-bfd2-5651dc12c139		gui.order
1e359ee8-1ce0-4eac-bfd2-5651dc12c139		consent.screen.text
286969a5-8a61-4c6b-947b-749d53439322	true	include.in.token.scope
286969a5-8a61-4c6b-947b-749d53439322	true	display.on.consent.screen
286969a5-8a61-4c6b-947b-749d53439322		gui.order
286969a5-8a61-4c6b-947b-749d53439322		consent.screen.text
d8e8fea8-e7f0-4867-8823-665cf98b3150	true	include.in.token.scope
d8e8fea8-e7f0-4867-8823-665cf98b3150	${addressScopeConsentText}	consent.screen.text
d8e8fea8-e7f0-4867-8823-665cf98b3150	true	display.on.consent.screen
95bd554c-d279-4898-b145-14284b26d635	true	include.in.token.scope
95bd554c-d279-4898-b145-14284b26d635	true	display.on.consent.screen
95bd554c-d279-4898-b145-14284b26d635		gui.order
95bd554c-d279-4898-b145-14284b26d635		consent.screen.text
da108e30-fe60-411a-8f18-d8cdfd96bc7f	true	include.in.token.scope
da108e30-fe60-411a-8f18-d8cdfd96bc7f	true	display.on.consent.screen
da108e30-fe60-411a-8f18-d8cdfd96bc7f		gui.order
da108e30-fe60-411a-8f18-d8cdfd96bc7f		consent.screen.text
f0425add-100d-4570-9da1-a87ab4d182b8	true	include.in.token.scope
f0425add-100d-4570-9da1-a87ab4d182b8	true	display.on.consent.screen
f0425add-100d-4570-9da1-a87ab4d182b8		gui.order
f0425add-100d-4570-9da1-a87ab4d182b8		consent.screen.text
3a11b03f-a652-4dba-9cc2-f76f7c916609	true	include.in.token.scope
3a11b03f-a652-4dba-9cc2-f76f7c916609	true	display.on.consent.screen
3a11b03f-a652-4dba-9cc2-f76f7c916609		gui.order
3a11b03f-a652-4dba-9cc2-f76f7c916609		consent.screen.text
fc7b70e8-6c5d-4254-ad66-4432a61e73f5	true	include.in.token.scope
fc7b70e8-6c5d-4254-ad66-4432a61e73f5	true	display.on.consent.screen
fc7b70e8-6c5d-4254-ad66-4432a61e73f5		gui.order
fc7b70e8-6c5d-4254-ad66-4432a61e73f5		consent.screen.text
3629ba2b-2071-403a-8d48-c56bf7e287f6	true	include.in.token.scope
3629ba2b-2071-403a-8d48-c56bf7e287f6	${organizationScopeConsentText}	consent.screen.text
3629ba2b-2071-403a-8d48-c56bf7e287f6	true	display.on.consent.screen
f850dfd4-7f01-4d04-84e5-271530cf4c70	true	include.in.token.scope
f850dfd4-7f01-4d04-84e5-271530cf4c70	true	display.on.consent.screen
f850dfd4-7f01-4d04-84e5-271530cf4c70		gui.order
f850dfd4-7f01-4d04-84e5-271530cf4c70		consent.screen.text
667c1f02-310a-43e7-8a25-68d6abc771d8	true	include.in.token.scope
667c1f02-310a-43e7-8a25-68d6abc771d8	true	display.on.consent.screen
667c1f02-310a-43e7-8a25-68d6abc771d8		gui.order
667c1f02-310a-43e7-8a25-68d6abc771d8		consent.screen.text
b2d3a92b-3b2f-4ba5-8478-6c44a9379989	true	include.in.token.scope
b2d3a92b-3b2f-4ba5-8478-6c44a9379989	true	display.on.consent.screen
b2d3a92b-3b2f-4ba5-8478-6c44a9379989		gui.order
b2d3a92b-3b2f-4ba5-8478-6c44a9379989		consent.screen.text
5774ea8c-8a74-46cc-8fc4-de6637936b45	true	include.in.token.scope
5774ea8c-8a74-46cc-8fc4-de6637936b45	true	display.on.consent.screen
5774ea8c-8a74-46cc-8fc4-de6637936b45		gui.order
5774ea8c-8a74-46cc-8fc4-de6637936b45		consent.screen.text
9d4acc7c-a02b-46e1-b1e3-6228917f908d	true	include.in.token.scope
9d4acc7c-a02b-46e1-b1e3-6228917f908d	true	display.on.consent.screen
9d4acc7c-a02b-46e1-b1e3-6228917f908d		gui.order
9d4acc7c-a02b-46e1-b1e3-6228917f908d		consent.screen.text
bfd7612d-abd5-4ed8-8ec4-04fc1ccea5a1	true	include.in.token.scope
bfd7612d-abd5-4ed8-8ec4-04fc1ccea5a1	true	display.on.consent.screen
bfd7612d-abd5-4ed8-8ec4-04fc1ccea5a1		gui.order
bfd7612d-abd5-4ed8-8ec4-04fc1ccea5a1		consent.screen.text
8f2ed22a-ea43-4a5d-935b-1e477d88bd00	true	include.in.token.scope
8f2ed22a-ea43-4a5d-935b-1e477d88bd00	true	display.on.consent.screen
8f2ed22a-ea43-4a5d-935b-1e477d88bd00		gui.order
8f2ed22a-ea43-4a5d-935b-1e477d88bd00		consent.screen.text
3e2b5486-649e-44e2-8090-31bd2e6e995e	true	include.in.token.scope
3e2b5486-649e-44e2-8090-31bd2e6e995e	true	display.on.consent.screen
3e2b5486-649e-44e2-8090-31bd2e6e995e		gui.order
3e2b5486-649e-44e2-8090-31bd2e6e995e		consent.screen.text
89beb243-229b-4a8b-87da-b65106b65958	true	include.in.token.scope
89beb243-229b-4a8b-87da-b65106b65958	true	display.on.consent.screen
89beb243-229b-4a8b-87da-b65106b65958		gui.order
89beb243-229b-4a8b-87da-b65106b65958		consent.screen.text
97dd5dc6-1099-4d37-9333-cb96f8f84ff3	false	display.on.consent.screen
7e9eb8cf-b79a-4753-8015-ae415883a962	true	include.in.token.scope
7e9eb8cf-b79a-4753-8015-ae415883a962	true	display.on.consent.screen
7e9eb8cf-b79a-4753-8015-ae415883a962		gui.order
7e9eb8cf-b79a-4753-8015-ae415883a962		consent.screen.text
2da98831-999b-4efb-a6a8-4d1007994038	true	include.in.token.scope
2da98831-999b-4efb-a6a8-4d1007994038	true	display.on.consent.screen
2da98831-999b-4efb-a6a8-4d1007994038		gui.order
2da98831-999b-4efb-a6a8-4d1007994038		consent.screen.text
5bde7941-4b13-4e13-ad0e-a395490dbc61	true	display.on.consent.screen
5bde7941-4b13-4e13-ad0e-a395490dbc61		consent.screen.text
5bde7941-4b13-4e13-ad0e-a395490dbc61	true	include.in.token.scope
5bde7941-4b13-4e13-ad0e-a395490dbc61		gui.order
7bdbe596-0ed5-43be-9456-595f9312d706	true	display.on.consent.screen
7bdbe596-0ed5-43be-9456-595f9312d706		consent.screen.text
7bdbe596-0ed5-43be-9456-595f9312d706	true	include.in.token.scope
7bdbe596-0ed5-43be-9456-595f9312d706		gui.order
1bbe4253-bf7c-4f64-9a0a-a2d0bb505b15	true	display.on.consent.screen
1bbe4253-bf7c-4f64-9a0a-a2d0bb505b15		consent.screen.text
1bbe4253-bf7c-4f64-9a0a-a2d0bb505b15	true	include.in.token.scope
1bbe4253-bf7c-4f64-9a0a-a2d0bb505b15		gui.order
84d58747-dbf8-4ee4-9eab-46c6df76e847	true	display.on.consent.screen
84d58747-dbf8-4ee4-9eab-46c6df76e847		consent.screen.text
84d58747-dbf8-4ee4-9eab-46c6df76e847	true	include.in.token.scope
84d58747-dbf8-4ee4-9eab-46c6df76e847		gui.order
\.


--
-- TOC entry 4163 (class 0 OID 16459)
-- Dependencies: 231
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
9eee2754-cbf5-42b9-a7ea-d782447cc4f4	e28c5545-1ed1-45b0-8a4e-ac79b7bb6cc6	t
9eee2754-cbf5-42b9-a7ea-d782447cc4f4	3456e0d7-ec64-4e6c-943d-b4d00b8e3ada	t
9eee2754-cbf5-42b9-a7ea-d782447cc4f4	9989de32-22d3-4753-8d69-655da8e53ada	t
9eee2754-cbf5-42b9-a7ea-d782447cc4f4	c5786f6a-0780-49f4-9481-1c1381acf9cc	t
9eee2754-cbf5-42b9-a7ea-d782447cc4f4	3c0d71d0-b8f8-4a05-8943-67b65bb34bd7	t
9eee2754-cbf5-42b9-a7ea-d782447cc4f4	bf7a58fc-2d5b-4385-a218-7c194679733a	t
9eee2754-cbf5-42b9-a7ea-d782447cc4f4	e1c884bc-1acc-4801-b560-7b124a2012d3	f
9eee2754-cbf5-42b9-a7ea-d782447cc4f4	aa9d5c9b-ea42-4a49-b554-fd32252f0886	f
9eee2754-cbf5-42b9-a7ea-d782447cc4f4	6178d2a9-a580-4906-bb8b-31990018282c	f
9eee2754-cbf5-42b9-a7ea-d782447cc4f4	a21eb8de-fb97-4e20-a427-8c3899be302d	f
9eee2754-cbf5-42b9-a7ea-d782447cc4f4	f710ee27-621f-420a-8073-f774b62572e4	f
d8fa8480-9e7f-4fc2-bec5-8479023566c5	e28c5545-1ed1-45b0-8a4e-ac79b7bb6cc6	t
d8fa8480-9e7f-4fc2-bec5-8479023566c5	3456e0d7-ec64-4e6c-943d-b4d00b8e3ada	t
d8fa8480-9e7f-4fc2-bec5-8479023566c5	9989de32-22d3-4753-8d69-655da8e53ada	t
d8fa8480-9e7f-4fc2-bec5-8479023566c5	c5786f6a-0780-49f4-9481-1c1381acf9cc	t
d8fa8480-9e7f-4fc2-bec5-8479023566c5	3c0d71d0-b8f8-4a05-8943-67b65bb34bd7	t
d8fa8480-9e7f-4fc2-bec5-8479023566c5	bf7a58fc-2d5b-4385-a218-7c194679733a	t
d8fa8480-9e7f-4fc2-bec5-8479023566c5	e1c884bc-1acc-4801-b560-7b124a2012d3	f
d8fa8480-9e7f-4fc2-bec5-8479023566c5	aa9d5c9b-ea42-4a49-b554-fd32252f0886	f
d8fa8480-9e7f-4fc2-bec5-8479023566c5	6178d2a9-a580-4906-bb8b-31990018282c	f
d8fa8480-9e7f-4fc2-bec5-8479023566c5	a21eb8de-fb97-4e20-a427-8c3899be302d	f
d8fa8480-9e7f-4fc2-bec5-8479023566c5	f710ee27-621f-420a-8073-f774b62572e4	f
58d58f34-c0be-4479-b8d6-eedb5a5a3210	e28c5545-1ed1-45b0-8a4e-ac79b7bb6cc6	t
58d58f34-c0be-4479-b8d6-eedb5a5a3210	3456e0d7-ec64-4e6c-943d-b4d00b8e3ada	t
58d58f34-c0be-4479-b8d6-eedb5a5a3210	9989de32-22d3-4753-8d69-655da8e53ada	t
58d58f34-c0be-4479-b8d6-eedb5a5a3210	c5786f6a-0780-49f4-9481-1c1381acf9cc	t
58d58f34-c0be-4479-b8d6-eedb5a5a3210	3c0d71d0-b8f8-4a05-8943-67b65bb34bd7	t
58d58f34-c0be-4479-b8d6-eedb5a5a3210	bf7a58fc-2d5b-4385-a218-7c194679733a	t
58d58f34-c0be-4479-b8d6-eedb5a5a3210	e1c884bc-1acc-4801-b560-7b124a2012d3	f
58d58f34-c0be-4479-b8d6-eedb5a5a3210	aa9d5c9b-ea42-4a49-b554-fd32252f0886	f
58d58f34-c0be-4479-b8d6-eedb5a5a3210	6178d2a9-a580-4906-bb8b-31990018282c	f
58d58f34-c0be-4479-b8d6-eedb5a5a3210	a21eb8de-fb97-4e20-a427-8c3899be302d	f
58d58f34-c0be-4479-b8d6-eedb5a5a3210	f710ee27-621f-420a-8073-f774b62572e4	f
c53d33f2-6196-4a0e-bb5b-5f6b2f49af07	e28c5545-1ed1-45b0-8a4e-ac79b7bb6cc6	t
c53d33f2-6196-4a0e-bb5b-5f6b2f49af07	3456e0d7-ec64-4e6c-943d-b4d00b8e3ada	t
c53d33f2-6196-4a0e-bb5b-5f6b2f49af07	9989de32-22d3-4753-8d69-655da8e53ada	t
c53d33f2-6196-4a0e-bb5b-5f6b2f49af07	c5786f6a-0780-49f4-9481-1c1381acf9cc	t
c53d33f2-6196-4a0e-bb5b-5f6b2f49af07	3c0d71d0-b8f8-4a05-8943-67b65bb34bd7	t
c53d33f2-6196-4a0e-bb5b-5f6b2f49af07	bf7a58fc-2d5b-4385-a218-7c194679733a	t
c53d33f2-6196-4a0e-bb5b-5f6b2f49af07	e1c884bc-1acc-4801-b560-7b124a2012d3	f
c53d33f2-6196-4a0e-bb5b-5f6b2f49af07	aa9d5c9b-ea42-4a49-b554-fd32252f0886	f
c53d33f2-6196-4a0e-bb5b-5f6b2f49af07	6178d2a9-a580-4906-bb8b-31990018282c	f
c53d33f2-6196-4a0e-bb5b-5f6b2f49af07	a21eb8de-fb97-4e20-a427-8c3899be302d	f
c53d33f2-6196-4a0e-bb5b-5f6b2f49af07	f710ee27-621f-420a-8073-f774b62572e4	f
4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	e28c5545-1ed1-45b0-8a4e-ac79b7bb6cc6	t
4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	3456e0d7-ec64-4e6c-943d-b4d00b8e3ada	t
4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	9989de32-22d3-4753-8d69-655da8e53ada	t
4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	c5786f6a-0780-49f4-9481-1c1381acf9cc	t
4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	3c0d71d0-b8f8-4a05-8943-67b65bb34bd7	t
4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	bf7a58fc-2d5b-4385-a218-7c194679733a	t
4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	e1c884bc-1acc-4801-b560-7b124a2012d3	f
4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	aa9d5c9b-ea42-4a49-b554-fd32252f0886	f
4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	6178d2a9-a580-4906-bb8b-31990018282c	f
4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	a21eb8de-fb97-4e20-a427-8c3899be302d	f
4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	f710ee27-621f-420a-8073-f774b62572e4	f
767d4eee-87ba-42cc-a25d-0d904138f24f	e28c5545-1ed1-45b0-8a4e-ac79b7bb6cc6	t
767d4eee-87ba-42cc-a25d-0d904138f24f	3456e0d7-ec64-4e6c-943d-b4d00b8e3ada	t
767d4eee-87ba-42cc-a25d-0d904138f24f	9989de32-22d3-4753-8d69-655da8e53ada	t
767d4eee-87ba-42cc-a25d-0d904138f24f	c5786f6a-0780-49f4-9481-1c1381acf9cc	t
767d4eee-87ba-42cc-a25d-0d904138f24f	3c0d71d0-b8f8-4a05-8943-67b65bb34bd7	t
767d4eee-87ba-42cc-a25d-0d904138f24f	bf7a58fc-2d5b-4385-a218-7c194679733a	t
767d4eee-87ba-42cc-a25d-0d904138f24f	e1c884bc-1acc-4801-b560-7b124a2012d3	f
767d4eee-87ba-42cc-a25d-0d904138f24f	aa9d5c9b-ea42-4a49-b554-fd32252f0886	f
767d4eee-87ba-42cc-a25d-0d904138f24f	6178d2a9-a580-4906-bb8b-31990018282c	f
767d4eee-87ba-42cc-a25d-0d904138f24f	a21eb8de-fb97-4e20-a427-8c3899be302d	f
767d4eee-87ba-42cc-a25d-0d904138f24f	f710ee27-621f-420a-8073-f774b62572e4	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	2d1ad2f3-dc40-488e-bf41-88e11bad2dac	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5bde7941-4b13-4e13-ad0e-a395490dbc61	f
f36c6fd0-b46c-43d5-9413-0e462e191822	edfbac25-1fba-44ba-92a6-ed54a4223db1	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9731bdab-053e-48f6-8095-068677f9bf93	f
f36c6fd0-b46c-43d5-9413-0e462e191822	feb7a0b9-e989-4366-8139-05d615a76c21	f
f36c6fd0-b46c-43d5-9413-0e462e191822	410b1e5f-2686-43f2-bbaa-b8fd3eedace1	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e835adcb-dd7e-414f-94e4-e3d0ca878075	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d2902ff9-2f92-4e77-b225-5838adf91fd9	f
f36c6fd0-b46c-43d5-9413-0e462e191822	595a0072-8691-4ce3-b8a9-6e41ae3af429	f
636672b6-143d-4bf2-ac14-e0feade63dc6	2d1ad2f3-dc40-488e-bf41-88e11bad2dac	f
636672b6-143d-4bf2-ac14-e0feade63dc6	7bdbe596-0ed5-43be-9456-595f9312d706	f
f36c6fd0-b46c-43d5-9413-0e462e191822	6f6ee623-c214-4af7-9e20-66cf5b26b3ce	f
f36c6fd0-b46c-43d5-9413-0e462e191822	125bb4be-470a-4b82-8b95-aa648432cc4d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	cf6e6dab-5dca-422d-aeca-07c9ee6c0f59	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d2570df5-42e6-4a25-919b-78f1bb4bb74a	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	410b1e5f-2686-43f2-bbaa-b8fd3eedace1	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	e835adcb-dd7e-414f-94e4-e3d0ca878075	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	fb813041-4997-4d95-b813-46d5ac27b91e	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	24f26bd5-0557-4bdb-a94e-334e2f73d9b0	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	cf6e6dab-5dca-422d-aeca-07c9ee6c0f59	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	c5328cf1-23a3-4ca3-accd-3b21720da4e2	f
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	t
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	t
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	e02a4651-1176-4678-b9a2-80876e2dc2f2	t
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	t
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	90374560-2ca4-456d-8801-98ac06c8b0f5	t
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	2f483427-27c2-4f28-99e2-a0f1f110d89a	t
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	d8e8fea8-e7f0-4867-8823-665cf98b3150	f
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	196faef5-835f-4231-acb3-fcd3c661efa6	f
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	ebe8188b-0c77-4993-995d-f7a99a578eb1	f
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	3629ba2b-2071-403a-8d48-c56bf7e287f6	f
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	2866ff77-6d11-4076-88b3-47ab819d4685	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	fc422b68-82cf-4220-a937-13b3346eda41	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	89beb243-229b-4a8b-87da-b65106b65958	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	8bdc24d1-60c3-49dc-8d9b-ed1dea10d7ed	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	3bfa0776-9fff-4b4d-93d4-6f4a41cdc3cd	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	e152de04-53be-4817-8fdd-5c5075350ce3	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	c21b2e25-4d80-4bbe-bfa5-08b7da303d9e	f
a7143ea8-7fcd-40a5-9b15-f417b9648c00	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	t
a7143ea8-7fcd-40a5-9b15-f417b9648c00	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	t
a7143ea8-7fcd-40a5-9b15-f417b9648c00	e02a4651-1176-4678-b9a2-80876e2dc2f2	t
a7143ea8-7fcd-40a5-9b15-f417b9648c00	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	t
a7143ea8-7fcd-40a5-9b15-f417b9648c00	90374560-2ca4-456d-8801-98ac06c8b0f5	t
a7143ea8-7fcd-40a5-9b15-f417b9648c00	2f483427-27c2-4f28-99e2-a0f1f110d89a	t
a7143ea8-7fcd-40a5-9b15-f417b9648c00	d8e8fea8-e7f0-4867-8823-665cf98b3150	f
a7143ea8-7fcd-40a5-9b15-f417b9648c00	196faef5-835f-4231-acb3-fcd3c661efa6	f
a7143ea8-7fcd-40a5-9b15-f417b9648c00	ebe8188b-0c77-4993-995d-f7a99a578eb1	f
a7143ea8-7fcd-40a5-9b15-f417b9648c00	3629ba2b-2071-403a-8d48-c56bf7e287f6	f
a7143ea8-7fcd-40a5-9b15-f417b9648c00	2866ff77-6d11-4076-88b3-47ab819d4685	f
f36c6fd0-b46c-43d5-9413-0e462e191822	eee90633-00a0-4c43-84f3-1e4418b77768	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9de8b34d-2499-4b06-a0c9-8d453c1d52db	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ef68f01a-aa2f-4d46-835f-b18471f512e3	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	bfd7612d-abd5-4ed8-8ec4-04fc1ccea5a1	f
b45b4d12-0a18-4c96-b1da-226175ba3a7b	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	t
b45b4d12-0a18-4c96-b1da-226175ba3a7b	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	t
b45b4d12-0a18-4c96-b1da-226175ba3a7b	e02a4651-1176-4678-b9a2-80876e2dc2f2	t
b45b4d12-0a18-4c96-b1da-226175ba3a7b	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	t
b45b4d12-0a18-4c96-b1da-226175ba3a7b	90374560-2ca4-456d-8801-98ac06c8b0f5	t
b45b4d12-0a18-4c96-b1da-226175ba3a7b	2f483427-27c2-4f28-99e2-a0f1f110d89a	t
b45b4d12-0a18-4c96-b1da-226175ba3a7b	d8e8fea8-e7f0-4867-8823-665cf98b3150	f
b45b4d12-0a18-4c96-b1da-226175ba3a7b	196faef5-835f-4231-acb3-fcd3c661efa6	f
b45b4d12-0a18-4c96-b1da-226175ba3a7b	ebe8188b-0c77-4993-995d-f7a99a578eb1	f
b45b4d12-0a18-4c96-b1da-226175ba3a7b	3629ba2b-2071-403a-8d48-c56bf7e287f6	f
b45b4d12-0a18-4c96-b1da-226175ba3a7b	2866ff77-6d11-4076-88b3-47ab819d4685	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	t
f36c6fd0-b46c-43d5-9413-0e462e191822	c9469db6-d939-496e-bf11-02e2750f8a0c	t
f36c6fd0-b46c-43d5-9413-0e462e191822	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	t
f36c6fd0-b46c-43d5-9413-0e462e191822	bfd7612d-abd5-4ed8-8ec4-04fc1ccea5a1	t
f36c6fd0-b46c-43d5-9413-0e462e191822	e02a4651-1176-4678-b9a2-80876e2dc2f2	t
f36c6fd0-b46c-43d5-9413-0e462e191822	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	t
f36c6fd0-b46c-43d5-9413-0e462e191822	90374560-2ca4-456d-8801-98ac06c8b0f5	t
f36c6fd0-b46c-43d5-9413-0e462e191822	be64a559-37eb-4a02-930a-75177c5e8f89	t
f36c6fd0-b46c-43d5-9413-0e462e191822	2f483427-27c2-4f28-99e2-a0f1f110d89a	t
f36c6fd0-b46c-43d5-9413-0e462e191822	eee47aba-f11c-451b-bb74-c301092240de	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0851e7e7-c812-4fd3-98d5-10b39f394ea2	f
f36c6fd0-b46c-43d5-9413-0e462e191822	05dacaa7-30ea-4e5f-b440-efd8671626ac	f
f36c6fd0-b46c-43d5-9413-0e462e191822	06d8558e-68e6-4a67-af33-e77385cc7931	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fc7b70e8-6c5d-4254-ad66-4432a61e73f5	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9ad3f5c8-0343-488d-b1dc-077332dfcd7f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	51670a24-22af-4044-a2c8-fa6f561cc77b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	3a11b03f-a652-4dba-9cc2-f76f7c916609	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9d4acc7c-a02b-46e1-b1e3-6228917f908d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e377d3df-ff4e-43b9-8b55-82cb4cafd891	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1116408b-03c1-441e-92a6-f04b4be4a372	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8bdc24d1-60c3-49dc-8d9b-ed1dea10d7ed	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1bbe4253-bf7c-4f64-9a0a-a2d0bb505b15	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2b58b3b0-08d8-4dec-881f-19b8a551b2f0	f
f36c6fd0-b46c-43d5-9413-0e462e191822	55b6e976-0954-4724-bff3-7e02d096ccdd	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ebe8188b-0c77-4993-995d-f7a99a578eb1	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2866ff77-6d11-4076-88b3-47ab819d4685	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d195c82c-f5b7-4af3-89e9-639b337cb874	f
f36c6fd0-b46c-43d5-9413-0e462e191822	3e2b5486-649e-44e2-8090-31bd2e6e995e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	62584a10-07a8-4e30-8cf9-28ca14ae516c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d8e8fea8-e7f0-4867-8823-665cf98b3150	f
f36c6fd0-b46c-43d5-9413-0e462e191822	4bd9da86-ee45-44fe-982e-19d82c9a0f23	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a5419278-ba86-4340-8edb-ee53c8633d85	f
f36c6fd0-b46c-43d5-9413-0e462e191822	89beb243-229b-4a8b-87da-b65106b65958	f
f36c6fd0-b46c-43d5-9413-0e462e191822	52609aff-9e18-4b71-9a21-1e04981e70fa	f
f36c6fd0-b46c-43d5-9413-0e462e191822	52ef2827-5c48-448b-8975-40266cc64b66	f
f36c6fd0-b46c-43d5-9413-0e462e191822	196faef5-835f-4231-acb3-fcd3c661efa6	f
f36c6fd0-b46c-43d5-9413-0e462e191822	3629ba2b-2071-403a-8d48-c56bf7e287f6	f
f36c6fd0-b46c-43d5-9413-0e462e191822	95bd554c-d279-4898-b145-14284b26d635	f
f36c6fd0-b46c-43d5-9413-0e462e191822	64bb1677-0898-479e-a67c-e43a31fac4cd	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ba75754a-52ca-40ef-b3f6-4a29f434a670	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8ab38785-690e-4e8e-adf7-f74b99037080	f
f36c6fd0-b46c-43d5-9413-0e462e191822	667c1f02-310a-43e7-8a25-68d6abc771d8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	676a49c9-b132-4103-85cb-25cd59321af2	f
14dca9b5-d63b-408f-be63-605611e53d4b	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	t
14dca9b5-d63b-408f-be63-605611e53d4b	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	t
14dca9b5-d63b-408f-be63-605611e53d4b	e02a4651-1176-4678-b9a2-80876e2dc2f2	t
14dca9b5-d63b-408f-be63-605611e53d4b	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	t
14dca9b5-d63b-408f-be63-605611e53d4b	90374560-2ca4-456d-8801-98ac06c8b0f5	t
14dca9b5-d63b-408f-be63-605611e53d4b	2f483427-27c2-4f28-99e2-a0f1f110d89a	t
14dca9b5-d63b-408f-be63-605611e53d4b	d8e8fea8-e7f0-4867-8823-665cf98b3150	f
14dca9b5-d63b-408f-be63-605611e53d4b	196faef5-835f-4231-acb3-fcd3c661efa6	f
14dca9b5-d63b-408f-be63-605611e53d4b	ebe8188b-0c77-4993-995d-f7a99a578eb1	f
14dca9b5-d63b-408f-be63-605611e53d4b	3629ba2b-2071-403a-8d48-c56bf7e287f6	f
14dca9b5-d63b-408f-be63-605611e53d4b	2866ff77-6d11-4076-88b3-47ab819d4685	f
f36c6fd0-b46c-43d5-9413-0e462e191822	43bba933-f048-4092-aa04-4d8d380ec896	f
f36c6fd0-b46c-43d5-9413-0e462e191822	dbb04868-6125-46de-9a5d-de8bedaac40e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	3bfa0776-9fff-4b4d-93d4-6f4a41cdc3cd	f
636672b6-143d-4bf2-ac14-e0feade63dc6	56e2aae1-4467-433a-af4e-c01c216dfab0	t
636672b6-143d-4bf2-ac14-e0feade63dc6	48477b64-55e8-4121-92fe-edeabb65e724	t
636672b6-143d-4bf2-ac14-e0feade63dc6	7b625778-5ea8-4665-a489-5ac0d9011945	t
636672b6-143d-4bf2-ac14-e0feade63dc6	e02a4651-1176-4678-b9a2-80876e2dc2f2	t
636672b6-143d-4bf2-ac14-e0feade63dc6	e813ac68-f822-4ad0-ba6e-38813bdb6fb5	t
636672b6-143d-4bf2-ac14-e0feade63dc6	f0425add-100d-4570-9da1-a87ab4d182b8	t
636672b6-143d-4bf2-ac14-e0feade63dc6	abde0849-08db-48ad-8443-7a7256b143be	t
636672b6-143d-4bf2-ac14-e0feade63dc6	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	t
636672b6-143d-4bf2-ac14-e0feade63dc6	8f2ed22a-ea43-4a5d-935b-1e477d88bd00	t
636672b6-143d-4bf2-ac14-e0feade63dc6	5774ea8c-8a74-46cc-8fc4-de6637936b45	t
636672b6-143d-4bf2-ac14-e0feade63dc6	d145c4d7-c125-4d8c-ba5a-9a27a88005de	t
636672b6-143d-4bf2-ac14-e0feade63dc6	2f483427-27c2-4f28-99e2-a0f1f110d89a	t
636672b6-143d-4bf2-ac14-e0feade63dc6	da108e30-fe60-411a-8f18-d8cdfd96bc7f	t
636672b6-143d-4bf2-ac14-e0feade63dc6	b2d3a92b-3b2f-4ba5-8478-6c44a9379989	t
636672b6-143d-4bf2-ac14-e0feade63dc6	799a3332-71ee-462e-9ad8-9a2b590420b8	t
636672b6-143d-4bf2-ac14-e0feade63dc6	678707fb-8938-48d9-a151-2c07ebce38bf	t
636672b6-143d-4bf2-ac14-e0feade63dc6	4422a95f-5255-494e-9db8-d3b0557e3de5	t
636672b6-143d-4bf2-ac14-e0feade63dc6	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	t
636672b6-143d-4bf2-ac14-e0feade63dc6	ab22d27f-8bd7-4c00-8115-13b3d8613c6c	t
636672b6-143d-4bf2-ac14-e0feade63dc6	6aebfc9a-3c33-4f44-9719-c5a6c4a4c6a8	t
636672b6-143d-4bf2-ac14-e0feade63dc6	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	t
636672b6-143d-4bf2-ac14-e0feade63dc6	1e359ee8-1ce0-4eac-bfd2-5651dc12c139	t
636672b6-143d-4bf2-ac14-e0feade63dc6	06f77d3c-cc1b-4d16-9201-2a1ec974551b	t
636672b6-143d-4bf2-ac14-e0feade63dc6	f850dfd4-7f01-4d04-84e5-271530cf4c70	t
636672b6-143d-4bf2-ac14-e0feade63dc6	bb0efd69-4acb-42c5-a498-346495c587bf	t
636672b6-143d-4bf2-ac14-e0feade63dc6	90374560-2ca4-456d-8801-98ac06c8b0f5	t
636672b6-143d-4bf2-ac14-e0feade63dc6	7e9eb8cf-b79a-4753-8015-ae415883a962	t
636672b6-143d-4bf2-ac14-e0feade63dc6	d8e8fea8-e7f0-4867-8823-665cf98b3150	f
636672b6-143d-4bf2-ac14-e0feade63dc6	196faef5-835f-4231-acb3-fcd3c661efa6	f
636672b6-143d-4bf2-ac14-e0feade63dc6	ebe8188b-0c77-4993-995d-f7a99a578eb1	f
636672b6-143d-4bf2-ac14-e0feade63dc6	3629ba2b-2071-403a-8d48-c56bf7e287f6	f
636672b6-143d-4bf2-ac14-e0feade63dc6	2866ff77-6d11-4076-88b3-47ab819d4685	f
f36c6fd0-b46c-43d5-9413-0e462e191822	cca675a4-ebcc-4488-8f38-6b16e1d0e77c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5378990c-879c-4b3b-8076-011707faebf8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	4360735b-545e-4aaa-b69a-8fbc59d0114b	f
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	t
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	t
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	e02a4651-1176-4678-b9a2-80876e2dc2f2	t
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	t
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	90374560-2ca4-456d-8801-98ac06c8b0f5	t
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	2f483427-27c2-4f28-99e2-a0f1f110d89a	t
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	d8e8fea8-e7f0-4867-8823-665cf98b3150	f
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	196faef5-835f-4231-acb3-fcd3c661efa6	f
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	ebe8188b-0c77-4993-995d-f7a99a578eb1	f
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	3629ba2b-2071-403a-8d48-c56bf7e287f6	f
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	2866ff77-6d11-4076-88b3-47ab819d4685	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	t
d7f84708-6ae4-42ea-93d3-825c725f7d2c	56e2aae1-4467-433a-af4e-c01c216dfab0	t
d7f84708-6ae4-42ea-93d3-825c725f7d2c	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	t
d7f84708-6ae4-42ea-93d3-825c725f7d2c	286969a5-8a61-4c6b-947b-749d53439322	t
d7f84708-6ae4-42ea-93d3-825c725f7d2c	e02a4651-1176-4678-b9a2-80876e2dc2f2	t
d7f84708-6ae4-42ea-93d3-825c725f7d2c	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	t
d7f84708-6ae4-42ea-93d3-825c725f7d2c	ebe8188b-0c77-4993-995d-f7a99a578eb1	t
d7f84708-6ae4-42ea-93d3-825c725f7d2c	2da98831-999b-4efb-a6a8-4d1007994038	t
d7f84708-6ae4-42ea-93d3-825c725f7d2c	90374560-2ca4-456d-8801-98ac06c8b0f5	t
d7f84708-6ae4-42ea-93d3-825c725f7d2c	be64a559-37eb-4a02-930a-75177c5e8f89	t
d7f84708-6ae4-42ea-93d3-825c725f7d2c	2f483427-27c2-4f28-99e2-a0f1f110d89a	t
d7f84708-6ae4-42ea-93d3-825c725f7d2c	48477b64-55e8-4121-92fe-edeabb65e724	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	05dacaa7-30ea-4e5f-b440-efd8671626ac	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	e813ac68-f822-4ad0-ba6e-38813bdb6fb5	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	fc7b70e8-6c5d-4254-ad66-4432a61e73f5	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	f0425add-100d-4570-9da1-a87ab4d182b8	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	0544d9aa-268d-4dbb-a91e-f44bdc594b62	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	51670a24-22af-4044-a2c8-fa6f561cc77b	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	abde0849-08db-48ad-8443-7a7256b143be	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	8f2ed22a-ea43-4a5d-935b-1e477d88bd00	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	2b58b3b0-08d8-4dec-881f-19b8a551b2f0	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	55b6e976-0954-4724-bff3-7e02d096ccdd	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	2866ff77-6d11-4076-88b3-47ab819d4685	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	d145c4d7-c125-4d8c-ba5a-9a27a88005de	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	3e2b5486-649e-44e2-8090-31bd2e6e995e	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	d195c82c-f5b7-4af3-89e9-639b337cb874	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	799a3332-71ee-462e-9ad8-9a2b590420b8	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	bfd7612d-abd5-4ed8-8ec4-04fc1ccea5a1	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	678707fb-8938-48d9-a151-2c07ebce38bf	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	4bd9da86-ee45-44fe-982e-19d82c9a0f23	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	300fff2d-0cd9-4a6e-9704-e0230695e7d3	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	6aebfc9a-3c33-4f44-9719-c5a6c4a4c6a8	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	89beb243-229b-4a8b-87da-b65106b65958	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	1e359ee8-1ce0-4eac-bfd2-5651dc12c139	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	52ef2827-5c48-448b-8975-40266cc64b66	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	52609aff-9e18-4b71-9a21-1e04981e70fa	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	196faef5-835f-4231-acb3-fcd3c661efa6	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	95bd554c-d279-4898-b145-14284b26d635	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	f850dfd4-7f01-4d04-84e5-271530cf4c70	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	64bb1677-0898-479e-a67c-e43a31fac4cd	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	bb0efd69-4acb-42c5-a498-346495c587bf	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	ba75754a-52ca-40ef-b3f6-4a29f434a670	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	8ab38785-690e-4e8e-adf7-f74b99037080	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	de001381-7e44-4fa8-b49e-76a9263c3ee8	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	676a49c9-b132-4103-85cb-25cd59321af2	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	eee47aba-f11c-451b-bb74-c301092240de	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	0851e7e7-c812-4fd3-98d5-10b39f394ea2	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	7b625778-5ea8-4665-a489-5ac0d9011945	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	06d8558e-68e6-4a67-af33-e77385cc7931	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	9ad3f5c8-0343-488d-b1dc-077332dfcd7f	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	9d4acc7c-a02b-46e1-b1e3-6228917f908d	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	3a11b03f-a652-4dba-9cc2-f76f7c916609	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	5774ea8c-8a74-46cc-8fc4-de6637936b45	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	da108e30-fe60-411a-8f18-d8cdfd96bc7f	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	62584a10-07a8-4e30-8cf9-28ca14ae516c	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	b2d3a92b-3b2f-4ba5-8478-6c44a9379989	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	d8e8fea8-e7f0-4867-8823-665cf98b3150	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	4422a95f-5255-494e-9db8-d3b0557e3de5	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	a5419278-ba86-4340-8edb-ee53c8633d85	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	ab22d27f-8bd7-4c00-8115-13b3d8613c6c	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	06f77d3c-cc1b-4d16-9201-2a1ec974551b	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	3629ba2b-2071-403a-8d48-c56bf7e287f6	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	667c1f02-310a-43e7-8a25-68d6abc771d8	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	7e9eb8cf-b79a-4753-8015-ae415883a962	f
f36c6fd0-b46c-43d5-9413-0e462e191822	286969a5-8a61-4c6b-947b-749d53439322	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	e02a4651-1176-4678-b9a2-80876e2dc2f2	t
29c5bc63-ce60-4a06-883b-a66d156c84b5	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	t
29c5bc63-ce60-4a06-883b-a66d156c84b5	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	t
29c5bc63-ce60-4a06-883b-a66d156c84b5	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	t
d0e81265-5646-4d25-9bb0-c689a2a61478	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	t
d0e81265-5646-4d25-9bb0-c689a2a61478	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	t
d0e81265-5646-4d25-9bb0-c689a2a61478	e02a4651-1176-4678-b9a2-80876e2dc2f2	t
d0e81265-5646-4d25-9bb0-c689a2a61478	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	t
d0e81265-5646-4d25-9bb0-c689a2a61478	90374560-2ca4-456d-8801-98ac06c8b0f5	t
d0e81265-5646-4d25-9bb0-c689a2a61478	2f483427-27c2-4f28-99e2-a0f1f110d89a	t
d0e81265-5646-4d25-9bb0-c689a2a61478	48477b64-55e8-4121-92fe-edeabb65e724	f
d0e81265-5646-4d25-9bb0-c689a2a61478	05dacaa7-30ea-4e5f-b440-efd8671626ac	f
d0e81265-5646-4d25-9bb0-c689a2a61478	e813ac68-f822-4ad0-ba6e-38813bdb6fb5	f
d0e81265-5646-4d25-9bb0-c689a2a61478	f0425add-100d-4570-9da1-a87ab4d182b8	f
d0e81265-5646-4d25-9bb0-c689a2a61478	fc7b70e8-6c5d-4254-ad66-4432a61e73f5	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	90374560-2ca4-456d-8801-98ac06c8b0f5	t
29c5bc63-ce60-4a06-883b-a66d156c84b5	2f483427-27c2-4f28-99e2-a0f1f110d89a	t
29c5bc63-ce60-4a06-883b-a66d156c84b5	d8e8fea8-e7f0-4867-8823-665cf98b3150	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	676a49c9-b132-4103-85cb-25cd59321af2	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	eee47aba-f11c-451b-bb74-c301092240de	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	52ef2827-5c48-448b-8975-40266cc64b66	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	64bb1677-0898-479e-a67c-e43a31fac4cd	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	2b58b3b0-08d8-4dec-881f-19b8a551b2f0	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	196faef5-835f-4231-acb3-fcd3c661efa6	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	3629ba2b-2071-403a-8d48-c56bf7e287f6	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	9ad3f5c8-0343-488d-b1dc-077332dfcd7f	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	2866ff77-6d11-4076-88b3-47ab819d4685	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	c9469db6-d939-496e-bf11-02e2750f8a0c	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	ebe8188b-0c77-4993-995d-f7a99a578eb1	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	55b6e976-0954-4724-bff3-7e02d096ccdd	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	d195c82c-f5b7-4af3-89e9-639b337cb874	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	bf99f3b1-2e5b-4816-a5c9-7e12c545f114	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	eee90633-00a0-4c43-84f3-1e4418b77768	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	e366dc19-c0c3-484d-abe9-4df2c38d8f2d	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	fc7b70e8-6c5d-4254-ad66-4432a61e73f5	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	95bd554c-d279-4898-b145-14284b26d635	f
d0e81265-5646-4d25-9bb0-c689a2a61478	be64a559-37eb-4a02-930a-75177c5e8f89	f
d0e81265-5646-4d25-9bb0-c689a2a61478	0544d9aa-268d-4dbb-a91e-f44bdc594b62	f
d0e81265-5646-4d25-9bb0-c689a2a61478	51670a24-22af-4044-a2c8-fa6f561cc77b	f
d0e81265-5646-4d25-9bb0-c689a2a61478	abde0849-08db-48ad-8443-7a7256b143be	f
d0e81265-5646-4d25-9bb0-c689a2a61478	8f2ed22a-ea43-4a5d-935b-1e477d88bd00	f
d0e81265-5646-4d25-9bb0-c689a2a61478	2b58b3b0-08d8-4dec-881f-19b8a551b2f0	f
d0e81265-5646-4d25-9bb0-c689a2a61478	55b6e976-0954-4724-bff3-7e02d096ccdd	f
d0e81265-5646-4d25-9bb0-c689a2a61478	2866ff77-6d11-4076-88b3-47ab819d4685	f
d0e81265-5646-4d25-9bb0-c689a2a61478	d145c4d7-c125-4d8c-ba5a-9a27a88005de	f
d0e81265-5646-4d25-9bb0-c689a2a61478	d195c82c-f5b7-4af3-89e9-639b337cb874	f
d0e81265-5646-4d25-9bb0-c689a2a61478	3e2b5486-649e-44e2-8090-31bd2e6e995e	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	1116408b-03c1-441e-92a6-f04b4be4a372	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	c4dca583-56f4-4321-adc4-02b468f2e266	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	5dfbd89f-8c18-474b-9539-f36907361f6f	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	992bdac6-8037-4ad8-b53c-772d6af5cb76	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	c22ae79e-cff3-487e-b656-372bafd3d263	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	d7311d75-34cb-4e2d-9d4d-c582260801ac	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	6eb12ac0-9deb-4e76-90a1-69764deec1b5	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	faed5bbb-88c2-40c1-aa39-19ca7bfa95bf	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	ba3166fc-3636-4089-a02a-35553a6fbeae	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	8ab38785-690e-4e8e-adf7-f74b99037080	f
d0e81265-5646-4d25-9bb0-c689a2a61478	799a3332-71ee-462e-9ad8-9a2b590420b8	f
d0e81265-5646-4d25-9bb0-c689a2a61478	678707fb-8938-48d9-a151-2c07ebce38bf	f
d0e81265-5646-4d25-9bb0-c689a2a61478	bfd7612d-abd5-4ed8-8ec4-04fc1ccea5a1	f
d0e81265-5646-4d25-9bb0-c689a2a61478	4bd9da86-ee45-44fe-982e-19d82c9a0f23	f
d0e81265-5646-4d25-9bb0-c689a2a61478	286969a5-8a61-4c6b-947b-749d53439322	f
d0e81265-5646-4d25-9bb0-c689a2a61478	300fff2d-0cd9-4a6e-9704-e0230695e7d3	f
d0e81265-5646-4d25-9bb0-c689a2a61478	6aebfc9a-3c33-4f44-9719-c5a6c4a4c6a8	f
d0e81265-5646-4d25-9bb0-c689a2a61478	89beb243-229b-4a8b-87da-b65106b65958	f
d0e81265-5646-4d25-9bb0-c689a2a61478	1e359ee8-1ce0-4eac-bfd2-5651dc12c139	f
d0e81265-5646-4d25-9bb0-c689a2a61478	52ef2827-5c48-448b-8975-40266cc64b66	f
d0e81265-5646-4d25-9bb0-c689a2a61478	52609aff-9e18-4b71-9a21-1e04981e70fa	f
d0e81265-5646-4d25-9bb0-c689a2a61478	196faef5-835f-4231-acb3-fcd3c661efa6	f
d0e81265-5646-4d25-9bb0-c689a2a61478	f850dfd4-7f01-4d04-84e5-271530cf4c70	f
d0e81265-5646-4d25-9bb0-c689a2a61478	95bd554c-d279-4898-b145-14284b26d635	f
d0e81265-5646-4d25-9bb0-c689a2a61478	64bb1677-0898-479e-a67c-e43a31fac4cd	f
d0e81265-5646-4d25-9bb0-c689a2a61478	bb0efd69-4acb-42c5-a498-346495c587bf	f
d0e81265-5646-4d25-9bb0-c689a2a61478	ba75754a-52ca-40ef-b3f6-4a29f434a670	f
d0e81265-5646-4d25-9bb0-c689a2a61478	8ab38785-690e-4e8e-adf7-f74b99037080	f
d0e81265-5646-4d25-9bb0-c689a2a61478	de001381-7e44-4fa8-b49e-76a9263c3ee8	f
d0e81265-5646-4d25-9bb0-c689a2a61478	676a49c9-b132-4103-85cb-25cd59321af2	f
d0e81265-5646-4d25-9bb0-c689a2a61478	c9469db6-d939-496e-bf11-02e2750f8a0c	f
d0e81265-5646-4d25-9bb0-c689a2a61478	eee47aba-f11c-451b-bb74-c301092240de	f
d0e81265-5646-4d25-9bb0-c689a2a61478	7b625778-5ea8-4665-a489-5ac0d9011945	f
d0e81265-5646-4d25-9bb0-c689a2a61478	0851e7e7-c812-4fd3-98d5-10b39f394ea2	f
d0e81265-5646-4d25-9bb0-c689a2a61478	06d8558e-68e6-4a67-af33-e77385cc7931	f
d0e81265-5646-4d25-9bb0-c689a2a61478	9ad3f5c8-0343-488d-b1dc-077332dfcd7f	f
d0e81265-5646-4d25-9bb0-c689a2a61478	9d4acc7c-a02b-46e1-b1e3-6228917f908d	f
d0e81265-5646-4d25-9bb0-c689a2a61478	3a11b03f-a652-4dba-9cc2-f76f7c916609	f
d0e81265-5646-4d25-9bb0-c689a2a61478	ebe8188b-0c77-4993-995d-f7a99a578eb1	f
d0e81265-5646-4d25-9bb0-c689a2a61478	5774ea8c-8a74-46cc-8fc4-de6637936b45	f
d0e81265-5646-4d25-9bb0-c689a2a61478	da108e30-fe60-411a-8f18-d8cdfd96bc7f	f
d0e81265-5646-4d25-9bb0-c689a2a61478	b2d3a92b-3b2f-4ba5-8478-6c44a9379989	f
d0e81265-5646-4d25-9bb0-c689a2a61478	62584a10-07a8-4e30-8cf9-28ca14ae516c	f
d0e81265-5646-4d25-9bb0-c689a2a61478	d8e8fea8-e7f0-4867-8823-665cf98b3150	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e366dc19-c0c3-484d-abe9-4df2c38d8f2d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ab53250f-01a0-4b30-8329-23634f4fefcc	f
f36c6fd0-b46c-43d5-9413-0e462e191822	669c24e0-9798-447a-95c7-2a55ac65b237	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5298c4b4-a89c-4a18-83f4-76461e45ae99	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	d536ec69-7063-4d53-8376-26973d9922c6	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	667c1f02-310a-43e7-8a25-68d6abc771d8	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	d2a8dd5b-b054-41c7-a50f-3a4f8f72679b	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	9de8b34d-2499-4b06-a0c9-8d453c1d52db	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	0851e7e7-c812-4fd3-98d5-10b39f394ea2	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	a7d92a94-bcf6-43c3-bb10-d4589e7b952a	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	ab53250f-01a0-4b30-8329-23634f4fefcc	f
d0e81265-5646-4d25-9bb0-c689a2a61478	4422a95f-5255-494e-9db8-d3b0557e3de5	f
d0e81265-5646-4d25-9bb0-c689a2a61478	a5419278-ba86-4340-8edb-ee53c8633d85	f
d0e81265-5646-4d25-9bb0-c689a2a61478	ab22d27f-8bd7-4c00-8115-13b3d8613c6c	f
d0e81265-5646-4d25-9bb0-c689a2a61478	06f77d3c-cc1b-4d16-9201-2a1ec974551b	f
d0e81265-5646-4d25-9bb0-c689a2a61478	3629ba2b-2071-403a-8d48-c56bf7e287f6	f
d0e81265-5646-4d25-9bb0-c689a2a61478	667c1f02-310a-43e7-8a25-68d6abc771d8	f
d0e81265-5646-4d25-9bb0-c689a2a61478	7e9eb8cf-b79a-4753-8015-ae415883a962	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	ae3acdee-5010-4564-86cf-3b4c709a7a38	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	5378990c-879c-4b3b-8076-011707faebf8	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	9731bdab-053e-48f6-8095-068677f9bf93	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	d2570df5-42e6-4a25-919b-78f1bb4bb74a	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	5bde7941-4b13-4e13-ad0e-a395490dbc61	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	9be14563-01d2-4d25-a112-9b50166575cb	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	5298c4b4-a89c-4a18-83f4-76461e45ae99	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	2da98831-999b-4efb-a6a8-4d1007994038	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d536ec69-7063-4d53-8376-26973d9922c6	f
f36c6fd0-b46c-43d5-9413-0e462e191822	32e5e12c-2c65-4e80-9be1-44fa2bf94028	f
f36c6fd0-b46c-43d5-9413-0e462e191822	6eb12ac0-9deb-4e76-90a1-69764deec1b5	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ba3166fc-3636-4089-a02a-35553a6fbeae	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	9d4acc7c-a02b-46e1-b1e3-6228917f908d	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	3a11b03f-a652-4dba-9cc2-f76f7c916609	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	43bba933-f048-4092-aa04-4d8d380ec896	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	d2902ff9-2f92-4e77-b225-5838adf91fd9	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	90f601de-7e84-47a6-82c9-1b8847ef69a8	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	4bd9da86-ee45-44fe-982e-19d82c9a0f23	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	32e5e12c-2c65-4e80-9be1-44fa2bf94028	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	3e2b5486-649e-44e2-8090-31bd2e6e995e	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	f9955ebd-bd00-42ca-97f0-10b6c4814450	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	ba75754a-52ca-40ef-b3f6-4a29f434a670	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	0f327441-f79e-4ccc-9894-4980d61a9aa6	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	06d8558e-68e6-4a67-af33-e77385cc7931	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	286969a5-8a61-4c6b-947b-749d53439322	f
363258bf-2231-431d-82ba-63c63ce82c2e	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	t
363258bf-2231-431d-82ba-63c63ce82c2e	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	t
363258bf-2231-431d-82ba-63c63ce82c2e	e02a4651-1176-4678-b9a2-80876e2dc2f2	t
363258bf-2231-431d-82ba-63c63ce82c2e	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	t
363258bf-2231-431d-82ba-63c63ce82c2e	90374560-2ca4-456d-8801-98ac06c8b0f5	t
363258bf-2231-431d-82ba-63c63ce82c2e	2f483427-27c2-4f28-99e2-a0f1f110d89a	t
363258bf-2231-431d-82ba-63c63ce82c2e	d8e8fea8-e7f0-4867-8823-665cf98b3150	f
363258bf-2231-431d-82ba-63c63ce82c2e	196faef5-835f-4231-acb3-fcd3c661efa6	f
363258bf-2231-431d-82ba-63c63ce82c2e	ebe8188b-0c77-4993-995d-f7a99a578eb1	f
363258bf-2231-431d-82ba-63c63ce82c2e	3629ba2b-2071-403a-8d48-c56bf7e287f6	f
363258bf-2231-431d-82ba-63c63ce82c2e	2866ff77-6d11-4076-88b3-47ab819d4685	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fb813041-4997-4d95-b813-46d5ac27b91e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c5328cf1-23a3-4ca3-accd-3b21720da4e2	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0c3cb893-1132-4214-b00b-b6cf715a97a7	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	cca675a4-ebcc-4488-8f38-6b16e1d0e77c	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	e377d3df-ff4e-43b9-8b55-82cb4cafd891	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	125bb4be-470a-4b82-8b95-aa648432cc4d	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	de5a2d52-38e3-4768-8f53-a46c5e8faf52	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	edfbac25-1fba-44ba-92a6-ed54a4223db1	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	62584a10-07a8-4e30-8cf9-28ca14ae516c	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	05dacaa7-30ea-4e5f-b440-efd8671626ac	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	dbb04868-6125-46de-9a5d-de8bedaac40e	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	ef68f01a-aa2f-4d46-835f-b18471f512e3	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	a5419278-ba86-4340-8edb-ee53c8633d85	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	0c3cb893-1132-4214-b00b-b6cf715a97a7	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	feb7a0b9-e989-4366-8139-05d615a76c21	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	b0f63457-d304-4e49-9267-de55fc5cfec0	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	be64a559-37eb-4a02-930a-75177c5e8f89	f
8c1a8594-ee37-49ad-9bc5-6db27db6a544	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	t
8c1a8594-ee37-49ad-9bc5-6db27db6a544	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	t
8c1a8594-ee37-49ad-9bc5-6db27db6a544	e02a4651-1176-4678-b9a2-80876e2dc2f2	t
f36c6fd0-b46c-43d5-9413-0e462e191822	483ecd4a-f176-411e-897a-1e6931bcfe5f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	de5a2d52-38e3-4768-8f53-a46c5e8faf52	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fc422b68-82cf-4220-a937-13b3346eda41	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d7311d75-34cb-4e2d-9d4d-c582260801ac	f
f36c6fd0-b46c-43d5-9413-0e462e191822	faed5bbb-88c2-40c1-aa39-19ca7bfa95bf	f
8c1a8594-ee37-49ad-9bc5-6db27db6a544	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	t
8c1a8594-ee37-49ad-9bc5-6db27db6a544	90374560-2ca4-456d-8801-98ac06c8b0f5	t
8c1a8594-ee37-49ad-9bc5-6db27db6a544	2f483427-27c2-4f28-99e2-a0f1f110d89a	t
8c1a8594-ee37-49ad-9bc5-6db27db6a544	d8e8fea8-e7f0-4867-8823-665cf98b3150	f
8c1a8594-ee37-49ad-9bc5-6db27db6a544	196faef5-835f-4231-acb3-fcd3c661efa6	f
8c1a8594-ee37-49ad-9bc5-6db27db6a544	ebe8188b-0c77-4993-995d-f7a99a578eb1	f
8c1a8594-ee37-49ad-9bc5-6db27db6a544	3629ba2b-2071-403a-8d48-c56bf7e287f6	f
8c1a8594-ee37-49ad-9bc5-6db27db6a544	2866ff77-6d11-4076-88b3-47ab819d4685	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0f327441-f79e-4ccc-9894-4980d61a9aa6	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	6f6ee623-c214-4af7-9e20-66cf5b26b3ce	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	c61b6a0d-0a10-4beb-bf70-9602297ab94e	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	2d0c315b-bfc0-487c-94c4-94016032e8cf	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	483ecd4a-f176-411e-897a-1e6931bcfe5f	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	cf6c9831-fc67-4090-aa7e-7e136e323944	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	52609aff-9e18-4b71-9a21-1e04981e70fa	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	218c78c8-9bce-4424-896d-f98089f26e28	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	595a0072-8691-4ce3-b8a9-6e41ae3af429	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	669c24e0-9798-447a-95c7-2a55ac65b237	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	63c987ed-5786-4f72-a2da-fda70991f508	f
29c5bc63-ce60-4a06-883b-a66d156c84b5	4360735b-545e-4aaa-b69a-8fbc59d0114b	f
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	t
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	56e2aae1-4467-433a-af4e-c01c216dfab0	t
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	t
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	e02a4651-1176-4678-b9a2-80876e2dc2f2	t
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	t
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	bfba13ac-edd0-4bae-a3fc-a03713ffbf5c	t
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	90374560-2ca4-456d-8801-98ac06c8b0f5	t
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	2f483427-27c2-4f28-99e2-a0f1f110d89a	t
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	d8e8fea8-e7f0-4867-8823-665cf98b3150	f
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	196faef5-835f-4231-acb3-fcd3c661efa6	f
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	ebe8188b-0c77-4993-995d-f7a99a578eb1	f
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	3629ba2b-2071-403a-8d48-c56bf7e287f6	f
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	2866ff77-6d11-4076-88b3-47ab819d4685	f
f36c6fd0-b46c-43d5-9413-0e462e191822	4d756a92-25d5-4373-8782-0565e3fe09b2	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0fa7c25e-a976-46d6-875d-9d77358c3e80	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b4b198ed-5c3c-448d-8553-55d64f840935	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7e9eb8cf-b79a-4753-8015-ae415883a962	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8bda4041-e3aa-4182-ad24-43b36474b2f0	f
f36c6fd0-b46c-43d5-9413-0e462e191822	44a6438e-06a1-423c-9a9b-a5ee207f855d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fe27ed2a-9a43-4460-b7fd-da3e758b21f0	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9480f6db-0d4c-4da9-a331-6462c3256673	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2a4f6e5d-687a-4c3a-aa98-f045339f3c46	f
f36c6fd0-b46c-43d5-9413-0e462e191822	42ed3d5b-916a-48b6-bb3b-006d9b187220	f
f36c6fd0-b46c-43d5-9413-0e462e191822	6aebfc9a-3c33-4f44-9719-c5a6c4a4c6a8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ba7ec3c1-2161-403d-898a-1d964eedf23b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5da60049-cd96-4b9f-9128-1326bbd5110b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	440395ac-8f69-4973-adce-462fc4120522	f
f36c6fd0-b46c-43d5-9413-0e462e191822	354422fc-b2f8-482e-9113-051e6e013b61	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1abfaef9-ce3b-438b-afdf-fabf50d26eed	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e30d3d7d-c75f-4577-90f8-befd832559ef	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d2a8dd5b-b054-41c7-a50f-3a4f8f72679b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	611e4c87-c553-421c-8184-3b01f9194dee	f
f36c6fd0-b46c-43d5-9413-0e462e191822	830209e1-ff70-426d-9825-b37b4fe5044c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b056d7c0-bfab-4e6c-b1f5-8290a954724c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c4dca583-56f4-4321-adc4-02b468f2e266	f
f36c6fd0-b46c-43d5-9413-0e462e191822	05eea5d8-f24c-4238-951f-7e2157f7ce9b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d8c526b7-be21-4c8a-8702-9e005ec61f23	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0a4b76c0-a0ec-4d8a-8865-921264098f30	f
f36c6fd0-b46c-43d5-9413-0e462e191822	30485bbd-157f-4c45-80f3-4f57604da7ac	f
f36c6fd0-b46c-43d5-9413-0e462e191822	79f24dd1-f9b7-4cd2-bef0-51b75e456dd9	f
f36c6fd0-b46c-43d5-9413-0e462e191822	36109312-2045-43f3-acb4-bd25cbcf14fd	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b2ed7e22-8199-4cb6-9c31-c22a058072fc	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1b8399f0-ac55-4956-906f-2428ffd15d7b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2864a93e-95ff-41f1-86a2-27d64f1ad912	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5860674f-c916-4cce-8b44-d05a2c489b90	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8693c08a-b7cb-4c03-b877-7c107d9a282b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5d30b4f0-ffa5-48cd-ae91-feaa250edfe4	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ebf37fe5-d677-4e97-aa97-c0b3bf6e60dc	f
f36c6fd0-b46c-43d5-9413-0e462e191822	111c51db-f146-4831-961d-ecf8ce6cf188	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7de72220-6e79-4403-9e42-07fbe915779f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ba47eb98-9ad8-4d08-829f-837a3635107b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8ba948c5-faf8-424d-b3e8-37b62ad72703	f
f36c6fd0-b46c-43d5-9413-0e462e191822	50e0de09-4c75-4ee1-bd26-b4402344595a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	02bcc7d6-52b4-4ade-9b32-5fc17c471946	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b918c43b-75d7-4e23-87ec-13ad3f714978	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2878ac9c-fd4c-485c-97e8-19a8057fefdc	f
f36c6fd0-b46c-43d5-9413-0e462e191822	80d1399b-f866-4cfa-8d24-c209dbaac6b6	f
f36c6fd0-b46c-43d5-9413-0e462e191822	6a356c45-792e-40c6-ad11-1b276446d2cd	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9be14563-01d2-4d25-a112-9b50166575cb	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7d86def0-7bf3-4926-a9f8-68adcbc35948	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c10b6b22-4bef-4f21-a7be-5a851a7de576	f
f36c6fd0-b46c-43d5-9413-0e462e191822	729757fe-dea7-498c-80d5-0a6e589fbb88	f
f36c6fd0-b46c-43d5-9413-0e462e191822	34ca1dac-6788-4471-888e-b6afc9a151f9	f
f36c6fd0-b46c-43d5-9413-0e462e191822	097ac263-341e-4f60-af98-92b004c47eec	f
f36c6fd0-b46c-43d5-9413-0e462e191822	56e2aae1-4467-433a-af4e-c01c216dfab0	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0456d609-0eb7-447a-aa91-423523c38083	f
f36c6fd0-b46c-43d5-9413-0e462e191822	da108e30-fe60-411a-8f18-d8cdfd96bc7f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	50cfd70b-866e-484c-857a-abe1544f0fa2	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7bf78fea-7ab5-4176-9ec0-7a0b9d3adecf	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8ff66e08-647d-4880-8d7d-471ab03f36d7	f
f36c6fd0-b46c-43d5-9413-0e462e191822	59c26954-3efd-4346-aa7a-b43c328c3863	f
f36c6fd0-b46c-43d5-9413-0e462e191822	62ce435c-4667-4ab8-861d-fc0980cd7239	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2ece843c-ae7d-454c-b166-db5f8ec93521	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5f1ea6cd-12a4-4852-8b0b-27ca6d402f67	f
f36c6fd0-b46c-43d5-9413-0e462e191822	42b0d279-e28d-4300-9d1e-4b9c7823721d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	626ba1db-3599-4d0a-9649-2d9184cc321e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b82a2f07-4318-429f-a713-0785b530a036	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b8d9bdc8-1de6-4f35-a2d1-52a414c81648	f
f36c6fd0-b46c-43d5-9413-0e462e191822	3f7b9747-dfb2-4192-83da-39077468f5ca	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c656fcf0-42f1-4881-9f92-1bf5136fa564	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ed77978b-bec1-4c83-b889-77cb0bd005c8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ab88fec5-dbde-49bb-93cf-eefeafee64e9	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2a2db87c-3834-4df7-a925-8174f92fcee3	f
f36c6fd0-b46c-43d5-9413-0e462e191822	533e9263-ab8f-4eff-b110-5415343d654e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e87e21b0-0a75-4b0d-9e2c-fd11d06625aa	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0663f872-4c0a-4d77-94c3-4ba7a6dc3bc7	f
f36c6fd0-b46c-43d5-9413-0e462e191822	3c94272e-6893-47de-b5cb-b4aab715e0c5	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ab02b2e1-b2d0-442d-be36-84e19a1a74d8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c22ae79e-cff3-487e-b656-372bafd3d263	f
f36c6fd0-b46c-43d5-9413-0e462e191822	3d06220b-a6b7-4b7b-994b-c4ddb5e7ad96	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9370d410-c486-4be0-aa9a-81c0ac4f9384	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e152de04-53be-4817-8fdd-5c5075350ce3	f
f36c6fd0-b46c-43d5-9413-0e462e191822	dcca1829-20b2-4026-b227-3c006e5bef4d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fd5aa840-8f62-4220-8043-f6a1f132cd3c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f0425add-100d-4570-9da1-a87ab4d182b8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	992bdac6-8037-4ad8-b53c-772d6af5cb76	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ece2fd04-57e5-4b03-a139-cdcb77d7dfee	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e813ac68-f822-4ad0-ba6e-38813bdb6fb5	f
f36c6fd0-b46c-43d5-9413-0e462e191822	de001381-7e44-4fa8-b49e-76a9263c3ee8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	6ca86c95-e876-4f42-99a0-e2f3d572f897	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f031feac-4931-4293-9f65-a9038f16b41e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	55b83805-2e91-47a5-ae96-9f2c980c373a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	47aac304-a931-497b-8102-15b07ce69435	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e5aa01cd-c0fb-4978-a511-f5525a4709b1	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8ba54ba4-2cd8-4471-b21c-1bffc2c6aacc	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b1ac7d6d-8448-42be-93eb-2d5604dfb696	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5bcc4d2e-b73d-4b2f-b9fa-707fdc83626b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	093bdec8-d6c5-4cdd-8a9f-9cffa0ff3e89	f
f36c6fd0-b46c-43d5-9413-0e462e191822	647d9c71-93a3-4ac6-8497-fa64f9dae118	f
f36c6fd0-b46c-43d5-9413-0e462e191822	444d4984-223c-40d1-a431-5f437a204b11	f
f36c6fd0-b46c-43d5-9413-0e462e191822	4a73e312-ed5c-4e1b-9258-76340d6a57d7	f
f36c6fd0-b46c-43d5-9413-0e462e191822	40aaf0be-7ebb-4754-9e2a-249f53a22769	f
f36c6fd0-b46c-43d5-9413-0e462e191822	72ec077c-7793-4577-8375-cd1ce329586d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	64aba9a5-4a61-4190-b988-d957e4138b53	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8e3f744f-58e9-410a-8e1b-8984b05f24df	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9cbfe3aa-cadf-4e8d-bdc2-26362fd6f946	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d3c3e109-4d13-4299-a571-88415ede5353	f
f36c6fd0-b46c-43d5-9413-0e462e191822	126c40cb-d8d6-43ae-909e-a7b0529ffc02	f
f36c6fd0-b46c-43d5-9413-0e462e191822	840de913-f4e5-47b7-90ff-8e6233e259cf	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1d92aec6-d2bc-42ae-a271-c06eaffc46af	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f52a92c1-ea91-4896-9e82-cdcab6ad8b9b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7da4bbee-cd9c-4548-b22e-ba2f7d6073d4	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c77a85d7-16b4-4391-a158-c7adb9de031f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	bf99f3b1-2e5b-4816-a5c9-7e12c545f114	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d7da8f38-8c27-4c82-8a96-fa0d416b544b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9437f7ea-9860-4dac-8661-97f7189bf97d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ac5f36b1-6070-4b84-97b3-72078e051deb	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b7abd9b5-9d48-4137-a9ab-b95b1511e83f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	15563d48-df24-4c77-9074-bf9844f38ebf	f
f36c6fd0-b46c-43d5-9413-0e462e191822	848e1619-77dd-4d4b-80a3-356263134e2a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	89bca4d6-d2d2-466d-be52-a671b9544a47	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9b63cd22-85c1-433a-81a7-69f9ff9e3eef	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1c3c40ad-6805-412a-ad4e-bc6e6ef2f34e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	799a3332-71ee-462e-9ad8-9a2b590420b8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	87144a0a-66ab-411b-83cf-5b952d11b566	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fe3486fb-34c2-405a-920c-b1fd75c9502e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d53d083c-016b-4237-b864-c0453b2f793a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	39c3d188-09e1-4ff9-a9e1-34dc7353b9e4	f
f36c6fd0-b46c-43d5-9413-0e462e191822	765a1b2d-eb7b-4d11-83a8-0f5c1b464746	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7faa433a-f5d7-43c1-af9d-c4c5cb8de237	f
f36c6fd0-b46c-43d5-9413-0e462e191822	dce5a8d5-83e5-4e5f-be55-6e8602f2de3c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	bed47e4c-58db-4fbb-9d06-14e115281a6a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	6fbc4d99-309e-477d-9b3c-892d54d25692	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d8794389-348e-4967-97b7-77cd27f3485d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	abf88bfc-73de-44af-8e3d-d537c09ce287	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f1ae55eb-0110-4c56-9bb0-a7dc1951163a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0544d9aa-268d-4dbb-a91e-f44bdc594b62	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8f2ed22a-ea43-4a5d-935b-1e477d88bd00	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f3d58afa-c59a-49c4-9d1f-56fa8a8251af	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0fc40810-8dfd-489c-a6b3-5798039afa62	f
f36c6fd0-b46c-43d5-9413-0e462e191822	3b60b1a5-6800-4b53-b3e4-223a22912772	f
f36c6fd0-b46c-43d5-9413-0e462e191822	21cc9678-32f4-4307-b177-b5a6d0d27ec2	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7d3cd13f-3717-4f11-91ea-80d1d54b0edc	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8c0bcf77-a888-4628-9800-065d5051380e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9d092bd4-7a24-4c55-ab20-fd4198073ef0	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c21b2e25-4d80-4bbe-bfa5-08b7da303d9e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	061f2d22-ec9c-4dab-a393-7c8b17645cc3	f
f36c6fd0-b46c-43d5-9413-0e462e191822	06c10cca-c56c-4f53-8984-be57d76c104e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fde23630-7bd8-407e-8d1b-7da030fbc99a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1e359ee8-1ce0-4eac-bfd2-5651dc12c139	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0df57532-0729-4e93-8e42-f8d484640ee5	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f64306fa-62fb-4639-a705-c86a34508208	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0b7739aa-f62c-4e67-9c32-1c0fa4912f8f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	6c49d235-f2af-4612-9700-23e146037042	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9082badf-6439-46fe-a7f4-238fc2399909	f
f36c6fd0-b46c-43d5-9413-0e462e191822	3d12b1b5-c4dd-4e47-a374-b8ddae055d9f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	eebc4edb-1a93-47b6-ae90-c096bd156b7e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2e082875-777a-4eb2-b519-f3edb591ddff	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d2a22102-62ed-4aef-b05e-877d9673db30	f
f36c6fd0-b46c-43d5-9413-0e462e191822	18bef4d5-77c4-414f-bd80-6efd2964ce7b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	4543a7e3-1639-4843-94be-f6b8512ece86	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5774ea8c-8a74-46cc-8fc4-de6637936b45	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f9c33f64-8292-4e5e-80c6-69baa9522a3b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1870a570-47cd-4a90-b476-fa24fe7044ac	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e21b1cd2-cddd-4797-b8d4-84c4eff8c6e4	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7bdbe596-0ed5-43be-9456-595f9312d706	f
f36c6fd0-b46c-43d5-9413-0e462e191822	88b827f5-466b-4e72-9ee5-51cd7272c69c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2da98831-999b-4efb-a6a8-4d1007994038	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e5a4c539-dd2b-4d47-83af-774847c3752b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b818d2c4-bc47-4076-a456-3d3c7e738891	f
f36c6fd0-b46c-43d5-9413-0e462e191822	aace8c85-5c21-4335-a7dc-7b8f8e4f836b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b5319bc6-c001-44b3-a902-26e90b3c1860	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9b451679-b8f4-4afa-8a27-0769787314c7	f
f36c6fd0-b46c-43d5-9413-0e462e191822	db702915-1f42-4646-b24e-6dded2018740	f
f36c6fd0-b46c-43d5-9413-0e462e191822	79362aa9-9881-4ae6-bc51-44eb917f7554	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b7f85c76-1ea9-41cb-a7be-c37fb9a7c407	f
f36c6fd0-b46c-43d5-9413-0e462e191822	483c41a1-4bb4-47aa-88ff-906fe7b1e56f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fed26260-eb28-4c01-9e21-7159ba78253a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c304ffd3-7dbc-4e66-a194-c80ffb7952c3	f
f36c6fd0-b46c-43d5-9413-0e462e191822	39d3a579-a584-4218-94d9-2e53dac98f28	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ee248d08-0cc6-48d0-b6b4-e9555287a2be	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a6902e53-4ccb-4dee-9db6-ffe2c7c3b9de	f
f36c6fd0-b46c-43d5-9413-0e462e191822	76a6a458-dddc-457b-8a06-c4b2b0c9eb94	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f08272e6-9979-4739-a032-a75038fb84e4	f
f36c6fd0-b46c-43d5-9413-0e462e191822	cf6c9831-fc67-4090-aa7e-7e136e323944	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b557a3e8-9893-4622-aff7-d6e0193e6466	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ab221cbb-5b05-4cbd-8dd2-f6b6fdbd8657	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2a74ce54-806f-4185-b295-d0149f267339	f
f36c6fd0-b46c-43d5-9413-0e462e191822	36a70ed3-51ac-4a09-bb8d-5d478c80d359	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a0dfc118-a289-4775-84a2-15dbea1c4712	f
f36c6fd0-b46c-43d5-9413-0e462e191822	45d69681-a209-450c-9cb8-39594ab9cf1a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fa0ec7f2-3172-4955-bb58-c2025947eef4	f
f36c6fd0-b46c-43d5-9413-0e462e191822	175fa0e8-33d8-4662-ae76-f77f9cbcd4dd	f
f36c6fd0-b46c-43d5-9413-0e462e191822	06f77d3c-cc1b-4d16-9201-2a1ec974551b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ae3acdee-5010-4564-86cf-3b4c709a7a38	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2974c445-8458-4bff-8507-7381e41715ff	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b004642c-5b16-40ad-a114-f00fe31047b2	f
f36c6fd0-b46c-43d5-9413-0e462e191822	589aa2ed-f8c2-4725-8f01-58230fe81b17	f
f36c6fd0-b46c-43d5-9413-0e462e191822	19cf70dd-321c-4098-b74a-bde1baacc323	f
f36c6fd0-b46c-43d5-9413-0e462e191822	03535d38-0879-4cc6-b49f-bbb0b9f900e7	f
f36c6fd0-b46c-43d5-9413-0e462e191822	78cc0320-966b-4327-9715-e3c2269b8d5f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e4203d44-8bd0-456e-bccf-d6c630e54f42	f
f36c6fd0-b46c-43d5-9413-0e462e191822	eddfd122-c10d-419b-bbba-458346a08a59	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5a59fc4f-7d39-40cf-9526-235357c9b394	f
f36c6fd0-b46c-43d5-9413-0e462e191822	df32c342-2d0c-491d-b1cf-376e97a3b76f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	981af595-4071-41ca-b589-5ce7d8fd7b38	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ccdf3be3-abe2-4918-b6dc-ef1b8a4b4001	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e4a141d6-6ca5-498b-b3b9-bd4a0cb8c512	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e3f8798d-6fa0-4ca8-9bae-1fd48024124d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1be09541-39d4-4021-9232-214c00c0bd98	f
f36c6fd0-b46c-43d5-9413-0e462e191822	67c4dccc-5309-4040-acee-355c0fee26e8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	dc086e5b-00f9-4b1b-8862-bbe348973d08	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2bc65b7d-d801-4bd1-9211-81a1db0e26cd	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fd67e6b9-e941-4fea-a380-3c470139d360	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c3c820ae-a077-4acd-99b2-a6896bf2c969	f
f36c6fd0-b46c-43d5-9413-0e462e191822	355464d7-8e40-45b6-9b90-5a4fdfc493fa	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e84b9822-3907-4aec-adad-7afb1a692ea7	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7130819b-fe55-4316-83cd-30d064a58d82	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ca476706-841c-4c50-a54c-c6050378d7d0	f
f36c6fd0-b46c-43d5-9413-0e462e191822	48477b64-55e8-4121-92fe-edeabb65e724	f
f36c6fd0-b46c-43d5-9413-0e462e191822	00ba2755-4a3d-41e5-963e-083defe6302f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	155119b7-f1f3-440c-b7d9-4af504760459	f
f36c6fd0-b46c-43d5-9413-0e462e191822	161fee46-6c21-48d8-8e4f-c0ed60e0c362	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fed4ee2c-9a3f-41ba-a530-f55d120577c6	f
f36c6fd0-b46c-43d5-9413-0e462e191822	798598b0-6434-4a40-a5ec-46d9af627a8e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f8ecadf7-6578-4099-9d85-6a79c2ecb77a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	6843cf3a-b8fe-4b39-8c1f-1ef12c719a16	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d1a45238-861e-4906-93ef-1cb7fa3eda23	f
f36c6fd0-b46c-43d5-9413-0e462e191822	49485b76-b629-4eb9-bafe-ab5023ace8b3	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b1ee5ea8-d931-413f-96e1-eca7f6bd0ca2	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d8315908-07f0-4f92-bf7d-3c1610a891d0	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7ac22702-ee30-4b0e-9ed9-5bf215e13ccc	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e3b7e890-e2d6-4bcb-96c5-3f1a3c6d8dae	f
f36c6fd0-b46c-43d5-9413-0e462e191822	66ea5ae7-686e-4542-ba15-de99ce84f2df	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a23b8937-5e80-482d-9ae9-198363c58ce5	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a809ef25-089c-48ad-ac4f-e5c88996d0ff	f
f36c6fd0-b46c-43d5-9413-0e462e191822	775eb05f-8d17-43ec-aa1b-98a2da388d63	f
f36c6fd0-b46c-43d5-9413-0e462e191822	4d9d97c5-042e-4bfe-b456-3a0566c25ac3	f
f36c6fd0-b46c-43d5-9413-0e462e191822	19dc56e8-1893-4e46-a717-348335c6c3e6	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1d566409-443a-4096-9e16-4ec96ee5cd23	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c535a239-85e4-49aa-a3ff-5b4d928039bb	f
f36c6fd0-b46c-43d5-9413-0e462e191822	69e99b56-e872-47fe-8099-8f1e3073e046	f
f36c6fd0-b46c-43d5-9413-0e462e191822	cec6f7d8-25d4-4fd1-bf1a-45bdba9f8b93	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9b68ba20-c21d-4058-9f18-9b051b05eae8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	cc746370-f8a5-4d20-9098-9bc8453d0864	f
f36c6fd0-b46c-43d5-9413-0e462e191822	17fca5f8-1ca1-41c7-bf3c-d4b8dd6dc159	f
f36c6fd0-b46c-43d5-9413-0e462e191822	bfa73bf6-3da4-4ce3-8de5-837985a8e0f5	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b98b8445-c3b8-4cf0-a9f0-cc810e45972b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9b8f72ac-447f-4964-99f3-29b9582e4073	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f83ff40a-c1f5-408b-bbb4-e1ac2a9c737a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fb8c9076-47db-4c00-bb3c-40b49fa2d987	f
f36c6fd0-b46c-43d5-9413-0e462e191822	92bc7d80-762d-4d8f-8952-d188e1a8e699	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f1253bf1-b808-4297-bc77-a82d422976b8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	3ba2180b-5c15-4180-aea5-2e6b261a5764	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a5a8530d-46c8-4119-8cf8-9bf08aed26f3	f
f36c6fd0-b46c-43d5-9413-0e462e191822	bbb75f72-b0a5-4f31-bef4-6da1c1a8b337	f
f36c6fd0-b46c-43d5-9413-0e462e191822	6d41b446-4120-4a64-8fac-a8e1bc04753c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	cfd86529-151e-46dd-8a73-ccc0edf85b4d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	15d5293a-d7b9-4911-a629-29ca6758f200	f
f36c6fd0-b46c-43d5-9413-0e462e191822	bef4795b-098e-460b-b548-21dc91b5e052	f
f36c6fd0-b46c-43d5-9413-0e462e191822	bfba13ac-edd0-4bae-a3fc-a03713ffbf5c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	dc718b7e-7918-4fb7-a15d-f4a4d8566138	f
f36c6fd0-b46c-43d5-9413-0e462e191822	6151aa22-02ab-4cd1-873c-c6203d60eb95	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a40a45aa-11f5-4a06-9c07-3807495083b5	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ed294b65-4739-49af-9085-543a8de72426	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a7d92a94-bcf6-43c3-bb10-d4589e7b952a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	4874f483-560f-48fa-9344-e0af44aac585	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c4b925e0-a011-430d-91f7-776a5e3ccaf1	f
f36c6fd0-b46c-43d5-9413-0e462e191822	047a5b9c-2e5f-460f-81df-195a2e8844f4	f
f36c6fd0-b46c-43d5-9413-0e462e191822	761aee43-26d5-4b25-9cf6-ac5c345f15ea	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d0cc542a-6dcd-4e8b-8f9d-0320ce424f04	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2e9e0c64-2c71-4ff3-b068-fd1f81549fba	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ef3eb33d-4d95-48b6-bc71-418243a1b895	f
f36c6fd0-b46c-43d5-9413-0e462e191822	91b02d20-12da-4cb9-8d57-3bba7ef16c15	f
f36c6fd0-b46c-43d5-9413-0e462e191822	375a0678-e4a5-458b-8b27-f63ac3036db1	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ed849d83-ef6e-4486-aae6-7e459c2d5825	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1f93aaa4-53aa-4cab-b59e-d0546dabf297	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f590c20b-5cd9-481d-8a3b-cc0de7687e22	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8d0c1740-07db-47ea-96c4-0e13cc23833e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	330fcba9-bcb4-4fe4-a287-bd4fe829dff4	f
f36c6fd0-b46c-43d5-9413-0e462e191822	4808ee1e-c9ab-421d-82da-6b5bbd4780aa	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d42da595-97d7-4f3c-b9b3-12b437b8ea87	f
f36c6fd0-b46c-43d5-9413-0e462e191822	062477c6-4092-4de6-9eb1-497a78b9ab28	f
f36c6fd0-b46c-43d5-9413-0e462e191822	14c4d887-d0ba-474e-83d1-199eae7db1b4	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5dfbd89f-8c18-474b-9539-f36907361f6f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	68fa6700-665b-4a94-ac85-698b71e73084	f
f36c6fd0-b46c-43d5-9413-0e462e191822	75e00d92-a8c4-4f33-a314-3b2c488bdec7	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7cee404a-2d05-42fe-9b46-8aba52ed52a6	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ac5acb79-a9da-440f-ae32-9ae45a7067a6	f
f36c6fd0-b46c-43d5-9413-0e462e191822	27d480ce-a7af-43c6-9f4d-dd591701a471	f
f36c6fd0-b46c-43d5-9413-0e462e191822	40b9a386-7501-4256-a8ac-0fb633309ec0	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c2e16739-e704-4fb5-9694-9c041a2e4773	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f9955ebd-bd00-42ca-97f0-10b6c4814450	f
f36c6fd0-b46c-43d5-9413-0e462e191822	911dec12-7d97-445c-ac5d-9f024a4dee44	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8a1399db-9669-4d43-a669-661f3ba788d5	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0764016a-0d06-414a-b249-645d0f59a187	f
f36c6fd0-b46c-43d5-9413-0e462e191822	4fe14775-5f28-46f2-bec3-8b1e31d62163	f
f36c6fd0-b46c-43d5-9413-0e462e191822	de1be950-da9b-42fd-a1ac-27cbbee8879e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9d2166fc-7317-4bec-9598-13e7b465f83f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2bc9644e-da26-4d12-96af-d0e670172551	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5cdd8acf-0fa3-4c00-aa4e-6b645e9f60a4	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a9ef5350-c2c8-420f-a398-8e115adc33f8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2f19a305-cd61-40d8-b993-8d5095a97b2c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1804592e-b533-464e-ae2b-bd3ff57d872c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8169cee7-062e-4a92-91c4-45559b0b76e5	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a32dc874-3acd-438d-ab1a-ba244dfabc2c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	785fc0c9-734e-4ed4-b0b5-e4c7d6ea97e1	f
f36c6fd0-b46c-43d5-9413-0e462e191822	273e009a-bed0-4995-80c1-3236bd78ef8c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	98c091a3-e5be-45ef-97b2-a6718fa87eb7	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1584385f-11fb-49ca-af35-fa31a08b356c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0cf3f16b-8e24-4a9e-b064-87ea7c2741de	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0da1ed0a-d556-4ee7-918e-f25fa0b07502	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5f701f98-4852-474a-8a41-9e0858f776b9	f
f36c6fd0-b46c-43d5-9413-0e462e191822	91493550-82bc-4b52-9fc8-7c0b708ea150	f
f36c6fd0-b46c-43d5-9413-0e462e191822	54f0f7cf-8566-44e6-811d-b7cce260b1af	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7572cdd4-bfd1-49a5-b605-5d8cbeff0078	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5931107d-8da3-48ab-a1c6-06ec9d141322	f
f36c6fd0-b46c-43d5-9413-0e462e191822	10b797b0-a7f0-4f2d-a4a0-081944cfc5c8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	43b2e26e-6d89-4a56-aa43-b1ab66816ab9	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5a828a51-dfc1-4d30-bc59-8c98d2610a61	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a3b4c5ba-e63c-4daf-863a-3addb3098f33	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7af0e687-3df7-48be-b2fc-987aee850d0c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b4bbb475-7c61-45ba-9478-e68e00b4a47a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	98765c9e-6963-4f34-8a09-6cb1c1eb5205	f
f36c6fd0-b46c-43d5-9413-0e462e191822	107cca17-17c9-4ee9-bcb9-537525d9bf07	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f850dfd4-7f01-4d04-84e5-271530cf4c70	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b6c8884a-26c5-415d-818f-690fa99fd11b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f2733f20-d455-4c83-848d-4c997b38d278	f
f36c6fd0-b46c-43d5-9413-0e462e191822	de92985e-3441-4ced-8f59-b750de1badad	f
f36c6fd0-b46c-43d5-9413-0e462e191822	dc16da7a-3d0c-4c54-926a-5f14bbe5ac41	f
f36c6fd0-b46c-43d5-9413-0e462e191822	3ddb11c6-1c74-4838-ae31-67b2f70ad342	f
f36c6fd0-b46c-43d5-9413-0e462e191822	63be8afc-7c04-47f0-aace-1befbcbaf491	f
f36c6fd0-b46c-43d5-9413-0e462e191822	56b8a484-3458-4243-8983-271114c84fb4	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2b395db3-d4d6-4f39-a3f6-7eff536e78e0	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7f44a8fd-3526-47c3-be59-db4abb3de63d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d23843be-84de-4aba-8e50-7f2fbed3948a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d3295f6b-ab73-480c-b51a-b00c234fc638	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2d1ad2f3-dc40-488e-bf41-88e11bad2dac	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7d47b3f9-22d3-4703-9011-901531865315	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b18798c5-a4ee-47d3-b46d-8e191ffee50d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e64f65a7-8877-4c98-9f6a-c41156f6f424	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1646bc69-d18c-4bde-a1d8-e44910761093	f
f36c6fd0-b46c-43d5-9413-0e462e191822	4c89582f-b9f4-4455-8c54-948a722f9332	f
f36c6fd0-b46c-43d5-9413-0e462e191822	bbcfed99-6b2b-4491-a392-60f6ddbe7c91	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b5842ac9-099a-4315-9425-190ed9f6093e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fefba933-c1de-4f0f-88d0-0cbaaf288c9d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	cab246b5-6b29-4392-9b87-e2402376b074	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ba0f1727-cfb2-4d3e-a042-6b59bdd7fd5b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c25730c8-33b3-4b69-ad36-16e982e6e27e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	495b0250-0c80-4699-a052-9bbba9c4647c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2d0c315b-bfc0-487c-94c4-94016032e8cf	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c60e3f55-f9b2-41f4-abb2-31542a76a00e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	4422a95f-5255-494e-9db8-d3b0557e3de5	f
f36c6fd0-b46c-43d5-9413-0e462e191822	67059fc6-7942-4ef0-b63b-02b8a5cb2280	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b75ca386-6f97-4bc5-898b-fc608cb05cf1	f
f36c6fd0-b46c-43d5-9413-0e462e191822	76ca2fa7-6dcc-4293-9d53-c26e719659c3	f
f36c6fd0-b46c-43d5-9413-0e462e191822	99ad4f51-d0f2-4bb6-a4f9-21dbcdaa96eb	f
f36c6fd0-b46c-43d5-9413-0e462e191822	97eb755d-d91b-4c71-ac1c-88158289bafc	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e4606bcb-8cd4-42af-b2c3-c26057ab5e40	f
f36c6fd0-b46c-43d5-9413-0e462e191822	77dc7cf8-525b-42d6-af90-b483d32bf9fc	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1a39597e-362b-4e88-ad05-651b779da912	f
f36c6fd0-b46c-43d5-9413-0e462e191822	51646898-c510-4b71-a0ae-1156eadb4166	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f1b518d4-eead-4f5f-9b9d-6c73a58c8817	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d9145244-3632-4b26-8476-c6878c3aa070	f
f36c6fd0-b46c-43d5-9413-0e462e191822	23054626-fb1b-4b58-b1e3-e155a3799d1b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	083fe495-a579-41e1-a5c8-c0c0007164e8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5dfdba76-26c8-4bed-82f1-6f7726b02195	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ab22d27f-8bd7-4c00-8115-13b3d8613c6c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	45d729c0-ad88-4ed7-bc8c-ba40ac4ec757	f
f36c6fd0-b46c-43d5-9413-0e462e191822	9398e13c-56e9-428e-abf5-c78c60c531cf	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1dc3e712-31a1-432b-884a-7363a98da186	f
f36c6fd0-b46c-43d5-9413-0e462e191822	abde0849-08db-48ad-8443-7a7256b143be	f
f36c6fd0-b46c-43d5-9413-0e462e191822	10c788f0-1ef9-440b-8d30-83917aa4addc	f
f36c6fd0-b46c-43d5-9413-0e462e191822	da39d33e-351a-456d-8830-40af9d15d7e2	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e2e759d0-9c92-432c-ab24-37054064b45c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b2d3a92b-3b2f-4ba5-8478-6c44a9379989	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b161b13c-e918-42a2-9285-921be51cf44c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8babf7ea-3c54-4957-a280-e79f4cf25550	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d1a50d11-4596-47c1-814c-2c9384bcef9c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	84d89f09-c93e-4824-b81c-81b6cb42655e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	697554b3-091d-4b1d-91aa-fddbe7ea858d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	1909dd60-a1de-4d2d-80c3-302a8e54feab	f
f36c6fd0-b46c-43d5-9413-0e462e191822	bd51fe55-bfc7-4e5a-939f-ee7802a863d3	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ddf13a3a-c2e0-4641-9820-8c76b1d83603	f
f36c6fd0-b46c-43d5-9413-0e462e191822	678707fb-8938-48d9-a151-2c07ebce38bf	f
f36c6fd0-b46c-43d5-9413-0e462e191822	32e91204-c5d1-4487-8024-60b4518c55f5	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d40ef658-1f34-4f29-88bd-b0307faa51e9	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f8b3bca0-efca-4109-a331-d78bab2015fa	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5b0b7eac-60c1-45f5-91b6-9ec5d3d8fb3f	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a943333a-2352-4bb8-89b3-93140cea226e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f9034ea0-6ec4-4862-87ea-74c6190e75ff	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2f99d979-17ef-4ed7-896c-833bc8bcc032	f
f36c6fd0-b46c-43d5-9413-0e462e191822	300fff2d-0cd9-4a6e-9704-e0230695e7d3	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7506e228-a453-4c1d-9d05-b6264a582a02	f
f36c6fd0-b46c-43d5-9413-0e462e191822	90f601de-7e84-47a6-82c9-1b8847ef69a8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ca51ebd0-68cb-4e8a-9bbd-34d9a6acf710	f
f36c6fd0-b46c-43d5-9413-0e462e191822	897aad7f-a9c2-4eb3-9d7f-f276ff93f0d3	f
f36c6fd0-b46c-43d5-9413-0e462e191822	23ecc9dd-b0d6-4086-bdfe-698932f1917d	f
f36c6fd0-b46c-43d5-9413-0e462e191822	065f3e02-955c-4c3c-90ca-5907d87a578c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fdf80c5e-a0dd-4fac-8cbb-88d42547bb93	f
f36c6fd0-b46c-43d5-9413-0e462e191822	218c78c8-9bce-4424-896d-f98089f26e28	f
f36c6fd0-b46c-43d5-9413-0e462e191822	98dcfc05-b8b6-4c80-932e-919c23fb7f11	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e143b4d8-5b4c-4122-9828-4e1f55282e03	f
f36c6fd0-b46c-43d5-9413-0e462e191822	001d65a0-366d-4d67-a8e8-f9b689b02de8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	357d441d-ed62-4087-ab5f-682b4b8933a7	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5e829fa1-9efb-4288-b8da-ad043fd91522	f
f36c6fd0-b46c-43d5-9413-0e462e191822	155ce536-c42d-456f-a67f-aa43dd459f58	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e354dc50-5fd1-4704-a47e-af97a32293e4	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2783cedb-72f9-4483-b43b-1805a593c7c9	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a0473064-d02c-4ec0-9cf3-1c8aea373b23	f
f36c6fd0-b46c-43d5-9413-0e462e191822	945e6080-a69e-4949-9b54-3aa075bd7a4b	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a5811e5e-064a-4718-b67d-f176bd17c617	f
f36c6fd0-b46c-43d5-9413-0e462e191822	41c6596c-6dce-4646-b974-a3a54eef84c7	f
f36c6fd0-b46c-43d5-9413-0e462e191822	24f26bd5-0557-4bdb-a94e-334e2f73d9b0	f
f36c6fd0-b46c-43d5-9413-0e462e191822	bb0efd69-4acb-42c5-a498-346495c587bf	f
f36c6fd0-b46c-43d5-9413-0e462e191822	602e2722-37e9-4c98-be89-3299ef5136a0	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7efe80bb-8a8f-4339-80cb-20f378a8dc25	f
f36c6fd0-b46c-43d5-9413-0e462e191822	3f0fecf0-f9d8-48ee-a4c2-16eb827a14f8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	90ad7e46-76f4-41c2-97a7-6b7dbe40c424	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7fe8d6a5-873b-4224-8f8a-c71833231740	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7b625778-5ea8-4665-a489-5ac0d9011945	f
f36c6fd0-b46c-43d5-9413-0e462e191822	615d233c-d6bc-4cbc-ad50-783c0c81bde3	f
f36c6fd0-b46c-43d5-9413-0e462e191822	38a6d525-c7e5-42b3-ab34-61e257fbd790	f
f36c6fd0-b46c-43d5-9413-0e462e191822	689642bb-fbfb-4eca-b420-2493294bdb39	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f2c4e7ad-b721-4f68-813f-a57cca96bdd8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	6c34ecec-7cb4-4d68-ac7b-d68d24814fd1	f
f36c6fd0-b46c-43d5-9413-0e462e191822	2622d011-48ec-4500-a4f5-68587202015a	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a4df84be-6a73-4c42-b4a6-45e09d92811c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	60aaefe8-5126-4c01-9cb1-ff300a3bccf4	f
f36c6fd0-b46c-43d5-9413-0e462e191822	caafd66b-04e3-44fc-9a88-726a796d37de	f
f36c6fd0-b46c-43d5-9413-0e462e191822	5f8932fa-1e66-40a3-b9bb-12d284cd1e7e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	ca864ce8-3822-47dc-bcd5-0ffbc36bfd06	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b074ef4c-6121-412a-9320-c667d12a9ed2	f
f36c6fd0-b46c-43d5-9413-0e462e191822	84a2216f-f16a-4232-917a-177ae52e71e6	f
f36c6fd0-b46c-43d5-9413-0e462e191822	49b79e5f-199d-4113-b26e-c4f54c9abc0c	f
f36c6fd0-b46c-43d5-9413-0e462e191822	937c89a4-be98-43e4-8c00-f77005a0f954	f
f36c6fd0-b46c-43d5-9413-0e462e191822	45970c92-a1a0-4a3e-aa56-e6a79d5eec07	f
f36c6fd0-b46c-43d5-9413-0e462e191822	46cbbe7a-1dcc-4ed2-ac97-a8171114e3f1	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d3eacc4e-9ad3-424c-aab4-0d402cd271e7	f
f36c6fd0-b46c-43d5-9413-0e462e191822	d145c4d7-c125-4d8c-ba5a-9a27a88005de	f
f36c6fd0-b46c-43d5-9413-0e462e191822	63c987ed-5786-4f72-a2da-fda70991f508	f
f36c6fd0-b46c-43d5-9413-0e462e191822	8ece4421-afba-4d83-bf06-b3e121d12999	f
f36c6fd0-b46c-43d5-9413-0e462e191822	bad9385d-d7d6-4def-8f2a-6c2bef1c3f18	f
f36c6fd0-b46c-43d5-9413-0e462e191822	fb78b3ad-9bdd-44ce-a90a-891513d27cf8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b42fd6d7-9dcf-4339-8b2a-265634106299	f
f36c6fd0-b46c-43d5-9413-0e462e191822	a773e372-d826-4bd6-90f5-74caad26d3e7	f
f36c6fd0-b46c-43d5-9413-0e462e191822	167ef9a5-4a07-4409-9275-b6b485f144fb	f
f36c6fd0-b46c-43d5-9413-0e462e191822	80c05831-092f-4049-9df1-df566b6a2698	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7806c004-bae3-4266-9da3-964c853e392e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	f89b9061-6295-4165-a3d4-86f595a4d777	f
f36c6fd0-b46c-43d5-9413-0e462e191822	18f53fb1-33c1-46b2-a95d-88a14d70eee4	f
f36c6fd0-b46c-43d5-9413-0e462e191822	4997c643-1fd3-4461-8517-878de6673f68	f
f36c6fd0-b46c-43d5-9413-0e462e191822	0fcfc4a0-f0cf-4810-bc50-84602714dd98	f
f36c6fd0-b46c-43d5-9413-0e462e191822	6c0d9c3f-922d-4af9-85f2-09ae706888bf	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b60ba2a4-a12b-4a1a-9422-963a930457c5	f
f36c6fd0-b46c-43d5-9413-0e462e191822	3c10842a-5b37-42a1-a02d-9f823662aca5	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c05b536f-c72a-4d03-95c5-43dec6ead9e8	f
f36c6fd0-b46c-43d5-9413-0e462e191822	68a71efd-07ac-4725-9cd6-eb5af6cf6f87	f
f36c6fd0-b46c-43d5-9413-0e462e191822	e81aa034-ad18-4cc1-8410-19bbc3bd87bc	f
f36c6fd0-b46c-43d5-9413-0e462e191822	43cdff75-7926-4a08-bf2f-aa54a74202b2	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b4c1be36-c580-496e-a011-541e0a91b2be	f
f36c6fd0-b46c-43d5-9413-0e462e191822	b0f63457-d304-4e49-9267-de55fc5cfec0	f
f36c6fd0-b46c-43d5-9413-0e462e191822	c61b6a0d-0a10-4beb-bf70-9602297ab94e	f
f36c6fd0-b46c-43d5-9413-0e462e191822	7c3541d4-1c94-4c6d-9683-2dd57b52b617	f
f36c6fd0-b46c-43d5-9413-0e462e191822	09c38d33-f251-4aec-b894-c4d3078704d0	f
58d58f34-c0be-4479-b8d6-eedb5a5a3210	6c33f453-f9bb-4503-a667-1c2f5a77c0b7	t
d7f84708-6ae4-42ea-93d3-825c725f7d2c	7bdbe596-0ed5-43be-9456-595f9312d706	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	1bbe4253-bf7c-4f64-9a0a-a2d0bb505b15	f
d7f84708-6ae4-42ea-93d3-825c725f7d2c	84d58747-dbf8-4ee4-9eab-46c6df76e847	f
\.


--
-- TOC entry 4164 (class 0 OID 16465)
-- Dependencies: 232
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
6178d2a9-a580-4906-bb8b-31990018282c	1125c0d3-1cfe-46ec-9877-9a98ec47ac94
c9469db6-d939-496e-bf11-02e2750f8a0c	9c3eccc4-a7b2-42eb-85ba-008578c60817
ebe8188b-0c77-4993-995d-f7a99a578eb1	788e7dc2-30ff-428e-bbe4-ff70a49e35ab
2f483427-27c2-4f28-99e2-a0f1f110d89a	081a0cb3-4e78-4950-bf11-ec32b54e6560
\.


--
-- TOC entry 4165 (class 0 OID 16468)
-- Dependencies: 233
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
058b2437-5d47-43ea-8a0e-b9e2acf64051	Trusted Hosts	c59dea27-0f0a-4d7e-9d51-e1017680e812	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c59dea27-0f0a-4d7e-9d51-e1017680e812	anonymous
7472fbf5-a0cd-4eb7-84a6-105c52682092	Consent Required	c59dea27-0f0a-4d7e-9d51-e1017680e812	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c59dea27-0f0a-4d7e-9d51-e1017680e812	anonymous
d7c85ff3-9355-4728-909a-443b4ee89eff	Full Scope Disabled	c59dea27-0f0a-4d7e-9d51-e1017680e812	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c59dea27-0f0a-4d7e-9d51-e1017680e812	anonymous
8ef949dc-d32e-4f98-a769-810f4859abbc	Max Clients Limit	c59dea27-0f0a-4d7e-9d51-e1017680e812	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c59dea27-0f0a-4d7e-9d51-e1017680e812	anonymous
b73e3245-c1a5-470c-b355-70ed0f7e777e	Allowed Protocol Mapper Types	c59dea27-0f0a-4d7e-9d51-e1017680e812	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c59dea27-0f0a-4d7e-9d51-e1017680e812	anonymous
1bf8bcb8-1974-47e7-9834-01533ee456bd	Allowed Client Scopes	c59dea27-0f0a-4d7e-9d51-e1017680e812	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c59dea27-0f0a-4d7e-9d51-e1017680e812	anonymous
5a25e78e-a979-4a13-abf3-6e7f017d7491	Allowed Protocol Mapper Types	c59dea27-0f0a-4d7e-9d51-e1017680e812	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c59dea27-0f0a-4d7e-9d51-e1017680e812	authenticated
b9a1711a-81b7-40a1-a5b6-59ac6d5ed7de	Allowed Client Scopes	c59dea27-0f0a-4d7e-9d51-e1017680e812	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c59dea27-0f0a-4d7e-9d51-e1017680e812	authenticated
7b1ce640-9fcc-44dc-ab23-698ba01d282e	rsa-generated	c59dea27-0f0a-4d7e-9d51-e1017680e812	rsa-generated	org.keycloak.keys.KeyProvider	c59dea27-0f0a-4d7e-9d51-e1017680e812	\N
e63ce040-6ab9-4b45-b6ce-785147e3efe8	rsa-enc-generated	c59dea27-0f0a-4d7e-9d51-e1017680e812	rsa-enc-generated	org.keycloak.keys.KeyProvider	c59dea27-0f0a-4d7e-9d51-e1017680e812	\N
3a638f32-45ee-4a6e-b058-a219177a660f	hmac-generated-hs512	c59dea27-0f0a-4d7e-9d51-e1017680e812	hmac-generated	org.keycloak.keys.KeyProvider	c59dea27-0f0a-4d7e-9d51-e1017680e812	\N
e37ac481-542c-4cec-b4b1-aa8517c4fe1e	aes-generated	c59dea27-0f0a-4d7e-9d51-e1017680e812	aes-generated	org.keycloak.keys.KeyProvider	c59dea27-0f0a-4d7e-9d51-e1017680e812	\N
163f7bfe-7288-412d-a160-2e87895550aa	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	c59dea27-0f0a-4d7e-9d51-e1017680e812	\N
c7fc895c-4dfd-475b-aa22-a0a993b38ed4	Full Scope Disabled	041f8a3b-b936-410d-b423-b51f4cd23d7f	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	041f8a3b-b936-410d-b423-b51f4cd23d7f	anonymous
e100d238-9e20-489a-97c1-19a291c74878	Trusted Hosts	041f8a3b-b936-410d-b423-b51f4cd23d7f	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	041f8a3b-b936-410d-b423-b51f4cd23d7f	anonymous
448051c0-8339-4788-bd72-2639ee35266e	Allowed Protocol Mapper Types	041f8a3b-b936-410d-b423-b51f4cd23d7f	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	041f8a3b-b936-410d-b423-b51f4cd23d7f	anonymous
0497e71e-3045-4247-b09f-06a2767f1516	Max Clients Limit	041f8a3b-b936-410d-b423-b51f4cd23d7f	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	041f8a3b-b936-410d-b423-b51f4cd23d7f	anonymous
29dbcea4-d738-4f44-becf-28d99bca1972	Allowed Client Scopes	041f8a3b-b936-410d-b423-b51f4cd23d7f	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	041f8a3b-b936-410d-b423-b51f4cd23d7f	anonymous
457ca3e0-37f0-4d32-ba1d-59662c10cbf8	Consent Required	041f8a3b-b936-410d-b423-b51f4cd23d7f	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	041f8a3b-b936-410d-b423-b51f4cd23d7f	anonymous
84eb8867-2cac-4f85-838e-ffd83e1a91bb	Allowed Client Scopes	041f8a3b-b936-410d-b423-b51f4cd23d7f	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	041f8a3b-b936-410d-b423-b51f4cd23d7f	authenticated
fb75cd90-644c-42ac-92b9-7c3c843f4324	Allowed Protocol Mapper Types	041f8a3b-b936-410d-b423-b51f4cd23d7f	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	041f8a3b-b936-410d-b423-b51f4cd23d7f	authenticated
4a5426a3-fd2f-4246-8022-4189eef5aa3f	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	041f8a3b-b936-410d-b423-b51f4cd23d7f	\N
8b4fe4e7-998e-4966-8056-7cd152b60b95	rsa-enc-generated	041f8a3b-b936-410d-b423-b51f4cd23d7f	rsa-enc-generated	org.keycloak.keys.KeyProvider	041f8a3b-b936-410d-b423-b51f4cd23d7f	\N
78753ebc-47d8-4c89-9d98-9cf6f1f326e4	hmac-generated-hs512	041f8a3b-b936-410d-b423-b51f4cd23d7f	hmac-generated	org.keycloak.keys.KeyProvider	041f8a3b-b936-410d-b423-b51f4cd23d7f	\N
57753359-c265-4532-8ae3-cb3170eea268	aes-generated	041f8a3b-b936-410d-b423-b51f4cd23d7f	aes-generated	org.keycloak.keys.KeyProvider	041f8a3b-b936-410d-b423-b51f4cd23d7f	\N
ff4ad619-ce47-461d-b4bd-75e192bd1fe8	rsa-generated	041f8a3b-b936-410d-b423-b51f4cd23d7f	rsa-generated	org.keycloak.keys.KeyProvider	041f8a3b-b936-410d-b423-b51f4cd23d7f	\N
\.


--
-- TOC entry 4166 (class 0 OID 16473)
-- Dependencies: 234
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
b5730914-b6c7-4e78-b963-5c724134ca6c	b73e3245-c1a5-470c-b355-70ed0f7e777e	allowed-protocol-mapper-types	oidc-address-mapper
0e08c84a-936f-473a-b054-ad352c5f18b0	b73e3245-c1a5-470c-b355-70ed0f7e777e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
de820791-d25d-47a8-aecd-1c415377c4eb	b73e3245-c1a5-470c-b355-70ed0f7e777e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e6943d97-2e0e-4a57-9085-d571dc8b62eb	b73e3245-c1a5-470c-b355-70ed0f7e777e	allowed-protocol-mapper-types	saml-user-attribute-mapper
3eddd603-ab04-4adf-9dcb-4fda2bb123a7	b73e3245-c1a5-470c-b355-70ed0f7e777e	allowed-protocol-mapper-types	saml-user-property-mapper
6df95c42-773c-4183-b3ec-8afa0953ac9f	b73e3245-c1a5-470c-b355-70ed0f7e777e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
5935f926-9263-4882-8520-e9a4b996b96f	b73e3245-c1a5-470c-b355-70ed0f7e777e	allowed-protocol-mapper-types	saml-role-list-mapper
83ab7bb9-92c6-45cd-9a9a-2dd92f3336ea	b73e3245-c1a5-470c-b355-70ed0f7e777e	allowed-protocol-mapper-types	oidc-full-name-mapper
3ce65292-9173-405f-a9ce-51857f0bf55e	b9a1711a-81b7-40a1-a5b6-59ac6d5ed7de	allow-default-scopes	true
d5d955ff-0862-4aab-9228-e8f3f9075703	058b2437-5d47-43ea-8a0e-b9e2acf64051	host-sending-registration-request-must-match	true
28fa3e09-cf15-43f6-893d-8cf4fce0abce	058b2437-5d47-43ea-8a0e-b9e2acf64051	client-uris-must-match	true
0043562a-66e7-4f67-ab37-087a3c21947b	5a25e78e-a979-4a13-abf3-6e7f017d7491	allowed-protocol-mapper-types	oidc-full-name-mapper
01420b4f-a59d-414f-808a-0d6544a54734	5a25e78e-a979-4a13-abf3-6e7f017d7491	allowed-protocol-mapper-types	oidc-address-mapper
41c345d4-76c8-448c-b3c1-30f839c20083	5a25e78e-a979-4a13-abf3-6e7f017d7491	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
5187a89d-fb0b-4426-9bfb-6224605a1e58	5a25e78e-a979-4a13-abf3-6e7f017d7491	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
73db2e5b-5b0d-4eaf-8717-44354909219d	5a25e78e-a979-4a13-abf3-6e7f017d7491	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a14fb5d6-f83d-4ec9-aa4c-2113a0114288	5a25e78e-a979-4a13-abf3-6e7f017d7491	allowed-protocol-mapper-types	saml-role-list-mapper
fcb98fb8-f415-491c-9eb0-8723cc6df5ed	5a25e78e-a979-4a13-abf3-6e7f017d7491	allowed-protocol-mapper-types	saml-user-attribute-mapper
2bf98bfa-ed7a-4966-9975-2f56c7008261	5a25e78e-a979-4a13-abf3-6e7f017d7491	allowed-protocol-mapper-types	saml-user-property-mapper
6890ba8f-f6ec-4554-a48d-81169182f733	8ef949dc-d32e-4f98-a769-810f4859abbc	max-clients	200
9cb952b0-7450-45e3-85f9-fa7b40ec31c7	1bf8bcb8-1974-47e7-9834-01533ee456bd	allow-default-scopes	true
8b3b7720-67d0-48c6-a958-f2dbb763e124	163f7bfe-7288-412d-a160-2e87895550aa	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
d7ecafe6-2c15-4f87-8e2f-93e2ac5ae241	7b1ce640-9fcc-44dc-ab23-698ba01d282e	privateKey	MIIEowIBAAKCAQEAi6Vm+mmxSNcqDeM6Yt7FsRiF2YZrMyns/vg18k6G0cUBnuodtBOM7HdC6bckmNQPnp9nMEOqepaTn6D5OrxLkrdmf14pbLyJw/zhykEddQfGO6R+Zj1fLIxTF/DpHkygZz8kTX5WHjuvJEZe/5kRBHFCWV/ZOswSenIDTUOhVjJqviF8x0/2isRT1rzI0t3Q9llviEx7snPgxVRKN9UTfmYWVe7KLkiEkswyXmXU+n0Hj0paap8MctpoOYrzdfFhNR6zGOcjvm25TyjpikY1lonJdng+Jl1oO6+6Fqri0wqiK9Ug4DQiAo3YabPYcydqq2a7nfwxJ/mEzt23rNcKCwIDAQABAoIBAAHrezf0HgjXVG+ucQ4M7ADcSnLMI0snx2dV+D/ljnrxz2zk4RWpsyVJGnVmHC2xtKlEncGPHJfk3BC0wNhq4EsbFGCp5b3l9arpHh2OuZ3zRmlpgIddTqKpJzdMC5hsC0SAHLqoAv0Vavn/sayn6RD7kaLy62Sgi5x9VshIJr6tm5BciDO9GwGwcdWdOKx8TMAHRxZnUKuIGu3HHCVwA8T5hmxIsk2JHmQ6agPl+gTFe43MaKqDWhCRrzJOQgvCteAY9OJhZxhQxmG7T9/iLuis5W46LUEjfSiIIWqEp346DtzHhtNHYdDG4RQTJwa11A/jTofUc77iX0vF43PPpmkCgYEAw8KquDsoOGjqhC7yg4vy3tmWqcA34X9P1hBRlwTWg2l3Elpz2Ca4bSsAvbvtNt1UXCxjv3D3p+HZDFZXbzKWg6PtE+KYcKmhIm0dIqQtr58DRHYglz+zLNKpqm1M7TWkoJYu5U0tqdiFv4Xlp8HIXZbLmekWAznvyzDRN7nOru0CgYEAtp4+EOa0dXQetKWAULm2mV70dlDqh8ZiIpttjdKhBpEDpNp8xIDEG5Gd7QQ2uS1+88Jg7tC7+FX6UoOa1vB1ZJU4KXywlr+Y9sZJ1DKCj/OaYOHEntsWr1QzQKGs8au7gOuhOw+y6KJOCLUkiWFJzl5f6fqD/dEF+uz79M/FhdcCgYAIZYIjEs5/1OgyMT1PrSIGsviGYWtELczD1sFZI+j7i/uCewS7AbYpYI3QlY3wK4Ahz/mbTYIh3ksL/2wSpe3UyaQylSaKtovlyR5VzQr0nHJsblCpjB7oTkTevX9uMT3VcXujdDMANPxPobOfBW3NrdkfyeKa0tJZOcfPhxW5ZQKBgDvEdJnBd+RM+dOzqthAv8NYcXfbqbaANhQPfH6DJhJpGaE1pMoHPqerM92jmGlou3j58BGZHTv8n62rxtx73F/r+nKRjZX45Q42/WjGkzabyrXUji5TlAwT6aZIg7qgswBRnfYfgDVlEVcGOgwAXFB/ULLaO6Kxa1yhfSC1c3cHAoGBAINKQcuF27BOlyK0Uxqigrc6Ts78gPzDlei9Lh5RC/YPy9h62UFg9Gd9zlE4kutXFimOCgiSy8O8ah5Q/40wBEHKa7CXmEcB9bztnoOCWMY5/I+KN/lufCYlKJDprYFTOk62CDI2onfYvJ5IU12UbrKIJJqSWSd0hGtNVr3ETR6V
d6ef195c-e0e2-429c-bd54-3b4a3c3d1a17	7b1ce640-9fcc-44dc-ab23-698ba01d282e	certificate	MIICmzCCAYMCBgGXv49eGjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNjMwMDYzNzEzWhcNMzUwNjMwMDYzODUzWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCLpWb6abFI1yoN4zpi3sWxGIXZhmszKez++DXyTobRxQGe6h20E4zsd0LptySY1A+en2cwQ6p6lpOfoPk6vEuSt2Z/XilsvInD/OHKQR11B8Y7pH5mPV8sjFMX8OkeTKBnPyRNflYeO68kRl7/mREEcUJZX9k6zBJ6cgNNQ6FWMmq+IXzHT/aKxFPWvMjS3dD2WW+ITHuyc+DFVEo31RN+ZhZV7souSISSzDJeZdT6fQePSlpqnwxy2mg5ivN18WE1HrMY5yO+bblPKOmKRjWWicl2eD4mXWg7r7oWquLTCqIr1SDgNCICjdhps9hzJ2qrZrud/DEn+YTO3bes1woLAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACea/8yBhj861kJFbhMY14lQ/EmnNsXhmNzAexObn5yBTgC8idRRK88ERv1ih8aFLqnNe3TSw67ywvW1jzSfM0ZvqRu5L/U3qrOwjY5y4uvH/RUm4G/kEjvFhFD2EiY4Tu8dE3pwWAmJH/S8d/3OkL7GCwRLukqGwXFe42XiiyslKRsVhJk1ovZjSlXLr12+cnVM8Dli0PXpV2p+zO0V5fUqB6wrw/GsbWwybvne63sIkrElVCp12Iiu2iR6iGE4MfYZUym4m4+gVRCrSzSjLgaxxephOeufGNNijDSgKPRkPy6hhOyEZe+biJvKieHmbI+mUjT9qrgah2RhSFm5Jxc=
e0fd80e1-4d5e-4822-8729-34918ef93f80	7b1ce640-9fcc-44dc-ab23-698ba01d282e	priority	100
9ac65e70-154e-48bc-8cdf-9013689f9a52	7b1ce640-9fcc-44dc-ab23-698ba01d282e	keyUse	SIG
2f3205b4-2228-4e63-b8e5-375845e264e1	e63ce040-6ab9-4b45-b6ce-785147e3efe8	certificate	MIICmzCCAYMCBgGXv49emTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNjMwMDYzNzEzWhcNMzUwNjMwMDYzODUzWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDJRGJFYT/TFtiz6aYDvbNTbstWBjxSzmbPycTgt3+Sl1TX3gAhMzwiFMkjAayOZQxUctpv5NEqEgSRtyjJJdPhjtd4j5/GlWHyGuCfuaDqit0d90MvYzJ4HxlPrxjrjssbqoFReJg7ppT7qwb6WdzpyI44ktiwm2HlSuwrRjMCJyzwPIr/gH6zhWjDmpk09v8k/DQm8PW5gp8k1t5RUtTQ8VeOuu9fkorQNXj+pwY16YNwLy3cDQyKlGpfs3KZ2ys1n1A9g0Z1fYyWu+Aqvf/ZEcTrE19sb56UkmReUOZrSugR7vZnxLdbQlrbxeNwXU/887gyb35DldZ+319toSTRAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAL462rhWJ63SZ1VYGvV68m5APcCSiTUxye2aQLz3CZJLfbqc5JnU7r4BqDymSU28vARlb4uwIo+VN9CzzZRNhl7XACBVyxlzH+IY9YDSQBpTP87S2YHhKKmb7VvqXeZu5q0Ak15BkHWg7Cb4z1v1RBrzYAanyhBS89f9FBML/PJqCO5i0ySSzYeBRJvjDPiD2A2EewQ9g4z7vAenxhaUUZXE5+sCJoFAD6bv5u1F5PCNXw9Ob4Am0f6F/tH1UQthdHmhdgfNB6O49+go8CWceDJk3VTggE01nTQXPl3K/08BcU66ocq4zqrh6e8+IF4ANPZo6YCUBG0XZ0Lm/SAzrk0=
50fc076e-b28a-4c63-98b4-c780beed9092	e63ce040-6ab9-4b45-b6ce-785147e3efe8	priority	100
ebdc2ae9-1106-47e2-a781-8ceffec60aa6	e63ce040-6ab9-4b45-b6ce-785147e3efe8	privateKey	MIIEowIBAAKCAQEAyURiRWE/0xbYs+mmA72zU27LVgY8Us5mz8nE4Ld/kpdU194AITM8IhTJIwGsjmUMVHLab+TRKhIEkbcoySXT4Y7XeI+fxpVh8hrgn7mg6ordHfdDL2MyeB8ZT68Y647LG6qBUXiYO6aU+6sG+lnc6ciOOJLYsJth5UrsK0YzAics8DyK/4B+s4Vow5qZNPb/JPw0JvD1uYKfJNbeUVLU0PFXjrrvX5KK0DV4/qcGNemDcC8t3A0MipRqX7NymdsrNZ9QPYNGdX2MlrvgKr3/2RHE6xNfbG+elJJkXlDma0roEe72Z8S3W0Ja28XjcF1P/PO4Mm9+Q5XWft9fbaEk0QIDAQABAoIBAAwU3MlJYylqr6ttFRgYZRFXD0Gksi5OUYGbnQPYQAIur1sd6mgTyUJKeSBu00rg6fKPymj5FU0vM7MDiaE5chSSHIESLgcfpHeCAYXVAMHTgB5yX0gS7k6jn0NXQWmycqLAg26+jHTYNQ0+YPbaOhaWgWMH/ZXsXd4Dt1WJqzovwI/Cbnhu7XSmBh9uy739KMy+WLjYu3DqKSN0TWdknsMNNPJ3Y6owog1NBKO8iYfaLpQ5GW9ffS6UicnmFzqRUclZZR4xghz8LagcsSJTqDWblchiveAXnes+Evs/o8UZICdP+V2shuKQqNHrd9sESUJUwtcsqwXYUgalp52ZdiECgYEA63QAtFJngEu5PC31J5sbTE0JRmOAHl09xmWMnMCMkAv0bYmpLbR+BMiwR5G2/WGPdFhOr6CWu6f8Oy+Lpv4W6FK59r9vTrilBuP7KCqYy+54B017ZUevD0EGSgH7fvB8mSZjHxmkvilgU19NN875fzFEbXvrjJOLTA92stVJlQ0CgYEA2tSrXCaxy0j8ie+Es0Y+sIHYzcy3fhouEUGaoaJXw2yer/7M5mWxNI+3CxzzVftI2fd9u8LisVHjhAQLFuvFiinhJ4rr/hUyaZFIQFQrSOsBHg6HCnzlIW0OfwI7LaVvnBGr0CuDPVIwawLlGQ2If83ECgiroE/nq23/f3uCZdUCgYB3CFJC11YT+jRPRDyoJTYLwPZra2od762HW1dW99EYEbMknW+194WuDXdw9y23s1a+ztYY2+rYO/i8QzEq31HdadUx9V3kQlzLuv4CNGbC0nBD4Nv9O9w4rfrr90yZxCJ5mnqKAoDS0kAsZgW3rR9dOh8J6pgOnZjSfw7XIhTtEQKBgQDYYvWz4NtsvhZiu0MIF00EMtHU5zsG6hJlo+6pKCQKrYzZUWcB6Mrqw7Xnuk/w1NN8HZvqH9MULnqA35Krrqaecb0f4eJsVD+OXkgIvHI035UySIFGYKween2cH/Outml/9YVlCrHy4CPanXk3Zcd1QV454cr8cicOwG2mfNY7pQKBgCtRMuay+ATvhKRSTVfnLLpiuPWGixWUUzQnOhQYTKfbYA0s3izBKk9Oo7JPbxyynlAJ6NLMdqqvFX6qLIqJHd8Amsbo9ploiXuT/DMjh8Niz/BGdwIN9jkuTLO4VacpgrfQ+e3jExJBdOj8HFapRThsBoVD6ELL7XbPwf5Foxhx
587a3874-587d-4f8a-b9f7-52674989c8a7	e63ce040-6ab9-4b45-b6ce-785147e3efe8	algorithm	RSA-OAEP
c07e82cc-5423-4135-b8d0-b6d87c295e50	e63ce040-6ab9-4b45-b6ce-785147e3efe8	keyUse	ENC
e8cc8a71-d8bb-4e5f-a573-35f7861456a4	3a638f32-45ee-4a6e-b058-a219177a660f	priority	100
3cb04032-6003-4680-85de-6d54a02ed5db	3a638f32-45ee-4a6e-b058-a219177a660f	kid	c894bf41-ac19-4d50-a74f-473ef8136a13
f3eea0dd-8fa8-48d1-992b-f3ca448fc50f	3a638f32-45ee-4a6e-b058-a219177a660f	secret	Tg5CbWXCzE5ZNGDxVT2_R1PFsT9Y2vshapg45i4rqDeCbKf3HEW1SZF-1exz5hp4ineYdyuQp70SBBqC-t7yNnCrswFiYaJe2h4pRjA_Xi1NiSIJrYFPuSegcx3ew-2GKn9doq1xyM4uYMFfOv8XWUkGmGxkIMgrBgrygpA2AYY
13950e4f-a399-4e79-8963-67be90af6259	3a638f32-45ee-4a6e-b058-a219177a660f	algorithm	HS512
f1fd098d-a805-4c0b-b9ad-d138b4850979	e37ac481-542c-4cec-b4b1-aa8517c4fe1e	secret	VPwCfv9su0bMqAuD8P_Zmg
46f3b90b-5535-41d5-9198-3e238442bd5e	e37ac481-542c-4cec-b4b1-aa8517c4fe1e	priority	100
5ee62913-b137-49f9-9a59-e959914fd7e0	e37ac481-542c-4cec-b4b1-aa8517c4fe1e	kid	1de5f263-ea4a-4d31-afe4-6de2f9a66e39
51b90335-bacc-41c4-9370-c3b7f03dcf4e	29dbcea4-d738-4f44-becf-28d99bca1972	allow-default-scopes	true
2f4cc584-3f5a-41dd-92f6-6eabfbee64b5	e100d238-9e20-489a-97c1-19a291c74878	host-sending-registration-request-must-match	true
3cbb0ad5-ee0e-421a-b23a-cf129f31ff09	e100d238-9e20-489a-97c1-19a291c74878	client-uris-must-match	true
2afd5b0e-d688-4f33-8bab-13be9ba01382	448051c0-8339-4788-bd72-2639ee35266e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
c61ac5e1-f60e-4d4b-9b64-ceceabfd1182	448051c0-8339-4788-bd72-2639ee35266e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
8a03f19e-ee0a-4b71-8c78-1b91abb8264e	448051c0-8339-4788-bd72-2639ee35266e	allowed-protocol-mapper-types	saml-role-list-mapper
053356d5-a89e-42ea-8e06-7c4f20b2fe4e	448051c0-8339-4788-bd72-2639ee35266e	allowed-protocol-mapper-types	oidc-address-mapper
ed74c4e0-111c-4092-ae48-ceed725aef7b	448051c0-8339-4788-bd72-2639ee35266e	allowed-protocol-mapper-types	saml-user-property-mapper
53074f70-752c-4bc6-9999-cea4d155a8c6	448051c0-8339-4788-bd72-2639ee35266e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c44db258-2fa8-4b84-a3dd-c9e2bd54e518	448051c0-8339-4788-bd72-2639ee35266e	allowed-protocol-mapper-types	saml-user-attribute-mapper
5a3ade92-77ed-40ed-8286-5fc783b3a884	448051c0-8339-4788-bd72-2639ee35266e	allowed-protocol-mapper-types	oidc-full-name-mapper
9308fa9e-0f00-4af7-a39a-f1168ac3a79c	84eb8867-2cac-4f85-838e-ffd83e1a91bb	allow-default-scopes	true
ed7f2b75-5be6-46f4-8720-600977b26917	fb75cd90-644c-42ac-92b9-7c3c843f4324	allowed-protocol-mapper-types	saml-role-list-mapper
718bddbf-6a31-48d9-9c06-5b2e730097ba	fb75cd90-644c-42ac-92b9-7c3c843f4324	allowed-protocol-mapper-types	saml-user-attribute-mapper
dba5defc-b2b8-4fb1-b1b0-21004476c54d	fb75cd90-644c-42ac-92b9-7c3c843f4324	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
0dff8cb7-6377-4c6a-970d-2a5b5c2e72e6	fb75cd90-644c-42ac-92b9-7c3c843f4324	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4cf42d33-153a-4575-85cc-e4ffd6168160	fb75cd90-644c-42ac-92b9-7c3c843f4324	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b43c331b-af83-4bfe-878f-30743ae078b9	fb75cd90-644c-42ac-92b9-7c3c843f4324	allowed-protocol-mapper-types	oidc-address-mapper
01390168-2509-4f91-8e25-06ef9166e44d	fb75cd90-644c-42ac-92b9-7c3c843f4324	allowed-protocol-mapper-types	saml-user-property-mapper
9d6f9dbb-58b7-4494-a11f-9ffc627625f1	fb75cd90-644c-42ac-92b9-7c3c843f4324	allowed-protocol-mapper-types	oidc-full-name-mapper
d4de36cc-ce88-4b7c-965c-2906da6d4f7c	0497e71e-3045-4247-b09f-06a2767f1516	max-clients	200
adf1025c-40db-43fc-8e66-d65c0449a066	8b4fe4e7-998e-4966-8056-7cd152b60b95	algorithm	RSA-OAEP
fcf2ce3f-f1f0-4a4c-a34a-2f47e7d92684	8b4fe4e7-998e-4966-8056-7cd152b60b95	keyUse	ENC
e764a351-221d-4e74-b96d-c4129a3c99e8	8b4fe4e7-998e-4966-8056-7cd152b60b95	privateKey	MIIEoAIBAAKCAQEAx4WRG/lZzvBiHS8MVmBVM+IJ0GhBGKxetIJHcxUBwegy+Qk8ALG1352n1V2z+/tUMb1tIaeLT/NoPiNXYPGydf5u2oY10/i+w6fvACGJxrbS1ZkbWg3RldVllTMaJRy8QVWs5v7Nr/Fe3xgwVp60WK2cHJwbl6GfbMijEN7L8FX60puIEskLYDaVTdOjxeTYLiD4gHZkTx5QY2IZkIGBoS6l2QlGgVPbVfk2nQDW7wqX9A2+DmSES91nG3fooTPJb65R4O19xv5Fx/2GqUdhcyiahP4PCyJa6/GgJczJckXUxdOTRyx8vHJSN+QQMWdJXD0bkLSToMqVujmcAoBBuQIDAQABAoH/ZvloiyeGUmd+O9GsbGgLkVt39TfZYQKVXlRey+ZrochVhnJdpX4Sf/a+SEC0Q7jTG1jImjX+kKTviCJ1VnNnx74pOF9MKLqYuiJSF583nHd/GP6MP04ifVJFu1tEgyLxhkbRleasAcJxVHMHf60pJxtzFtD67KddwKdMgch7OO49AZXQZwaPLXQELwyHV8FxZad4wjMoJsrdxDrMLJHCn1eU9sHwrR3iyIrSsUwiO9powY2i9TE1r5xDAcUgZSyGcrF2TitdB/CdmgDZzSc5qL72spCkpgLFn8qYtykcFLug8pDP4JvBUEiasSdDJ4e7A6oKKJC5vwLmaDAiE7iRAoGBAPYwzYeuHeAyclqT4icH2kgO9cu0blCjqzDojwvLvSxcR2rDUmIuyV/6+CJp54qYDDN+TgPhRTvIRoOnPPg0VRNTny8fCiZLMtA2b5SgXVcnqQ4tjwBFpwxGl5Rppi7fTly+v+xec0tn37d4oE6DgpXD7kfSQkvnmH6TDIAHlgBpAoGBAM94uzdlOK9EBjcR+ctsWucEGMe6gNqOug0zbuc0MTSvg0r2DkSaHtO1PWvnTPrm4gVO1AmYQwu3hoVBTshimZkNWLHluGNyfPI39D52YOgGSUz++iThwyaqEqex9vzr6jnrFwYztz2XV+kF+IW+w75oUKj6EKh7dhsvuYEwPQzRAoGAbmw3U5sKNWwLFItuDVmdU2K6ZpLYQ/0VJMu6lWzdvc7qDX3sLrOTiSRVNYJQ4z4Ngu8s6NqaphTPY++YDi/S1OdV59nBQKnL8c3owD4pf5T/Y6eVk2aqZXwoMt4sNqvcRwcbqFY42mKN2ooVRQIBiVEnSDmLmOYY5PTpz2cXpbkCgYAdkvos9VLVOP8hzoArDTEQCTd3ERDZFstSomhGsNvqxLIUd2qlQMrwJr+wp/IDOfIyC4CSNZApFWopiJuwWM3IUWy5PyO/mUxSQsOgO8Ooj2zXeukxZLUqx8eM/ANXHlHvG6HWknymXPJ9FwrMFdtVQw1saOkC+0ZkrbLlxXiOYQKBgBH5Z4MtLYkABPyhnbmfhNFUK5jMy+BflVSVrcrnlT7O34PIriyMJPYdU0yUVhXNKLkkQQ0YMnGqXHgH9edONkqQFOttdqSucJeGGG+Zd3zrGz1lDWAOR/s7HNTJzWCl8jpb/owhok0SALt+p8jjnioyWt4wLtA66gichRSiE9Te
c467d85a-b188-4b11-a6b0-e2d090f6fc77	8b4fe4e7-998e-4966-8056-7cd152b60b95	priority	100
e4dfa3c0-17fa-43ba-99ae-47aa6e2406b3	8b4fe4e7-998e-4966-8056-7cd152b60b95	certificate	MIICozCCAYsCBgGXgR07szANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDDApmaGlyLXJlYWxtMB4XDTI1MDYxODAzMzYwNloXDTM1MDYxODAzMzc0NlowFTETMBEGA1UEAwwKZmhpci1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMeFkRv5Wc7wYh0vDFZgVTPiCdBoQRisXrSCR3MVAcHoMvkJPACxtd+dp9Vds/v7VDG9bSGni0/zaD4jV2DxsnX+btqGNdP4vsOn7wAhica20tWZG1oN0ZXVZZUzGiUcvEFVrOb+za/xXt8YMFaetFitnBycG5ehn2zIoxDey/BV+tKbiBLJC2A2lU3To8Xk2C4g+IB2ZE8eUGNiGZCBgaEupdkJRoFT21X5Np0A1u8Kl/QNvg5khEvdZxt36KEzyW+uUeDtfcb+Rcf9hqlHYXMomoT+DwsiWuvxoCXMyXJF1MXTk0csfLxyUjfkEDFnSVw9G5C0k6DKlbo5nAKAQbkCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAczP5oyD3qBYEyBvJDg0/8NHab0ABwexR4wxeW3ydoiL/gvSAK9b1h0OI6ItLQdtVDjOpFx7Tfd2kK5IfEQY6SsQubwsjFcEl8OfkZqlAqojioR954pNJzOUyNxK43oWQViehR87ds7JK81DDvU1j+4NOBICIzZAIFWalqZMSUNhBF+1hkHIFjB/BzyG4N24yE9hJbhg6yd973WOGnHVlUY9tfRsY4l7j8+IFnCt1punxVctG+djNAlz7UDFm0yZomDNjXah0vUK5WPXjFeH9nP/J0dRq4DuXsxju7BBbZveexd6d9I1tHqqtqd+hrITQJYkXXOWQ6lDY/PuyG4PL+A==
f6d71854-3293-4527-affc-e70f88531c29	78753ebc-47d8-4c89-9d98-9cf6f1f326e4	algorithm	HS512
334ba882-5c2c-4e1d-9b5c-a8336483c566	78753ebc-47d8-4c89-9d98-9cf6f1f326e4	secret	XZkouRJ-abqjpwexFLUPYnj0N0BirgnIDATzen3wFxoBNgw0jKXcQxHEQ__Ud_PgDAPEpn60t5tSfNKnAJKWK-ZFZwrljq2yCS1gFrrFbc8gkECMJMiZKqzIhaxnIo-qZ1-ks-exLOwZwQnbmIC4GBOz1ViRYiikNt2qe14xc-Q
ad3e3f34-adef-45f6-b77a-04794fa2701a	78753ebc-47d8-4c89-9d98-9cf6f1f326e4	priority	100
1e98a239-b168-48ad-a9fd-384956e08549	78753ebc-47d8-4c89-9d98-9cf6f1f326e4	kid	10388efa-6d61-447b-b93a-517746029ca8
cb7e28dc-5324-43a6-afa9-d0e9e1726525	57753359-c265-4532-8ae3-cb3170eea268	priority	100
077971ff-b527-46df-a58b-70438be534a3	57753359-c265-4532-8ae3-cb3170eea268	secret	WjWDMoewb77E9X4gmwlJRA
44be1f94-28e5-4a18-a180-3b1be60f9ff2	57753359-c265-4532-8ae3-cb3170eea268	kid	95980e02-bff5-4156-a1c1-9adc68cc0e73
04fbb749-af23-4fef-acdf-54de11146bc3	ff4ad619-ce47-461d-b4bd-75e192bd1fe8	keyUse	SIG
4ab75cd3-6d4c-4d7c-894d-575e7d8b6abc	ff4ad619-ce47-461d-b4bd-75e192bd1fe8	privateKey	MIIEpAIBAAKCAQEA4kn7Ahh4YC8574y4Y3x5OBS4rJ9Xy3Hiq77lml/SGy1X78j+7l4Y4MeRHll7QYrWLZyFc8Ll6HppBTP4zxDYmyc9Q52nRh0Xw8yOlU82tbfIuQuHj+ih/NtRJcB9GN3RPRYa8mN14l+EUZIRC4uGkyZx1xbgm8BCV2/TLokVAtG71Smev1wIzl/J4KyTDnqG5eqqv5bM0Ix56+vA4hSKWRiQP40qLGezpi+dIRNlVoSz+ebSJbutGo3sT+dGUgqca4iaH6IKAwZHl8JdFNbHH+uJG+oCm3DOJ6ZTpmhLwweoAw88uk38LhHEkSRTBmBBBF+r6H7yTcKr1P6X9GgWgwIDAQABAoIBABODE4y7tW19xP4d4Sxa6EzopH/mAXj+afArNrsX9hL31vRLHYhKPtTrAF1gk9sz8IHgVDWGIbLpEzMqpxKbvkGqoYK6DlliWtE8SzMesHX80eb60oabJZSbCKU7ss25GristkgeQWTynYM3GBcpwcHgd8J3K4jijBXkA46orVIfwA920p5oiRchFJFjJcIUQowPdFMYBHea4z8Oo1uGUYmns+m8iPt2+FdKrm5DLV+YFCdENuvR7QIT2w5xO6ysfjm/odN1Oalx4LTOgtar4out1dQ7ceMcTJML4/+kJmMti6e+zY8NmZ9yLboA5b8T0skna8gTs63JPMqev8eIC+kCgYEA93ohI2JUJn0rZVps7RrxmL4QI4FvbtjH8CIFkPof4foSDADlQDstcE9Jfohdwq9FolSbWYjSA/L9djtE6yPqrDGLbye6HjSvV9o5NctxqbVig2WD7NJ4l/d+qfrXDd9tI1umIzx7Ty+x4tR12EHOwZhjgdtknz5H2IfvNyq+kdcCgYEA6hUMGi5FvlzigDpV+bQzx64VIZswIVNxPDB3rW4EpXkbvMLqp/ANSYivOfYYF62RcFsehfmylOePJDT3bXDkU20kGe5MtkY6kh2zkmq/48ROVWUpDutYWy8XiIfRTA28uoEntyXil2H06qc5v5UQ+6PgwngJzOZlGYZuz4moozUCgYEAzvKeS4yqehUp+POJKy3g4q3tqQNQQA2gBLsulHHVv47zEH6fNvtFoClteBZo8ajIPlsqHdFAbnUAZ6Jgm5HJaH118Fn0VdYQ2xJtzQJ35kb8PozhqWTH26znixVsSPmRtoOphsXJCAsGYnzwnwtI7rOUYr8ogdH/Gp9x91wTSLkCgYBNlBwmsR88L9yBUtQbpbVjgDZQpPYWlWj54bZILCYuES04KgFLFyvQKxSnyP/DGSsSaaB8Fn0xDG1MOqGmC7wgShOk5G1YG35d3qoc5HQkMHMlqhkpcKYf0kOiZCDha8wYo6Vd9ZhbQ4PAIRvqeqTeQTnEObRFzDXFd+BRt/XD4QKBgQDaABvJgKFnK5GMnaDGAc9AR34W3E7fRDxU2GMJOFWWkHKoTuJMT/BwR3+Y2ogQjaovMSas6rWxNsktjbJBgmbZ19vmOzcabMFmLHPRZ94eoC3SLCoS3X0uxVmUJgs0+U3OYsP1nb7puWB7DaA88wd6WDsbBTKi76PrEuwCPOy3gw==
2990c3ac-041c-4982-b155-bfdedcaf83df	ff4ad619-ce47-461d-b4bd-75e192bd1fe8	certificate	MIICozCCAYsCBgGXgR063zANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDDApmaGlyLXJlYWxtMB4XDTI1MDYxODAzMzYwNVoXDTM1MDYxODAzMzc0NVowFTETMBEGA1UEAwwKZmhpci1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOJJ+wIYeGAvOe+MuGN8eTgUuKyfV8tx4qu+5Zpf0hstV+/I/u5eGODHkR5Ze0GK1i2chXPC5eh6aQUz+M8Q2JsnPUOdp0YdF8PMjpVPNrW3yLkLh4/oofzbUSXAfRjd0T0WGvJjdeJfhFGSEQuLhpMmcdcW4JvAQldv0y6JFQLRu9Upnr9cCM5fyeCskw56huXqqr+WzNCMeevrwOIUilkYkD+NKixns6YvnSETZVaEs/nm0iW7rRqN7E/nRlIKnGuImh+iCgMGR5fCXRTWxx/riRvqAptwziemU6ZoS8MHqAMPPLpN/C4RxJEkUwZgQQRfq+h+8k3Cq9T+l/RoFoMCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEABxlGLCUNENabYo3NXfP9GSQdppjcsEUG867KVbyvRGXbIi2uXGLFC9UhTVDz8s6Dhxtv2HhbPWpCOcSaF3FjhWVo7l5OYH5OWbNo2svqCJVE4xo4BGtJtwx8FRNAQK4tM3WxTHAKzLyGB5r4BxyaB2DyvYOyu34d8htwfXMSMChZXt9lKpZSlIhisCOKu9MFu54QfmOQivxK/9lJ/x3oUEMvqjr+4AqrGocLMZ4dwr882J+88tuKAmUMN8LLcQlx0ZuJ4Bn5qSM33KeqbsoYVjHv+2OmrTPUdaea9U7hPF1IzLeXMWYSkhR6LhBIkFa9xnMc5wNPP3kIxSeVhRyDuw==
9833223d-72a9-4c20-bd9d-2ed80cd1d466	ff4ad619-ce47-461d-b4bd-75e192bd1fe8	priority	100
d8618769-5ef2-400e-bfb1-2bd842248ce3	4a5426a3-fd2f-4246-8022-4189eef5aa3f	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"Admin","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"fhirUser","displayName":"Id of patient in FHIR Server","validations":{},"annotations":{},"permissions":{"view":[],"edit":["admin"]},"selector":{"scopes":["fhirUser"]},"multivalued":false},{"name":"phone","displayName":"Phone number","validations":{},"annotations":{},"required":{"roles":["admin","user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"address","displayName":"Address","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"gender","displayName":"Gender","validations":{},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
\.


--
-- TOC entry 4167 (class 0 OID 16478)
-- Dependencies: 235
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.composite_role (composite, child_role) FROM stdin;
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	3b066307-ccd0-43ed-a977-2a3ff55fb5f5
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	d3d60608-f580-4a78-9604-3c1eaccb873f
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	13463c11-20e4-4c91-8d3c-700276badb44
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	5dbfc010-f481-4a37-8a69-03966d90388f
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	3adbd483-254a-42bf-8d3e-c9ffedacec00
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	27b34137-55f8-4780-a79d-9dc7c0773556
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	7d04ad7a-1dfa-4f45-b4a3-111294caa1cb
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	b2901135-c978-42d7-92d4-07b0d0dac753
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	f00f9554-b908-4265-a509-dd139053f868
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	463835a2-fbf0-48a3-9f39-8bc9fdcc64a8
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	32859ee5-1886-44dd-8e82-72f84b9c3191
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	52902548-d260-4b94-9ede-0c34b6b98aed
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	abbc83fe-5d41-4c9d-bc69-d155cd0e1345
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	1646d598-be46-4c5e-8296-bf8cadf919bf
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	3b38f4d5-0211-4163-9dd0-95dbefa7a31e
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	ee66b328-4d4e-45ea-b78a-2dc91a0ebb64
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	546e33cc-8513-495f-8fe3-f5268bf2c24e
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	e345260f-e8db-43e0-b507-47b3b7ded410
3adbd483-254a-42bf-8d3e-c9ffedacec00	ee66b328-4d4e-45ea-b78a-2dc91a0ebb64
5dbfc010-f481-4a37-8a69-03966d90388f	3b38f4d5-0211-4163-9dd0-95dbefa7a31e
5dbfc010-f481-4a37-8a69-03966d90388f	e345260f-e8db-43e0-b507-47b3b7ded410
9ca49408-842b-4cda-86c2-5e1f7407be08	55185916-80ee-4f01-aa52-41a1a308da70
9ca49408-842b-4cda-86c2-5e1f7407be08	b6898dda-5101-402a-92b0-d6e271175cc0
b6898dda-5101-402a-92b0-d6e271175cc0	90411d85-d3aa-48eb-9d27-809a151db1c3
cc698ccf-f93b-41a6-a470-09dd3dadd438	ee55916b-5b4d-4606-ac4c-8acaaa8a6c5e
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	8c9ba266-8110-4c8b-b896-b268713f264e
9ca49408-842b-4cda-86c2-5e1f7407be08	1125c0d3-1cfe-46ec-9877-9a98ec47ac94
9ca49408-842b-4cda-86c2-5e1f7407be08	f4850653-e54d-4425-aa60-994c544efbaf
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	aae3b073-5366-455d-82d9-706cd266e8a8
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	06678ae0-1c69-4e35-9b6e-38f602143e14
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	833ccee3-920b-4427-8050-e3abfdc57081
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	cfdab536-2b01-4f31-9d82-54d36c343aad
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	2f7dba61-8e17-4c73-93fa-fa553ccdc0be
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	aae745a1-6167-4136-8b1c-31326922d9ea
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	5a06893c-5ea5-489b-a472-af0276903196
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	7136710f-f7d3-40a8-b4f2-d0562dd649a0
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	a1ebd545-e222-4981-b3dd-d3e52c1fb5b3
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	4a02c504-1281-4daf-a7ba-c4382eed32db
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	fccf241c-4530-4ef3-8016-3f063e442b98
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	e9acb963-6a16-4fd8-8044-18138c0cca52
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	37309358-966e-43dc-960e-65fa504518f1
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	0e4dba83-c5e7-49ce-b4ef-edf7b2983060
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	a2aa8695-cce8-4771-b0e3-f7c5125e8672
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	26fe0fa0-bf1f-4ec6-ab4b-1406edcfe7b2
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	5bd0e129-e49b-4fa4-accd-edfa8c9b785e
833ccee3-920b-4427-8050-e3abfdc57081	0e4dba83-c5e7-49ce-b4ef-edf7b2983060
833ccee3-920b-4427-8050-e3abfdc57081	5bd0e129-e49b-4fa4-accd-edfa8c9b785e
cfdab536-2b01-4f31-9d82-54d36c343aad	a2aa8695-cce8-4771-b0e3-f7c5125e8672
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	0865dd03-e0f0-42c5-a4ec-118e44f4216d
1c7bd0c4-40bd-4812-84ca-f8b86c4521eb	dafcdf53-10c6-4eb4-8cbb-9516c3811e00
1c7bd0c4-40bd-4812-84ca-f8b86c4521eb	f03e0200-d658-461a-8bb0-5ea1cff50eb3
1c7bd0c4-40bd-4812-84ca-f8b86c4521eb	9da19dc4-517b-4634-86c0-1ae414f4b3fd
1c7bd0c4-40bd-4812-84ca-f8b86c4521eb	9e800f34-0d0a-4255-b6e2-0d5f8b53b6c5
1c7bd0c4-40bd-4812-84ca-f8b86c4521eb	6e13eb40-c005-4c37-94c4-20810d74e9fb
1c7bd0c4-40bd-4812-84ca-f8b86c4521eb	d3ee8ecd-cad1-4fe6-801d-483ee1bd1ef9
39f0641c-a68d-43f3-bd07-684a5c196c8c	6b7d3836-9d77-4b1d-bb0b-0eb7a73bee05
5810aa60-30fd-438c-83d1-9a3ac263475c	6ac75507-43ac-4470-9b19-071fa99e9881
5810aa60-30fd-438c-83d1-9a3ac263475c	f03e0200-d658-461a-8bb0-5ea1cff50eb3
5810aa60-30fd-438c-83d1-9a3ac263475c	9da19dc4-517b-4634-86c0-1ae414f4b3fd
5810aa60-30fd-438c-83d1-9a3ac263475c	205f27f9-43de-4240-80f1-8b5ffc7b84d5
5810aa60-30fd-438c-83d1-9a3ac263475c	f07630be-9483-4bbc-b04c-da5ca7e383a3
5810aa60-30fd-438c-83d1-9a3ac263475c	b8a37e3f-4f35-4ce0-b70a-eb57885f5317
5810aa60-30fd-438c-83d1-9a3ac263475c	dafcdf53-10c6-4eb4-8cbb-9516c3811e00
5810aa60-30fd-438c-83d1-9a3ac263475c	992c19ba-c6bd-4c1c-97e7-0399e3e19e8b
5810aa60-30fd-438c-83d1-9a3ac263475c	a7164d5c-36cd-47fc-95b3-c86bc0b4b548
5810aa60-30fd-438c-83d1-9a3ac263475c	3eb1fca6-e1d3-44fb-9eb8-7eab265018da
5810aa60-30fd-438c-83d1-9a3ac263475c	2d2317fa-ecd4-4331-a99e-10e360588ae6
5810aa60-30fd-438c-83d1-9a3ac263475c	678d2c95-46f5-489e-ac9a-90936c98c6bc
5810aa60-30fd-438c-83d1-9a3ac263475c	aa077273-c074-4610-9310-2faa1a88f6ca
5810aa60-30fd-438c-83d1-9a3ac263475c	e128118b-7c95-4f35-99f9-2324ead6c2b2
5810aa60-30fd-438c-83d1-9a3ac263475c	e2514ff0-e97f-4d84-96a8-a06d8087b099
5810aa60-30fd-438c-83d1-9a3ac263475c	9e800f34-0d0a-4255-b6e2-0d5f8b53b6c5
5810aa60-30fd-438c-83d1-9a3ac263475c	6e13eb40-c005-4c37-94c4-20810d74e9fb
5810aa60-30fd-438c-83d1-9a3ac263475c	d3ee8ecd-cad1-4fe6-801d-483ee1bd1ef9
6416ea21-2c6f-4671-bfda-3d9aacd408ab	2c10cbcc-65e9-4c23-a51c-07a128ffa777
6e13eb40-c005-4c37-94c4-20810d74e9fb	dafcdf53-10c6-4eb4-8cbb-9516c3811e00
756672dc-1a78-4011-b733-95e6c7d713e6	23efe8e8-c68b-43f4-9b55-b317d0911610
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	dafcdf53-10c6-4eb4-8cbb-9516c3811e00
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	992c19ba-c6bd-4c1c-97e7-0399e3e19e8b
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	f03e0200-d658-461a-8bb0-5ea1cff50eb3
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	8f86e174-8430-462f-a159-616eb34f15d7
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	9da19dc4-517b-4634-86c0-1ae414f4b3fd
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	788e7dc2-30ff-428e-bbe4-ff70a49e35ab
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	756672dc-1a78-4011-b733-95e6c7d713e6
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	7317366a-e3a7-477b-a4db-a46508d297b8
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	9e800f34-0d0a-4255-b6e2-0d5f8b53b6c5
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	6e13eb40-c005-4c37-94c4-20810d74e9fb
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	d3ee8ecd-cad1-4fe6-801d-483ee1bd1ef9
d3ee8ecd-cad1-4fe6-801d-483ee1bd1ef9	f03e0200-d658-461a-8bb0-5ea1cff50eb3
d3ee8ecd-cad1-4fe6-801d-483ee1bd1ef9	2d2317fa-ecd4-4331-a99e-10e360588ae6
\.


--
-- TOC entry 4168 (class 0 OID 16481)
-- Dependencies: 236
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority, version) FROM stdin;
de3705c2-3a39-47a2-a7d5-dbb70f0db898	\N	password	25aa4edb-e990-4caf-bb7d-97277056973a	1750229854277	\N	{"value":"RPt1YTRU3+PHmIQDhuSGPFGhVj3Xf4Rvp4B4iwJq2To=","salt":"1it77OQFM36qAcllwXIyYg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
1e622490-30dd-45d1-9bde-dfe5c28af815	\N	password	1fc17d40-e60c-44c8-89f4-cdc526116154	1750331332754	My password	{"value":"JFeZ0Fa6tUIr/UxwKXONIFE/J1A3Q1PVUy2U+daPsPY=","salt":"++UHsN/Dg2BAcyFHXnFjjw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	0
d128e826-cdce-45a2-97c4-706fb692e271	\N	otp	1fc17d40-e60c-44c8-89f4-cdc526116154	1751272047995	phone	{"value":"OmM2BguyhVhE6kL3QxWQ"}	{"subType":"totp","digits":6,"counter":0,"period":30,"algorithm":"HmacSHA1"}	20	0
36d70481-7102-4c8a-a904-a9dfe56f1528	\N	password	b97d8dc5-d06e-4d1d-9376-65295bf49585	1751268842733	My password	{"value":"J26dPye0LPWvLRTXdKx/NtML79Qcyc5vk/QApmIt8Ow=","salt":"hz50fjexQbgzZTqT5Ok1BA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	2
ce518df4-cab7-4c17-bc98-f04fcce7dc72	\N	webauthn-passwordless	a029c552-b8e3-4b4f-b917-a29075a0ea37	1751613852597	Passkey (Default Label)	{}	{"aaguid":"00000000-0000-0000-0000-000000000000","credentialId":"hxTC5hPhHTXDI/PlJkYDxA==","counter":0,"credentialPublicKey":"pQECAyYgASFYIDfHtT3bp2o8wZWaw5BPRlTRsQYGjhf96ekSBIB2CfjZIlggERMO0qlvypEBKqdD-ZuNhxC8gvbF2-fBWSpxgy0Vz-g","attestationStatementFormat":"none","transports":["internal","hybrid"]}	20	0
9d632057-711a-4f82-afc8-540b92537d99	\N	otp	6ceb0dc2-b56b-4116-9aca-92060432a07f	1751945055229	Redmi	{"value":"kGctECPMUIbzlRaJSbhv"}	{"subType":"totp","digits":6,"counter":0,"period":30,"algorithm":"HmacSHA1"}	20	0
ce567b25-a95c-487a-9161-a2d5e9082fe6	\N	webauthn-passwordless	6ceb0dc2-b56b-4116-9aca-92060432a07f	1751945649951	Passkey (Laptop)	{}	{"aaguid":"00000000-0000-0000-0000-000000000000","credentialId":"9RwMK+qXd4KTSjiTzmf2wxxrm0NhbigSIvwL5I89DCI=","counter":0,"credentialPublicKey":"pQECAyYgASFYINKJhBzjqfEYKWRkAxgp9wNJGen4l0s4yosWV3-gXpGWIlggw_qzR-9GdHFZqpNYkCmlJ00bRDYrpmV1SLB70EiBQQk","attestationStatementFormat":"none","transports":["internal"]}	30	0
17b30c00-0a5e-4e48-9eeb-4fa08dbd7809	\N	password	0bcec2b7-860b-46ca-a105-46a9fae43a60	1751596253940	My password	{"value":"oVxAeOiuvQxTVCvM052mUxEssKEROp9Dqjz/mBlL75o=","salt":"m+OWtjMhIcdQMWxFnb3GRiDXFMlMWiQiRcHMDe8Y12s=","additionalParameters":{}}	{"hashIterations":1,"algorithm":"sha256","additionalParameters":{}}	10	7
6a8cc9ad-a270-4a77-9466-a21b1a74cf14	\N	password	a029c552-b8e3-4b4f-b917-a29075a0ea37	1751615253147	\N	{"value":"Uj3nxzoGuAxM88hqxqH5BZRRgU8D3MUcEVXGvwaaSuo=","salt":"hYlRSqvOgiOPmVdmEq5zfop105+BYuDsHq32+Z4e1J0=","additionalParameters":{}}	{"hashIterations":1,"algorithm":"sha256","additionalParameters":{}}	10	5
f9711e8e-ffad-49b4-a938-55296d820fba	\N	password	68baa92f-562d-4681-a78c-f7f421924975	1751861579195	My password	{"value":"vvKxpTn4PgLN9qvQvMhbE8dGipl/y/GiUxJxgOjvnCY=","salt":"vxMiI8DxguKyQohFNk6Xjbn9hViuK1Y6ZQCU87wwuno=","additionalParameters":{}}	{"hashIterations":1,"algorithm":"sha256","additionalParameters":{}}	10	2
b5f8b8b5-a846-4669-8976-2a7bbe3ce1fc	\N	webauthn-passwordless	f65b3829-5635-4b8a-898c-4b46b32c2316	1751944657996	Passkey (Laptop)	{}	{"aaguid":"00000000-0000-0000-0000-000000000000","credentialId":"DxsAJ/O2dg/j0yChTI4mpGdFlVDiSBZ50vJEFJZ7Gbo=","counter":0,"credentialPublicKey":"pQECAyYgASFYIINGZtr6hu_ckyqD9OcQGEulWqPsGYOha6GlRtmoejfDIlggaJ4LSN6HJBbL3kep30iuTl1WefrO5GNUuDCI-tVU91k","attestationStatementFormat":"none","transports":["internal"]}	20	0
e28ae901-3337-4dd9-97e0-1b4904150f89	\N	password	6ceb0dc2-b56b-4116-9aca-92060432a07f	1751945011648	My password	{"value":"ILEdfRB67Yvtu7ZBazkGgMirIT3dDDvzLfSNp4nMpys=","salt":"grlBKV4sz5a06CMvX//tqA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	1
41feaa01-e2fd-416c-8490-bbde4a698a0c	\N	otp	f65b3829-5635-4b8a-898c-4b46b32c2316	1751948260135	Redmi	{"value":"uxF4QLNtt6CNFl2HVHBz"}	{"subType":"totp","digits":6,"counter":0,"period":30,"algorithm":"HmacSHA1"}	30	0
7eb0481b-fe4b-4b02-9cd6-ca9a50b5e2fb	\N	otp	e4347de6-75b7-4561-9cf7-325c656fc7df	1751948406868	Redmi	{"value":"jq6pSAaVIOGAVm1Jsuwi"}	{"subType":"totp","digits":6,"counter":0,"period":30,"algorithm":"HmacSHA1"}	20	0
43140845-c687-41e4-8a0e-2034b97b463f	\N	password	e4347de6-75b7-4561-9cf7-325c656fc7df	1751949101436	\N	{"value":"PB/bwKugQrUWd8lL4y1QtH0ahGMagsjl4AGc8qq0JLs=","salt":"IVssl/lgxKLiq/knIDt0S98ez0vUU0nKQsmvh5cNnjE=","additionalParameters":{}}	{"hashIterations":1,"algorithm":"sha256","additionalParameters":{}}	10	4
14851ed0-a4f7-4e05-94d5-a9bd17b7209b	\N	webauthn-passwordless	e4347de6-75b7-4561-9cf7-325c656fc7df	1751948426398	Passkey (Laptop)	{}	{"aaguid":"00000000-0000-0000-0000-000000000000","credentialId":"OogbbXLlrRydwrls+jfAnqQhb2IKbrt1WrQM9+ZF/70=","counter":0,"credentialPublicKey":"pQECAyYgASFYICc1hOIwS_hiQ4vo6pbAl4wXWl8tF0js7rsrs7pmGkFDIlggvF6naE00gSW5mNdpiwlHVUGGEmMpRfG2sG8IYw_Ivb0","attestationStatementFormat":"none","transports":["internal"]}	30	0
8e03cd7d-6aba-4b1a-afb2-a5aba3cbe9d9	\N	otp	e4347de6-75b7-4561-9cf7-325c656fc7df	1751949092068	Redmi	{"value":"GF7o4JVg2nlPJiArwrPb"}	{"subType":"totp","digits":6,"counter":0,"period":30,"algorithm":"HmacSHA1"}	40	0
70e3539e-ac0d-4afb-bd24-97d6ec27028a	\N	password	f65b3829-5635-4b8a-898c-4b46b32c2316	1751619243641	\N	{"value":"BrqFrmAA0MRg4vbOoLzoyXzdGgafzw7R/r+3GsPW+Zs=","salt":"6hi1YkJxufuBq8+vF7/uNY+V2BaJSOOrQyjdFk1q4YM=","additionalParameters":{}}	{"hashIterations":1,"algorithm":"sha256","additionalParameters":{}}	10	75
a2f4bd32-ef39-4f94-a594-bcff148eefac	\N	otp	f65bc99f-3ac0-48d0-8c49-ce0b452d821d	1752652461650	Redmi	{"value":"BmgUj4UmwVF3PN2xK79q"}	{"subType":"totp","digits":6,"counter":0,"period":30,"algorithm":"HmacSHA1"}	20	0
e5ea6b3e-2c91-40f4-96c0-568690ccce41	\N	webauthn	f65bc99f-3ac0-48d0-8c49-ce0b452d821d	1752654099763	Passkey (Google Laptop)	{}	{"aaguid":"00000000-0000-0000-0000-000000000000","credentialId":"fZeQdlJlzbimsBfwqqi0c/mrbUesMDtlztxwR1rvW4A=","counter":0,"credentialPublicKey":"pQECAyYgASFYII3QHQS2l-H4antOn28n2kQT7COT-lTW2NE9MKkn5LSMIlggg2HPkGeIIrH2gcq9FsxaIVj0pFMqiBMFqnDVLz320j4","attestationStatementFormat":"none","transports":["internal"]}	30	0
316305b9-05dc-49df-878a-9f94d2758e37	\N	webauthn-passwordless	f65b3829-5635-4b8a-898c-4b46b32c2316	1752660722685	Passkey (Google Laptop)	{}	{"aaguid":"00000000-0000-0000-0000-000000000000","credentialId":"GCqRhpbqEv5eG7N1UEJfozOFgKHvSKHrM1D0Nsd8fyY=","counter":0,"credentialPublicKey":"pQECAyYgASFYIOuGLyzc8yCiehv9rIieFaxFuv8duZDi-GJH1Gm6RgowIlggSDqXsn5i5RV6smNDSCJiSs6Oc9GLgCZMunYw12pAlmQ","attestationStatementFormat":"none","transports":["internal"]}	40	0
ebf29696-d991-4865-8ae9-30288e72b224	\N	password	f65bc99f-3ac0-48d0-8c49-ce0b452d821d	1752652469070	\N	{"value":"yP/cs2DDxQqygP9AJjSyFtOKxvyH3yX5yZFCIOSJRls=","salt":"U6UuSuHIMMiEA+zFT1BCoEU3bnjrH+Wpmb3R/gxrDwg=","additionalParameters":{}}	{"hashIterations":1,"algorithm":"sha256","additionalParameters":{}}	10	11
\.


--
-- TOC entry 4169 (class 0 OID 16487)
-- Dependencies: 237
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-06-30 13:38:38.996907	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	1265518357
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-06-30 13:38:39.016481	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	1265518357
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-06-30 13:38:39.087986	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	1265518357
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-06-30 13:38:39.098861	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1265518357
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-06-30 13:38:39.251322	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	1265518357
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-06-30 13:38:39.259498	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	1265518357
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-06-30 13:38:39.411788	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	1265518357
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-06-30 13:38:39.42424	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	1265518357
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-06-30 13:38:39.446543	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	1265518357
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-06-30 13:38:39.622903	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	1265518357
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-06-30 13:38:39.705282	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1265518357
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-06-30 13:38:39.710126	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1265518357
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-06-30 13:38:39.756171	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1265518357
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-06-30 13:38:39.793547	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	1265518357
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-06-30 13:38:39.796978	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1265518357
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-06-30 13:38:39.802163	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	1265518357
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-06-30 13:38:39.809641	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	1265518357
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-06-30 13:38:39.882574	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	1265518357
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-06-30 13:38:39.944372	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	1265518357
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-06-30 13:38:39.954454	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	1265518357
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-06-30 13:38:39.959208	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	1265518357
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-06-30 13:38:39.96484	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	1265518357
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-06-30 13:38:40.088229	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	1265518357
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-06-30 13:38:40.101215	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	1265518357
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-06-30 13:38:40.104956	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	1265518357
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-06-30 13:38:40.761774	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	1265518357
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-06-30 13:38:40.86348	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	1265518357
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-06-30 13:38:40.873067	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	1265518357
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-06-30 13:38:40.949063	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	1265518357
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-06-30 13:38:40.973836	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	1265518357
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-06-30 13:38:41.010212	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	1265518357
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-06-30 13:38:41.023607	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	1265518357
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-06-30 13:38:41.035654	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1265518357
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-06-30 13:38:41.039997	34	MARK_RAN	9:f9753208029f582525ed12011a19d054	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	1265518357
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-06-30 13:38:41.08135	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	1265518357
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-06-30 13:38:41.091947	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	1265518357
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-06-30 13:38:41.099658	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1265518357
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-06-30 13:38:41.10681	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	1265518357
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-06-30 13:38:41.112952	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	1265518357
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-06-30 13:38:41.11604	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	1265518357
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-06-30 13:38:41.120231	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	1265518357
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-06-30 13:38:41.131721	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	1265518357
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-06-30 13:38:43.775501	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	1265518357
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-06-30 13:38:43.788781	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	1265518357
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-06-30 13:38:43.803647	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	1265518357
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-06-30 13:38:43.818832	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	1265518357
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-06-30 13:38:43.822069	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	1265518357
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-06-30 13:38:44.013565	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	1265518357
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-06-30 13:38:44.026958	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	1265518357
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-06-30 13:38:44.08189	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	1265518357
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-06-30 13:38:44.724061	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	1265518357
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-06-30 13:38:44.735212	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1265518357
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-06-30 13:38:44.748597	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	1265518357
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-06-30 13:38:44.760298	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	1265518357
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-06-30 13:38:44.773914	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	1265518357
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-06-30 13:38:44.787245	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	1265518357
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-06-30 13:38:44.862084	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	1265518357
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-06-30 13:38:45.581141	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	1265518357
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-06-30 13:38:45.612998	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	1265518357
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-06-30 13:38:45.622619	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	1265518357
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-06-30 13:38:45.637695	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	1265518357
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-06-30 13:38:45.644178	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	1265518357
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-06-30 13:38:45.6496	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	1265518357
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-06-30 13:38:45.655313	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	1265518357
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-06-30 13:38:45.66075	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	1265518357
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-06-30 13:38:45.725619	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	1265518357
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-06-30 13:38:45.794256	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	1265518357
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-06-30 13:38:45.806585	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	1265518357
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-06-30 13:38:45.885635	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	1265518357
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-06-30 13:38:45.903322	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	1265518357
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-06-30 13:38:45.913456	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	1265518357
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-06-30 13:38:45.934808	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1265518357
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-06-30 13:38:45.947793	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1265518357
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-06-30 13:38:45.952236	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1265518357
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-06-30 13:38:45.987531	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	1265518357
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-06-30 13:38:46.045259	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	1265518357
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-06-30 13:38:46.054219	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	1265518357
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-06-30 13:38:46.058717	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	1265518357
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-06-30 13:38:46.090217	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	1265518357
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-06-30 13:38:46.094348	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	1265518357
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-06-30 13:38:46.159003	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	1265518357
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-06-30 13:38:46.163487	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1265518357
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-06-30 13:38:46.176752	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1265518357
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-06-30 13:38:46.181773	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1265518357
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-06-30 13:38:46.248605	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1265518357
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-06-30 13:38:46.256724	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	1265518357
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-06-30 13:38:46.269538	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	1265518357
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-06-30 13:38:46.279255	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	1265518357
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-30 13:38:46.292832	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	1265518357
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-30 13:38:46.308342	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	1265518357
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-30 13:38:46.392783	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1265518357
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-30 13:38:46.413858	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	1265518357
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-30 13:38:46.421346	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	1265518357
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-30 13:38:46.459288	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	1265518357
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-30 13:38:46.500558	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	1265518357
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-06-30 13:38:46.533217	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	1265518357
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-06-30 13:38:46.797604	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1265518357
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-06-30 13:38:46.801646	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1265518357
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-06-30 13:38:46.825298	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1265518357
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-06-30 13:38:46.913186	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1265518357
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-06-30 13:38:46.917367	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1265518357
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-06-30 13:38:46.99679	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	1265518357
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-06-30 13:38:47.012017	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	1265518357
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-06-30 13:38:47.031437	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	1265518357
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-06-30 13:38:47.127567	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	1265518357
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-06-30 13:38:47.240452	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	1265518357
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-06-30 13:38:47.394165	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	1265518357
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-06-30 13:38:47.435593	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	1265518357
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-06-30 13:38:47.536259	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	1265518357
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-06-30 13:38:47.541435	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	1265518357
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-06-30 13:38:47.570729	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1265518357
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-06-30 13:38:47.590343	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	1265518357
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-06-30 13:38:47.609542	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	1265518357
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-06-30 13:38:47.614151	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	1265518357
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-06-30 13:38:47.625238	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	1265518357
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-06-30 13:38:47.628212	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	1265518357
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-06-30 13:38:47.641208	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	1265518357
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-06-30 13:38:47.647972	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1265518357
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-06-30 13:38:47.904493	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	1265518357
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-06-30 13:38:47.913454	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	1265518357
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-06-30 13:38:47.922176	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1265518357
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-06-30 13:38:47.977527	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1265518357
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-06-30 13:38:47.985688	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	1265518357
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-06-30 13:38:47.988788	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1265518357
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-06-30 13:38:47.992925	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1265518357
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-30 13:38:48.004312	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1265518357
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-30 13:38:48.072811	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1265518357
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-30 13:38:48.393861	128	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1265518357
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-30 13:38:48.597027	129	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1265518357
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-30 13:38:48.777272	130	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1265518357
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-30 13:38:49.017009	131	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1265518357
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-30 13:38:49.021124	132	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1265518357
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-30 13:38:49.096761	133	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1265518357
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-30 13:38:49.125758	134	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	1265518357
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-30 13:38:49.151403	135	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	1265518357
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-30 13:38:49.156722	136	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	1265518357
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-06-30 13:38:49.315607	137	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	1265518357
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-30 13:38:49.331855	138	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	1265518357
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-30 13:38:49.34685	139	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	1265518357
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-30 13:38:49.400147	140	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	1265518357
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-30 13:38:49.417405	141	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	1265518357
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-30 13:38:49.428917	142	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	1265518357
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-30 13:38:49.495498	143	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	1265518357
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-30 13:38:49.647939	144	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	1265518357
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-30 13:38:49.829928	145	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1265518357
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-30 13:38:49.85064	146	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	1265518357
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-06-30 13:38:49.857726	147	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	1265518357
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-06-30 13:38:49.870048	148	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.29.1	\N	\N	1265518357
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-06-30 13:38:49.884561	149	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	1265518357
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-06-30 13:38:49.894812	150	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.29.1	\N	\N	1265518357
26.2.0-36750	keycloak	META-INF/jpa-changelog-26.2.0.xml	2025-06-30 13:38:49.9042	151	EXECUTED	9:b49ce951c22f7eb16480ff085640a33a	createTable tableName=SERVER_CONFIG		\N	4.29.1	\N	\N	1265518357
26.2.0-26106	keycloak	META-INF/jpa-changelog-26.2.0.xml	2025-06-30 13:38:49.913005	152	EXECUTED	9:b5877d5dab7d10ff3a9d209d7beb6680	addColumn tableName=CREDENTIAL		\N	4.29.1	\N	\N	1265518357
\.


--
-- TOC entry 4170 (class 0 OID 16492)
-- Dependencies: 238
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- TOC entry 4171 (class 0 OID 16495)
-- Dependencies: 239
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
c59dea27-0f0a-4d7e-9d51-e1017680e812	6178d2a9-a580-4906-bb8b-31990018282c	f
c59dea27-0f0a-4d7e-9d51-e1017680e812	c5a655ce-c550-4608-9f85-819518464c45	t
c59dea27-0f0a-4d7e-9d51-e1017680e812	6d6ce73e-3240-46a6-a155-566683389d24	t
c59dea27-0f0a-4d7e-9d51-e1017680e812	9989de32-22d3-4753-8d69-655da8e53ada	t
c59dea27-0f0a-4d7e-9d51-e1017680e812	c5786f6a-0780-49f4-9481-1c1381acf9cc	t
c59dea27-0f0a-4d7e-9d51-e1017680e812	a21eb8de-fb97-4e20-a427-8c3899be302d	f
c59dea27-0f0a-4d7e-9d51-e1017680e812	aa9d5c9b-ea42-4a49-b554-fd32252f0886	f
c59dea27-0f0a-4d7e-9d51-e1017680e812	3c0d71d0-b8f8-4a05-8943-67b65bb34bd7	t
c59dea27-0f0a-4d7e-9d51-e1017680e812	e28c5545-1ed1-45b0-8a4e-ac79b7bb6cc6	t
c59dea27-0f0a-4d7e-9d51-e1017680e812	f710ee27-621f-420a-8073-f774b62572e4	f
c59dea27-0f0a-4d7e-9d51-e1017680e812	3456e0d7-ec64-4e6c-943d-b4d00b8e3ada	t
c59dea27-0f0a-4d7e-9d51-e1017680e812	bf7a58fc-2d5b-4385-a218-7c194679733a	t
c59dea27-0f0a-4d7e-9d51-e1017680e812	e1c884bc-1acc-4801-b560-7b124a2012d3	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	231c88af-23ce-4090-b1e3-968b9dfb4458	t
041f8a3b-b936-410d-b423-b51f4cd23d7f	97dd5dc6-1099-4d37-9333-cb96f8f84ff3	t
041f8a3b-b936-410d-b423-b51f4cd23d7f	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2	t
041f8a3b-b936-410d-b423-b51f4cd23d7f	2f483427-27c2-4f28-99e2-a0f1f110d89a	t
041f8a3b-b936-410d-b423-b51f4cd23d7f	e02a4651-1176-4678-b9a2-80876e2dc2f2	t
041f8a3b-b936-410d-b423-b51f4cd23d7f	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644	t
041f8a3b-b936-410d-b423-b51f4cd23d7f	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe	t
041f8a3b-b936-410d-b423-b51f4cd23d7f	90374560-2ca4-456d-8801-98ac06c8b0f5	t
041f8a3b-b936-410d-b423-b51f4cd23d7f	ebe8188b-0c77-4993-995d-f7a99a578eb1	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	d8e8fea8-e7f0-4867-8823-665cf98b3150	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	196faef5-835f-4231-acb3-fcd3c661efa6	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	2866ff77-6d11-4076-88b3-47ab819d4685	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	3629ba2b-2071-403a-8d48-c56bf7e287f6	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	c9469db6-d939-496e-bf11-02e2750f8a0c	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	52ef2827-5c48-448b-8975-40266cc64b66	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	676a49c9-b132-4103-85cb-25cd59321af2	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	64bb1677-0898-479e-a67c-e43a31fac4cd	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	55b6e976-0954-4724-bff3-7e02d096ccdd	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	2b58b3b0-08d8-4dec-881f-19b8a551b2f0	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	d195c82c-f5b7-4af3-89e9-639b337cb874	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	eee47aba-f11c-451b-bb74-c301092240de	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	9ad3f5c8-0343-488d-b1dc-077332dfcd7f	f
041f8a3b-b936-410d-b423-b51f4cd23d7f	84d58747-dbf8-4ee4-9eab-46c6df76e847	f
\.


--
-- TOC entry 4172 (class 0 OID 16499)
-- Dependencies: 240
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- TOC entry 4173 (class 0 OID 16504)
-- Dependencies: 241
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- TOC entry 4174 (class 0 OID 16509)
-- Dependencies: 242
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 4175 (class 0 OID 16514)
-- Dependencies: 243
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 4176 (class 0 OID 16517)
-- Dependencies: 244
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- TOC entry 4177 (class 0 OID 16522)
-- Dependencies: 245
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 4178 (class 0 OID 16525)
-- Dependencies: 246
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 4179 (class 0 OID 16531)
-- Dependencies: 247
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 4180 (class 0 OID 16534)
-- Dependencies: 248
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 4181 (class 0 OID 16539)
-- Dependencies: 249
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- TOC entry 4182 (class 0 OID 16544)
-- Dependencies: 250
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- TOC entry 4183 (class 0 OID 16550)
-- Dependencies: 251
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- TOC entry 4184 (class 0 OID 16553)
-- Dependencies: 252
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- TOC entry 4185 (class 0 OID 16565)
-- Dependencies: 253
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 4186 (class 0 OID 16570)
-- Dependencies: 254
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- TOC entry 4187 (class 0 OID 16575)
-- Dependencies: 255
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 4188 (class 0 OID 16580)
-- Dependencies: 256
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.jgroups_ping (address, name, cluster_name, ip, coord) FROM stdin;
uuid://a6f6d69c-bd66-4fb4-b037-d70200fe1997	keycloak-server--0000019-58b87ccb6c-dfk2r-45094	ISPN	100.100.201.40:7800	t
\.


--
-- TOC entry 4189 (class 0 OID 16585)
-- Dependencies: 257
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
\.


--
-- TOC entry 4190 (class 0 OID 16589)
-- Dependencies: 258
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
9ca49408-842b-4cda-86c2-5e1f7407be08	c59dea27-0f0a-4d7e-9d51-e1017680e812	f	${role_default-roles}	default-roles-master	c59dea27-0f0a-4d7e-9d51-e1017680e812	\N	\N
3b066307-ccd0-43ed-a977-2a3ff55fb5f5	c59dea27-0f0a-4d7e-9d51-e1017680e812	f	${role_create-realm}	create-realm	c59dea27-0f0a-4d7e-9d51-e1017680e812	\N	\N
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	c59dea27-0f0a-4d7e-9d51-e1017680e812	f	${role_admin}	admin	c59dea27-0f0a-4d7e-9d51-e1017680e812	\N	\N
d3d60608-f580-4a78-9604-3c1eaccb873f	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_create-client}	create-client	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
13463c11-20e4-4c91-8d3c-700276badb44	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_view-realm}	view-realm	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
5dbfc010-f481-4a37-8a69-03966d90388f	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_view-users}	view-users	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
3adbd483-254a-42bf-8d3e-c9ffedacec00	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_view-clients}	view-clients	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
27b34137-55f8-4780-a79d-9dc7c0773556	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_view-events}	view-events	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
7d04ad7a-1dfa-4f45-b4a3-111294caa1cb	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_view-identity-providers}	view-identity-providers	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
b2901135-c978-42d7-92d4-07b0d0dac753	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_view-authorization}	view-authorization	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
f00f9554-b908-4265-a509-dd139053f868	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_manage-realm}	manage-realm	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
463835a2-fbf0-48a3-9f39-8bc9fdcc64a8	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_manage-users}	manage-users	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
32859ee5-1886-44dd-8e82-72f84b9c3191	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_manage-clients}	manage-clients	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
52902548-d260-4b94-9ede-0c34b6b98aed	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_manage-events}	manage-events	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
abbc83fe-5d41-4c9d-bc69-d155cd0e1345	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_manage-identity-providers}	manage-identity-providers	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
1646d598-be46-4c5e-8296-bf8cadf919bf	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_manage-authorization}	manage-authorization	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
3b38f4d5-0211-4163-9dd0-95dbefa7a31e	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_query-users}	query-users	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
ee66b328-4d4e-45ea-b78a-2dc91a0ebb64	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_query-clients}	query-clients	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
546e33cc-8513-495f-8fe3-f5268bf2c24e	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_query-realms}	query-realms	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
081a0cb3-4e78-4950-bf11-ec32b54e6560	f36c6fd0-b46c-43d5-9413-0e462e191822	t		access	041f8a3b-b936-410d-b423-b51f4cd23d7f	f36c6fd0-b46c-43d5-9413-0e462e191822	\N
9ec5fbd0-cb52-4633-af6e-3b76b0102cf3	041f8a3b-b936-410d-b423-b51f4cd23d7f	f		apple-health-access	041f8a3b-b936-410d-b423-b51f4cd23d7f	\N	\N
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	041f8a3b-b936-410d-b423-b51f4cd23d7f	f	${role_default-roles}	default-roles-fhir-realm	041f8a3b-b936-410d-b423-b51f4cd23d7f	\N	\N
2efe294a-1b0c-4854-828d-3b124b5bf0d2	041f8a3b-b936-410d-b423-b51f4cd23d7f	f	Users who can access system-level patient data	system-access	041f8a3b-b936-410d-b423-b51f4cd23d7f	\N	\N
8f86e174-8430-462f-a159-616eb34f15d7	041f8a3b-b936-410d-b423-b51f4cd23d7f	f	${role_uma_authorization}	uma_authorization	041f8a3b-b936-410d-b423-b51f4cd23d7f	\N	\N
cebc8201-176e-4aa9-9b63-da3c4d9f4612	041f8a3b-b936-410d-b423-b51f4cd23d7f	f		patient	041f8a3b-b936-410d-b423-b51f4cd23d7f	\N	\N
788e7dc2-30ff-428e-bbe4-ff70a49e35ab	041f8a3b-b936-410d-b423-b51f4cd23d7f	f	${role_offline-access}	offline_access	041f8a3b-b936-410d-b423-b51f4cd23d7f	\N	\N
e345260f-e8db-43e0-b507-47b3b7ded410	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_query-groups}	query-groups	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
55185916-80ee-4f01-aa52-41a1a308da70	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	t	${role_view-profile}	view-profile	c59dea27-0f0a-4d7e-9d51-e1017680e812	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	\N
b6898dda-5101-402a-92b0-d6e271175cc0	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	t	${role_manage-account}	manage-account	c59dea27-0f0a-4d7e-9d51-e1017680e812	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	\N
90411d85-d3aa-48eb-9d27-809a151db1c3	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	t	${role_manage-account-links}	manage-account-links	c59dea27-0f0a-4d7e-9d51-e1017680e812	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	\N
160c77de-beed-4e46-b537-a9212f2ebb1a	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	t	${role_view-applications}	view-applications	c59dea27-0f0a-4d7e-9d51-e1017680e812	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	\N
ee55916b-5b4d-4606-ac4c-8acaaa8a6c5e	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	t	${role_view-consent}	view-consent	c59dea27-0f0a-4d7e-9d51-e1017680e812	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	\N
cc698ccf-f93b-41a6-a470-09dd3dadd438	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	t	${role_manage-consent}	manage-consent	c59dea27-0f0a-4d7e-9d51-e1017680e812	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	\N
29158e62-deef-42d7-ac52-e765104081e0	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	t	${role_view-groups}	view-groups	c59dea27-0f0a-4d7e-9d51-e1017680e812	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	\N
7e7e3926-1d09-4f14-8b5e-ac86decb4d81	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	t	${role_delete-account}	delete-account	c59dea27-0f0a-4d7e-9d51-e1017680e812	9eee2754-cbf5-42b9-a7ea-d782447cc4f4	\N
bb376142-fe93-4977-945b-cf5ad6413df4	c53d33f2-6196-4a0e-bb5b-5f6b2f49af07	t	${role_read-token}	read-token	c59dea27-0f0a-4d7e-9d51-e1017680e812	c53d33f2-6196-4a0e-bb5b-5f6b2f49af07	\N
8c9ba266-8110-4c8b-b896-b268713f264e	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	t	${role_impersonation}	impersonation	c59dea27-0f0a-4d7e-9d51-e1017680e812	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	\N
1125c0d3-1cfe-46ec-9877-9a98ec47ac94	c59dea27-0f0a-4d7e-9d51-e1017680e812	f	${role_offline-access}	offline_access	c59dea27-0f0a-4d7e-9d51-e1017680e812	\N	\N
f4850653-e54d-4425-aa60-994c544efbaf	c59dea27-0f0a-4d7e-9d51-e1017680e812	f	${role_uma_authorization}	uma_authorization	c59dea27-0f0a-4d7e-9d51-e1017680e812	\N	\N
d7468bb8-3b4a-4709-8364-4f1e5ae0fb22	2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	t	\N	uma_protection	041f8a3b-b936-410d-b423-b51f4cd23d7f	2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	\N
aae3b073-5366-455d-82d9-706cd266e8a8	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_create-client}	create-client	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
06678ae0-1c69-4e35-9b6e-38f602143e14	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_view-realm}	view-realm	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
833ccee3-920b-4427-8050-e3abfdc57081	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_view-users}	view-users	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
cfdab536-2b01-4f31-9d82-54d36c343aad	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_view-clients}	view-clients	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
2f7dba61-8e17-4c73-93fa-fa553ccdc0be	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_view-events}	view-events	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
aae745a1-6167-4136-8b1c-31326922d9ea	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_view-identity-providers}	view-identity-providers	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
5a06893c-5ea5-489b-a472-af0276903196	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_view-authorization}	view-authorization	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
7136710f-f7d3-40a8-b4f2-d0562dd649a0	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_manage-realm}	manage-realm	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
a1ebd545-e222-4981-b3dd-d3e52c1fb5b3	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_manage-users}	manage-users	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
4a02c504-1281-4daf-a7ba-c4382eed32db	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_manage-clients}	manage-clients	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
fccf241c-4530-4ef3-8016-3f063e442b98	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_manage-events}	manage-events	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
6416ea21-2c6f-4671-bfda-3d9aacd408ab	74994dc4-9c37-457b-b002-b6b0d6dfb0ab	t		patient	041f8a3b-b936-410d-b423-b51f4cd23d7f	74994dc4-9c37-457b-b002-b6b0d6dfb0ab	\N
1c7bd0c4-40bd-4812-84ca-f8b86c4521eb	74994dc4-9c37-457b-b002-b6b0d6dfb0ab	t		admin	041f8a3b-b936-410d-b423-b51f4cd23d7f	74994dc4-9c37-457b-b002-b6b0d6dfb0ab	\N
e9acb963-6a16-4fd8-8044-18138c0cca52	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_manage-identity-providers}	manage-identity-providers	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
37309358-966e-43dc-960e-65fa504518f1	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_manage-authorization}	manage-authorization	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
0e4dba83-c5e7-49ce-b4ef-edf7b2983060	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_query-users}	query-users	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
a2aa8695-cce8-4771-b0e3-f7c5125e8672	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_query-clients}	query-clients	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
26fe0fa0-bf1f-4ec6-ab4b-1406edcfe7b2	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_query-realms}	query-realms	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
5bd0e129-e49b-4fa4-accd-edfa8c9b785e	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_query-groups}	query-groups	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
f03e0200-d658-461a-8bb0-5ea1cff50eb3	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_query-users}	query-users	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
6ac75507-43ac-4470-9b19-071fa99e9881	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_view-events}	view-events	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
9da19dc4-517b-4634-86c0-1ae414f4b3fd	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_manage-users}	manage-users	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
f07630be-9483-4bbc-b04c-da5ca7e383a3	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_manage-events}	manage-events	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
205f27f9-43de-4240-80f1-8b5ffc7b84d5	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_view-identity-providers}	view-identity-providers	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
5810aa60-30fd-438c-83d1-9a3ac263475c	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_realm-admin}	realm-admin	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
b8a37e3f-4f35-4ce0-b70a-eb57885f5317	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_manage-identity-providers}	manage-identity-providers	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
dafcdf53-10c6-4eb4-8cbb-9516c3811e00	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_query-clients}	query-clients	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
a7164d5c-36cd-47fc-95b3-c86bc0b4b548	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_impersonation}	impersonation	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
992c19ba-c6bd-4c1c-97e7-0399e3e19e8b	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_manage-clients}	manage-clients	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
3eb1fca6-e1d3-44fb-9eb8-7eab265018da	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_manage-authorization}	manage-authorization	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
2d2317fa-ecd4-4331-a99e-10e360588ae6	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_query-groups}	query-groups	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
678d2c95-46f5-489e-ac9a-90936c98c6bc	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_query-realms}	query-realms	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
aa077273-c074-4610-9310-2faa1a88f6ca	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_view-authorization}	view-authorization	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
e128118b-7c95-4f35-99f9-2324ead6c2b2	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_create-client}	create-client	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
e2514ff0-e97f-4d84-96a8-a06d8087b099	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_manage-realm}	manage-realm	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
9e800f34-0d0a-4255-b6e2-0d5f8b53b6c5	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_view-realm}	view-realm	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
6e13eb40-c005-4c37-94c4-20810d74e9fb	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_view-clients}	view-clients	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
d3ee8ecd-cad1-4fe6-801d-483ee1bd1ef9	363258bf-2231-431d-82ba-63c63ce82c2e	t	${role_view-users}	view-users	041f8a3b-b936-410d-b423-b51f4cd23d7f	363258bf-2231-431d-82ba-63c63ce82c2e	\N
73c7d51e-2f3e-4c8d-b9f0-f97c78b05621	d7f84708-6ae4-42ea-93d3-825c725f7d2c	t	\N	uma_protection	041f8a3b-b936-410d-b423-b51f4cd23d7f	d7f84708-6ae4-42ea-93d3-825c725f7d2c	\N
29df026a-ef13-4ada-88b8-a5540fb075f7	14dca9b5-d63b-408f-be63-605611e53d4b	t	${role_read-token}	read-token	041f8a3b-b936-410d-b423-b51f4cd23d7f	14dca9b5-d63b-408f-be63-605611e53d4b	\N
9c3eccc4-a7b2-42eb-85ba-008578c60817	f36c6fd0-b46c-43d5-9413-0e462e191822	t	Client role for user1	user1	041f8a3b-b936-410d-b423-b51f4cd23d7f	f36c6fd0-b46c-43d5-9413-0e462e191822	\N
462f8907-3e28-443a-a2be-c38babd5800e	636672b6-143d-4bf2-ac14-e0feade63dc6	t	\N	uma_protection	041f8a3b-b936-410d-b423-b51f4cd23d7f	636672b6-143d-4bf2-ac14-e0feade63dc6	\N
1c487db0-18ee-4710-b240-f966c9105aed	636672b6-143d-4bf2-ac14-e0feade63dc6	t		admin	041f8a3b-b936-410d-b423-b51f4cd23d7f	636672b6-143d-4bf2-ac14-e0feade63dc6	\N
2c10cbcc-65e9-4c23-a51c-07a128ffa777	636672b6-143d-4bf2-ac14-e0feade63dc6	t		user1	041f8a3b-b936-410d-b423-b51f4cd23d7f	636672b6-143d-4bf2-ac14-e0feade63dc6	\N
f988bdfe-e4c1-4890-8831-8a70c0313367	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	t	${role_view-applications}	view-applications	041f8a3b-b936-410d-b423-b51f4cd23d7f	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	\N
23efe8e8-c68b-43f4-9b55-b317d0911610	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	t	${role_manage-account-links}	manage-account-links	041f8a3b-b936-410d-b423-b51f4cd23d7f	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	\N
4fc9d6ae-e7be-4a09-ab61-705be086420d	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	t	${role_delete-account}	delete-account	041f8a3b-b936-410d-b423-b51f4cd23d7f	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	\N
6b7d3836-9d77-4b1d-bb0b-0eb7a73bee05	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	t	${role_view-consent}	view-consent	041f8a3b-b936-410d-b423-b51f4cd23d7f	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	\N
756672dc-1a78-4011-b733-95e6c7d713e6	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	t	${role_manage-account}	manage-account	041f8a3b-b936-410d-b423-b51f4cd23d7f	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	\N
39f0641c-a68d-43f3-bd07-684a5c196c8c	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	t	${role_manage-consent}	manage-consent	041f8a3b-b936-410d-b423-b51f4cd23d7f	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	\N
a11a809b-0649-46c0-b078-e2e23a9cdbcc	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	t	${role_view-groups}	view-groups	041f8a3b-b936-410d-b423-b51f4cd23d7f	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	\N
0865dd03-e0f0-42c5-a4ec-118e44f4216d	dbe09ae6-8593-4a11-9455-03f179bbae8c	t	${role_impersonation}	impersonation	c59dea27-0f0a-4d7e-9d51-e1017680e812	dbe09ae6-8593-4a11-9455-03f179bbae8c	\N
7317366a-e3a7-477b-a4db-a46508d297b8	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	t	${role_view-profile}	view-profile	041f8a3b-b936-410d-b423-b51f4cd23d7f	938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	\N
8108b1d8-8e67-4173-9195-3c55dab99f92	767d4eee-87ba-42cc-a25d-0d904138f24f	t	\N	uma_protection	c59dea27-0f0a-4d7e-9d51-e1017680e812	767d4eee-87ba-42cc-a25d-0d904138f24f	\N
\.


--
-- TOC entry 4191 (class 0 OID 16595)
-- Dependencies: 259
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.migration_model (id, version, update_time) FROM stdin;
e2hpl	26.2.5	1751265531
\.


--
-- TOC entry 4192 (class 0 OID 16599)
-- Dependencies: 260
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
eabcc3de-352a-4086-9674-1cabd8a1d517	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1751443493	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://192.168.56.1:8090/fhir","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751443491","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","client_request_param_launch":"123xyz","scope":"launch openid fhirUser offline_access patient/Patient.rs","userSessionStartedAt":"1751443491","redirect_uri":"http://localhost/custom/smart/redirect","state":"0de77d7d-9068-473b-b39a-12f08c043f05","code_challenge":"xZZCjEqDDUxGEBAaP6TStJa8gUovVkAhH18Fdr9GdcU"}}	local	local	0
6125c687-d79c-4834-b9b4-581f8099ef5b	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1751443742	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://192.168.56.1:8090/fhir","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751443741","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Coverage.rs patient/Specimen.rs patient/MedicationDispense.rs patient/ServiceRequest.rs","userSessionStartedAt":"1751443741","redirect_uri":"http://localhost/custom/smart/redirect","state":"7c31ab97-a6af-4c01-b457-4734723e7aae","code_challenge":"vRhcXj8N7M8FBKUKicJAByKsiX3WZGxUEfJMI4HO8xE"}}	local	local	0
dd41b32e-182e-42d1-aaf6-17eac0336aed	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1751452777	{"authMethod":"openid-connect","redirectUri":"https://oauth.pstmn.io/v1/callback","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Patient.u patient/Observation.u patient/Observation.c","SSO_AUTH":"true","userSessionStartedAt":"1751446471","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751448597","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://oauth.pstmn.io/v1/callback","code_challenge":"mg2mvf0xtOkfwH4H9NeFD5XyHDkCFKN7G_ONk51X2_k"}}	local	local	1
c242cf2e-ba2e-4cd8-8edd-09a11a4ded1e	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1751281471	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://192.168.56.1:8090/fhir","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751279917","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Coverage.rs patient/Specimen.rs patient/MedicationDispense.rs patient/ServiceRequest.rs","SSO_AUTH":"true","userSessionStartedAt":"1751279917","redirect_uri":"http://localhost/custom/smart/redirect","state":"e67b13fc-3264-445f-85c6-1408f23adad0","code_challenge":"D2yZWwH3SnClCC_rGz6oRaNwd_qFhmAcbiTcX9L3SgU"}}	local	local	2
24c1b825-27a7-4c78-8a82-5dc3f2f2a180	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1751340778	{"authMethod":"openid-connect","redirectUri":"https://www.facebook.com/","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Coverage.rs patient/Specimen.rs patient/MedicationDispense.rs patient/ServiceRequest.rs","SSO_AUTH":"true","userSessionStartedAt":"1751338241","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751340764","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://www.facebook.com/","code_challenge":"VtKKhO-HjMmE5maOVYoeUwZaPvgFNxM1V5QyZpyraqU"}}	local	local	0
3890f210-a3f6-41a2-a7a9-2de03d238d7c	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1751359608	{"authMethod":"openid-connect","redirectUri":"https://oauth.pstmn.io/v1/callback","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rsw patient/AllergyIntolerance.rsw patient/CarePlan.rsw patient/CareTeam.rsw patient/Condition.rsw patient/Device.rsw patient/DiagnosticReport.rsw patient/DocumentReference.rsw patient/Encounter.rsw patient/Goal.rsw patient/Immunization.rsw patient/Location.rsw patient/MedicationRequest.rsw patient/Observation.rsw patient/Organization.rsw patient/Patient.rsw patient/Practitioner.rsw patient/Procedure.rsw patient/Provenance.rsw patient/PractitionerRole.rsw","userSessionStartedAt":"1751359607","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751359607","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://oauth.pstmn.io/v1/callback","code_challenge":"mg2mvf0xtOkfwH4H9NeFD5XyHDkCFKN7G_ONk51X2_k"}}	local	local	0
5273319a-927a-4ddc-90cd-64afa38c2e53	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1751359790	{"authMethod":"openid-connect","redirectUri":"https://www.facebook.com/","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs","userSessionStartedAt":"1751359789","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751359789","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://www.facebook.com/","code_challenge":"VtKKhO-HjMmE5maOVYoeUwZaPvgFNxM1V5QyZpyraqU"}}	local	local	0
0edb0830-8a89-43e9-b140-394c50482af1	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1751359881	{"authMethod":"openid-connect","redirectUri":"https://oauth.pstmn.io/v1/callback","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rsw patient/AllergyIntolerance.rsw patient/CarePlan.rsw patient/CareTeam.rsw patient/Condition.rsw patient/Device.rsw patient/DiagnosticReport.rsw patient/DocumentReference.rsw patient/Encounter.rsw patient/Goal.rsw patient/Immunization.rsw patient/Location.rsw patient/MedicationRequest.rsw patient/Observation.rsw patient/Organization.rsw patient/Patient.rsw patient/Practitioner.rsw patient/Procedure.rsw patient/Provenance.rsw patient/PractitionerRole.rsw","userSessionStartedAt":"1751359880","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751359880","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://oauth.pstmn.io/v1/callback","code_challenge":"mg2mvf0xtOkfwH4H9NeFD5XyHDkCFKN7G_ONk51X2_k"}}	local	local	0
c638370f-e3b6-4196-9ae2-6876b08651ee	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1751361278	{"authMethod":"openid-connect","redirectUri":"https://oauth.pstmn.io/v1/callback","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Patient.u","userSessionStartedAt":"1751361276","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751361276","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://oauth.pstmn.io/v1/callback","code_challenge":"mg2mvf0xtOkfwH4H9NeFD5XyHDkCFKN7G_ONk51X2_k"}}	local	local	0
a7e32360-1142-49b4-a3b1-fae930c963f5	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1751366953	{"authMethod":"openid-connect","redirectUri":"https://www.facebook.com/","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs","userSessionStartedAt":"1751366952","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751366952","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://www.facebook.com/","code_challenge":"VtKKhO-HjMmE5maOVYoeUwZaPvgFNxM1V5QyZpyraqU"}}	local	local	0
6244d8f6-f5a9-44ee-bd16-530397471270	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1751449052	{"authMethod":"openid-connect","redirectUri":"https://www.facebook.com/","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs","userSessionStartedAt":"1751449052","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751449052","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://www.facebook.com/","code_challenge":"VtKKhO-HjMmE5maOVYoeUwZaPvgFNxM1V5QyZpyraqU"}}	local	local	0
04dd41b2-4059-40e0-926f-6e86cebaf5c3	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1751367238	{"authMethod":"openid-connect","redirectUri":"https://www.facebook.com/","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs","userSessionStartedAt":"1751367237","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751367237","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://www.facebook.com/","code_challenge":"VtKKhO-HjMmE5maOVYoeUwZaPvgFNxM1V5QyZpyraqU"}}	local	local	0
5b18f478-c29a-4090-b833-029a635476a1	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1751427106	{"authMethod":"openid-connect","redirectUri":"https://www.facebook.com/","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs","userSessionStartedAt":"1751427105","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751427105","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://www.facebook.com/","code_challenge":"VtKKhO-HjMmE5maOVYoeUwZaPvgFNxM1V5QyZpyraqU"}}	local	local	0
374a65c5-2e78-4d8f-b929-79858f06e35d	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1751429370	{"authMethod":"openid-connect","redirectUri":"https://www.facebook.com/","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs","userSessionStartedAt":"1751429370","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751429370","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://www.facebook.com/","code_challenge":"VtKKhO-HjMmE5maOVYoeUwZaPvgFNxM1V5QyZpyraqU"}}	local	local	0
0ae5e4e3-cc3d-417a-b5f0-4da815fbfad0	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1751431660	{"authMethod":"openid-connect","redirectUri":"https://oauth.pstmn.io/v1/callback","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Patient.u patient/Observation.u patient/Observation.c","userSessionStartedAt":"1751431658","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751431658","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://oauth.pstmn.io/v1/callback","code_challenge":"mg2mvf0xtOkfwH4H9NeFD5XyHDkCFKN7G_ONk51X2_k"}}	local	local	0
5f1bf262-68bc-4dbc-a720-d1add17d11d1	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1751452849	{"authMethod":"openid-connect","redirectUri":"https://oauth.pstmn.io/v1/callback","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Patient.u patient/Observation.u patient/Observation.c patient/*.*","userSessionStartedAt":"1751452848","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751452848","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://oauth.pstmn.io/v1/callback","code_challenge":"mg2mvf0xtOkfwH4H9NeFD5XyHDkCFKN7G_ONk51X2_k"}}	local	local	0
5e808741-5a44-4e20-91da-0d35196da507	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1751438416	{"authMethod":"openid-connect","redirectUri":"https://oauth.pstmn.io/v1/callback","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Patient.u patient/Observation.u patient/Observation.c","userSessionStartedAt":"1751438414","iss":"http://192.168.56.1:8080/realms/fhir-realm","startedAt":"1751438414","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://oauth.pstmn.io/v1/callback","code_challenge":"mg2mvf0xtOkfwH4H9NeFD5XyHDkCFKN7G_ONk51X2_k"}}	local	local	0
62bd1838-4fb3-4b8d-a278-b79af2e4d55d	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1752115866	{"authMethod":"openid-connect","redirectUri":"https://www.facebook.com/","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","userSessionRememberMe":"true","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs","iss":"http://192.168.56.1:8080/realms/fhir-realm","userSessionStartedAt":"1752115865","startedAt":"1752115865","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://www.facebook.com/","code_challenge":"VtKKhO-HjMmE5maOVYoeUwZaPvgFNxM1V5QyZpyraqU"}}	local	local	0
5abaf8dd-4535-4281-b6f6-78c1fd462244	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1753179220	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://host.docker.internal:8090/fhir","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753178406","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","client_request_param_launch":"123xyz","scope":"launch openid fhirUser offline_access user/*.*","SSO_AUTH":"true","userSessionStartedAt":"1753178406","redirect_uri":"http://localhost/custom/smart/redirect","state":"0dbc33ee-9921-4114-8bdc-6cf937b921cd","code_challenge":"7N0ZXQGQQUa0mspIv4a-Dol3WpYnwQ_P6xg50r-XHvU"}}	local	local	9
6d2d4f04-25b9-42b3-b0ab-249c03acf93a	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1753180773	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://host.docker.internal:8090/fhir","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753178858","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","client_request_param_launch":"123xyz","scope":"patient/*.* fhirUser offline_access launch","SSO_AUTH":"true","userSessionStartedAt":"1753178858","redirect_uri":"http://localhost/custom/smart/redirect","state":"5f7a4b81-2e03-4f98-95a2-6a5b48c8799d","code_challenge":"Vdgkg4fA4vezMIGU6WsNCKtL6nkfjBHymYo5Hsd9LLM"}}	local	local	10
1eb608c2-2b08-4379-85d0-fa5df6227457	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1753159775	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://host.docker.internal:8090/fhir","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753159326","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs","userSessionStartedAt":"1753159326","redirect_uri":"http://localhost/custom/smart/redirect","state":"a72faf12-2d8d-4b1f-b835-11e8b80d6c14","code_challenge":"VeVhd-15k6ZC2SEPnWbhh6k1T2baQoAMr4xgZujK1CA"}}	local	local	3
dc1006f5-4d64-469b-8c6b-afdf4b00866d	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1753159766	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://host.docker.internal:8090/fhir","userSessionRememberMe":"true","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753159760","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Coverage.rs patient/Specimen.rs patient/MedicationDispense.rs patient/ServiceRequest.rs","userSessionStartedAt":"1753159760","redirect_uri":"http://localhost/custom/smart/redirect","state":"f0227855-068d-4394-8091-fcd3313805ee","code_challenge":"l04Kjp2TGtEZXvJiumcBm-vcFWn5XpGISwRBrnzpj04"}}	local	local	0
d7942e67-8b18-4c44-a713-7c9f085994a4	d0e81265-5646-4d25-9bb0-c689a2a61478	1	1752825293	{"authMethod":"openid-connect","redirectUri":"https://inferno.healthit.gov/suites/custom/smart/redirect","notes":{"clientId":"d0e81265-5646-4d25-9bb0-c689a2a61478","client_request_param_aud":"https://fhir-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/fhir","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1752825290","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs","SSO_AUTH":"true","userSessionStartedAt":"1752823902","redirect_uri":"https://inferno.healthit.gov/suites/custom/smart/redirect","state":"e146b71c-342f-4e4c-b033-376b076267de","code_challenge":"x_dmxuAIvy1KWOg-lLSS5W4QV9k5WVNxGkIHJWX6NT4"}}	local	local	0
d7942e67-8b18-4c44-a713-7c9f085994a4	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1752828959	{"authMethod":"openid-connect","redirectUri":"https://inferno.healthit.gov/suites/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"https://fhir-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/fhir","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1752823902","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Coverage.rs patient/Specimen.rs patient/MedicationDispense.rs patient/ServiceRequest.rs","SSO_AUTH":"true","userSessionStartedAt":"1752823902","redirect_uri":"https://inferno.healthit.gov/suites/custom/smart/redirect","state":"1860b020-5c29-48ba-88e9-6c36b14fb104","code_challenge":"A65s5zwAmLRX083hRvm05kMxypJ_iRjcJo6G9MsZKDM"}}	local	local	9
291b18ba-efca-40fa-b7f9-3f20feb74089	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1753170316	{"authMethod":"openid-connect","redirectUri":"https://oauth.pstmn.io/v1/callback","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs","SSO_AUTH":"true","userSessionStartedAt":"1753169979","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753169979","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://oauth.pstmn.io/v1/callback","code_challenge":"_5mjn7J-UMoluq6t6DiJ32S-RjJj0P-eJua2Cufx64M"}}	local	local	0
08faf091-c19d-4e2b-a4ad-a5d58f378b8a	f36c6fd0-b46c-43d5-9413-0e462e191822	1	1753170572	{"authMethod":"openid-connect","redirectUri":"https://www.facebook.com","notes":{"clientId":"f36c6fd0-b46c-43d5-9413-0e462e191822","userSessionRememberMe":"true","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Coverage.rs patient/Specimen.rs patient/MedicationDispense.rs patient/ServiceRequest.rs","SSO_AUTH":"true","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","userSessionStartedAt":"1753166932","startedAt":"1753170556","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://www.facebook.com","code_challenge":"HrWV9wLWCBcDtroNJ9jPDcMzshCtgjVD0ALQSoDmZmM"}}	local	local	0
2492e801-b6bb-4c1e-a44b-943d094130a2	d0e81265-5646-4d25-9bb0-c689a2a61478	1	1753090338	{"authMethod":"openid-connect","redirectUri":"https://oauth.pstmn.io/v1/callback","notes":{"clientId":"d0e81265-5646-4d25-9bb0-c689a2a61478","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs","SSO_AUTH":"true","userSessionStartedAt":"1753083476","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753090336","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://oauth.pstmn.io/v1/callback","code_challenge":"2Yln7nM7dpxZx9-4zcBE0XJu43OxGuJfs-1-dfgRaPA"}}	local	local	0
291b18ba-efca-40fa-b7f9-3f20feb74089	d0e81265-5646-4d25-9bb0-c689a2a61478	1	1753171907	{"authMethod":"openid-connect","redirectUri":"https://oauth.pstmn.io/v1/callback","notes":{"clientId":"d0e81265-5646-4d25-9bb0-c689a2a61478","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs","SSO_AUTH":"true","userSessionStartedAt":"1753169979","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753171906","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://oauth.pstmn.io/v1/callback","code_challenge":"wpHpsTRjBGlRgzb2WwawYdW72QR9d0DOQcmd0Rg8wKA"}}	local	local	0
decb9b62-99a1-4754-aedb-ea294a146310	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1753160087	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://host.docker.internal:8090/fhir","userSessionRememberMe":"true","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753160069","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Coverage.rs patient/Specimen.rs patient/MedicationDispense.rs patient/ServiceRequest.rs","userSessionStartedAt":"1753160069","redirect_uri":"http://localhost/custom/smart/redirect","state":"a1776605-e31a-4e73-ac58-4d3b53a4c8fd","code_challenge":"TB0zKhZ8Taq8nsAlqlrcqZ6bbzHWVFhVZ9y4z4G4MAc"}}	local	local	2
e406c0a7-077a-41b1-a506-3ab7b1859177	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1752829125	{"authMethod":"openid-connect","redirectUri":"https://inferno.healthit.gov/suites/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"https://fhir-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/fhir","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1752829122","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","client_request_param_launch":"123xyz","scope":"launch openid fhirUser offline_access user/Medication.rs user/AllergyIntolerance.rs user/CarePlan.rs user/CareTeam.rs user/Condition.rs user/Device.rs user/DiagnosticReport.rs user/DocumentReference.rs user/Encounter.rs user/Goal.rs user/Immunization.rs user/Location.rs user/MedicationRequest.rs user/Observation.rs user/Organization.rs user/Patient.rs user/Practitioner.rs user/Procedure.rs user/Provenance.rs user/PractitionerRole.rs","userSessionStartedAt":"1752829122","redirect_uri":"https://inferno.healthit.gov/suites/custom/smart/redirect","state":"2e7f8883-07f7-47e6-be7b-da71ffeae193","code_challenge":"9w6vioGAOGUIf5HL7wNKSWX8-uURJjJBZ-jz2NVpUV4"}}	local	local	2
3eda3ed9-6ebb-42e4-98b3-22099dffebc5	d0e81265-5646-4d25-9bb0-c689a2a61478	1	1753080509	{"authMethod":"openid-connect","redirectUri":"https://oauth.pstmn.io/v1/callback","notes":{"clientId":"d0e81265-5646-4d25-9bb0-c689a2a61478","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs","SSO_AUTH":"true","userSessionStartedAt":"1753080285","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753080506","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"https://oauth.pstmn.io/v1/callback","code_challenge":"EKxl9J82unNhnQvz_0cv6E7vI1UfZrUNWYsvmanD5Yc"}}	local	local	0
fa87c1de-b600-413b-91c1-dbd18984f24f	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1753160330	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://host.docker.internal:8090/fhir","userSessionRememberMe":"true","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753160327","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","client_request_param_launch":"123xyz","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Coverage.rs patient/Specimen.rs patient/MedicationDispense.rs patient/ServiceRequest.rs","userSessionStartedAt":"1753160327","redirect_uri":"http://localhost/custom/smart/redirect","state":"109493aa-3128-470f-9e0a-b066b6396cde","code_challenge":"KRfXlCEci7vmEblRFFDNIACjG3QW8mU-0-z6y5A74ug"}}	local	local	0
c673fa49-1a3f-4e9a-b1ac-108c0c366226	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1753160578	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://host.docker.internal:8090/fhir","userSessionRememberMe":"true","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753160576","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","client_request_param_launch":"123xyz","scope":"launch/patient openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Coverage.rs patient/Specimen.rs patient/MedicationDispense.rs patient/ServiceRequest.rs","userSessionStartedAt":"1753160576","redirect_uri":"http://localhost/custom/smart/redirect","state":"9d4811ef-39b6-44f8-9286-40a42cac471d","code_challenge":"h12UERJrYSB_fh8Kh5wnbrPYxZcFR1bLYnvWqWGg2ck"}}	local	local	0
3e4fe512-4bf1-4215-833b-ab5402981500	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1753160644	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://host.docker.internal:8090/fhir","userSessionRememberMe":"true","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753160642","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","client_request_param_launch":"123xyz","scope":"launch openid fhirUser offline_access patient/Medication.rs patient/AllergyIntolerance.rs patient/CarePlan.rs patient/CareTeam.rs patient/Condition.rs patient/Device.rs patient/DiagnosticReport.rs patient/DocumentReference.rs patient/Encounter.rs patient/Goal.rs patient/Immunization.rs patient/Location.rs patient/MedicationRequest.rs patient/Observation.rs patient/Organization.rs patient/Patient.rs patient/Practitioner.rs patient/Procedure.rs patient/Provenance.rs patient/PractitionerRole.rs patient/Coverage.rs patient/Specimen.rs patient/MedicationDispense.rs patient/ServiceRequest.rs","userSessionStartedAt":"1753160642","redirect_uri":"http://localhost/custom/smart/redirect","state":"7381ab47-ba8c-4bdf-81ad-31cbb9c46787","code_challenge":"mqPyFfEN6VNPK5KRbJ0qXk_wi29DAPv3G5C4cHcF9ts"}}	local	local	0
c44b60af-0d0c-468f-9de8-5147d21f0403	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1753161123	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://host.docker.internal:8090/fhir","userSessionRememberMe":"true","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753161119","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","client_request_param_launch":"123xyz","scope":"launch openid fhirUser offline_access user/Medication.rs user/AllergyIntolerance.rs user/CarePlan.rs user/CareTeam.rs user/Condition.rs user/Device.rs user/DiagnosticReport.rs user/DocumentReference.rs user/Encounter.rs user/Goal.rs user/Immunization.rs user/Location.rs user/MedicationRequest.rs user/Observation.rs user/Organization.rs user/Patient.rs user/Practitioner.rs user/Procedure.rs user/Provenance.rs user/PractitionerRole.rs user/Coverage.rs user/Specimen.rs user/MedicationDispense.rs user/ServiceRequest.rs","userSessionStartedAt":"1753161119","redirect_uri":"http://localhost/custom/smart/redirect","state":"0963cf4d-4d5d-4767-8584-a6b563122e43","code_challenge":"SORZHakcuUo_Ov8b9IwTHGKzae9_3Yd0fbhly2z8ctY"}}	local	local	0
5a8d08d6-f371-4c78-afc2-669c3d4a5f9b	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1753162015	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://host.docker.internal:8090/fhir","userSessionRememberMe":"true","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753161992","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","client_request_param_launch":"123xyz","scope":"launch openid fhirUser offline_access user/Medication.rs user/AllergyIntolerance.rs user/CarePlan.rs user/CareTeam.rs user/Condition.rs user/Device.rs user/DiagnosticReport.rs user/DocumentReference.rs user/Encounter.rs user/Goal.rs user/Immunization.rs user/Location.rs user/MedicationRequest.rs user/Observation.rs user/Organization.rs user/Patient.rs user/Practitioner.rs user/Procedure.rs user/Provenance.rs user/PractitionerRole.rs user/Coverage.rs user/Specimen.rs user/MedicationDispense.rs user/ServiceRequest.rs","userSessionStartedAt":"1753161992","redirect_uri":"http://localhost/custom/smart/redirect","state":"bd005809-3d69-4143-b649-60529d486874","code_challenge":"Lgo7CPeEv6ZzBFSsSfuLikwB8ej0pgSmX4CmNUBUr5o"}}	local	local	2
feff661c-1cd0-4b3f-8df2-1a2a5f8ff83b	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1753178419	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://host.docker.internal:8090/fhir","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753178259","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","client_request_param_launch":"123xyz","scope":"launch openid fhirUser offline_access user/*.*","userSessionStartedAt":"1753178258","redirect_uri":"http://localhost/custom/smart/redirect","state":"ba1d3a2c-42cb-4be1-9557-80aae1f92337","code_challenge":"VFtZpUX4dAv_yyd6Ji_93cO5ZXl7aP1ZxUoNvpy39bw"}}	local	local	3
eb26fcac-ba2a-4648-924d-363d04a1b153	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1753176192	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","scope":"patient/*.* openid fhirUser offline_access","SSO_AUTH":"true","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","userSessionStartedAt":"1753174669","startedAt":"1753176167","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","redirect_uri":"http://localhost/custom/smart/redirect","state":"9c05de92-5119-4bfd-b4a2-1145ce31ea3e","code_challenge":"GLqYlGXhgeqsSmGHeIhl1RTlGQ0gB1SO2PpgRlPuUdA"}}	local	local	2
08faf091-c19d-4e2b-a4ad-a5d58f378b8a	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1753177226	{"authMethod":"openid-connect","redirectUri":"https://oauth.pstmn.io/v1/callback","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","userSessionRememberMe":"true","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753174446","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","scope":"patient/*.* openid fhirUser offline_access","SSO_AUTH":"true","userSessionStartedAt":"1753166932","redirect_uri":"https://oauth.pstmn.io/v1/callback","state":"c99cbe13254edf2e5098926248cc9ba4","code_challenge":"uCExikclHzTUJnDZtjBq4hiy3I56_j5bQRw4RwAvG_c"}}	local	local	2
00605d21-6e52-4059-b899-753e872d51da	d7f84708-6ae4-42ea-93d3-825c725f7d2c	1	1753178099	{"authMethod":"openid-connect","redirectUri":"http://localhost/custom/smart/redirect","notes":{"clientId":"d7f84708-6ae4-42ea-93d3-825c725f7d2c","client_request_param_aud":"http://host.docker.internal:8090/fhir","iss":"https://keycloak-server.gentlecliff-869c2758.centralus.azurecontainerapps.io/realms/fhir-realm","startedAt":"1753178082","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","client_request_param_launch":"123xyz","scope":"launch openid fhirUser offline_access user/*.*","userSessionStartedAt":"1753178082","redirect_uri":"http://localhost/custom/smart/redirect","state":"e4842cf8-7df0-4629-89ee-5bdb5f5cb978","code_challenge":"LxIipUGwGcHlWHJn9GRsracuq5D09QzIQDDgCopW4rE"}}	local	local	2
\.


--
-- TOC entry 4193 (class 0 OID 16607)
-- Dependencies: 261
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
62bd1838-4fb3-4b8d-a278-b79af2e4d55d	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1752115866	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFbGVjdHJvbi8zMi4zLjMiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1752115865","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1752115846,\\"0d9f4e20-d669-43f4-bc40-9f016ae780b5\\":1752115863}"},"state":"LOGGED_IN"}	1752115866	\N	0
5e808741-5a44-4e20-91da-0d35196da507	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751438416	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751438414","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751438414}"},"state":"LOGGED_IN"}	1751438416	\N	0
6125c687-d79c-4834-b9b4-581f8099ef5b	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751443742	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751443741","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751443741}"},"state":"LOGGED_IN"}	1751443742	\N	0
6244d8f6-f5a9-44ee-bd16-530397471270	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751449052	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFbGVjdHJvbi8zMi4zLjMiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751449052","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751449052}"},"state":"LOGGED_IN"}	1751449052	\N	0
5f1bf262-68bc-4dbc-a720-d1add17d11d1	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751452849	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751452848","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751452848}"},"state":"LOGGED_IN"}	1751452849	\N	0
3890f210-a3f6-41a2-a7a9-2de03d238d7c	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751359608	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751359607","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751359607}"},"state":"LOGGED_IN"}	1751359608	\N	0
5273319a-927a-4ddc-90cd-64afa38c2e53	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751359790	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFbGVjdHJvbi8zMi4zLjMiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751359789","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751359789}"},"state":"LOGGED_IN"}	1751359790	\N	0
c242cf2e-ba2e-4cd8-8edd-09a11a4ded1e	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751281441	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751279917","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751279917,\\"39dfd9a3-b6f2-4c0c-bff0-bf193292cf2e\\":1751281439}"},"state":"LOGGED_IN"}	1751281471	\N	2
24c1b825-27a7-4c78-8a82-5dc3f2f2a180	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751340778	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751338241","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751338241,\\"39dfd9a3-b6f2-4c0c-bff0-bf193292cf2e\\":1751340763}"},"state":"LOGGED_IN"}	1751340778	\N	0
0edb0830-8a89-43e9-b140-394c50482af1	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751359881	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751359880","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751359880}"},"state":"LOGGED_IN"}	1751359881	\N	0
c638370f-e3b6-4196-9ae2-6876b08651ee	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751361278	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751361276","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751361276}"},"state":"LOGGED_IN"}	1751361278	\N	0
5a8d08d6-f371-4c78-afc2-669c3d4a5f9b	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753161996	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753161992","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753161988,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753161992,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753161992}"},"state":"LOGGED_IN"}	1753162015	\N	2
a7e32360-1142-49b4-a3b1-fae930c963f5	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751366953	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFbGVjdHJvbi8zMi4zLjMiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751366952","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751366952}"},"state":"LOGGED_IN"}	1751366953	\N	0
04dd41b2-4059-40e0-926f-6e86cebaf5c3	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751367238	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFbGVjdHJvbi8zMi4zLjMiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751367237","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751367237}"},"state":"LOGGED_IN"}	1751367238	\N	0
5b18f478-c29a-4090-b833-029a635476a1	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751427106	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFbGVjdHJvbi8zMi4zLjMiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751427105","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751427104}"},"state":"LOGGED_IN"}	1751427106	\N	0
374a65c5-2e78-4d8f-b929-79858f06e35d	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751429370	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFbGVjdHJvbi8zMi4zLjMiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751429370","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751429370}"},"state":"LOGGED_IN"}	1751429370	\N	0
0ae5e4e3-cc3d-417a-b5f0-4da815fbfad0	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751431660	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751431658","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751431658}"},"state":"LOGGED_IN"}	1751431660	\N	0
eabcc3de-352a-4086-9674-1cabd8a1d517	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751443493	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751443491","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751443491}"},"state":"LOGGED_IN"}	1751443493	\N	0
dd41b32e-182e-42d1-aaf6-17eac0336aed	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1751448599	1	{"ipAddress":"192.168.56.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxOTIuMTY4LjU2LjEiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1751446471","authenticators-completed":"{\\"cfc11889-c826-496d-b3fc-955df7ff6bb6\\":1751446470,\\"39dfd9a3-b6f2-4c0c-bff0-bf193292cf2e\\":1751448597}"},"state":"LOGGED_IN"}	1751452777	\N	1
eb26fcac-ba2a-4648-924d-363d04a1b153	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753176176	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753174669","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753174664,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753174669,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753174669,\\"5f31ee06-ae57-4db9-b29f-6f1a5d28a42c\\":1753176173}"},"state":"LOGGED_IN"}	1753176192	\N	2
e406c0a7-077a-41b1-a506-3ab7b1859177	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1752829123	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM4LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1752829122","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1752829006,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1752829122,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1752829122}"},"state":"LOGGED_IN"}	1752829125	\N	2
2492e801-b6bb-4c1e-a44b-943d094130a2	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753090338	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753083476","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753083469,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753083476,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753083476,\\"5f31ee06-ae57-4db9-b29f-6f1a5d28a42c\\":1753090336}"},"state":"LOGGED_IN"}	1753090338	\N	0
3eda3ed9-6ebb-42e4-98b3-22099dffebc5	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753080509	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753080285","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753080279,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753080285,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753080285,\\"5f31ee06-ae57-4db9-b29f-6f1a5d28a42c\\":1753080506}"},"state":"LOGGED_IN"}	1753080509	\N	0
00605d21-6e52-4059-b899-753e872d51da	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753178084	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753178082","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753178077,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753178082,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753178082}"},"state":"LOGGED_IN"}	1753178099	\N	2
d7942e67-8b18-4c44-a713-7c9f085994a4	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1752824737	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1752823902","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1752823896,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1752823902,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1752823902,\\"5f31ee06-ae57-4db9-b29f-6f1a5d28a42c\\":1752824736}"},"state":"LOGGED_IN"}	1752828959	\N	22
dc1006f5-4d64-469b-8c6b-afdf4b00866d	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753159766	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753159760","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753159756,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753159760,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753159760}"},"state":"LOGGED_IN"}	1753159766	\N	0
1eb608c2-2b08-4379-85d0-fa5df6227457	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753159328	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753159326","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753159322,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753159326,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753159326}"},"state":"LOGGED_IN"}	1753159775	\N	3
decb9b62-99a1-4754-aedb-ea294a146310	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753160072	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753160069","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753160059,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753160065,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753160065}"},"state":"LOGGED_IN"}	1753160087	\N	2
fa87c1de-b600-413b-91c1-dbd18984f24f	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753160330	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753160327","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753160324,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753160327,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753160327}"},"state":"LOGGED_IN"}	1753160330	\N	0
c673fa49-1a3f-4e9a-b1ac-108c0c366226	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753160578	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753160576","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753160571,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753160576,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753160576}"},"state":"LOGGED_IN"}	1753160594	\N	2
3e4fe512-4bf1-4215-833b-ab5402981500	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753160644	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753160642","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753160627,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753160642,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753160642}"},"state":"LOGGED_IN"}	1753160828	\N	6
c44b60af-0d0c-468f-9de8-5147d21f0403	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753161123	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753161119","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753161113,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753161119,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753161119}"},"state":"LOGGED_IN"}	1753161140	\N	2
5abaf8dd-4535-4281-b6f6-78c1fd462244	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753178563	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753178406","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753178401,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753178406,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753178406,\\"5f31ee06-ae57-4db9-b29f-6f1a5d28a42c\\":1753178560}"},"state":"LOGGED_IN"}	1753179220	\N	11
6d2d4f04-25b9-42b3-b0ab-249c03acf93a	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753179702	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTM4LjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1753178858","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753178852,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753178858,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753178858,\\"5f31ee06-ae57-4db9-b29f-6f1a5d28a42c\\":1753179699}"},"state":"LOGGED_IN"}	1753180773	\N	15
291b18ba-efca-40fa-b7f9-3f20feb74089	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753170316	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFbGVjdHJvbi8zMi4zLjMiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753169979","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753169975,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753169979,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753169979,\\"5f31ee06-ae57-4db9-b29f-6f1a5d28a42c\\":1753170315}"},"state":"LOGGED_IN"}	1753171907	\N	2
08faf091-c19d-4e2b-a4ad-a5d58f378b8a	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753170572	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":true,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753166932","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753166927,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753166932,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753166932,\\"5f31ee06-ae57-4db9-b29f-6f1a5d28a42c\\":1753170556}"},"state":"LOGGED_IN"}	1753177722	\N	8
feff661c-1cd0-4b3f-8df2-1a2a5f8ff83b	f65b3829-5635-4b8a-898c-4b46b32c2316	041f8a3b-b936-410d-b423-b51f4cd23d7f	1753178262	1	{"ipAddress":"115.78.2.148","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTUuNzguMi4xNDgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJFZGdlLzEzOC4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1753178259","authenticators-completed":"{\\"45423120-af8f-4af1-af92-5d15342504dc\\":1753178250,\\"d1bcd55b-a674-46d8-a9c5-547862e4867c\\":1753178255,\\"daf1f006-490c-4abb-b16e-e3f743d0c6f7\\":1753178255}"},"state":"LOGGED_IN"}	1753178419	\N	3
\.


--
-- TOC entry 4194 (class 0 OID 16614)
-- Dependencies: 262
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- TOC entry 4195 (class 0 OID 16619)
-- Dependencies: 263
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- TOC entry 4196 (class 0 OID 16624)
-- Dependencies: 264
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- TOC entry 4197 (class 0 OID 16629)
-- Dependencies: 265
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
aca52d66-dc39-4079-9fcb-a8a7c2efc6b1	audience resolve	openid-connect	oidc-audience-resolve-mapper	d8fa8480-9e7f-4fc2-bec5-8479023566c5	\N
be240e64-b8d1-4843-9003-c32b198bf9de	locale	openid-connect	oidc-usermodel-attribute-mapper	767d4eee-87ba-42cc-a25d-0d904138f24f	\N
f84a5d84-f2a6-4b15-b0a4-c6694d35bee4	role list	saml	saml-role-list-mapper	\N	c5a655ce-c550-4608-9f85-819518464c45
ecb70b71-8b92-4e59-b8e3-39754f6ad2a6	organization	saml	saml-organization-membership-mapper	\N	6d6ce73e-3240-46a6-a155-566683389d24
4e177c87-8be5-4de3-b64e-5df0ac3c0303	full name	openid-connect	oidc-full-name-mapper	\N	9989de32-22d3-4753-8d69-655da8e53ada
c195d10f-ae13-4de8-a1af-3b4ebbe04d0b	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	9989de32-22d3-4753-8d69-655da8e53ada
71d98f65-f04b-464c-9e99-24b3666f7271	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	9989de32-22d3-4753-8d69-655da8e53ada
f052921b-ab7f-4249-8339-c70ba8364e36	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	9989de32-22d3-4753-8d69-655da8e53ada
abfc5401-9e1c-4590-9a42-f19ca9e88312	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	9989de32-22d3-4753-8d69-655da8e53ada
5efa532b-771c-42e3-bbb0-089c98260f9f	username	openid-connect	oidc-usermodel-attribute-mapper	\N	9989de32-22d3-4753-8d69-655da8e53ada
85e65dd6-082d-4b1e-a861-58a298c30b33	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	9989de32-22d3-4753-8d69-655da8e53ada
27c45ded-17aa-4c27-9f1c-7bb86a673e7e	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	9989de32-22d3-4753-8d69-655da8e53ada
92040ef7-5ab6-4d25-910c-537b9636856c	website	openid-connect	oidc-usermodel-attribute-mapper	\N	9989de32-22d3-4753-8d69-655da8e53ada
af4a9a7f-2f2d-40b7-a06e-d84e83a0536c	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	9989de32-22d3-4753-8d69-655da8e53ada
18ddeb26-414e-4686-b145-44a0c02062c6	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	9989de32-22d3-4753-8d69-655da8e53ada
1e54d0ab-a64a-4665-8a0d-4b64d93df3ab	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	9989de32-22d3-4753-8d69-655da8e53ada
2d7c69ab-be19-4339-93ac-e528e08542fc	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	9989de32-22d3-4753-8d69-655da8e53ada
e65cb8c8-1df7-43de-a4b4-b1a49c677d82	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	9989de32-22d3-4753-8d69-655da8e53ada
7d05ca67-92b9-44d6-9065-6724e445dcbc	email	openid-connect	oidc-usermodel-attribute-mapper	\N	c5786f6a-0780-49f4-9481-1c1381acf9cc
6640a0a9-1039-4be9-bdb1-661acc1041c9	email verified	openid-connect	oidc-usermodel-property-mapper	\N	c5786f6a-0780-49f4-9481-1c1381acf9cc
a48a913e-bedf-4bcd-b217-5b591e35e8d5	address	openid-connect	oidc-address-mapper	\N	a21eb8de-fb97-4e20-a427-8c3899be302d
2e43eb45-e89b-4845-be6f-3aa95554ed6c	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	aa9d5c9b-ea42-4a49-b554-fd32252f0886
27c3629f-8b4c-43f2-8818-5bb66f7dbd89	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	aa9d5c9b-ea42-4a49-b554-fd32252f0886
332545cc-800a-4d76-88ef-f56614b15167	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	3c0d71d0-b8f8-4a05-8943-67b65bb34bd7
089f625c-d917-4896-894d-7c520b0b2a7a	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	3c0d71d0-b8f8-4a05-8943-67b65bb34bd7
9bc6e0fe-b4ac-48c5-8a2f-7f56da05bbb6	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	3c0d71d0-b8f8-4a05-8943-67b65bb34bd7
09f2dcb8-9493-484a-8ef4-caa04d330197	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	e28c5545-1ed1-45b0-8a4e-ac79b7bb6cc6
95af420e-d48d-496b-81dd-8fce211598c1	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	f710ee27-621f-420a-8073-f774b62572e4
8a55d930-a3fa-43d1-aadd-7d2f9c928e6e	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	f710ee27-621f-420a-8073-f774b62572e4
e12f91b3-c09a-403b-a696-5fe9197d47f0	acr loa level	openid-connect	oidc-acr-mapper	\N	3456e0d7-ec64-4e6c-943d-b4d00b8e3ada
20a76be7-e80d-4652-b478-8bae00d994e5	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	bf7a58fc-2d5b-4385-a218-7c194679733a
f754abbe-94ab-4034-b42e-d4af8a4aa81e	sub	openid-connect	oidc-sub-mapper	\N	bf7a58fc-2d5b-4385-a218-7c194679733a
dc28a441-f4da-4341-a82a-e9c79961a6d6	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	6c33f453-f9bb-4503-a667-1c2f5a77c0b7
ffa64bb4-c19f-43f9-8617-c66a0cc19ae8	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	6c33f453-f9bb-4503-a667-1c2f5a77c0b7
cf257ffd-4eb4-4c3e-acf0-cc6878643289	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	6c33f453-f9bb-4503-a667-1c2f5a77c0b7
1a6c6b10-52e2-4182-9938-92a29c3268ad	organization	openid-connect	oidc-organization-membership-mapper	\N	e1c884bc-1acc-4801-b560-7b124a2012d3
0beb641e-6eff-4a69-8566-dbfd39dc9b7d	Client Type	openid-connect	oidc-hardcoded-claim-mapper	636672b6-143d-4bf2-ac14-e0feade63dc6	\N
6de7b35a-5d98-4978-87b7-07561b5fc961	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	56e2aae1-4467-433a-af4e-c01c216dfab0
12006855-065a-4159-a9a3-a8533091e044	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	56e2aae1-4467-433a-af4e-c01c216dfab0
cebd3eed-8b62-411f-8369-3e6cbdac45a9	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	56e2aae1-4467-433a-af4e-c01c216dfab0
834c343a-628f-47a2-a8c4-8e776aa36ea0	acr loa level	openid-connect	oidc-acr-mapper	\N	dd51ce28-2d93-40be-a20b-f7ed9fe5f6fe
8319d429-43e8-4f94-a202-47169b8894e6	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	196faef5-835f-4231-acb3-fcd3c661efa6
7ee45e29-017a-4685-be1c-ffdab37c43ec	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	196faef5-835f-4231-acb3-fcd3c661efa6
8a61d8c8-51bd-4fa0-a0a9-6dcf83336968	email verified	openid-connect	oidc-usermodel-property-mapper	\N	2f483427-27c2-4f28-99e2-a0f1f110d89a
e234ea4e-d049-4c5a-9555-ba07bc32d99d	email	openid-connect	oidc-usermodel-attribute-mapper	\N	2f483427-27c2-4f28-99e2-a0f1f110d89a
33a93bc2-debc-42d5-a48d-36da6b446143	role list	saml	saml-role-list-mapper	\N	231c88af-23ce-4090-b1e3-968b9dfb4458
5821842a-1d8b-4c26-9b7f-aa0f26f247e8	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2
f4daab6b-d4ba-43af-a586-1bcb1195c78f	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2
e39e2bd2-5e44-4f3b-a4a7-78f1a7bbb040	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2
6e439d00-e7fc-4711-bd87-2458c15a84e2	full name	openid-connect	oidc-full-name-mapper	\N	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2
1024dd9d-ab61-46e3-8498-f293ee8b3bfc	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2
8f075c90-c9c8-4d5d-9002-9ce50b4f0007	username	openid-connect	oidc-usermodel-attribute-mapper	\N	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2
b4a9b73d-eef8-4dd8-b09e-2be37371992f	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2
00dcc1b0-47ac-4ef7-a23a-1fdc9ac6a24c	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2
b39c4582-65be-41d9-8c9e-9cb06d0df9da	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2
c67f34b4-e629-4ba0-b0d0-92a814ebe68c	website	openid-connect	oidc-usermodel-attribute-mapper	\N	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2
7a7698a1-9d06-4a60-86c5-65327fb3244c	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2
7b18c8e5-3d75-42ed-9522-6e027e036237	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2
fc6351ce-73df-44c0-a485-dbeab3be5506	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2
1075e9c0-592b-4509-a0f5-feb728395e6e	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	55b8cc78-509f-4c9d-844c-83b5c2e5cdc2
d2d46a1d-ca5a-4b5a-9d10-58d2e1f2cbfc	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	e02a4651-1176-4678-b9a2-80876e2dc2f2
1e9c6b46-2d81-4229-aff1-82fbcadd822e	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	e02a4651-1176-4678-b9a2-80876e2dc2f2
bf0e7c10-2024-4329-883a-11745d48291c	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	e02a4651-1176-4678-b9a2-80876e2dc2f2
691e2388-2328-4615-ba84-4e70162e0217	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	8bc27fbd-cbf6-4fe7-800c-4a6674b1e644
75012dbc-0dce-4da8-a2de-8b167b3d3998	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	2866ff77-6d11-4076-88b3-47ab819d4685
274d3661-e07e-43c3-9d43-750f09d6ef98	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	2866ff77-6d11-4076-88b3-47ab819d4685
f38ae2c0-2b3f-4971-9f59-d2a735c65f26	Add patient id to Token	openid-connect	oidc-usermodel-attribute-mapper	\N	c9469db6-d939-496e-bf11-02e2750f8a0c
26f9f57a-efdd-481b-b23a-2a805389f1cf	sub	openid-connect	oidc-sub-mapper	\N	90374560-2ca4-456d-8801-98ac06c8b0f5
ea1b09b7-0aba-4483-aae2-1a65b258eb60	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	90374560-2ca4-456d-8801-98ac06c8b0f5
dba6df56-93f2-4ec9-b261-43e1fae29a0f	address	openid-connect	oidc-address-mapper	\N	d8e8fea8-e7f0-4867-8823-665cf98b3150
e9f92a1a-7351-440f-9971-28d3292ef6b8	organization	openid-connect	oidc-organization-membership-mapper	\N	3629ba2b-2071-403a-8d48-c56bf7e287f6
65b61580-8db9-48f0-bde2-4e8a3335ec39	organization	saml	saml-organization-membership-mapper	\N	97dd5dc6-1099-4d37-9333-cb96f8f84ff3
09f8c7f0-b058-4e24-bfc4-31bbdc1b2fa1	audience resolve	openid-connect	oidc-audience-resolve-mapper	a7143ea8-7fcd-40a5-9b15-f417b9648c00	\N
55af775b-6cec-417e-b9d7-652bf3036a72	Add patient id to Token from dedicated scopes	openid-connect	oidc-usermodel-attribute-mapper	f36c6fd0-b46c-43d5-9413-0e462e191822	\N
bb8b325f-5694-47af-85e2-7977b15684b8	Client Type	openid-connect	oidc-hardcoded-claim-mapper	f36c6fd0-b46c-43d5-9413-0e462e191822	\N
954fefc8-e52a-44aa-a630-1d90f90451d4	Client Type	openid-connect	oidc-hardcoded-claim-mapper	d7f84708-6ae4-42ea-93d3-825c725f7d2c	\N
4b4c4d6e-8f75-4e0f-bebc-3a0c25d7d144	patient-id	openid-connect	oidc-usermodel-attribute-mapper	d7f84708-6ae4-42ea-93d3-825c725f7d2c	\N
f476a12c-e8b9-428d-92ee-3cf5de0e3bbe	patient-id	openid-connect	oidc-usermodel-attribute-mapper	d0e81265-5646-4d25-9bb0-c689a2a61478	\N
a2731f87-9ac0-4d5f-a2f2-59e0cead1e5e	Client Type	openid-connect	oidc-hardcoded-claim-mapper	d0e81265-5646-4d25-9bb0-c689a2a61478	\N
af981690-7e3c-471a-b6a4-c934cf4d38ee	locale	openid-connect	oidc-usermodel-attribute-mapper	8c1a8594-ee37-49ad-9bc5-6db27db6a544	\N
\.


--
-- TOC entry 4198 (class 0 OID 16634)
-- Dependencies: 266
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
be240e64-b8d1-4843-9003-c32b198bf9de	true	introspection.token.claim
be240e64-b8d1-4843-9003-c32b198bf9de	true	userinfo.token.claim
be240e64-b8d1-4843-9003-c32b198bf9de	locale	user.attribute
be240e64-b8d1-4843-9003-c32b198bf9de	true	id.token.claim
be240e64-b8d1-4843-9003-c32b198bf9de	true	access.token.claim
be240e64-b8d1-4843-9003-c32b198bf9de	locale	claim.name
be240e64-b8d1-4843-9003-c32b198bf9de	String	jsonType.label
f84a5d84-f2a6-4b15-b0a4-c6694d35bee4	false	single
f84a5d84-f2a6-4b15-b0a4-c6694d35bee4	Basic	attribute.nameformat
f84a5d84-f2a6-4b15-b0a4-c6694d35bee4	Role	attribute.name
18ddeb26-414e-4686-b145-44a0c02062c6	true	introspection.token.claim
18ddeb26-414e-4686-b145-44a0c02062c6	true	userinfo.token.claim
18ddeb26-414e-4686-b145-44a0c02062c6	birthdate	user.attribute
18ddeb26-414e-4686-b145-44a0c02062c6	true	id.token.claim
18ddeb26-414e-4686-b145-44a0c02062c6	true	access.token.claim
18ddeb26-414e-4686-b145-44a0c02062c6	birthdate	claim.name
18ddeb26-414e-4686-b145-44a0c02062c6	String	jsonType.label
1e54d0ab-a64a-4665-8a0d-4b64d93df3ab	true	introspection.token.claim
1e54d0ab-a64a-4665-8a0d-4b64d93df3ab	true	userinfo.token.claim
1e54d0ab-a64a-4665-8a0d-4b64d93df3ab	zoneinfo	user.attribute
1e54d0ab-a64a-4665-8a0d-4b64d93df3ab	true	id.token.claim
1e54d0ab-a64a-4665-8a0d-4b64d93df3ab	true	access.token.claim
1e54d0ab-a64a-4665-8a0d-4b64d93df3ab	zoneinfo	claim.name
1e54d0ab-a64a-4665-8a0d-4b64d93df3ab	String	jsonType.label
27c45ded-17aa-4c27-9f1c-7bb86a673e7e	true	introspection.token.claim
27c45ded-17aa-4c27-9f1c-7bb86a673e7e	true	userinfo.token.claim
27c45ded-17aa-4c27-9f1c-7bb86a673e7e	picture	user.attribute
27c45ded-17aa-4c27-9f1c-7bb86a673e7e	true	id.token.claim
27c45ded-17aa-4c27-9f1c-7bb86a673e7e	true	access.token.claim
27c45ded-17aa-4c27-9f1c-7bb86a673e7e	picture	claim.name
27c45ded-17aa-4c27-9f1c-7bb86a673e7e	String	jsonType.label
2d7c69ab-be19-4339-93ac-e528e08542fc	true	introspection.token.claim
2d7c69ab-be19-4339-93ac-e528e08542fc	true	userinfo.token.claim
2d7c69ab-be19-4339-93ac-e528e08542fc	locale	user.attribute
2d7c69ab-be19-4339-93ac-e528e08542fc	true	id.token.claim
2d7c69ab-be19-4339-93ac-e528e08542fc	true	access.token.claim
2d7c69ab-be19-4339-93ac-e528e08542fc	locale	claim.name
2d7c69ab-be19-4339-93ac-e528e08542fc	String	jsonType.label
4e177c87-8be5-4de3-b64e-5df0ac3c0303	true	introspection.token.claim
4e177c87-8be5-4de3-b64e-5df0ac3c0303	true	userinfo.token.claim
4e177c87-8be5-4de3-b64e-5df0ac3c0303	true	id.token.claim
4e177c87-8be5-4de3-b64e-5df0ac3c0303	true	access.token.claim
5efa532b-771c-42e3-bbb0-089c98260f9f	true	introspection.token.claim
5efa532b-771c-42e3-bbb0-089c98260f9f	true	userinfo.token.claim
5efa532b-771c-42e3-bbb0-089c98260f9f	username	user.attribute
5efa532b-771c-42e3-bbb0-089c98260f9f	true	id.token.claim
5efa532b-771c-42e3-bbb0-089c98260f9f	true	access.token.claim
5efa532b-771c-42e3-bbb0-089c98260f9f	preferred_username	claim.name
5efa532b-771c-42e3-bbb0-089c98260f9f	String	jsonType.label
71d98f65-f04b-464c-9e99-24b3666f7271	true	introspection.token.claim
71d98f65-f04b-464c-9e99-24b3666f7271	true	userinfo.token.claim
71d98f65-f04b-464c-9e99-24b3666f7271	firstName	user.attribute
71d98f65-f04b-464c-9e99-24b3666f7271	true	id.token.claim
71d98f65-f04b-464c-9e99-24b3666f7271	true	access.token.claim
71d98f65-f04b-464c-9e99-24b3666f7271	given_name	claim.name
71d98f65-f04b-464c-9e99-24b3666f7271	String	jsonType.label
85e65dd6-082d-4b1e-a861-58a298c30b33	true	introspection.token.claim
85e65dd6-082d-4b1e-a861-58a298c30b33	true	userinfo.token.claim
85e65dd6-082d-4b1e-a861-58a298c30b33	profile	user.attribute
85e65dd6-082d-4b1e-a861-58a298c30b33	true	id.token.claim
85e65dd6-082d-4b1e-a861-58a298c30b33	true	access.token.claim
85e65dd6-082d-4b1e-a861-58a298c30b33	profile	claim.name
85e65dd6-082d-4b1e-a861-58a298c30b33	String	jsonType.label
92040ef7-5ab6-4d25-910c-537b9636856c	true	introspection.token.claim
92040ef7-5ab6-4d25-910c-537b9636856c	true	userinfo.token.claim
92040ef7-5ab6-4d25-910c-537b9636856c	website	user.attribute
92040ef7-5ab6-4d25-910c-537b9636856c	true	id.token.claim
92040ef7-5ab6-4d25-910c-537b9636856c	true	access.token.claim
92040ef7-5ab6-4d25-910c-537b9636856c	website	claim.name
92040ef7-5ab6-4d25-910c-537b9636856c	String	jsonType.label
abfc5401-9e1c-4590-9a42-f19ca9e88312	true	introspection.token.claim
abfc5401-9e1c-4590-9a42-f19ca9e88312	true	userinfo.token.claim
abfc5401-9e1c-4590-9a42-f19ca9e88312	nickname	user.attribute
abfc5401-9e1c-4590-9a42-f19ca9e88312	true	id.token.claim
abfc5401-9e1c-4590-9a42-f19ca9e88312	true	access.token.claim
abfc5401-9e1c-4590-9a42-f19ca9e88312	nickname	claim.name
abfc5401-9e1c-4590-9a42-f19ca9e88312	String	jsonType.label
af4a9a7f-2f2d-40b7-a06e-d84e83a0536c	true	introspection.token.claim
af4a9a7f-2f2d-40b7-a06e-d84e83a0536c	true	userinfo.token.claim
af4a9a7f-2f2d-40b7-a06e-d84e83a0536c	gender	user.attribute
af4a9a7f-2f2d-40b7-a06e-d84e83a0536c	true	id.token.claim
af4a9a7f-2f2d-40b7-a06e-d84e83a0536c	true	access.token.claim
af4a9a7f-2f2d-40b7-a06e-d84e83a0536c	gender	claim.name
af4a9a7f-2f2d-40b7-a06e-d84e83a0536c	String	jsonType.label
c195d10f-ae13-4de8-a1af-3b4ebbe04d0b	true	introspection.token.claim
c195d10f-ae13-4de8-a1af-3b4ebbe04d0b	true	userinfo.token.claim
c195d10f-ae13-4de8-a1af-3b4ebbe04d0b	lastName	user.attribute
c195d10f-ae13-4de8-a1af-3b4ebbe04d0b	true	id.token.claim
c195d10f-ae13-4de8-a1af-3b4ebbe04d0b	true	access.token.claim
c195d10f-ae13-4de8-a1af-3b4ebbe04d0b	family_name	claim.name
c195d10f-ae13-4de8-a1af-3b4ebbe04d0b	String	jsonType.label
e65cb8c8-1df7-43de-a4b4-b1a49c677d82	true	introspection.token.claim
e65cb8c8-1df7-43de-a4b4-b1a49c677d82	true	userinfo.token.claim
e65cb8c8-1df7-43de-a4b4-b1a49c677d82	updatedAt	user.attribute
e65cb8c8-1df7-43de-a4b4-b1a49c677d82	true	id.token.claim
e65cb8c8-1df7-43de-a4b4-b1a49c677d82	true	access.token.claim
e65cb8c8-1df7-43de-a4b4-b1a49c677d82	updated_at	claim.name
e65cb8c8-1df7-43de-a4b4-b1a49c677d82	long	jsonType.label
f052921b-ab7f-4249-8339-c70ba8364e36	true	introspection.token.claim
f052921b-ab7f-4249-8339-c70ba8364e36	true	userinfo.token.claim
f052921b-ab7f-4249-8339-c70ba8364e36	middleName	user.attribute
f052921b-ab7f-4249-8339-c70ba8364e36	true	id.token.claim
f052921b-ab7f-4249-8339-c70ba8364e36	true	access.token.claim
f052921b-ab7f-4249-8339-c70ba8364e36	middle_name	claim.name
f052921b-ab7f-4249-8339-c70ba8364e36	String	jsonType.label
6640a0a9-1039-4be9-bdb1-661acc1041c9	true	introspection.token.claim
6640a0a9-1039-4be9-bdb1-661acc1041c9	true	userinfo.token.claim
6640a0a9-1039-4be9-bdb1-661acc1041c9	emailVerified	user.attribute
6640a0a9-1039-4be9-bdb1-661acc1041c9	true	id.token.claim
6640a0a9-1039-4be9-bdb1-661acc1041c9	true	access.token.claim
6640a0a9-1039-4be9-bdb1-661acc1041c9	email_verified	claim.name
6640a0a9-1039-4be9-bdb1-661acc1041c9	boolean	jsonType.label
7d05ca67-92b9-44d6-9065-6724e445dcbc	true	introspection.token.claim
7d05ca67-92b9-44d6-9065-6724e445dcbc	true	userinfo.token.claim
7d05ca67-92b9-44d6-9065-6724e445dcbc	email	user.attribute
7d05ca67-92b9-44d6-9065-6724e445dcbc	true	id.token.claim
7d05ca67-92b9-44d6-9065-6724e445dcbc	true	access.token.claim
7d05ca67-92b9-44d6-9065-6724e445dcbc	email	claim.name
7d05ca67-92b9-44d6-9065-6724e445dcbc	String	jsonType.label
a48a913e-bedf-4bcd-b217-5b591e35e8d5	formatted	user.attribute.formatted
a48a913e-bedf-4bcd-b217-5b591e35e8d5	country	user.attribute.country
a48a913e-bedf-4bcd-b217-5b591e35e8d5	true	introspection.token.claim
a48a913e-bedf-4bcd-b217-5b591e35e8d5	postal_code	user.attribute.postal_code
a48a913e-bedf-4bcd-b217-5b591e35e8d5	true	userinfo.token.claim
a48a913e-bedf-4bcd-b217-5b591e35e8d5	street	user.attribute.street
a48a913e-bedf-4bcd-b217-5b591e35e8d5	true	id.token.claim
a48a913e-bedf-4bcd-b217-5b591e35e8d5	region	user.attribute.region
a48a913e-bedf-4bcd-b217-5b591e35e8d5	true	access.token.claim
a48a913e-bedf-4bcd-b217-5b591e35e8d5	locality	user.attribute.locality
27c3629f-8b4c-43f2-8818-5bb66f7dbd89	true	introspection.token.claim
27c3629f-8b4c-43f2-8818-5bb66f7dbd89	true	userinfo.token.claim
27c3629f-8b4c-43f2-8818-5bb66f7dbd89	phoneNumberVerified	user.attribute
27c3629f-8b4c-43f2-8818-5bb66f7dbd89	true	id.token.claim
27c3629f-8b4c-43f2-8818-5bb66f7dbd89	true	access.token.claim
27c3629f-8b4c-43f2-8818-5bb66f7dbd89	phone_number_verified	claim.name
27c3629f-8b4c-43f2-8818-5bb66f7dbd89	boolean	jsonType.label
2e43eb45-e89b-4845-be6f-3aa95554ed6c	true	introspection.token.claim
2e43eb45-e89b-4845-be6f-3aa95554ed6c	true	userinfo.token.claim
2e43eb45-e89b-4845-be6f-3aa95554ed6c	phoneNumber	user.attribute
2e43eb45-e89b-4845-be6f-3aa95554ed6c	true	id.token.claim
2e43eb45-e89b-4845-be6f-3aa95554ed6c	true	access.token.claim
2e43eb45-e89b-4845-be6f-3aa95554ed6c	phone_number	claim.name
2e43eb45-e89b-4845-be6f-3aa95554ed6c	String	jsonType.label
089f625c-d917-4896-894d-7c520b0b2a7a	true	introspection.token.claim
089f625c-d917-4896-894d-7c520b0b2a7a	true	multivalued
089f625c-d917-4896-894d-7c520b0b2a7a	foo	user.attribute
089f625c-d917-4896-894d-7c520b0b2a7a	true	access.token.claim
089f625c-d917-4896-894d-7c520b0b2a7a	resource_access.${client_id}.roles	claim.name
089f625c-d917-4896-894d-7c520b0b2a7a	String	jsonType.label
332545cc-800a-4d76-88ef-f56614b15167	true	introspection.token.claim
332545cc-800a-4d76-88ef-f56614b15167	true	multivalued
332545cc-800a-4d76-88ef-f56614b15167	foo	user.attribute
332545cc-800a-4d76-88ef-f56614b15167	true	access.token.claim
332545cc-800a-4d76-88ef-f56614b15167	realm_access.roles	claim.name
332545cc-800a-4d76-88ef-f56614b15167	String	jsonType.label
9bc6e0fe-b4ac-48c5-8a2f-7f56da05bbb6	true	introspection.token.claim
9bc6e0fe-b4ac-48c5-8a2f-7f56da05bbb6	true	access.token.claim
09f2dcb8-9493-484a-8ef4-caa04d330197	true	introspection.token.claim
09f2dcb8-9493-484a-8ef4-caa04d330197	true	access.token.claim
8a55d930-a3fa-43d1-aadd-7d2f9c928e6e	true	introspection.token.claim
8a55d930-a3fa-43d1-aadd-7d2f9c928e6e	true	multivalued
8a55d930-a3fa-43d1-aadd-7d2f9c928e6e	foo	user.attribute
8a55d930-a3fa-43d1-aadd-7d2f9c928e6e	true	id.token.claim
8a55d930-a3fa-43d1-aadd-7d2f9c928e6e	true	access.token.claim
8a55d930-a3fa-43d1-aadd-7d2f9c928e6e	groups	claim.name
8a55d930-a3fa-43d1-aadd-7d2f9c928e6e	String	jsonType.label
95af420e-d48d-496b-81dd-8fce211598c1	true	introspection.token.claim
95af420e-d48d-496b-81dd-8fce211598c1	true	userinfo.token.claim
95af420e-d48d-496b-81dd-8fce211598c1	username	user.attribute
95af420e-d48d-496b-81dd-8fce211598c1	true	id.token.claim
95af420e-d48d-496b-81dd-8fce211598c1	true	access.token.claim
95af420e-d48d-496b-81dd-8fce211598c1	upn	claim.name
95af420e-d48d-496b-81dd-8fce211598c1	String	jsonType.label
e12f91b3-c09a-403b-a696-5fe9197d47f0	true	introspection.token.claim
e12f91b3-c09a-403b-a696-5fe9197d47f0	true	id.token.claim
e12f91b3-c09a-403b-a696-5fe9197d47f0	true	access.token.claim
20a76be7-e80d-4652-b478-8bae00d994e5	AUTH_TIME	user.session.note
20a76be7-e80d-4652-b478-8bae00d994e5	true	introspection.token.claim
20a76be7-e80d-4652-b478-8bae00d994e5	true	id.token.claim
20a76be7-e80d-4652-b478-8bae00d994e5	true	access.token.claim
20a76be7-e80d-4652-b478-8bae00d994e5	auth_time	claim.name
20a76be7-e80d-4652-b478-8bae00d994e5	long	jsonType.label
f754abbe-94ab-4034-b42e-d4af8a4aa81e	true	introspection.token.claim
f754abbe-94ab-4034-b42e-d4af8a4aa81e	true	access.token.claim
cf257ffd-4eb4-4c3e-acf0-cc6878643289	clientAddress	user.session.note
cf257ffd-4eb4-4c3e-acf0-cc6878643289	true	introspection.token.claim
cf257ffd-4eb4-4c3e-acf0-cc6878643289	true	id.token.claim
cf257ffd-4eb4-4c3e-acf0-cc6878643289	true	access.token.claim
cf257ffd-4eb4-4c3e-acf0-cc6878643289	clientAddress	claim.name
cf257ffd-4eb4-4c3e-acf0-cc6878643289	String	jsonType.label
dc28a441-f4da-4341-a82a-e9c79961a6d6	client_id	user.session.note
dc28a441-f4da-4341-a82a-e9c79961a6d6	true	introspection.token.claim
dc28a441-f4da-4341-a82a-e9c79961a6d6	true	id.token.claim
dc28a441-f4da-4341-a82a-e9c79961a6d6	true	access.token.claim
dc28a441-f4da-4341-a82a-e9c79961a6d6	client_id	claim.name
dc28a441-f4da-4341-a82a-e9c79961a6d6	String	jsonType.label
ffa64bb4-c19f-43f9-8617-c66a0cc19ae8	clientHost	user.session.note
ffa64bb4-c19f-43f9-8617-c66a0cc19ae8	true	introspection.token.claim
ffa64bb4-c19f-43f9-8617-c66a0cc19ae8	true	id.token.claim
ffa64bb4-c19f-43f9-8617-c66a0cc19ae8	true	access.token.claim
ffa64bb4-c19f-43f9-8617-c66a0cc19ae8	clientHost	claim.name
ffa64bb4-c19f-43f9-8617-c66a0cc19ae8	String	jsonType.label
1a6c6b10-52e2-4182-9938-92a29c3268ad	true	introspection.token.claim
1a6c6b10-52e2-4182-9938-92a29c3268ad	true	multivalued
1a6c6b10-52e2-4182-9938-92a29c3268ad	true	id.token.claim
1a6c6b10-52e2-4182-9938-92a29c3268ad	true	access.token.claim
1a6c6b10-52e2-4182-9938-92a29c3268ad	organization	claim.name
1a6c6b10-52e2-4182-9938-92a29c3268ad	String	jsonType.label
12006855-065a-4159-a9a3-a8533091e044	clientAddress	user.session.note
12006855-065a-4159-a9a3-a8533091e044	true	id.token.claim
12006855-065a-4159-a9a3-a8533091e044	true	introspection.token.claim
12006855-065a-4159-a9a3-a8533091e044	true	access.token.claim
12006855-065a-4159-a9a3-a8533091e044	clientAddress	claim.name
12006855-065a-4159-a9a3-a8533091e044	String	jsonType.label
6de7b35a-5d98-4978-87b7-07561b5fc961	client_id	user.session.note
6de7b35a-5d98-4978-87b7-07561b5fc961	true	introspection.token.claim
6de7b35a-5d98-4978-87b7-07561b5fc961	true	userinfo.token.claim
6de7b35a-5d98-4978-87b7-07561b5fc961	true	id.token.claim
6de7b35a-5d98-4978-87b7-07561b5fc961	true	access.token.claim
6de7b35a-5d98-4978-87b7-07561b5fc961	client_id	claim.name
6de7b35a-5d98-4978-87b7-07561b5fc961	String	jsonType.label
cebd3eed-8b62-411f-8369-3e6cbdac45a9	clientHost	user.session.note
cebd3eed-8b62-411f-8369-3e6cbdac45a9	true	id.token.claim
cebd3eed-8b62-411f-8369-3e6cbdac45a9	true	introspection.token.claim
cebd3eed-8b62-411f-8369-3e6cbdac45a9	true	access.token.claim
cebd3eed-8b62-411f-8369-3e6cbdac45a9	clientHost	claim.name
cebd3eed-8b62-411f-8369-3e6cbdac45a9	String	jsonType.label
12006855-065a-4159-a9a3-a8533091e044	true	userinfo.token.claim
cebd3eed-8b62-411f-8369-3e6cbdac45a9	true	userinfo.token.claim
834c343a-628f-47a2-a8c4-8e776aa36ea0	true	id.token.claim
834c343a-628f-47a2-a8c4-8e776aa36ea0	true	introspection.token.claim
834c343a-628f-47a2-a8c4-8e776aa36ea0	true	access.token.claim
834c343a-628f-47a2-a8c4-8e776aa36ea0	true	userinfo.token.claim
7ee45e29-017a-4685-be1c-ffdab37c43ec	true	introspection.token.claim
7ee45e29-017a-4685-be1c-ffdab37c43ec	true	userinfo.token.claim
7ee45e29-017a-4685-be1c-ffdab37c43ec	phoneNumberVerified	user.attribute
7ee45e29-017a-4685-be1c-ffdab37c43ec	true	id.token.claim
7ee45e29-017a-4685-be1c-ffdab37c43ec	true	access.token.claim
7ee45e29-017a-4685-be1c-ffdab37c43ec	phone_number_verified	claim.name
7ee45e29-017a-4685-be1c-ffdab37c43ec	boolean	jsonType.label
8319d429-43e8-4f94-a202-47169b8894e6	true	introspection.token.claim
8319d429-43e8-4f94-a202-47169b8894e6	true	userinfo.token.claim
8319d429-43e8-4f94-a202-47169b8894e6	phoneNumber	user.attribute
8319d429-43e8-4f94-a202-47169b8894e6	true	id.token.claim
8319d429-43e8-4f94-a202-47169b8894e6	true	access.token.claim
8319d429-43e8-4f94-a202-47169b8894e6	phone_number	claim.name
8319d429-43e8-4f94-a202-47169b8894e6	String	jsonType.label
8a61d8c8-51bd-4fa0-a0a9-6dcf83336968	true	introspection.token.claim
8a61d8c8-51bd-4fa0-a0a9-6dcf83336968	true	userinfo.token.claim
8a61d8c8-51bd-4fa0-a0a9-6dcf83336968	emailVerified	user.attribute
8a61d8c8-51bd-4fa0-a0a9-6dcf83336968	true	id.token.claim
8a61d8c8-51bd-4fa0-a0a9-6dcf83336968	true	access.token.claim
8a61d8c8-51bd-4fa0-a0a9-6dcf83336968	email_verified	claim.name
8a61d8c8-51bd-4fa0-a0a9-6dcf83336968	boolean	jsonType.label
e234ea4e-d049-4c5a-9555-ba07bc32d99d	true	introspection.token.claim
e234ea4e-d049-4c5a-9555-ba07bc32d99d	true	userinfo.token.claim
e234ea4e-d049-4c5a-9555-ba07bc32d99d	email	user.attribute
e234ea4e-d049-4c5a-9555-ba07bc32d99d	true	id.token.claim
e234ea4e-d049-4c5a-9555-ba07bc32d99d	true	access.token.claim
e234ea4e-d049-4c5a-9555-ba07bc32d99d	email	claim.name
e234ea4e-d049-4c5a-9555-ba07bc32d99d	String	jsonType.label
33a93bc2-debc-42d5-a48d-36da6b446143	false	single
33a93bc2-debc-42d5-a48d-36da6b446143	Basic	attribute.nameformat
33a93bc2-debc-42d5-a48d-36da6b446143	Role	attribute.name
00dcc1b0-47ac-4ef7-a23a-1fdc9ac6a24c	true	introspection.token.claim
00dcc1b0-47ac-4ef7-a23a-1fdc9ac6a24c	true	userinfo.token.claim
00dcc1b0-47ac-4ef7-a23a-1fdc9ac6a24c	firstName	user.attribute
00dcc1b0-47ac-4ef7-a23a-1fdc9ac6a24c	true	id.token.claim
00dcc1b0-47ac-4ef7-a23a-1fdc9ac6a24c	true	access.token.claim
00dcc1b0-47ac-4ef7-a23a-1fdc9ac6a24c	given_name	claim.name
00dcc1b0-47ac-4ef7-a23a-1fdc9ac6a24c	String	jsonType.label
1024dd9d-ab61-46e3-8498-f293ee8b3bfc	true	introspection.token.claim
1024dd9d-ab61-46e3-8498-f293ee8b3bfc	true	userinfo.token.claim
1024dd9d-ab61-46e3-8498-f293ee8b3bfc	picture	user.attribute
1024dd9d-ab61-46e3-8498-f293ee8b3bfc	true	id.token.claim
1024dd9d-ab61-46e3-8498-f293ee8b3bfc	true	access.token.claim
1024dd9d-ab61-46e3-8498-f293ee8b3bfc	picture	claim.name
1024dd9d-ab61-46e3-8498-f293ee8b3bfc	String	jsonType.label
1075e9c0-592b-4509-a0f5-feb728395e6e	true	introspection.token.claim
1075e9c0-592b-4509-a0f5-feb728395e6e	true	userinfo.token.claim
1075e9c0-592b-4509-a0f5-feb728395e6e	profile	user.attribute
1075e9c0-592b-4509-a0f5-feb728395e6e	true	id.token.claim
1075e9c0-592b-4509-a0f5-feb728395e6e	true	access.token.claim
1075e9c0-592b-4509-a0f5-feb728395e6e	profile	claim.name
1075e9c0-592b-4509-a0f5-feb728395e6e	String	jsonType.label
5821842a-1d8b-4c26-9b7f-aa0f26f247e8	true	introspection.token.claim
5821842a-1d8b-4c26-9b7f-aa0f26f247e8	true	userinfo.token.claim
5821842a-1d8b-4c26-9b7f-aa0f26f247e8	gender	user.attribute
5821842a-1d8b-4c26-9b7f-aa0f26f247e8	true	id.token.claim
5821842a-1d8b-4c26-9b7f-aa0f26f247e8	true	access.token.claim
5821842a-1d8b-4c26-9b7f-aa0f26f247e8	gender	claim.name
5821842a-1d8b-4c26-9b7f-aa0f26f247e8	String	jsonType.label
6e439d00-e7fc-4711-bd87-2458c15a84e2	true	id.token.claim
6e439d00-e7fc-4711-bd87-2458c15a84e2	true	introspection.token.claim
6e439d00-e7fc-4711-bd87-2458c15a84e2	true	access.token.claim
6e439d00-e7fc-4711-bd87-2458c15a84e2	true	userinfo.token.claim
7a7698a1-9d06-4a60-86c5-65327fb3244c	true	introspection.token.claim
7a7698a1-9d06-4a60-86c5-65327fb3244c	true	userinfo.token.claim
7a7698a1-9d06-4a60-86c5-65327fb3244c	zoneinfo	user.attribute
7a7698a1-9d06-4a60-86c5-65327fb3244c	true	id.token.claim
7a7698a1-9d06-4a60-86c5-65327fb3244c	true	access.token.claim
7a7698a1-9d06-4a60-86c5-65327fb3244c	zoneinfo	claim.name
7a7698a1-9d06-4a60-86c5-65327fb3244c	String	jsonType.label
7b18c8e5-3d75-42ed-9522-6e027e036237	true	introspection.token.claim
7b18c8e5-3d75-42ed-9522-6e027e036237	true	userinfo.token.claim
7b18c8e5-3d75-42ed-9522-6e027e036237	birthdate	user.attribute
7b18c8e5-3d75-42ed-9522-6e027e036237	true	id.token.claim
7b18c8e5-3d75-42ed-9522-6e027e036237	true	access.token.claim
7b18c8e5-3d75-42ed-9522-6e027e036237	birthdate	claim.name
7b18c8e5-3d75-42ed-9522-6e027e036237	String	jsonType.label
8f075c90-c9c8-4d5d-9002-9ce50b4f0007	true	introspection.token.claim
8f075c90-c9c8-4d5d-9002-9ce50b4f0007	true	userinfo.token.claim
8f075c90-c9c8-4d5d-9002-9ce50b4f0007	username	user.attribute
8f075c90-c9c8-4d5d-9002-9ce50b4f0007	true	id.token.claim
8f075c90-c9c8-4d5d-9002-9ce50b4f0007	true	access.token.claim
8f075c90-c9c8-4d5d-9002-9ce50b4f0007	preferred_username	claim.name
8f075c90-c9c8-4d5d-9002-9ce50b4f0007	String	jsonType.label
b39c4582-65be-41d9-8c9e-9cb06d0df9da	true	introspection.token.claim
b39c4582-65be-41d9-8c9e-9cb06d0df9da	true	userinfo.token.claim
b39c4582-65be-41d9-8c9e-9cb06d0df9da	nickname	user.attribute
b39c4582-65be-41d9-8c9e-9cb06d0df9da	true	id.token.claim
b39c4582-65be-41d9-8c9e-9cb06d0df9da	true	access.token.claim
b39c4582-65be-41d9-8c9e-9cb06d0df9da	nickname	claim.name
b39c4582-65be-41d9-8c9e-9cb06d0df9da	String	jsonType.label
b4a9b73d-eef8-4dd8-b09e-2be37371992f	true	introspection.token.claim
b4a9b73d-eef8-4dd8-b09e-2be37371992f	true	userinfo.token.claim
b4a9b73d-eef8-4dd8-b09e-2be37371992f	locale	user.attribute
b4a9b73d-eef8-4dd8-b09e-2be37371992f	true	id.token.claim
b4a9b73d-eef8-4dd8-b09e-2be37371992f	true	access.token.claim
b4a9b73d-eef8-4dd8-b09e-2be37371992f	locale	claim.name
b4a9b73d-eef8-4dd8-b09e-2be37371992f	String	jsonType.label
c67f34b4-e629-4ba0-b0d0-92a814ebe68c	true	introspection.token.claim
c67f34b4-e629-4ba0-b0d0-92a814ebe68c	true	userinfo.token.claim
c67f34b4-e629-4ba0-b0d0-92a814ebe68c	website	user.attribute
c67f34b4-e629-4ba0-b0d0-92a814ebe68c	true	id.token.claim
c67f34b4-e629-4ba0-b0d0-92a814ebe68c	true	access.token.claim
c67f34b4-e629-4ba0-b0d0-92a814ebe68c	website	claim.name
c67f34b4-e629-4ba0-b0d0-92a814ebe68c	String	jsonType.label
e39e2bd2-5e44-4f3b-a4a7-78f1a7bbb040	true	introspection.token.claim
e39e2bd2-5e44-4f3b-a4a7-78f1a7bbb040	true	userinfo.token.claim
e39e2bd2-5e44-4f3b-a4a7-78f1a7bbb040	middleName	user.attribute
e39e2bd2-5e44-4f3b-a4a7-78f1a7bbb040	true	id.token.claim
e39e2bd2-5e44-4f3b-a4a7-78f1a7bbb040	true	access.token.claim
e39e2bd2-5e44-4f3b-a4a7-78f1a7bbb040	middle_name	claim.name
e39e2bd2-5e44-4f3b-a4a7-78f1a7bbb040	String	jsonType.label
f4daab6b-d4ba-43af-a586-1bcb1195c78f	true	introspection.token.claim
f4daab6b-d4ba-43af-a586-1bcb1195c78f	true	userinfo.token.claim
f4daab6b-d4ba-43af-a586-1bcb1195c78f	updatedAt	user.attribute
f4daab6b-d4ba-43af-a586-1bcb1195c78f	true	id.token.claim
f4daab6b-d4ba-43af-a586-1bcb1195c78f	true	access.token.claim
f4daab6b-d4ba-43af-a586-1bcb1195c78f	updated_at	claim.name
f4daab6b-d4ba-43af-a586-1bcb1195c78f	long	jsonType.label
fc6351ce-73df-44c0-a485-dbeab3be5506	true	introspection.token.claim
fc6351ce-73df-44c0-a485-dbeab3be5506	true	userinfo.token.claim
fc6351ce-73df-44c0-a485-dbeab3be5506	lastName	user.attribute
fc6351ce-73df-44c0-a485-dbeab3be5506	true	id.token.claim
fc6351ce-73df-44c0-a485-dbeab3be5506	true	access.token.claim
fc6351ce-73df-44c0-a485-dbeab3be5506	family_name	claim.name
fc6351ce-73df-44c0-a485-dbeab3be5506	String	jsonType.label
1e9c6b46-2d81-4229-aff1-82fbcadd822e	foo	user.attribute
1e9c6b46-2d81-4229-aff1-82fbcadd822e	true	introspection.token.claim
1e9c6b46-2d81-4229-aff1-82fbcadd822e	true	access.token.claim
1e9c6b46-2d81-4229-aff1-82fbcadd822e	resource_access.${client_id}.roles	claim.name
1e9c6b46-2d81-4229-aff1-82fbcadd822e	String	jsonType.label
1e9c6b46-2d81-4229-aff1-82fbcadd822e	true	multivalued
bf0e7c10-2024-4329-883a-11745d48291c	foo	user.attribute
bf0e7c10-2024-4329-883a-11745d48291c	true	introspection.token.claim
bf0e7c10-2024-4329-883a-11745d48291c	true	access.token.claim
bf0e7c10-2024-4329-883a-11745d48291c	realm_access.roles	claim.name
bf0e7c10-2024-4329-883a-11745d48291c	String	jsonType.label
bf0e7c10-2024-4329-883a-11745d48291c	true	multivalued
d2d46a1d-ca5a-4b5a-9d10-58d2e1f2cbfc	true	introspection.token.claim
d2d46a1d-ca5a-4b5a-9d10-58d2e1f2cbfc	true	access.token.claim
691e2388-2328-4615-ba84-4e70162e0217	true	introspection.token.claim
691e2388-2328-4615-ba84-4e70162e0217	true	access.token.claim
274d3661-e07e-43c3-9d43-750f09d6ef98	true	introspection.token.claim
274d3661-e07e-43c3-9d43-750f09d6ef98	true	userinfo.token.claim
274d3661-e07e-43c3-9d43-750f09d6ef98	username	user.attribute
274d3661-e07e-43c3-9d43-750f09d6ef98	true	id.token.claim
274d3661-e07e-43c3-9d43-750f09d6ef98	true	access.token.claim
274d3661-e07e-43c3-9d43-750f09d6ef98	upn	claim.name
274d3661-e07e-43c3-9d43-750f09d6ef98	String	jsonType.label
75012dbc-0dce-4da8-a2de-8b167b3d3998	true	introspection.token.claim
75012dbc-0dce-4da8-a2de-8b167b3d3998	true	multivalued
75012dbc-0dce-4da8-a2de-8b167b3d3998	true	userinfo.token.claim
75012dbc-0dce-4da8-a2de-8b167b3d3998	foo	user.attribute
75012dbc-0dce-4da8-a2de-8b167b3d3998	true	id.token.claim
75012dbc-0dce-4da8-a2de-8b167b3d3998	true	access.token.claim
75012dbc-0dce-4da8-a2de-8b167b3d3998	groups	claim.name
75012dbc-0dce-4da8-a2de-8b167b3d3998	String	jsonType.label
f38ae2c0-2b3f-4971-9f59-d2a735c65f26	true	aggregate.attrs
f38ae2c0-2b3f-4971-9f59-d2a735c65f26	true	introspection.token.claim
f38ae2c0-2b3f-4971-9f59-d2a735c65f26	false	multivalued
f38ae2c0-2b3f-4971-9f59-d2a735c65f26	true	userinfo.token.claim
f38ae2c0-2b3f-4971-9f59-d2a735c65f26	patient-id	user.attribute
f38ae2c0-2b3f-4971-9f59-d2a735c65f26	true	id.token.claim
f38ae2c0-2b3f-4971-9f59-d2a735c65f26	true	lightweight.claim
f38ae2c0-2b3f-4971-9f59-d2a735c65f26	true	access.token.claim
f38ae2c0-2b3f-4971-9f59-d2a735c65f26	patient_id	claim.name
f38ae2c0-2b3f-4971-9f59-d2a735c65f26	String	jsonType.label
26f9f57a-efdd-481b-b23a-2a805389f1cf	true	introspection.token.claim
26f9f57a-efdd-481b-b23a-2a805389f1cf	true	access.token.claim
ea1b09b7-0aba-4483-aae2-1a65b258eb60	AUTH_TIME	user.session.note
ea1b09b7-0aba-4483-aae2-1a65b258eb60	true	introspection.token.claim
ea1b09b7-0aba-4483-aae2-1a65b258eb60	true	userinfo.token.claim
ea1b09b7-0aba-4483-aae2-1a65b258eb60	true	id.token.claim
ea1b09b7-0aba-4483-aae2-1a65b258eb60	true	access.token.claim
ea1b09b7-0aba-4483-aae2-1a65b258eb60	auth_time	claim.name
ea1b09b7-0aba-4483-aae2-1a65b258eb60	long	jsonType.label
dba6df56-93f2-4ec9-b261-43e1fae29a0f	formatted	user.attribute.formatted
dba6df56-93f2-4ec9-b261-43e1fae29a0f	country	user.attribute.country
dba6df56-93f2-4ec9-b261-43e1fae29a0f	true	introspection.token.claim
dba6df56-93f2-4ec9-b261-43e1fae29a0f	postal_code	user.attribute.postal_code
dba6df56-93f2-4ec9-b261-43e1fae29a0f	true	userinfo.token.claim
dba6df56-93f2-4ec9-b261-43e1fae29a0f	street	user.attribute.street
dba6df56-93f2-4ec9-b261-43e1fae29a0f	true	id.token.claim
dba6df56-93f2-4ec9-b261-43e1fae29a0f	region	user.attribute.region
dba6df56-93f2-4ec9-b261-43e1fae29a0f	true	access.token.claim
dba6df56-93f2-4ec9-b261-43e1fae29a0f	locality	user.attribute.locality
e9f92a1a-7351-440f-9971-28d3292ef6b8	true	introspection.token.claim
e9f92a1a-7351-440f-9971-28d3292ef6b8	true	multivalued
e9f92a1a-7351-440f-9971-28d3292ef6b8	true	userinfo.token.claim
e9f92a1a-7351-440f-9971-28d3292ef6b8	true	id.token.claim
e9f92a1a-7351-440f-9971-28d3292ef6b8	true	access.token.claim
e9f92a1a-7351-440f-9971-28d3292ef6b8	organization	claim.name
e9f92a1a-7351-440f-9971-28d3292ef6b8	String	jsonType.label
55af775b-6cec-417e-b9d7-652bf3036a72	true	aggregate.attrs
55af775b-6cec-417e-b9d7-652bf3036a72	true	introspection.token.claim
55af775b-6cec-417e-b9d7-652bf3036a72	false	multivalued
55af775b-6cec-417e-b9d7-652bf3036a72	true	userinfo.token.claim
55af775b-6cec-417e-b9d7-652bf3036a72	fhirUser	user.attribute
55af775b-6cec-417e-b9d7-652bf3036a72	true	id.token.claim
55af775b-6cec-417e-b9d7-652bf3036a72	true	lightweight.claim
55af775b-6cec-417e-b9d7-652bf3036a72	true	access.token.claim
55af775b-6cec-417e-b9d7-652bf3036a72	fhirUser	claim.name
55af775b-6cec-417e-b9d7-652bf3036a72	String	jsonType.label
bb8b325f-5694-47af-85e2-7977b15684b8	true	introspection.token.claim
bb8b325f-5694-47af-85e2-7977b15684b8	public	claim.value
bb8b325f-5694-47af-85e2-7977b15684b8	true	userinfo.token.claim
bb8b325f-5694-47af-85e2-7977b15684b8	true	id.token.claim
bb8b325f-5694-47af-85e2-7977b15684b8	true	lightweight.claim
bb8b325f-5694-47af-85e2-7977b15684b8	true	access.token.claim
bb8b325f-5694-47af-85e2-7977b15684b8	client_type	claim.name
bb8b325f-5694-47af-85e2-7977b15684b8	String	jsonType.label
bb8b325f-5694-47af-85e2-7977b15684b8	false	access.tokenResponse.claim
4b4c4d6e-8f75-4e0f-bebc-3a0c25d7d144	true	aggregate.attrs
4b4c4d6e-8f75-4e0f-bebc-3a0c25d7d144	true	introspection.token.claim
4b4c4d6e-8f75-4e0f-bebc-3a0c25d7d144	false	multivalued
4b4c4d6e-8f75-4e0f-bebc-3a0c25d7d144	true	userinfo.token.claim
4b4c4d6e-8f75-4e0f-bebc-3a0c25d7d144	fhirUser	user.attribute
4b4c4d6e-8f75-4e0f-bebc-3a0c25d7d144	true	id.token.claim
4b4c4d6e-8f75-4e0f-bebc-3a0c25d7d144	true	lightweight.claim
4b4c4d6e-8f75-4e0f-bebc-3a0c25d7d144	true	access.token.claim
4b4c4d6e-8f75-4e0f-bebc-3a0c25d7d144	fhirUser	claim.name
4b4c4d6e-8f75-4e0f-bebc-3a0c25d7d144	String	jsonType.label
954fefc8-e52a-44aa-a630-1d90f90451d4	true	introspection.token.claim
954fefc8-e52a-44aa-a630-1d90f90451d4	credential	claim.value
954fefc8-e52a-44aa-a630-1d90f90451d4	true	userinfo.token.claim
954fefc8-e52a-44aa-a630-1d90f90451d4	true	id.token.claim
954fefc8-e52a-44aa-a630-1d90f90451d4	true	lightweight.claim
954fefc8-e52a-44aa-a630-1d90f90451d4	true	access.token.claim
954fefc8-e52a-44aa-a630-1d90f90451d4	client_type	claim.name
954fefc8-e52a-44aa-a630-1d90f90451d4	String	jsonType.label
954fefc8-e52a-44aa-a630-1d90f90451d4	true	access.tokenResponse.claim
a2731f87-9ac0-4d5f-a2f2-59e0cead1e5e	true	introspection.token.claim
a2731f87-9ac0-4d5f-a2f2-59e0cead1e5e	public	claim.value
a2731f87-9ac0-4d5f-a2f2-59e0cead1e5e	true	userinfo.token.claim
a2731f87-9ac0-4d5f-a2f2-59e0cead1e5e	true	id.token.claim
a2731f87-9ac0-4d5f-a2f2-59e0cead1e5e	true	lightweight.claim
a2731f87-9ac0-4d5f-a2f2-59e0cead1e5e	true	access.token.claim
a2731f87-9ac0-4d5f-a2f2-59e0cead1e5e	client_type	claim.name
a2731f87-9ac0-4d5f-a2f2-59e0cead1e5e	String	jsonType.label
a2731f87-9ac0-4d5f-a2f2-59e0cead1e5e	false	access.tokenResponse.claim
f476a12c-e8b9-428d-92ee-3cf5de0e3bbe	true	aggregate.attrs
f476a12c-e8b9-428d-92ee-3cf5de0e3bbe	true	introspection.token.claim
f476a12c-e8b9-428d-92ee-3cf5de0e3bbe	true	userinfo.token.claim
f476a12c-e8b9-428d-92ee-3cf5de0e3bbe	fhirUser	user.attribute
f476a12c-e8b9-428d-92ee-3cf5de0e3bbe	true	id.token.claim
f476a12c-e8b9-428d-92ee-3cf5de0e3bbe	true	lightweight.claim
f476a12c-e8b9-428d-92ee-3cf5de0e3bbe	true	access.token.claim
f476a12c-e8b9-428d-92ee-3cf5de0e3bbe	fhirUser	claim.name
f476a12c-e8b9-428d-92ee-3cf5de0e3bbe	String	jsonType.label
af981690-7e3c-471a-b6a4-c934cf4d38ee	true	introspection.token.claim
af981690-7e3c-471a-b6a4-c934cf4d38ee	true	userinfo.token.claim
af981690-7e3c-471a-b6a4-c934cf4d38ee	locale	user.attribute
af981690-7e3c-471a-b6a4-c934cf4d38ee	true	id.token.claim
af981690-7e3c-471a-b6a4-c934cf4d38ee	true	access.token.claim
af981690-7e3c-471a-b6a4-c934cf4d38ee	locale	claim.name
af981690-7e3c-471a-b6a4-c934cf4d38ee	String	jsonType.label
0beb641e-6eff-4a69-8566-dbfd39dc9b7d	true	introspection.token.claim
0beb641e-6eff-4a69-8566-dbfd39dc9b7d	credential	claim.value
0beb641e-6eff-4a69-8566-dbfd39dc9b7d	true	userinfo.token.claim
0beb641e-6eff-4a69-8566-dbfd39dc9b7d	true	id.token.claim
0beb641e-6eff-4a69-8566-dbfd39dc9b7d	true	lightweight.claim
0beb641e-6eff-4a69-8566-dbfd39dc9b7d	true	access.token.claim
0beb641e-6eff-4a69-8566-dbfd39dc9b7d	client_type	claim.name
0beb641e-6eff-4a69-8566-dbfd39dc9b7d	String	jsonType.label
0beb641e-6eff-4a69-8566-dbfd39dc9b7d	true	access.tokenResponse.claim
\.


--
-- TOC entry 4199 (class 0 OID 16639)
-- Dependencies: 267
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
041f8a3b-b936-410d-b423-b51f4cd23d7f	60	300	1800				t	t	259200	inventage	fhir-realm	0	hashAlgorithm(sha256)	f	t	t	f	EXTERNAL	1800	36000	f	f	dbe09ae6-8593-4a11-9455-03f179bbae8c	1800	f	\N	f	t	f	f	0	1	30	6	HmacSHA1	totp	ced9ebfe-9689-489a-a821-1a4acf77b0ae	d3ae413b-8592-4bb9-ada7-674a051fe01a	4b0c98c6-22d5-42b3-abef-69961d2f5db3	8ba9f457-250f-4b11-b9d9-7be33e44313b	0f830992-1d44-49d3-ba8b-bcded6dd11e2	2592000	f	1800	t	f	a1a2070d-a16f-4bb2-ba75-eb0794751ad7	0	f	0	0	94e08ac6-b9cc-499c-9ad9-8d9347f398a7
c59dea27-0f0a-4d7e-9d51-e1017680e812	60	300	86400				t	t	259200	custom-theme	master	0	\N	f	f	f	f	EXTERNAL	86400	86400	f	f	4f9d68ce-2e56-4d97-b0ec-d4c98f9d33b7	1800	f	\N	f	t	f	f	0	1	30	6	HmacSHA1	totp	57c9e91e-1532-4a66-989f-5739e2591b2a	cec96a14-62a4-4f25-809c-50f4e72709f7	90e3da48-9779-4507-bde5-ae0883c37d7b	ef411cfb-66d1-473b-996b-4ad8e583149c	a10420bc-df45-4a9b-a76a-6c534c258b84	2592000	f	900	t	f	38210274-0ac4-40d1-af5d-bc061b29c6f1	0	f	0	0	9ca49408-842b-4cda-86c2-5e1f7407be08
\.


--
-- TOC entry 4200 (class 0 OID 16672)
-- Dependencies: 268
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	c59dea27-0f0a-4d7e-9d51-e1017680e812	
_browser_header.xContentTypeOptions	c59dea27-0f0a-4d7e-9d51-e1017680e812	nosniff
_browser_header.referrerPolicy	c59dea27-0f0a-4d7e-9d51-e1017680e812	no-referrer
_browser_header.xRobotsTag	c59dea27-0f0a-4d7e-9d51-e1017680e812	none
_browser_header.xFrameOptions	c59dea27-0f0a-4d7e-9d51-e1017680e812	SAMEORIGIN
_browser_header.contentSecurityPolicy	c59dea27-0f0a-4d7e-9d51-e1017680e812	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	c59dea27-0f0a-4d7e-9d51-e1017680e812	max-age=31536000; includeSubDomains
bruteForceProtected	c59dea27-0f0a-4d7e-9d51-e1017680e812	false
permanentLockout	c59dea27-0f0a-4d7e-9d51-e1017680e812	false
maxTemporaryLockouts	c59dea27-0f0a-4d7e-9d51-e1017680e812	0
bruteForceStrategy	c59dea27-0f0a-4d7e-9d51-e1017680e812	MULTIPLE
maxFailureWaitSeconds	c59dea27-0f0a-4d7e-9d51-e1017680e812	900
minimumQuickLoginWaitSeconds	c59dea27-0f0a-4d7e-9d51-e1017680e812	60
waitIncrementSeconds	c59dea27-0f0a-4d7e-9d51-e1017680e812	60
quickLoginCheckMilliSeconds	c59dea27-0f0a-4d7e-9d51-e1017680e812	1000
maxDeltaTimeSeconds	c59dea27-0f0a-4d7e-9d51-e1017680e812	43200
failureFactor	c59dea27-0f0a-4d7e-9d51-e1017680e812	30
realmReusableOtpCode	c59dea27-0f0a-4d7e-9d51-e1017680e812	false
firstBrokerLoginFlowId	c59dea27-0f0a-4d7e-9d51-e1017680e812	e6a735b7-c9c8-4433-80ff-4c933216959a
displayName	c59dea27-0f0a-4d7e-9d51-e1017680e812	Keycloak
displayNameHtml	c59dea27-0f0a-4d7e-9d51-e1017680e812	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	c59dea27-0f0a-4d7e-9d51-e1017680e812	RS256
offlineSessionMaxLifespanEnabled	c59dea27-0f0a-4d7e-9d51-e1017680e812	false
offlineSessionMaxLifespan	c59dea27-0f0a-4d7e-9d51-e1017680e812	5184000
cibaBackchannelTokenDeliveryMode	c59dea27-0f0a-4d7e-9d51-e1017680e812	poll
cibaExpiresIn	c59dea27-0f0a-4d7e-9d51-e1017680e812	120
cibaAuthRequestedUserHint	c59dea27-0f0a-4d7e-9d51-e1017680e812	login_hint
parRequestUriLifespan	c59dea27-0f0a-4d7e-9d51-e1017680e812	60
cibaInterval	c59dea27-0f0a-4d7e-9d51-e1017680e812	5
organizationsEnabled	c59dea27-0f0a-4d7e-9d51-e1017680e812	false
adminPermissionsEnabled	c59dea27-0f0a-4d7e-9d51-e1017680e812	false
verifiableCredentialsEnabled	c59dea27-0f0a-4d7e-9d51-e1017680e812	false
actionTokenGeneratedByAdminLifespan	c59dea27-0f0a-4d7e-9d51-e1017680e812	43200
actionTokenGeneratedByUserLifespan	c59dea27-0f0a-4d7e-9d51-e1017680e812	300
webAuthnPolicyRpEntityName	c59dea27-0f0a-4d7e-9d51-e1017680e812	keycloak
webAuthnPolicySignatureAlgorithms	c59dea27-0f0a-4d7e-9d51-e1017680e812	ES256,RS256
webAuthnPolicyRpId	c59dea27-0f0a-4d7e-9d51-e1017680e812	
webAuthnPolicyAttestationConveyancePreference	c59dea27-0f0a-4d7e-9d51-e1017680e812	not specified
webAuthnPolicyAuthenticatorAttachment	c59dea27-0f0a-4d7e-9d51-e1017680e812	not specified
webAuthnPolicyRequireResidentKey	c59dea27-0f0a-4d7e-9d51-e1017680e812	not specified
webAuthnPolicyUserVerificationRequirement	c59dea27-0f0a-4d7e-9d51-e1017680e812	not specified
webAuthnPolicyCreateTimeout	c59dea27-0f0a-4d7e-9d51-e1017680e812	0
webAuthnPolicyAvoidSameAuthenticatorRegister	c59dea27-0f0a-4d7e-9d51-e1017680e812	false
webAuthnPolicyRpEntityNamePasswordless	c59dea27-0f0a-4d7e-9d51-e1017680e812	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	c59dea27-0f0a-4d7e-9d51-e1017680e812	ES256,RS256
webAuthnPolicyRpIdPasswordless	c59dea27-0f0a-4d7e-9d51-e1017680e812	
webAuthnPolicyAttestationConveyancePreferencePasswordless	c59dea27-0f0a-4d7e-9d51-e1017680e812	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	c59dea27-0f0a-4d7e-9d51-e1017680e812	not specified
webAuthnPolicyRequireResidentKeyPasswordless	c59dea27-0f0a-4d7e-9d51-e1017680e812	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	c59dea27-0f0a-4d7e-9d51-e1017680e812	not specified
webAuthnPolicyCreateTimeoutPasswordless	c59dea27-0f0a-4d7e-9d51-e1017680e812	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	c59dea27-0f0a-4d7e-9d51-e1017680e812	false
client-policies.profiles	c59dea27-0f0a-4d7e-9d51-e1017680e812	{"profiles":[]}
client-policies.policies	c59dea27-0f0a-4d7e-9d51-e1017680e812	{"policies":[]}
adminEventsExpiration	c59dea27-0f0a-4d7e-9d51-e1017680e812	259200
darkMode	c59dea27-0f0a-4d7e-9d51-e1017680e812	true
adminEventsExpiration	041f8a3b-b936-410d-b423-b51f4cd23d7f	259200
bruteForceProtected	041f8a3b-b936-410d-b423-b51f4cd23d7f	true
oauth2DevicePollingInterval	c59dea27-0f0a-4d7e-9d51-e1017680e812	5
clientSessionIdleTimeout	c59dea27-0f0a-4d7e-9d51-e1017680e812	0
clientSessionMaxLifespan	c59dea27-0f0a-4d7e-9d51-e1017680e812	0
clientOfflineSessionIdleTimeout	c59dea27-0f0a-4d7e-9d51-e1017680e812	0
clientOfflineSessionMaxLifespan	c59dea27-0f0a-4d7e-9d51-e1017680e812	0
_browser_header.contentSecurityPolicyReportOnly	041f8a3b-b936-410d-b423-b51f4cd23d7f	
_browser_header.xContentTypeOptions	041f8a3b-b936-410d-b423-b51f4cd23d7f	nosniff
_browser_header.referrerPolicy	041f8a3b-b936-410d-b423-b51f4cd23d7f	no-referrer
_browser_header.xRobotsTag	041f8a3b-b936-410d-b423-b51f4cd23d7f	none
_browser_header.xFrameOptions	041f8a3b-b936-410d-b423-b51f4cd23d7f	SAMEORIGIN
_browser_header.contentSecurityPolicy	041f8a3b-b936-410d-b423-b51f4cd23d7f	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	041f8a3b-b936-410d-b423-b51f4cd23d7f	max-age=31536000; includeSubDomains
permanentLockout	041f8a3b-b936-410d-b423-b51f4cd23d7f	false
maxTemporaryLockouts	041f8a3b-b936-410d-b423-b51f4cd23d7f	0
bruteForceStrategy	041f8a3b-b936-410d-b423-b51f4cd23d7f	MULTIPLE
minimumQuickLoginWaitSeconds	041f8a3b-b936-410d-b423-b51f4cd23d7f	60
waitIncrementSeconds	041f8a3b-b936-410d-b423-b51f4cd23d7f	60
realmReusableOtpCode	041f8a3b-b936-410d-b423-b51f4cd23d7f	false
defaultSignatureAlgorithm	041f8a3b-b936-410d-b423-b51f4cd23d7f	RS256
offlineSessionMaxLifespanEnabled	041f8a3b-b936-410d-b423-b51f4cd23d7f	false
offlineSessionMaxLifespan	041f8a3b-b936-410d-b423-b51f4cd23d7f	5184000
clientOfflineSessionIdleTimeout	041f8a3b-b936-410d-b423-b51f4cd23d7f	0
clientOfflineSessionMaxLifespan	041f8a3b-b936-410d-b423-b51f4cd23d7f	0
actionTokenGeneratedByAdminLifespan	041f8a3b-b936-410d-b423-b51f4cd23d7f	43200
actionTokenGeneratedByUserLifespan	041f8a3b-b936-410d-b423-b51f4cd23d7f	300
oauth2DevicePollingInterval	041f8a3b-b936-410d-b423-b51f4cd23d7f	5
organizationsEnabled	041f8a3b-b936-410d-b423-b51f4cd23d7f	false
adminPermissionsEnabled	041f8a3b-b936-410d-b423-b51f4cd23d7f	false
webAuthnPolicyRpEntityName	041f8a3b-b936-410d-b423-b51f4cd23d7f	keycloak
webAuthnPolicySignatureAlgorithms	041f8a3b-b936-410d-b423-b51f4cd23d7f	ES256,RS256
webAuthnPolicyRpId	041f8a3b-b936-410d-b423-b51f4cd23d7f	
webAuthnPolicyAttestationConveyancePreference	041f8a3b-b936-410d-b423-b51f4cd23d7f	not specified
webAuthnPolicyAuthenticatorAttachment	041f8a3b-b936-410d-b423-b51f4cd23d7f	not specified
webAuthnPolicyRequireResidentKey	041f8a3b-b936-410d-b423-b51f4cd23d7f	not specified
webAuthnPolicyUserVerificationRequirement	041f8a3b-b936-410d-b423-b51f4cd23d7f	not specified
webAuthnPolicyCreateTimeout	041f8a3b-b936-410d-b423-b51f4cd23d7f	0
webAuthnPolicyAvoidSameAuthenticatorRegister	041f8a3b-b936-410d-b423-b51f4cd23d7f	false
webAuthnPolicyRpEntityNamePasswordless	041f8a3b-b936-410d-b423-b51f4cd23d7f	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	041f8a3b-b936-410d-b423-b51f4cd23d7f	ES256,RS256
webAuthnPolicyRpIdPasswordless	041f8a3b-b936-410d-b423-b51f4cd23d7f	
webAuthnPolicyAttestationConveyancePreferencePasswordless	041f8a3b-b936-410d-b423-b51f4cd23d7f	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	041f8a3b-b936-410d-b423-b51f4cd23d7f	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	041f8a3b-b936-410d-b423-b51f4cd23d7f	not specified
webAuthnPolicyCreateTimeoutPasswordless	041f8a3b-b936-410d-b423-b51f4cd23d7f	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	041f8a3b-b936-410d-b423-b51f4cd23d7f	false
cibaBackchannelTokenDeliveryMode	041f8a3b-b936-410d-b423-b51f4cd23d7f	poll
cibaExpiresIn	041f8a3b-b936-410d-b423-b51f4cd23d7f	120
cibaInterval	041f8a3b-b936-410d-b423-b51f4cd23d7f	5
cibaAuthRequestedUserHint	041f8a3b-b936-410d-b423-b51f4cd23d7f	login_hint
firstBrokerLoginFlowId	041f8a3b-b936-410d-b423-b51f4cd23d7f	97c789fb-2e97-4d63-b34f-c0f2da0f7c62
actionTokenGeneratedByUserLifespan.verify-email	041f8a3b-b936-410d-b423-b51f4cd23d7f	
actionTokenGeneratedByUserLifespan.idp-verify-account-via-email	041f8a3b-b936-410d-b423-b51f4cd23d7f	
actionTokenGeneratedByUserLifespan.execute-actions	041f8a3b-b936-410d-b423-b51f4cd23d7f	
shortVerificationUri	041f8a3b-b936-410d-b423-b51f4cd23d7f	
actionTokenGeneratedByUserLifespan.reset-credentials	041f8a3b-b936-410d-b423-b51f4cd23d7f	
verifiableCredentialsEnabled	041f8a3b-b936-410d-b423-b51f4cd23d7f	false
client-policies.profiles	041f8a3b-b936-410d-b423-b51f4cd23d7f	{"profiles":[]}
client-policies.policies	041f8a3b-b936-410d-b423-b51f4cd23d7f	{"policies":[]}
quickLoginCheckMilliSeconds	041f8a3b-b936-410d-b423-b51f4cd23d7f	1000
webAuthnPolicyRequireResidentKeyPasswordless	041f8a3b-b936-410d-b423-b51f4cd23d7f	not specified
failureFactor	041f8a3b-b936-410d-b423-b51f4cd23d7f	3
maxDeltaTimeSeconds	041f8a3b-b936-410d-b423-b51f4cd23d7f	43200
maxFailureWaitSeconds	041f8a3b-b936-410d-b423-b51f4cd23d7f	1296000
shortVerificationUri	c59dea27-0f0a-4d7e-9d51-e1017680e812	
actionTokenGeneratedByUserLifespan.verify-email	c59dea27-0f0a-4d7e-9d51-e1017680e812	
actionTokenGeneratedByUserLifespan.idp-verify-account-via-email	c59dea27-0f0a-4d7e-9d51-e1017680e812	
actionTokenGeneratedByUserLifespan.reset-credentials	c59dea27-0f0a-4d7e-9d51-e1017680e812	
actionTokenGeneratedByUserLifespan.execute-actions	c59dea27-0f0a-4d7e-9d51-e1017680e812	
oauth2DeviceCodeLifespan	c59dea27-0f0a-4d7e-9d51-e1017680e812	600
parRequestUriLifespan	041f8a3b-b936-410d-b423-b51f4cd23d7f	60
oauth2DeviceCodeLifespan	041f8a3b-b936-410d-b423-b51f4cd23d7f	1800
clientSessionIdleTimeout	041f8a3b-b936-410d-b423-b51f4cd23d7f	1800
clientSessionMaxLifespan	041f8a3b-b936-410d-b423-b51f4cd23d7f	1800
\.


--
-- TOC entry 4201 (class 0 OID 16677)
-- Dependencies: 269
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- TOC entry 4202 (class 0 OID 16680)
-- Dependencies: 270
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
041f8a3b-b936-410d-b423-b51f4cd23d7f	SEND_RESET_PASSWORD
041f8a3b-b936-410d-b423-b51f4cd23d7f	UPDATE_CONSENT_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	GRANT_CONSENT
041f8a3b-b936-410d-b423-b51f4cd23d7f	VERIFY_PROFILE_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	REMOVE_TOTP
041f8a3b-b936-410d-b423-b51f4cd23d7f	REVOKE_GRANT
041f8a3b-b936-410d-b423-b51f4cd23d7f	UPDATE_TOTP
041f8a3b-b936-410d-b423-b51f4cd23d7f	LOGIN_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	CLIENT_LOGIN
041f8a3b-b936-410d-b423-b51f4cd23d7f	RESET_PASSWORD_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	UPDATE_CREDENTIAL
041f8a3b-b936-410d-b423-b51f4cd23d7f	IMPERSONATE_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	CODE_TO_TOKEN_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	CUSTOM_REQUIRED_ACTION
041f8a3b-b936-410d-b423-b51f4cd23d7f	OAUTH2_DEVICE_CODE_TO_TOKEN_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	RESTART_AUTHENTICATION
041f8a3b-b936-410d-b423-b51f4cd23d7f	IMPERSONATE
041f8a3b-b936-410d-b423-b51f4cd23d7f	UPDATE_PROFILE_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	LOGIN
041f8a3b-b936-410d-b423-b51f4cd23d7f	OAUTH2_DEVICE_VERIFY_USER_CODE
041f8a3b-b936-410d-b423-b51f4cd23d7f	UPDATE_PASSWORD_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	CLIENT_INITIATED_ACCOUNT_LINKING
041f8a3b-b936-410d-b423-b51f4cd23d7f	OAUTH2_EXTENSION_GRANT
041f8a3b-b936-410d-b423-b51f4cd23d7f	USER_DISABLED_BY_PERMANENT_LOCKOUT
041f8a3b-b936-410d-b423-b51f4cd23d7f	REMOVE_CREDENTIAL_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	TOKEN_EXCHANGE
041f8a3b-b936-410d-b423-b51f4cd23d7f	AUTHREQID_TO_TOKEN
041f8a3b-b936-410d-b423-b51f4cd23d7f	LOGOUT
041f8a3b-b936-410d-b423-b51f4cd23d7f	REGISTER
041f8a3b-b936-410d-b423-b51f4cd23d7f	DELETE_ACCOUNT_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	CLIENT_REGISTER
041f8a3b-b936-410d-b423-b51f4cd23d7f	IDENTITY_PROVIDER_LINK_ACCOUNT
041f8a3b-b936-410d-b423-b51f4cd23d7f	USER_DISABLED_BY_TEMPORARY_LOCKOUT
041f8a3b-b936-410d-b423-b51f4cd23d7f	DELETE_ACCOUNT
041f8a3b-b936-410d-b423-b51f4cd23d7f	UPDATE_PASSWORD
041f8a3b-b936-410d-b423-b51f4cd23d7f	CLIENT_DELETE
041f8a3b-b936-410d-b423-b51f4cd23d7f	FEDERATED_IDENTITY_LINK_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	IDENTITY_PROVIDER_FIRST_LOGIN
041f8a3b-b936-410d-b423-b51f4cd23d7f	CLIENT_DELETE_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	VERIFY_EMAIL
041f8a3b-b936-410d-b423-b51f4cd23d7f	CLIENT_LOGIN_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	RESTART_AUTHENTICATION_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	EXECUTE_ACTIONS
041f8a3b-b936-410d-b423-b51f4cd23d7f	REMOVE_FEDERATED_IDENTITY_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	TOKEN_EXCHANGE_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	PERMISSION_TOKEN
041f8a3b-b936-410d-b423-b51f4cd23d7f	FEDERATED_IDENTITY_OVERRIDE_LINK
041f8a3b-b936-410d-b423-b51f4cd23d7f	SEND_IDENTITY_PROVIDER_LINK_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	UPDATE_CREDENTIAL_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	EXECUTE_ACTION_TOKEN_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	OAUTH2_EXTENSION_GRANT_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	SEND_VERIFY_EMAIL
041f8a3b-b936-410d-b423-b51f4cd23d7f	OAUTH2_DEVICE_AUTH
041f8a3b-b936-410d-b423-b51f4cd23d7f	EXECUTE_ACTIONS_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	REMOVE_FEDERATED_IDENTITY
041f8a3b-b936-410d-b423-b51f4cd23d7f	OAUTH2_DEVICE_CODE_TO_TOKEN
041f8a3b-b936-410d-b423-b51f4cd23d7f	IDENTITY_PROVIDER_POST_LOGIN
041f8a3b-b936-410d-b423-b51f4cd23d7f	IDENTITY_PROVIDER_LINK_ACCOUNT_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	FEDERATED_IDENTITY_OVERRIDE_LINK_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	OAUTH2_DEVICE_VERIFY_USER_CODE_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	UPDATE_EMAIL
041f8a3b-b936-410d-b423-b51f4cd23d7f	REGISTER_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	REVOKE_GRANT_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	EXECUTE_ACTION_TOKEN
041f8a3b-b936-410d-b423-b51f4cd23d7f	LOGOUT_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	UPDATE_EMAIL_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	CLIENT_UPDATE_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	AUTHREQID_TO_TOKEN_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	INVITE_ORG_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	UPDATE_PROFILE
041f8a3b-b936-410d-b423-b51f4cd23d7f	CLIENT_REGISTER_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	FEDERATED_IDENTITY_LINK
041f8a3b-b936-410d-b423-b51f4cd23d7f	INVITE_ORG
041f8a3b-b936-410d-b423-b51f4cd23d7f	SEND_IDENTITY_PROVIDER_LINK
041f8a3b-b936-410d-b423-b51f4cd23d7f	SEND_VERIFY_EMAIL_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	RESET_PASSWORD
041f8a3b-b936-410d-b423-b51f4cd23d7f	CLIENT_INITIATED_ACCOUNT_LINKING_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	OAUTH2_DEVICE_AUTH_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	REMOVE_CREDENTIAL
041f8a3b-b936-410d-b423-b51f4cd23d7f	UPDATE_CONSENT
041f8a3b-b936-410d-b423-b51f4cd23d7f	REMOVE_TOTP_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	VERIFY_EMAIL_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	SEND_RESET_PASSWORD_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	CLIENT_UPDATE
041f8a3b-b936-410d-b423-b51f4cd23d7f	CUSTOM_REQUIRED_ACTION_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	IDENTITY_PROVIDER_POST_LOGIN_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	UPDATE_TOTP_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	CODE_TO_TOKEN
041f8a3b-b936-410d-b423-b51f4cd23d7f	VERIFY_PROFILE
041f8a3b-b936-410d-b423-b51f4cd23d7f	GRANT_CONSENT_ERROR
041f8a3b-b936-410d-b423-b51f4cd23d7f	IDENTITY_PROVIDER_FIRST_LOGIN_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	SEND_RESET_PASSWORD
c59dea27-0f0a-4d7e-9d51-e1017680e812	UPDATE_CONSENT_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	GRANT_CONSENT
c59dea27-0f0a-4d7e-9d51-e1017680e812	VERIFY_PROFILE_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	REMOVE_TOTP
c59dea27-0f0a-4d7e-9d51-e1017680e812	REVOKE_GRANT
c59dea27-0f0a-4d7e-9d51-e1017680e812	UPDATE_TOTP
c59dea27-0f0a-4d7e-9d51-e1017680e812	LOGIN_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	CLIENT_LOGIN
c59dea27-0f0a-4d7e-9d51-e1017680e812	RESET_PASSWORD_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	UPDATE_CREDENTIAL
c59dea27-0f0a-4d7e-9d51-e1017680e812	IMPERSONATE_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	CODE_TO_TOKEN_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	CUSTOM_REQUIRED_ACTION
c59dea27-0f0a-4d7e-9d51-e1017680e812	OAUTH2_DEVICE_CODE_TO_TOKEN_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	RESTART_AUTHENTICATION
c59dea27-0f0a-4d7e-9d51-e1017680e812	IMPERSONATE
c59dea27-0f0a-4d7e-9d51-e1017680e812	UPDATE_PROFILE_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	LOGIN
c59dea27-0f0a-4d7e-9d51-e1017680e812	OAUTH2_DEVICE_VERIFY_USER_CODE
c59dea27-0f0a-4d7e-9d51-e1017680e812	UPDATE_PASSWORD_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	CLIENT_INITIATED_ACCOUNT_LINKING
c59dea27-0f0a-4d7e-9d51-e1017680e812	OAUTH2_EXTENSION_GRANT
c59dea27-0f0a-4d7e-9d51-e1017680e812	USER_DISABLED_BY_PERMANENT_LOCKOUT
c59dea27-0f0a-4d7e-9d51-e1017680e812	REMOVE_CREDENTIAL_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	TOKEN_EXCHANGE
c59dea27-0f0a-4d7e-9d51-e1017680e812	AUTHREQID_TO_TOKEN
c59dea27-0f0a-4d7e-9d51-e1017680e812	LOGOUT
c59dea27-0f0a-4d7e-9d51-e1017680e812	REGISTER
c59dea27-0f0a-4d7e-9d51-e1017680e812	DELETE_ACCOUNT_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	CLIENT_REGISTER
c59dea27-0f0a-4d7e-9d51-e1017680e812	IDENTITY_PROVIDER_LINK_ACCOUNT
c59dea27-0f0a-4d7e-9d51-e1017680e812	USER_DISABLED_BY_TEMPORARY_LOCKOUT
c59dea27-0f0a-4d7e-9d51-e1017680e812	DELETE_ACCOUNT
c59dea27-0f0a-4d7e-9d51-e1017680e812	UPDATE_PASSWORD
c59dea27-0f0a-4d7e-9d51-e1017680e812	CLIENT_DELETE
c59dea27-0f0a-4d7e-9d51-e1017680e812	FEDERATED_IDENTITY_LINK_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	IDENTITY_PROVIDER_FIRST_LOGIN
c59dea27-0f0a-4d7e-9d51-e1017680e812	CLIENT_DELETE_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	VERIFY_EMAIL
c59dea27-0f0a-4d7e-9d51-e1017680e812	CLIENT_LOGIN_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	RESTART_AUTHENTICATION_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	EXECUTE_ACTIONS
c59dea27-0f0a-4d7e-9d51-e1017680e812	REMOVE_FEDERATED_IDENTITY_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	TOKEN_EXCHANGE_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	PERMISSION_TOKEN
c59dea27-0f0a-4d7e-9d51-e1017680e812	FEDERATED_IDENTITY_OVERRIDE_LINK
c59dea27-0f0a-4d7e-9d51-e1017680e812	SEND_IDENTITY_PROVIDER_LINK_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	UPDATE_CREDENTIAL_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	EXECUTE_ACTION_TOKEN_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	OAUTH2_EXTENSION_GRANT_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	SEND_VERIFY_EMAIL
c59dea27-0f0a-4d7e-9d51-e1017680e812	OAUTH2_DEVICE_AUTH
c59dea27-0f0a-4d7e-9d51-e1017680e812	EXECUTE_ACTIONS_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	REMOVE_FEDERATED_IDENTITY
c59dea27-0f0a-4d7e-9d51-e1017680e812	OAUTH2_DEVICE_CODE_TO_TOKEN
c59dea27-0f0a-4d7e-9d51-e1017680e812	IDENTITY_PROVIDER_POST_LOGIN
c59dea27-0f0a-4d7e-9d51-e1017680e812	IDENTITY_PROVIDER_LINK_ACCOUNT_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	FEDERATED_IDENTITY_OVERRIDE_LINK_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	OAUTH2_DEVICE_VERIFY_USER_CODE_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	UPDATE_EMAIL
c59dea27-0f0a-4d7e-9d51-e1017680e812	REGISTER_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	REVOKE_GRANT_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	EXECUTE_ACTION_TOKEN
c59dea27-0f0a-4d7e-9d51-e1017680e812	LOGOUT_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	UPDATE_EMAIL_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	CLIENT_UPDATE_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	AUTHREQID_TO_TOKEN_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	INVITE_ORG_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	UPDATE_PROFILE
c59dea27-0f0a-4d7e-9d51-e1017680e812	CLIENT_REGISTER_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	FEDERATED_IDENTITY_LINK
c59dea27-0f0a-4d7e-9d51-e1017680e812	INVITE_ORG
c59dea27-0f0a-4d7e-9d51-e1017680e812	SEND_IDENTITY_PROVIDER_LINK
c59dea27-0f0a-4d7e-9d51-e1017680e812	SEND_VERIFY_EMAIL_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	RESET_PASSWORD
c59dea27-0f0a-4d7e-9d51-e1017680e812	CLIENT_INITIATED_ACCOUNT_LINKING_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	OAUTH2_DEVICE_AUTH_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	REMOVE_CREDENTIAL
c59dea27-0f0a-4d7e-9d51-e1017680e812	UPDATE_CONSENT
c59dea27-0f0a-4d7e-9d51-e1017680e812	REMOVE_TOTP_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	VERIFY_EMAIL_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	SEND_RESET_PASSWORD_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	CLIENT_UPDATE
c59dea27-0f0a-4d7e-9d51-e1017680e812	CUSTOM_REQUIRED_ACTION_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	IDENTITY_PROVIDER_POST_LOGIN_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	UPDATE_TOTP_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	CODE_TO_TOKEN
c59dea27-0f0a-4d7e-9d51-e1017680e812	VERIFY_PROFILE
c59dea27-0f0a-4d7e-9d51-e1017680e812	GRANT_CONSENT_ERROR
c59dea27-0f0a-4d7e-9d51-e1017680e812	IDENTITY_PROVIDER_FIRST_LOGIN_ERROR
\.


--
-- TOC entry 4203 (class 0 OID 16683)
-- Dependencies: 271
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
c59dea27-0f0a-4d7e-9d51-e1017680e812	jboss-logging
041f8a3b-b936-410d-b423-b51f4cd23d7f	jboss-logging
\.


--
-- TOC entry 4204 (class 0 OID 16686)
-- Dependencies: 272
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- TOC entry 4205 (class 0 OID 16691)
-- Dependencies: 273
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	c59dea27-0f0a-4d7e-9d51-e1017680e812
password	password	t	t	041f8a3b-b936-410d-b423-b51f4cd23d7f
\.


--
-- TOC entry 4206 (class 0 OID 16698)
-- Dependencies: 274
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
041f8a3b-b936-410d-b423-b51f4cd23d7f	false	debug
041f8a3b-b936-410d-b423-b51f4cd23d7f	Tri Thinh	replyToDisplayName
041f8a3b-b936-410d-b423-b51f4cd23d7f	false	starttls
041f8a3b-b936-410d-b423-b51f4cd23d7f	false	auth
041f8a3b-b936-410d-b423-b51f4cd23d7f		envelopeFrom
041f8a3b-b936-410d-b423-b51f4cd23d7f	true	ssl
041f8a3b-b936-410d-b423-b51f4cd23d7f		password
041f8a3b-b936-410d-b423-b51f4cd23d7f	1025	port
041f8a3b-b936-410d-b423-b51f4cd23d7f	localhost	host
041f8a3b-b936-410d-b423-b51f4cd23d7f	ngoisaonhovietnam@gmail.com	replyTo
041f8a3b-b936-410d-b423-b51f4cd23d7f	thinh.thai09@hcmut.edu.vn	from
041f8a3b-b936-410d-b423-b51f4cd23d7f	Keycloak Admin	fromDisplayName
041f8a3b-b936-410d-b423-b51f4cd23d7f	basic	authType
041f8a3b-b936-410d-b423-b51f4cd23d7f		user
\.


--
-- TOC entry 4207 (class 0 OID 16703)
-- Dependencies: 275
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- TOC entry 4208 (class 0 OID 16706)
-- Dependencies: 276
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.redirect_uris (client_id, value) FROM stdin;
9eee2754-cbf5-42b9-a7ea-d782447cc4f4	/realms/master/account/*
d8fa8480-9e7f-4fc2-bec5-8479023566c5	/realms/master/account/*
938aed6d-c4ca-41ba-9d97-c4cf2d17d9c6	/realms/fhir-realm/account/*
a7143ea8-7fcd-40a5-9b15-f417b9648c00	/realms/fhir-realm/account/*
636672b6-143d-4bf2-ac14-e0feade63dc6	*
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	*
29c5bc63-ce60-4a06-883b-a66d156c84b5	http://localhost/custom/smart/redirect
29c5bc63-ce60-4a06-883b-a66d156c84b5	http://localhost/custom/smart_stu2/.well-known/jwks.json
767d4eee-87ba-42cc-a25d-0d904138f24f	/admin/master/console/
767d4eee-87ba-42cc-a25d-0d904138f24f	/admin/master/console/*
d7f84708-6ae4-42ea-93d3-825c725f7d2c	http://localhost/custom/smart/launch
f36c6fd0-b46c-43d5-9413-0e462e191822	http://192.168.30.17:3000/callback
f36c6fd0-b46c-43d5-9413-0e462e191822	http://localhost/callback
f36c6fd0-b46c-43d5-9413-0e462e191822	https://www.facebook.com
8c1a8594-ee37-49ad-9bc5-6db27db6a544	/admin/fhir-realm/console/
8c1a8594-ee37-49ad-9bc5-6db27db6a544	/admin/fhir-realm/console/*
f36c6fd0-b46c-43d5-9413-0e462e191822	http://localhost/permissions-callback
f36c6fd0-b46c-43d5-9413-0e462e191822	http://192.168.56.1:3000/callback
f36c6fd0-b46c-43d5-9413-0e462e191822	http://localhost:3000/choose-permissions*
f36c6fd0-b46c-43d5-9413-0e462e191822	https://oauth.pstmn.io/v1/callback
d7f84708-6ae4-42ea-93d3-825c725f7d2c	http://192.168.56.1:3000/choose-permissions*
d0e81265-5646-4d25-9bb0-c689a2a61478	https://inferno.healthit.gov/suites/custom/smart/redirect
d0e81265-5646-4d25-9bb0-c689a2a61478	https://oauth.pstmn.io/v1/callback
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	https://inferno.healthit.gov/suites/custom/smart/redirect
d7f84708-6ae4-42ea-93d3-825c725f7d2c	http://localhost/custom/smart/redirect
d7f84708-6ae4-42ea-93d3-825c725f7d2c	https://inferno.healthit.gov/suites/custom/smart/redirect
d7f84708-6ae4-42ea-93d3-825c725f7d2c	http://localhost:3000/callback
d7f84708-6ae4-42ea-93d3-825c725f7d2c	http://localhost:3000/api/auth/auth
d7f84708-6ae4-42ea-93d3-825c725f7d2c	https://www.facebook.com
d7f84708-6ae4-42ea-93d3-825c725f7d2c	*
d7f84708-6ae4-42ea-93d3-825c725f7d2c	http://localhost:3000/choose-permissions*
d7f84708-6ae4-42ea-93d3-825c725f7d2c	https://oauth.pstmn.io/v1/callback
\.


--
-- TOC entry 4209 (class 0 OID 16709)
-- Dependencies: 277
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- TOC entry 4210 (class 0 OID 16714)
-- Dependencies: 278
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
bdac4a96-ac85-4173-b7cc-c283cd126e42	VERIFY_EMAIL	Verify Email	c59dea27-0f0a-4d7e-9d51-e1017680e812	t	f	VERIFY_EMAIL	50
762fc62c-cccd-4033-a2ab-fe041cbc8c3d	UPDATE_PROFILE	Update Profile	c59dea27-0f0a-4d7e-9d51-e1017680e812	t	f	UPDATE_PROFILE	40
b035a965-791a-4589-a42e-b1f018a1f56b	CONFIGURE_TOTP	Configure OTP	c59dea27-0f0a-4d7e-9d51-e1017680e812	t	f	CONFIGURE_TOTP	10
a0ffe02a-54c8-4eb8-ad12-8343abc8e0f8	UPDATE_PASSWORD	Update Password	c59dea27-0f0a-4d7e-9d51-e1017680e812	t	f	UPDATE_PASSWORD	30
b0c305b1-e92c-4c89-b85a-1a1d85782092	TERMS_AND_CONDITIONS	Terms and Conditions	c59dea27-0f0a-4d7e-9d51-e1017680e812	f	f	TERMS_AND_CONDITIONS	20
1ef623c7-a05d-44dc-a800-155d1b0fc5ee	delete_account	Delete Account	c59dea27-0f0a-4d7e-9d51-e1017680e812	f	f	delete_account	60
45e45f6a-fb83-4188-a822-6e4fee3cfefa	delete_credential	Delete Credential	c59dea27-0f0a-4d7e-9d51-e1017680e812	t	f	delete_credential	100
8336a56a-f8ec-49ab-9e31-c369948377af	update_user_locale	Update User Locale	c59dea27-0f0a-4d7e-9d51-e1017680e812	t	f	update_user_locale	1000
4c900843-b441-44f3-9c69-979b12ffa4b2	webauthn-register	Webauthn Register	c59dea27-0f0a-4d7e-9d51-e1017680e812	t	f	webauthn-register	70
dcac526f-f1ea-421a-a1b4-c47218adce66	webauthn-register-passwordless	Webauthn Register Passwordless	c59dea27-0f0a-4d7e-9d51-e1017680e812	t	f	webauthn-register-passwordless	80
f09d4f83-8da7-40ce-8370-81e30cc84627	VERIFY_PROFILE	Verify Profile	c59dea27-0f0a-4d7e-9d51-e1017680e812	t	f	VERIFY_PROFILE	90
9007b50e-1362-48b3-804f-2af980879487	CONFIGURE_TOTP	Configure OTP	041f8a3b-b936-410d-b423-b51f4cd23d7f	t	f	CONFIGURE_TOTP	10
81b1a577-9533-4bab-93dd-85b0e3f05f76	TERMS_AND_CONDITIONS	Terms and Conditions	041f8a3b-b936-410d-b423-b51f4cd23d7f	f	f	TERMS_AND_CONDITIONS	20
59e5ed80-5e66-4daf-8dd9-642d338cb842	UPDATE_PASSWORD	Update Password	041f8a3b-b936-410d-b423-b51f4cd23d7f	t	f	UPDATE_PASSWORD	30
acc3f66e-f7e4-4319-9950-76542df1ed17	UPDATE_PROFILE	Update Profile	041f8a3b-b936-410d-b423-b51f4cd23d7f	t	f	UPDATE_PROFILE	40
08216cd9-4392-4d6f-b662-91be277e7a86	VERIFY_EMAIL	Verify Email	041f8a3b-b936-410d-b423-b51f4cd23d7f	t	f	VERIFY_EMAIL	50
11e16e4d-d854-4783-9352-92f792ad8344	delete_account	Delete Account	041f8a3b-b936-410d-b423-b51f4cd23d7f	f	f	delete_account	60
c3ddd379-dba2-439c-a193-2243da462dd5	webauthn-register	Webauthn Register	041f8a3b-b936-410d-b423-b51f4cd23d7f	t	f	webauthn-register	70
fd3176ad-17b9-4eab-9c69-a64556c782c6	VERIFY_PROFILE	Verify Profile	041f8a3b-b936-410d-b423-b51f4cd23d7f	t	f	VERIFY_PROFILE	90
49b34b9b-362f-473e-a5f5-0c936b6038e3	delete_credential	Delete Credential	041f8a3b-b936-410d-b423-b51f4cd23d7f	t	f	delete_credential	100
5803e945-9ee2-4043-8e9f-89fce412f5fa	update_user_locale	Update User Locale	041f8a3b-b936-410d-b423-b51f4cd23d7f	t	f	update_user_locale	1000
cac50799-39dd-4524-b27d-61a68a5ef369	webauthn-register-passwordless	Webauthn Register Passwordless	041f8a3b-b936-410d-b423-b51f4cd23d7f	t	t	webauthn-register-passwordless	80
\.


--
-- TOC entry 4211 (class 0 OID 16721)
-- Dependencies: 279
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- TOC entry 4212 (class 0 OID 16727)
-- Dependencies: 280
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- TOC entry 4213 (class 0 OID 16730)
-- Dependencies: 281
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- TOC entry 4214 (class 0 OID 16733)
-- Dependencies: 282
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- TOC entry 4215 (class 0 OID 16738)
-- Dependencies: 283
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- TOC entry 4216 (class 0 OID 16743)
-- Dependencies: 284
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- TOC entry 4217 (class 0 OID 16748)
-- Dependencies: 285
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- TOC entry 4218 (class 0 OID 16754)
-- Dependencies: 286
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- TOC entry 4219 (class 0 OID 16759)
-- Dependencies: 287
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- TOC entry 4220 (class 0 OID 16762)
-- Dependencies: 288
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- TOC entry 4221 (class 0 OID 16765)
-- Dependencies: 289
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
da1747cc-b377-4b8f-a870-63621f1ee015	9c3eccc4-a7b2-42eb-85ba-008578c60817	patient-id	902
c4b7cf0b-7d06-4fc7-b521-da069cf661e8	9c3eccc4-a7b2-42eb-85ba-008578c60817	patient_id	902
\.


--
-- TOC entry 4222 (class 0 OID 16770)
-- Dependencies: 290
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
d8fa8480-9e7f-4fc2-bec5-8479023566c5	b6898dda-5101-402a-92b0-d6e271175cc0
d8fa8480-9e7f-4fc2-bec5-8479023566c5	29158e62-deef-42d7-ac52-e765104081e0
a7143ea8-7fcd-40a5-9b15-f417b9648c00	756672dc-1a78-4011-b733-95e6c7d713e6
a7143ea8-7fcd-40a5-9b15-f417b9648c00	a11a809b-0649-46c0-b078-e2e23a9cdbcc
\.


--
-- TOC entry 4223 (class 0 OID 16773)
-- Dependencies: 291
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- TOC entry 4224 (class 0 OID 16776)
-- Dependencies: 292
-- Data for Name: server_config; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.server_config (server_config_key, value, version) FROM stdin;
crt_jgroups	{"prvKey":"MIIEogIBAAKCAQEAzcOQh9JR+keOqQxSrybSMfXtaNTgt/um/qSz0Yj6QBdSTWVRMPUKnkWwaHyTsQqNdip3i7SHJ0Fdw1tec8O1ubJp2+8BkTnEmK71xmGKFvLoqpigx81+d82vlKmD0dAu6CzZoAmms4Eg0470jd56hLj2oqaLOHnuzsgUFjEpwxCgx6k6gCMKeORtUzCDBYI5k3GGZ/H7T/kDFHwR2bTTTLa9JosTg0hWIC48Kzl0eaTD14Ov8b3xBXu3bkXdG8ldf80w0VSEyEHoefZJXyaBD1NVda6Us1fcra+jE2BPEqtTWXia/SrMY+8Ts+GjOTAFFU4ir2HMo0ua+kXxqHG9dQIDAQABAoIBAAuIL1x9XBzTz9oHl8a7PUKRjum2LJYDI5vX7UAMFkJrTDCMQh2lTiAKtdVVTg25Eq6RuLt6taxsjG27fDKuwEuVBTvPTF4wR6VrANlKdCvPF10gSrqH+NOMEpAZZArpSQe4I8ZFZDNhRE63D1u4IVO47hG1lc3nf4vVSNLplHabKTWLvmfrqi3NCFa4UKqd6eN7ZeQI0F8fepw994R7CLG9uZa9IpvgGPsEPXCIcDtjKYHVG+M4h3iuyTO7D7N8ENbWFj0++27BShvvg6+gDKPHvw+HUd2VsV7MHgWkNWcDpNGbE3Lta5Wb8B9BM6RLUi5z/P6b/RsR2fYJzAuAKyECgYEA8UFVif43cqNXlothPa+8EE47e8g2r8Bdd3QPtP9cpmMwdabKMHSsmNKCBnrI8TJCWkGxvL+iOG4WckxT46An9PMuummGFBbvRiN2sBQBggz++a9jrlGXTXq2IDzEijYKGnuBSzyDOktuO1+LyL81EerCXZEcVL6j7Ha99At9yJ0CgYEA2lbviYAIlJh66rs37hQCNJqAUDjO/chaHiae+uV1KFPsgMIgAAz0wOt0AGLf1iljDA0ZjJPdgJv6Sr3673pkZncWaDvPyW+v1F1+lGerWuH2fJVEvTJ1SfR9z2IgnCSN/0d+8IuN0Qfg+h6TZ17wq8+3ya05AyUyugWI0j2FlLkCgYBKCVLG1k0N0TK/8GYXGCcOmfOHORoPNWl5jxSC5xr3tNjaQiUqWaPeAjwE4Qlpe5MBP8fbtLODvcUFrobQBAY/FaHxcxDCeYdUbu2te3Y7AuH8neZpSIC2NkJOAlgOUicnmV9ER32+FgfuEJRFNuiCZxjevfmDyD1mA8qnah9fwQKBgBfk06n0fPvmA+2UN3aycdtX3RrqXJyhRFtwVo2Wds/G/2bH18Cpqk9CdRtltqE1PkWfWWBs/hyI9Ucgq0lx13LvLWCSyxZ8Rn2zDZsoDTSQ7eyMWU1rLDK/stTzJCZySafaJyYj3400k4ZLuk3hsezben1zm32goICDAoofeXLhAoGAUCJgQTlAyD7o33J67m3q19pUl8Zrpusmwhrf3waY2W8O4uyDXWi96yjm/8M8OEc8y+10JXrcm41MTqESzdGjHX8vuYU3Iy6b3WKep6ALiooZa3Pxxno6VfhuoFthL0Xqjuyc8SIbfyFHXVHXJmb3ILr/ZapyD8fVaU6qdGlUWOU=","pubKey":"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzcOQh9JR+keOqQxSrybSMfXtaNTgt/um/qSz0Yj6QBdSTWVRMPUKnkWwaHyTsQqNdip3i7SHJ0Fdw1tec8O1ubJp2+8BkTnEmK71xmGKFvLoqpigx81+d82vlKmD0dAu6CzZoAmms4Eg0470jd56hLj2oqaLOHnuzsgUFjEpwxCgx6k6gCMKeORtUzCDBYI5k3GGZ/H7T/kDFHwR2bTTTLa9JosTg0hWIC48Kzl0eaTD14Ov8b3xBXu3bkXdG8ldf80w0VSEyEHoefZJXyaBD1NVda6Us1fcra+jE2BPEqtTWXia/SrMY+8Ts+GjOTAFFU4ir2HMo0ua+kXxqHG9dQIDAQAB","crt":"MIICnTCCAYUCBgGXv6mdLjANBgkqhkiG9w0BAQsFADASMRAwDgYDVQQDDAdqZ3JvdXBzMB4XDTI1MDYzMDA3MDU1M1oXDTI1MDgyOTA3MDczMVowEjEQMA4GA1UEAwwHamdyb3VwczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAM3DkIfSUfpHjqkMUq8m0jH17WjU4Lf7pv6ks9GI+kAXUk1lUTD1Cp5FsGh8k7EKjXYqd4u0hydBXcNbXnPDtbmyadvvAZE5xJiu9cZhihby6KqYoMfNfnfNr5Spg9HQLugs2aAJprOBINOO9I3eeoS49qKmizh57s7IFBYxKcMQoMepOoAjCnjkbVMwgwWCOZNxhmfx+0/5AxR8Edm000y2vSaLE4NIViAuPCs5dHmkw9eDr/G98QV7t25F3RvJXX/NMNFUhMhB6Hn2SV8mgQ9TVXWulLNX3K2voxNgTxKrU1l4mv0qzGPvE7PhozkwBRVOIq9hzKNLmvpF8ahxvXUCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAAobTaVaUYCH4ubo7tY4q9q1V9TbZsRJDOlhwI+bRpUYOFebYbZ3BzJa06yQR2N6R+PJTyyxhN66p4CWY1LhjiQ24/ietSJVz6PTZknGyQJekv/+hOzGhn2+b24Z7R162cDLGpAx3w8Bj9C6nvPrZz63+Hau7c3hxLlr4afTOT98Rh0Eui9DZR2aAD0CXBhs/H3y8p6L1bRd38dPAK00Fl9YUa75EvIfqF55gF7XIqwOEPPrC4KpfGSTWSTSeM32wj+hh3UpFmR5pkE50ZeObHFqAxK5HitrRfFcAEdGCG6Zwx5PTI9TDh+piSq2EHt2Je3KvKAP8wjFTyZfN8tFc7g==","alias":"b0daa06c-fc4e-444a-a23e-a81d1e2e891c","generatedMillis":1751267254040}	0
\.


--
-- TOC entry 4225 (class 0 OID 16782)
-- Dependencies: 293
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
fhirUser	Patient/902	b97d8dc5-d06e-4d1d-9376-65295bf49585	93e8b0a1-1f4d-4b3a-b9a5-6c0947d4518a	\N	\N	\N
fhirUser	Patient/902	f65b3829-5635-4b8a-898c-4b46b32c2316	fabab8a5-7b66-4e2c-a94f-f6dd280fc038	\N	\N	\N
patient-id	902	f65b3829-5635-4b8a-898c-4b46b32c2316	0ea80c4a-239a-4e27-8466-793bb2f0ccdd	\N	\N	\N
fhirUser	Patient/902	0bcec2b7-860b-46ca-a105-46a9fae43a60	76cf94fd-109c-4bd5-b819-c92bd3ad4e19	\N	\N	\N
phone	0123456789	a029c552-b8e3-4b4f-b917-a29075a0ea37	d472be9b-7b51-49ee-b432-f0f0eec6a8e8	\N	\N	\N
phone	0988889000	f65b3829-5635-4b8a-898c-4b46b32c2316	1f7835b9-91e4-4b50-83af-d122be3114ae	\N	\N	\N
fhirUser	Admin/1	f65bc99f-3ac0-48d0-8c49-ce0b452d821d	22a870a9-d2fe-4cd0-ac4e-1e3546c9aeb8	\N	\N	\N
phone	0987654321	f65bc99f-3ac0-48d0-8c49-ce0b452d821d	932d35a2-f81f-4f0e-bd06-7f500298084e	\N	\N	\N
address	5 Tran Quang Long	0bcec2b7-860b-46ca-a105-46a9fae43a60	7760cff1-2aaa-4713-b044-ee73ed4117d8	\N	\N	\N
gender	Male	f65b3829-5635-4b8a-898c-4b46b32c2316	c2dbbf45-99f9-4d56-9c13-eea00850c63b	\N	\N	\N
address	1 XVNT	979eebed-5c8e-42f8-b32b-b28e6ae5d471	b041904a-f6e7-44e5-ad2a-a604d76058d9	\N	\N	\N
fhirUser	Patient/401	979eebed-5c8e-42f8-b32b-b28e6ae5d471	efe57334-5ee6-4044-b13d-e88c0d99cd45	\N	\N	\N
gender	Female	979eebed-5c8e-42f8-b32b-b28e6ae5d471	1f264c9b-315c-4142-9820-ede4cc1e46f3	\N	\N	\N
phone	0988889000	979eebed-5c8e-42f8-b32b-b28e6ae5d471	e000c724-cbab-4ba9-9ed6-c9e1f28a5b93	\N	\N	\N
address	2 XVNT	68baa92f-562d-4681-a78c-f7f421924975	b4466c6f-be22-45a4-9b52-4b3692f8777f	\N	\N	\N
fhirUser	Patient/402	68baa92f-562d-4681-a78c-f7f421924975	f5266dd1-09b2-4110-8982-b9d7467562ad	\N	\N	\N
gender	Female	68baa92f-562d-4681-a78c-f7f421924975	07662522-fc33-47bd-97cd-640557c63e8a	\N	\N	\N
phone	0988889000	68baa92f-562d-4681-a78c-f7f421924975	ce12340e-93c9-4bfa-9227-988bdfbea101	\N	\N	\N
phone	0903020199	0bcec2b7-860b-46ca-a105-46a9fae43a60	9d6da32b-c785-4414-9326-9b360ec078ab	\N	\N	\N
fhirUser	Patient/1234	e4347de6-75b7-4561-9cf7-325c656fc7df	b74b0789-6983-40a7-bc4a-43be9e77d2ea	\N	\N	\N
phone	0988889000	e4347de6-75b7-4561-9cf7-325c656fc7df	d57612ca-aa19-4138-89a9-ef4e58bc7c0a	\N	\N	\N
address	1 Harlem	43cb6e01-f82d-48d9-b449-1bdede0e8805	8dffad92-df2b-4587-a593-6d64eed85ee1	\N	\N	\N
fhirUser	Patient/4c91fbe8-789b-42b3-af57-713dc61d639b	43cb6e01-f82d-48d9-b449-1bdede0e8805	3bfcb448-1ec1-4586-bfda-2677657338b1	\N	\N	\N
gender	Male	43cb6e01-f82d-48d9-b449-1bdede0e8805	ae6f494e-b7f1-4380-bc1e-551908074e2a	\N	\N	\N
phone	0903020199	43cb6e01-f82d-48d9-b449-1bdede0e8805	348d3b70-f3a3-4315-8adf-b12069175e54	\N	\N	\N
address	79/7 Pham Viet Chanh	db5693ec-d1e8-43d6-b2b1-89eb20c5937a	f342b7a2-f633-40a8-8940-218ab9ef4af5	\N	\N	\N
fhirUser	Patient/123	db5693ec-d1e8-43d6-b2b1-89eb20c5937a	7a44108d-9d3a-4371-889f-ab13e38bb4d3	\N	\N	\N
gender	Male	db5693ec-d1e8-43d6-b2b1-89eb20c5937a	105000cb-6eff-4b49-af28-2401241d7a3c	\N	\N	\N
phone	0903021781	db5693ec-d1e8-43d6-b2b1-89eb20c5937a	f6e2697a-87c8-4409-82e8-2b449066a49e	\N	\N	\N
address	92 Xo Viet Nghe Tinh	f65b3829-5635-4b8a-898c-4b46b32c2316	b7562916-64e7-479f-a93e-b5d3edc2afa1	\N	\N	\N
\.


--
-- TOC entry 4226 (class 0 OID 16788)
-- Dependencies: 294
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 4227 (class 0 OID 16793)
-- Dependencies: 295
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 4228 (class 0 OID 16796)
-- Dependencies: 296
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
f65bc99f-3ac0-48d0-8c49-ce0b452d821d	admin-realm@gmail.com	admin-realm@gmail.com	t	t	\N	realm-admin	123	041f8a3b-b936-410d-b423-b51f4cd23d7f	admin-realm	1751622377909	\N	0
25aa4edb-e990-4caf-bb7d-97277056973a	thinh@test.com	thinh@test.com	t	t	\N	Thinh	Thai	041f8a3b-b936-410d-b423-b51f4cd23d7f	admin	1750217899140	\N	0
b97d8dc5-d06e-4d1d-9376-65295bf49585	admin1@gmail.com	admin1@gmail.com	t	t	\N	Thinh	Thai Tri	041f8a3b-b936-410d-b423-b51f4cd23d7f	admin1	1750233173232	\N	0
e604b03c-0d2b-4c4f-b71b-a8ae9cfbea59	\N	53392ee9-09df-4155-9b64-37aac993534d	f	t	\N	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	service-account-clinic-a	1750327918073	636672b6-143d-4bf2-ac14-e0feade63dc6	0
4aa0b569-ff1e-4f2c-b9a7-f4115439898b	\N	541d661d-2952-431c-9350-a785831f7750	f	t	\N	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	service-account-inferno-ehr	1750841192325	d7f84708-6ae4-42ea-93d3-825c725f7d2c	0
5632d6e8-7122-428f-a8e9-d1f2b5e5dedb	\N	112b4c9f-8735-4dfa-98b7-c68d255f0dc9	f	t	\N	\N	\N	041f8a3b-b936-410d-b423-b51f4cd23d7f	service-account-validation-service	1750310159588	2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	0
1fc17d40-e60c-44c8-89f4-cdc526116154	user@gmail.com	user@gmail.com	t	t	\N	User	Nguyen	041f8a3b-b936-410d-b423-b51f4cd23d7f	user	1750331326506	\N	0
0bcec2b7-860b-46ca-a105-46a9fae43a60	user10@gmail.com	user10@gmail.com	t	t	\N	Test hash	Random	041f8a3b-b936-410d-b423-b51f4cd23d7f	user10	1751596244329	\N	0
a029c552-b8e3-4b4f-b917-a29075a0ea37	user20@gmail.com	user20@gmail.com	t	t	\N	user	20	041f8a3b-b936-410d-b423-b51f4cd23d7f	user20	1751613760941	\N	0
979eebed-5c8e-42f8-b32b-b28e6ae5d471	inserted1@gmail.com	inserted1@gmail.com	t	t	\N	insert	by API	041f8a3b-b936-410d-b423-b51f4cd23d7f	inserted1	1751859806	\N	0
68baa92f-562d-4681-a78c-f7f421924975	inserted2@gmail.com	inserted2@gmail.com	t	t	\N	insert	by API	041f8a3b-b936-410d-b423-b51f4cd23d7f	inserted2	1751861578	\N	0
6ceb0dc2-b56b-4116-9aca-92060432a07f	thinh.thaitri0409@gmail.com	thinh.thaitri0409@gmail.com	t	t	\N	Thinh	Thai Tri	c59dea27-0f0a-4d7e-9d51-e1017680e812	admin_keycloak	1751944994772	\N	0
e4347de6-75b7-4561-9cf7-325c656fc7df	ngoisaonhovietnam@gmail.com	ngoisaonhovietnam@gmail.com	t	t	\N	email	tester	041f8a3b-b936-410d-b423-b51f4cd23d7f	email1	1751948359183	\N	0
43cb6e01-f82d-48d9-b449-1bdede0e8805	newuser1@gmail.com	newuser1@gmail.com	t	t	\N	New	User	041f8a3b-b936-410d-b423-b51f4cd23d7f	newuser1	1751972088000	\N	0
db5693ec-d1e8-43d6-b2b1-89eb20c5937a	deployed1@gmail.com	deployed1@gmail.com	t	t	\N	deployed	Thai Tri	041f8a3b-b936-410d-b423-b51f4cd23d7f	deployed1	1752634181335	\N	0
f65b3829-5635-4b8a-898c-4b46b32c2316	user1@gmail.com	user1@gmail.com	t	t	\N	Vaughn	Pham Nguyen	041f8a3b-b936-410d-b423-b51f4cd23d7f	user1	1750737173434	\N	0
591af5ab-bfac-454d-a7b3-89f550938e1b	\N	17b77e81-287f-4afa-9c53-0465dc62dee9	f	t	\N	\N	\N	c59dea27-0f0a-4d7e-9d51-e1017680e812	service-account-admin-cli	1753083969693	58d58f34-c0be-4479-b8d6-eedb5a5a3210	0
\.


--
-- TOC entry 4229 (class 0 OID 16804)
-- Dependencies: 297
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 4230 (class 0 OID 16809)
-- Dependencies: 298
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- TOC entry 4231 (class 0 OID 16814)
-- Dependencies: 299
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 4232 (class 0 OID 16819)
-- Dependencies: 300
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- TOC entry 4233 (class 0 OID 16824)
-- Dependencies: 301
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- TOC entry 4234 (class 0 OID 16827)
-- Dependencies: 302
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
b97d8dc5-d06e-4d1d-9376-65295bf49585	UPDATE_PASSWORD
979eebed-5c8e-42f8-b32b-b28e6ae5d471	webauthn-register-passwordless
43cb6e01-f82d-48d9-b449-1bdede0e8805	webauthn-register-passwordless
43cb6e01-f82d-48d9-b449-1bdede0e8805	UPDATE_PASSWORD
db5693ec-d1e8-43d6-b2b1-89eb20c5937a	webauthn-register-passwordless
db5693ec-d1e8-43d6-b2b1-89eb20c5937a	UPDATE_PASSWORD
\.


--
-- TOC entry 4235 (class 0 OID 16831)
-- Dependencies: 303
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	0bcec2b7-860b-46ca-a105-46a9fae43a60
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	f65bc99f-3ac0-48d0-8c49-ce0b452d821d
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	979eebed-5c8e-42f8-b32b-b28e6ae5d471
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	68baa92f-562d-4681-a78c-f7f421924975
9ca49408-842b-4cda-86c2-5e1f7407be08	6ceb0dc2-b56b-4116-9aca-92060432a07f
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	6ceb0dc2-b56b-4116-9aca-92060432a07f
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	43cb6e01-f82d-48d9-b449-1bdede0e8805
8f86e174-8430-462f-a159-616eb34f15d7	25aa4edb-e990-4caf-bb7d-97277056973a
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	25aa4edb-e990-4caf-bb7d-97277056973a
788e7dc2-30ff-428e-bbe4-ff70a49e35ab	25aa4edb-e990-4caf-bb7d-97277056973a
9da19dc4-517b-4634-86c0-1ae414f4b3fd	25aa4edb-e990-4caf-bb7d-97277056973a
9e800f34-0d0a-4255-b6e2-0d5f8b53b6c5	25aa4edb-e990-4caf-bb7d-97277056973a
6e13eb40-c005-4c37-94c4-20810d74e9fb	25aa4edb-e990-4caf-bb7d-97277056973a
d3ee8ecd-cad1-4fe6-801d-483ee1bd1ef9	25aa4edb-e990-4caf-bb7d-97277056973a
2c10cbcc-65e9-4c23-a51c-07a128ffa777	25aa4edb-e990-4caf-bb7d-97277056973a
8f86e174-8430-462f-a159-616eb34f15d7	b97d8dc5-d06e-4d1d-9376-65295bf49585
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	b97d8dc5-d06e-4d1d-9376-65295bf49585
788e7dc2-30ff-428e-bbe4-ff70a49e35ab	b97d8dc5-d06e-4d1d-9376-65295bf49585
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	e604b03c-0d2b-4c4f-b71b-a8ae9cfbea59
462f8907-3e28-443a-a2be-c38babd5800e	e604b03c-0d2b-4c4f-b71b-a8ae9cfbea59
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	4aa0b569-ff1e-4f2c-b9a7-f4115439898b
73c7d51e-2f3e-4c8d-b9f0-f97c78b05621	4aa0b569-ff1e-4f2c-b9a7-f4115439898b
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
d7468bb8-3b4a-4709-8364-4f1e5ae0fb22	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
f03e0200-d658-461a-8bb0-5ea1cff50eb3	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
9da19dc4-517b-4634-86c0-1ae414f4b3fd	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
dafcdf53-10c6-4eb4-8cbb-9516c3811e00	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
992c19ba-c6bd-4c1c-97e7-0399e3e19e8b	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
9e800f34-0d0a-4255-b6e2-0d5f8b53b6c5	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
d3ee8ecd-cad1-4fe6-801d-483ee1bd1ef9	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
6e13eb40-c005-4c37-94c4-20810d74e9fb	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
1c7bd0c4-40bd-4812-84ca-f8b86c4521eb	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
29df026a-ef13-4ada-88b8-a5540fb075f7	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
23efe8e8-c68b-43f4-9b55-b317d0911610	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
4fc9d6ae-e7be-4a09-ab61-705be086420d	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
756672dc-1a78-4011-b733-95e6c7d713e6	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
a11a809b-0649-46c0-b078-e2e23a9cdbcc	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
7317366a-e3a7-477b-a4db-a46508d297b8	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
39f0641c-a68d-43f3-bd07-684a5c196c8c	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
f988bdfe-e4c1-4890-8831-8a70c0313367	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
6b7d3836-9d77-4b1d-bb0b-0eb7a73bee05	5632d6e8-7122-428f-a8e9-d1f2b5e5dedb
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	1fc17d40-e60c-44c8-89f4-cdc526116154
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	f65b3829-5635-4b8a-898c-4b46b32c2316
9c3eccc4-a7b2-42eb-85ba-008578c60817	f65b3829-5635-4b8a-898c-4b46b32c2316
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	a029c552-b8e3-4b4f-b917-a29075a0ea37
5810aa60-30fd-438c-83d1-9a3ac263475c	f65bc99f-3ac0-48d0-8c49-ce0b452d821d
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	e4347de6-75b7-4561-9cf7-325c656fc7df
94e08ac6-b9cc-499c-9ad9-8d9347f398a7	db5693ec-d1e8-43d6-b2b1-89eb20c5937a
9ca49408-842b-4cda-86c2-5e1f7407be08	591af5ab-bfac-454d-a7b3-89f550938e1b
fb9f0b09-b0d0-4cb0-995c-ff01cccd2dca	591af5ab-bfac-454d-a7b3-89f550938e1b
\.


--
-- TOC entry 4236 (class 0 OID 16834)
-- Dependencies: 304
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: admin_temporary
--

COPY public.web_origins (client_id, value) FROM stdin;
636672b6-143d-4bf2-ac14-e0feade63dc6	*
74994dc4-9c37-457b-b002-b6b0d6dfb0ab	*
d7f84708-6ae4-42ea-93d3-825c725f7d2c	http://localhost
29c5bc63-ce60-4a06-883b-a66d156c84b5	http://localhost
d7f84708-6ae4-42ea-93d3-825c725f7d2c	http://localhost:3000
767d4eee-87ba-42cc-a25d-0d904138f24f	+
8c1a8594-ee37-49ad-9bc5-6db27db6a544	+
d0e81265-5646-4d25-9bb0-c689a2a61478	http://localhost
2fe1fdd0-a3be-4958-9790-f4f7e1d62ee5	
f36c6fd0-b46c-43d5-9413-0e462e191822	http://localhost/
f36c6fd0-b46c-43d5-9413-0e462e191822	http://192.168.30.17:3000/
f36c6fd0-b46c-43d5-9413-0e462e191822	http://192.168.56.1:3000/
\.


--
-- TOC entry 3796 (class 2606 OID 16839)
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- TOC entry 3788 (class 2606 OID 16841)
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- TOC entry 3888 (class 2606 OID 16843)
-- Name: server_config SERVER_CONFIG_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.server_config
    ADD CONSTRAINT "SERVER_CONFIG_pkey" PRIMARY KEY (server_config_key);


--
-- TOC entry 3772 (class 2606 OID 16845)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3665 (class 2606 OID 16847)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3680 (class 2606 OID 16849)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3667 (class 2606 OID 16851)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3815 (class 2606 OID 16853)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3655 (class 2606 OID 16855)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3692 (class 2606 OID 16857)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3688 (class 2606 OID 16859)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3731 (class 2606 OID 16861)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3711 (class 2606 OID 16863)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3716 (class 2606 OID 16865)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3723 (class 2606 OID 16867)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3727 (class 2606 OID 16869)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3735 (class 2606 OID 16871)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3743 (class 2606 OID 16873)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3817 (class 2606 OID 16875)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3820 (class 2606 OID 16877)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3823 (class 2606 OID 16879)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3832 (class 2606 OID 16881)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3752 (class 2606 OID 16883)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3662 (class 2606 OID 16885)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3708 (class 2606 OID 16887)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3739 (class 2606 OID 16889)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3807 (class 2606 OID 16891)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3923 (class 2606 OID 16893)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3657 (class 2606 OID 16895)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3882 (class 2606 OID 16897)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3670 (class 2606 OID 16899)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3812 (class 2606 OID 16901)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3828 (class 2606 OID 16903)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3774 (class 2606 OID 16905)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3637 (class 2606 OID 16907)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3653 (class 2606 OID 16909)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3643 (class 2606 OID 16911)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3647 (class 2606 OID 16913)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3650 (class 2606 OID 16915)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3932 (class 2606 OID 16917)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3695 (class 2606 OID 16919)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3759 (class 2606 OID 16921)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3799 (class 2606 OID 16923)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3830 (class 2606 OID 16925)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3699 (class 2606 OID 16927)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3915 (class 2606 OID 16929)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3853 (class 2606 OID 16931)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3864 (class 2606 OID 16933)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3859 (class 2606 OID 16935)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3640 (class 2606 OID 16937)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3845 (class 2606 OID 16939)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3869 (class 2606 OID 16941)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3848 (class 2606 OID 16943)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3885 (class 2606 OID 16945)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3907 (class 2606 OID 16947)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3921 (class 2606 OID 16949)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3917 (class 2606 OID 16951)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3721 (class 2606 OID 16953)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3903 (class 2606 OID 16955)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3896 (class 2606 OID 16957)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3768 (class 2606 OID 16959)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3745 (class 2606 OID 16961)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3749 (class 2606 OID 16963)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3761 (class 2606 OID 16965)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3764 (class 2606 OID 16967)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3766 (class 2606 OID 16969)
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- TOC entry 3778 (class 2606 OID 16971)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3781 (class 2606 OID 16973)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3783 (class 2606 OID 16975)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3801 (class 2606 OID 16977)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3805 (class 2606 OID 16979)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3835 (class 2606 OID 16981)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3838 (class 2606 OID 16983)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3840 (class 2606 OID 16985)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3929 (class 2606 OID 16987)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3874 (class 2606 OID 16989)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3879 (class 2606 OID 16991)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3876 (class 2606 OID 16993)
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- TOC entry 3890 (class 2606 OID 16995)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3926 (class 2606 OID 16997)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3935 (class 2606 OID 16999)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3702 (class 2606 OID 17001)
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3678 (class 2606 OID 17003)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3673 (class 2606 OID 17005)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3851 (class 2606 OID 17007)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3686 (class 2606 OID 17009)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3706 (class 2606 OID 17011)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3826 (class 2606 OID 17013)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3843 (class 2606 OID 17015)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3770 (class 2606 OID 17017)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3757 (class 2606 OID 17019)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3660 (class 2606 OID 17021)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3675 (class 2606 OID 17023)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3911 (class 2606 OID 17025)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3899 (class 2606 OID 17027)
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3867 (class 2606 OID 17029)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3857 (class 2606 OID 17031)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3862 (class 2606 OID 17033)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3872 (class 2606 OID 17035)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3901 (class 2606 OID 17037)
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- TOC entry 3790 (class 2606 OID 17039)
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- TOC entry 3792 (class 2606 OID 17041)
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- TOC entry 3794 (class 2606 OID 17043)
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- TOC entry 3810 (class 2606 OID 17045)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3913 (class 2606 OID 17047)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3712 (class 1259 OID 17048)
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- TOC entry 3713 (class 1259 OID 17049)
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- TOC entry 3638 (class 1259 OID 17050)
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- TOC entry 3641 (class 1259 OID 17051)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3651 (class 1259 OID 17052)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- TOC entry 3644 (class 1259 OID 17053)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- TOC entry 3645 (class 1259 OID 17054)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3648 (class 1259 OID 17055)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- TOC entry 3681 (class 1259 OID 17056)
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- TOC entry 3663 (class 1259 OID 17057)
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- TOC entry 3658 (class 1259 OID 17058)
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- TOC entry 3668 (class 1259 OID 17059)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- TOC entry 3676 (class 1259 OID 17060)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3682 (class 1259 OID 17061)
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- TOC entry 3802 (class 1259 OID 17062)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3683 (class 1259 OID 17063)
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3693 (class 1259 OID 17064)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- TOC entry 3689 (class 1259 OID 17065)
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- TOC entry 3690 (class 1259 OID 17066)
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- TOC entry 3696 (class 1259 OID 17067)
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- TOC entry 3697 (class 1259 OID 17068)
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- TOC entry 3703 (class 1259 OID 17069)
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- TOC entry 3704 (class 1259 OID 17070)
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- TOC entry 3709 (class 1259 OID 17071)
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3740 (class 1259 OID 17072)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3741 (class 1259 OID 17073)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- TOC entry 3714 (class 1259 OID 17074)
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3717 (class 1259 OID 17075)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3718 (class 1259 OID 17076)
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3719 (class 1259 OID 17077)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3724 (class 1259 OID 17078)
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3725 (class 1259 OID 17079)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3728 (class 1259 OID 17080)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3729 (class 1259 OID 17081)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3732 (class 1259 OID 17082)
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3733 (class 1259 OID 17083)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3736 (class 1259 OID 17084)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3737 (class 1259 OID 17085)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3746 (class 1259 OID 17086)
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- TOC entry 3747 (class 1259 OID 17087)
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- TOC entry 3750 (class 1259 OID 17088)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- TOC entry 3762 (class 1259 OID 17089)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3753 (class 1259 OID 17090)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- TOC entry 3754 (class 1259 OID 17091)
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- TOC entry 3755 (class 1259 OID 17092)
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- TOC entry 3775 (class 1259 OID 17093)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- TOC entry 3776 (class 1259 OID 17094)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- TOC entry 3784 (class 1259 OID 17095)
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- TOC entry 3785 (class 1259 OID 17096)
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- TOC entry 3786 (class 1259 OID 17097)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 3797 (class 1259 OID 17098)
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- TOC entry 3854 (class 1259 OID 17099)
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- TOC entry 3855 (class 1259 OID 17100)
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- TOC entry 3803 (class 1259 OID 17101)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- TOC entry 3813 (class 1259 OID 17102)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- TOC entry 3671 (class 1259 OID 17103)
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- TOC entry 3818 (class 1259 OID 17104)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3824 (class 1259 OID 17105)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3821 (class 1259 OID 17106)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3808 (class 1259 OID 17107)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- TOC entry 3833 (class 1259 OID 17108)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3836 (class 1259 OID 17109)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- TOC entry 3841 (class 1259 OID 17110)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- TOC entry 3846 (class 1259 OID 17111)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- TOC entry 3849 (class 1259 OID 17112)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- TOC entry 3860 (class 1259 OID 17113)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3865 (class 1259 OID 17114)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3870 (class 1259 OID 17115)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3877 (class 1259 OID 17116)
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- TOC entry 3880 (class 1259 OID 17117)
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- TOC entry 3684 (class 1259 OID 17118)
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3883 (class 1259 OID 17119)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- TOC entry 3886 (class 1259 OID 17120)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- TOC entry 3779 (class 1259 OID 17121)
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- TOC entry 3904 (class 1259 OID 17122)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3905 (class 1259 OID 17123)
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- TOC entry 3891 (class 1259 OID 17124)
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- TOC entry 3892 (class 1259 OID 17125)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- TOC entry 3897 (class 1259 OID 17126)
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- TOC entry 3700 (class 1259 OID 17127)
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- TOC entry 3908 (class 1259 OID 17128)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- TOC entry 3927 (class 1259 OID 17129)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- TOC entry 3930 (class 1259 OID 17130)
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- TOC entry 3933 (class 1259 OID 17131)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- TOC entry 3909 (class 1259 OID 17132)
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- TOC entry 3918 (class 1259 OID 17133)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3919 (class 1259 OID 17134)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3924 (class 1259 OID 17135)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3936 (class 1259 OID 17136)
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- TOC entry 3893 (class 1259 OID 17137)
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- TOC entry 3894 (class 1259 OID 17138)
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: admin_temporary
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- TOC entry 3957 (class 2606 OID 17139)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3943 (class 2606 OID 17144)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3954 (class 2606 OID 17149)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3945 (class 2606 OID 17154)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3973 (class 2606 OID 17159)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3999 (class 2606 OID 17164)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3970 (class 2606 OID 17169)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3975 (class 2606 OID 17174)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3992 (class 2606 OID 17179)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 4001 (class 2606 OID 17184)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3961 (class 2606 OID 17189)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- TOC entry 3971 (class 2606 OID 17194)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3966 (class 2606 OID 17199)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3950 (class 2606 OID 17204)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3939 (class 2606 OID 17209)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- TOC entry 3940 (class 2606 OID 17214)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3941 (class 2606 OID 17219)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3942 (class 2606 OID 17224)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4002 (class 2606 OID 17229)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3946 (class 2606 OID 17234)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3947 (class 2606 OID 17239)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3963 (class 2606 OID 17244)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3944 (class 2606 OID 17249)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3949 (class 2606 OID 17254)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- TOC entry 3948 (class 2606 OID 17259)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3967 (class 2606 OID 17264)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3998 (class 2606 OID 17269)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- TOC entry 3996 (class 2606 OID 17274)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3997 (class 2606 OID 17279)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3937 (class 2606 OID 17284)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3990 (class 2606 OID 17289)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3980 (class 2606 OID 17294)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3985 (class 2606 OID 17299)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3981 (class 2606 OID 17304)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3982 (class 2606 OID 17309)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3938 (class 2606 OID 17314)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3991 (class 2606 OID 17319)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3983 (class 2606 OID 17324)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3984 (class 2606 OID 17329)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3978 (class 2606 OID 17334)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3976 (class 2606 OID 17339)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3977 (class 2606 OID 17344)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3979 (class 2606 OID 17349)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3986 (class 2606 OID 17354)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3951 (class 2606 OID 17359)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3994 (class 2606 OID 17364)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- TOC entry 3993 (class 2606 OID 17369)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3955 (class 2606 OID 17374)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3956 (class 2606 OID 17379)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3968 (class 2606 OID 17384)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3969 (class 2606 OID 17389)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3959 (class 2606 OID 17394)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3960 (class 2606 OID 17399)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- TOC entry 4003 (class 2606 OID 17404)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3989 (class 2606 OID 17409)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3964 (class 2606 OID 17414)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3952 (class 2606 OID 17419)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3965 (class 2606 OID 17424)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- TOC entry 3953 (class 2606 OID 17429)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3974 (class 2606 OID 17434)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3987 (class 2606 OID 17439)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3988 (class 2606 OID 17444)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3972 (class 2606 OID 17449)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3995 (class 2606 OID 17454)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 4000 (class 2606 OID 17459)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3962 (class 2606 OID 17464)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3958 (class 2606 OID 17469)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: admin_temporary
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


-- Completed on 2025-07-30 12:01:09

--
-- PostgreSQL database dump complete
--

