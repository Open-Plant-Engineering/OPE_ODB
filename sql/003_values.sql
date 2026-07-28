-- =====================================================
-- OPE_ODB
-- Values
-- =====================================================

-- =====================================================
-- STRING POOL
-- =====================================================

create table string_pool
(
    string_id       bigint generated always as identity primary key,

    string_value    text not null unique
);

comment on table string_pool is
'Deduplicated string storage';


-- =====================================================
-- VECTOR3 POOL
-- =====================================================

create table vector3_pool
(
    vector3_id      bigint generated always as identity primary key,

    x_value         double precision not null,
    y_value         double precision not null,
    z_value         double precision not null,

    unique
    (
        x_value,
        y_value,
        z_value
    )
);

comment on table vector3_pool is
'Reusable 3D vector storage for POSITION, DIRECTION and ORIENTATION values';

-- =====================================================
-- STRING VALUES
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

    constraint fk_value_string_element
        foreign key
        (
            container_id,
            local_id
        )
        references element
        (
            container_id,
            local_id
        ),

    constraint fk_value_string_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        ),

    constraint fk_value_string_pool
        foreign key
        (
            string_id
        )
        references string_pool
        (
            string_id
        )
);

comment on table value_string is
'STRING values (TEXT and WORD)';

-- =====================================================
-- NUMBER VALUES
-- =====================================================

create table value_number
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value           double precision not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_value_number_element
        foreign key
        (
            container_id,
            local_id
        )
        references element
        (
            container_id,
            local_id
        ),

    constraint fk_value_number_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        )
);

comment on table value_number is
'NUMBER values (REAL and INTEGER)';

-- =====================================================
-- LOGICAL VALUES
-- =====================================================

create table value_logical
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value           boolean not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_value_logical_element
        foreign key
        (
            container_id,
            local_id
        )
        references element
        (
            container_id,
            local_id
        ),

    constraint fk_value_logical_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        )
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

    constraint fk_value_reference_element
        foreign key
        (
            container_id,
            local_id
        )
        references element
        (
            container_id,
            local_id
        ),

    constraint fk_value_reference_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        ),

    constraint fk_value_reference_target
        foreign key
        (
            ref_container_id,
            ref_local_id
        )
        references element
        (
            container_id,
            local_id
        )
);


-- =====================================================
-- POSITION VALUES
-- =====================================================

create table value_position
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    vector3_id      bigint not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_value_position_element
        foreign key
        (
            container_id,
            local_id
        )
        references element
        (
            container_id,
            local_id
        ),

    constraint fk_value_position_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        ),

    constraint fk_value_position_vector
        foreign key
        (
            vector3_id
        )
        references vector3_pool
        (
            vector3_id
        )
);

-- =====================================================
-- DIRECTION VALUES
-- =====================================================

create table value_direction
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    vector3_id      bigint not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_value_direction_element
        foreign key
        (
            container_id,
            local_id
        )
        references element
        (
            container_id,
            local_id
        ),

    constraint fk_value_direction_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        ),

    constraint fk_value_direction_vector
        foreign key
        (
            vector3_id
        )
        references vector3_pool
        (
            vector3_id
        )
);

-- =====================================================
-- ORIENTATION VALUES
-- =====================================================

create table value_orientation
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    vector3_id      bigint not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_value_orientation_element
        foreign key
        (
            container_id,
            local_id
        )
        references element
        (
            container_id,
            local_id
        ),

    constraint fk_value_orientation_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        ),

    constraint fk_value_orientation_vector
        foreign key
        (
            vector3_id
        )
        references vector3_pool
        (
            vector3_id
        )
);

-- =====================================================
-- DATETIME VALUES
-- =====================================================

create table value_datetime
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value           timestamp not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_value_datetime_element
        foreign key
        (
            container_id,
            local_id
        )
        references element
        (
            container_id,
            local_id
        ),

    constraint fk_value_datetime_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        )
);

-- =====================================================
-- JSON VALUES
-- =====================================================

create table value_json
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value           jsonb not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_value_json_element
        foreign key
        (
            container_id,
            local_id
        )
        references element
        (
            container_id,
            local_id
        ),

    constraint fk_value_json_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        )
);

-- =====================================================
-- BLOB VALUES
-- =====================================================

create table value_blob
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value           bytea not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_value_blob_element
        foreign key
        (
            container_id,
            local_id
        )
        references element
        (
            container_id,
            local_id
        ),

    constraint fk_value_blob_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        )
);

-- =====================================================
-- UUID VALUES
-- =====================================================

create table value_uuid
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value           uuid not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_value_uuid_element
        foreign key
        (
            container_id,
            local_id
        )
        references element
        (
            container_id,
            local_id
        ),

    constraint fk_value_uuid_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        )
);