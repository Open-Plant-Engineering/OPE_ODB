-- =====================================================
-- EODB - INITIAL SCHEMA
-- Phase 1 : E3D Data Import
-- =====================================================

-- =====================================================
-- NODE TYPES
-- =====================================================

create table node_type
(
    type_id         smallint primary key,
    type_name       varchar(64) not null unique
);

-- =====================================================
-- ATTRIBUTE DEFINITIONS
-- =====================================================

create table attribute_definition
(
    attribute_id        integer generated always as identity primary key,

    attribute_name      varchar(128) not null unique,

    data_type           smallint not null,

    data_length        integer not null default 1
);

comment on column attribute_definition.data_length is
'E3D datatype length/size metadata. For TEXT = max length, for arrays = element count, for POSITION/DIRECTION/ORIENTATION = component count.';

-- =====================================================
-- TYPE ATTRIBUTE MAPPING
-- =====================================================

create table type_attribute
(
    type_id         smallint not null,
    attribute_id    integer not null,

    primary key
    (
        type_id,
        attribute_id
    ),

    constraint fk_type_attribute_type
        foreign key (type_id)
        references node_type(type_id),

    constraint fk_type_attribute_attribute
        foreign key (attribute_id)
        references attribute_definition(attribute_id)
);

-- =====================================================
-- ELEMENTS
-- =====================================================

create table element
(
    container_id        bigint not null,
    local_id            bigint not null,

    type_id             smallint not null,

    owner_container_id  bigint,
    owner_local_id      bigint,

    owner_index         integer not null default 0,

    primary key
    (
        container_id,
        local_id
    ),

    constraint fk_element_type
        foreign key (type_id)
        references node_type(type_id)
);

-- =====================================================
-- STRING POOL
-- =====================================================

create table string_pool
(
    string_id       bigint generated always as identity primary key,

    string_value    text not null unique
);

-- =====================================================
-- TEXT VALUES
-- =====================================================

create table value_string
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    string_id       bigint not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_vs_attr
        foreign key (attribute_id)
        references attribute_definition(attribute_id),

    constraint fk_vs_string
        foreign key (string_id)
        references string_pool(string_id)
);

-- =====================================================
-- REAL VALUES
-- =====================================================

create table value_real
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value_real      double precision not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_vr_attr
        foreign key (attribute_id)
        references attribute_definition(attribute_id)
);

-- =====================================================
-- INTEGER VALUES
-- =====================================================

create table value_integer
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value_integer   bigint not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_vi_attr
        foreign key (attribute_id)
        references attribute_definition(attribute_id)
);

-- =====================================================
-- LOGICAL VALUES
-- =====================================================

create table value_logical
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value_logical   boolean not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_vl_attr
        foreign key (attribute_id)
        references attribute_definition(attribute_id)
);

-- =====================================================
-- WORD VALUES
-- =====================================================

create table value_word
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value_word      integer not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_vw_attr
        foreign key (attribute_id)
        references attribute_definition(attribute_id)
);

-- =====================================================
-- REFERENCE VALUES
-- =====================================================

create table value_reference
(
    container_id        bigint not null,
    local_id            bigint not null,

    attribute_id        integer not null,

    ref_container_id    bigint not null,
    ref_local_id        bigint not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_vref_attr
        foreign key (attribute_id)
        references attribute_definition(attribute_id)
);

-- =====================================================
-- POSITION VALUES
-- =====================================================

create table value_position
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    x_value         double precision not null,
    y_value         double precision not null,
    z_value         double precision not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_vp_attr
        foreign key (attribute_id)
        references attribute_definition(attribute_id)
);

-- =====================================================
-- DIRECTION VALUES
-- =====================================================

create table value_direction
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    x_value         double precision not null,
    y_value         double precision not null,
    z_value         double precision not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_vd_attr
        foreign key (attribute_id)
        references attribute_definition(attribute_id)
);

-- =====================================================
-- ORIENTATION VALUES
-- =====================================================

create table value_orientation
(
    container_id        bigint not null,
    local_id            bigint not null,

    attribute_id        integer not null,

    orientation_text    text not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_vo_attr
        foreign key (attribute_id)
        references attribute_definition(attribute_id)
);

-- =====================================================
-- DATETIME VALUES
-- =====================================================

create table value_datetime
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value_datetime  timestamp,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_vdt_attr
        foreign key (attribute_id)
        references attribute_definition(attribute_id)
);

-- =====================================================
-- UNKNOWN VALUES
-- =====================================================

create table value_unknown
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value_text      text not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_vu_attr
        foreign key (attribute_id)
        references attribute_definition(attribute_id)
);

-- =====================================================
-- STRING ARRAYS
-- =====================================================

create table array_string
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    array_index     integer not null,

    string_id       bigint not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        array_index
    )
);

-- =====================================================
-- REAL ARRAYS
-- =====================================================

create table array_real
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    array_index     integer not null,

    value_real      double precision not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        array_index
    )
);

-- =====================================================
-- INTEGER ARRAYS
-- =====================================================

create table array_integer
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    array_index     integer not null,

    value_integer   bigint not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        array_index
    )
);

-- =====================================================
-- LOGICAL ARRAYS
-- =====================================================

create table array_logical
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    array_index     integer not null,

    value_logical   boolean not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        array_index
    )
);

-- =====================================================
-- REFERENCE ARRAYS
-- =====================================================

create table array_reference
(
    container_id        bigint not null,
    local_id            bigint not null,

    attribute_id        integer not null,

    array_index         integer not null,

    ref_container_id    bigint not null,
    ref_local_id        bigint not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        array_index
    )
);

-- =====================================================
-- POSITION ARRAYS
-- =====================================================

create table array_position
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    array_index     integer not null,

    x_value         double precision not null,
    y_value         double precision not null,
    z_value         double precision not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        array_index
    )
);

-- =====================================================
-- DIRECTION ARRAYS
-- =====================================================

create table array_direction
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    array_index     integer not null,

    x_value         double precision not null,
    y_value         double precision not null,
    z_value         double precision not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        array_index
    )
);

-- =====================================================
-- DATETIME ARRAYS
-- =====================================================

create table array_datetime
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    array_index     integer not null,

    value_datetime  timestamp,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        array_index
    )
);

-- =====================================================
-- UNKNOWN ARRAYS
-- =====================================================

create table array_unknown
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    array_index     integer not null,

    value_text      text not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        array_index
    )
);