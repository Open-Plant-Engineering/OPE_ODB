-- =====================================================
-- OPE_ODB
-- Array Values
-- =====================================================

-- =====================================================
-- STRING ARRAYS
-- =====================================================

create table array_string
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    string_id       bigint not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_array_string_element
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

    constraint fk_array_string_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        ),

    constraint fk_array_string_pool
        foreign key
        (
            string_id
        )
        references string_pool
        (
            string_id
        )
);

comment on table array_string is
'Array of STRING values';

-- =====================================================
-- NUMBER ARRAYS
-- =====================================================

create table array_number
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    value           double precision not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_array_number_element
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

    constraint fk_array_number_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        )
);

comment on table array_number is
'Array of NUMBER values';

-- =====================================================
-- LOGICAL ARRAYS
-- =====================================================

create table array_logical
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    value           boolean not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_array_logical_element
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

    constraint fk_array_logical_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        )
);

comment on table array_logical is
'Array of LOGICAL values';

-- =====================================================
-- REFERENCE ARRAYS
-- =====================================================

create table array_reference
(
    container_id        bigint not null,
    local_id            bigint not null,

    attribute_id        integer not null,

    sequence_no         integer not null,

    ref_container_id    bigint not null,
    ref_local_id        bigint not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_array_reference_element
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

    constraint fk_array_reference_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        ),

    constraint fk_array_reference_target
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

comment on table array_reference is
'Array of REFERENCE values';

-- =====================================================
-- POSITION ARRAYS
-- =====================================================

create table array_position
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    vector3_id      bigint not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_array_position_element
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

    constraint fk_array_position_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        ),

    constraint fk_array_position_vector
        foreign key
        (
            vector3_id
        )
        references vector3_pool
        (
            vector3_id
        )
);

comment on table array_position is
'Array of POSITION values';

-- =====================================================
-- DIRECTION ARRAYS
-- =====================================================

create table array_direction
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    vector3_id      bigint not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_array_direction_element
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

    constraint fk_array_direction_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        ),

    constraint fk_array_direction_vector
        foreign key
        (
            vector3_id
        )
        references vector3_pool
        (
            vector3_id
        )
);

comment on table array_direction is
'Array of DIRECTION values';

-- =====================================================
-- ORIENTATION ARRAYS
-- =====================================================

create table array_orientation
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    vector3_id      bigint not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_array_orientation_element
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

    constraint fk_array_orientation_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        ),

    constraint fk_array_orientation_vector
        foreign key
        (
            vector3_id
        )
        references vector3_pool
        (
            vector3_id
        )
);

comment on table array_orientation is
'Array of ORIENTATION values';

-- =====================================================
-- DATETIME ARRAYS
-- =====================================================

create table array_datetime
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    value           timestamp not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_array_datetime_element
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

    constraint fk_array_datetime_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        )
);

comment on table array_datetime is
'Array of DATETIME values';

-- =====================================================
-- JSON ARRAYS
-- =====================================================

create table array_json
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    value           jsonb not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_array_json_element
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

    constraint fk_array_json_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        )
);

comment on table array_json is
'Array of JSON values';

-- =====================================================
-- BLOB ARRAYS
-- =====================================================

create table array_blob
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    value           bytea not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_array_blob_element
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

    constraint fk_array_blob_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        )
);

comment on table array_blob is
'Array of BLOB values';

-- =====================================================
-- UUID ARRAYS
-- =====================================================

create table array_uuid
(
    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    value           uuid not null,

    primary key
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_array_uuid_element
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

    constraint fk_array_uuid_attribute
        foreign key
        (
            attribute_id
        )
        references attribute_definition
        (
            attribute_id
        )
);

comment on table array_uuid is
'Array of UUID values';