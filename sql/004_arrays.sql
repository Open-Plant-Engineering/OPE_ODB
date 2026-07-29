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

    is_deleted      boolean not null default false,

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

comment on column array_string.is_deleted is
'Logical delete flag. False = active, True = deleted';

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

    is_deleted      boolean not null default false,

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

comment on column array_number.is_deleted is
'Logical delete flag. False = active, True = deleted';

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

    is_deleted      boolean not null default false,

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

comment on column array_logical.is_deleted is
'Logical delete flag. False = active, True = deleted';

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

    is_deleted      boolean not null default false,

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

comment on column array_reference.is_deleted is
'Logical delete flag. False = active, True = deleted';

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

    is_deleted      boolean not null default false,

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

comment on column array_position.is_deleted is
'Logical delete flag. False = active, True = deleted';


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

    is_deleted      boolean not null default false,

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

comment on column array_direction.is_deleted is
'Logical delete flag. False = active, True = deleted';

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

    is_deleted      boolean not null default false,

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

comment on column array_orientation.is_deleted is
'Logical delete flag. False = active, True = deleted';

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

    is_deleted      boolean not null default false,

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

comment on column array_datetime.is_deleted is
'Logical delete flag. False = active, True = deleted';

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

    is_deleted      boolean not null default false,

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

comment on column array_json.is_deleted is
'Logical delete flag. False = active, True = deleted';

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

    is_deleted      boolean not null default false,

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

comment on column array_blob.is_deleted is
'Logical delete flag. False = active, True = deleted';

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

    is_deleted      boolean not null default false,

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

comment on column array_uuid.is_deleted is
'Logical delete flag. False = active, True = deleted';