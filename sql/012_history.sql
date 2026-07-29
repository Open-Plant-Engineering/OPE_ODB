-- =====================================================
-- OPE_ODB
-- History
-- =====================================================

-- =====================================================
-- HISTORY ELEMENT
-- =====================================================

create table history_element
(
    revision_id         bigint not null,

    container_id        bigint not null,
    local_id            bigint not null,

    type_id             smallint not null,

    owner_container_id  bigint not null,
    owner_local_id      bigint not null,

    sequence_no         integer not null,

    is_deleted          boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id
    ),

    constraint fk_history_element_revision
        foreign key
        (
            revision_id
        )
        references revision
        (
            revision_id
        )
);

comment on table history_element is
'Stores previous element state before hierarchy changes';

-- =====================================================
-- HISTORY STRING
-- =====================================================

create table history_string
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    string_id       bigint not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_history_string_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_string is
'Stores previous string values before modification';

create table history_number
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value           double precision not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_history_number_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_number is
'Stores previous number values before modification';


create table history_logical
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value           boolean not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_history_logical_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_logical is
'Stores previous logical values before modification';


create table history_reference
(
    revision_id         bigint not null,

    container_id        bigint not null,
    local_id            bigint not null,

    attribute_id        integer not null,

    ref_container_id    bigint not null,
    ref_local_id        bigint not null,

    is_deleted          boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_history_reference_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_reference is
'Stores previous reference values before modification';


create table history_position
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    vector3_id      bigint not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_history_position_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_position is
'Stores previous position values before modification';


create table history_direction
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    vector3_id      bigint not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_history_direction_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_direction is
'Stores previous direction values before modification';


create table history_orientation
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    vector3_id      bigint not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_history_orientation_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_orientation is
'Stores previous orientation values before modification';


create table history_datetime
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value           timestamp not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_history_datetime_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_datetime is
'Stores previous datetime values before modification';


create table history_json
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value           jsonb not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_history_json_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_json is
'Stores previous JSON values before modification';


create table history_blob
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value           bytea not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_history_blob_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_blob is
'Stores previous BLOB values before modification';


create table history_uuid
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    value           uuid not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    ),

    constraint fk_history_uuid_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_uuid is
'Stores previous UUID values before modification';


-- =====================================================
-- HISTORY ARRAY STRING
-- =====================================================

create table history_array_string
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    string_id       bigint not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_history_array_string_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_array_string is
'Stores previous string array values before modification';

-- =====================================================
-- HISTORY ARRAY NUMBER
-- =====================================================

create table history_array_number
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    value           double precision not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_history_array_number_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_array_number is
'Stores previous number array values before modification';

-- =====================================================
-- HISTORY ARRAY LOGICAL
-- =====================================================

create table history_array_logical
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    value           boolean not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_history_array_logical_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_array_logical is
'Stores previous logical array values before modification';

-- =====================================================
-- HISTORY ARRAY REFERENCE
-- =====================================================

create table history_array_reference
(
    revision_id         bigint not null,

    container_id        bigint not null,
    local_id            bigint not null,

    attribute_id        integer not null,

    sequence_no         integer not null,

    ref_container_id    bigint not null,
    ref_local_id        bigint not null,

    is_deleted          boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_history_array_reference_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_array_reference is
'Stores previous reference array values before modification';

-- =====================================================
-- HISTORY ARRAY POSITION
-- =====================================================

create table history_array_position
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    vector3_id      bigint not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_history_array_position_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_array_position is
'Stores previous position array values before modification';

-- =====================================================
-- HISTORY ARRAY DIRECTION
-- =====================================================

create table history_array_direction
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    vector3_id      bigint not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_history_array_direction_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_array_direction is
'Stores previous direction array values before modification';

-- =====================================================
-- HISTORY ARRAY ORIENTATION
-- =====================================================

create table history_array_orientation
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    vector3_id      bigint not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_history_array_orientation_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_array_orientation is
'Stores previous orientation array values before modification';

-- =====================================================
-- HISTORY ARRAY DATETIME
-- =====================================================

create table history_array_datetime
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    value           timestamp with time zone not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_history_array_datetime_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_array_datetime is
'Stores previous datetime array values before modification';

-- =====================================================
-- HISTORY ARRAY JSON
-- =====================================================

create table history_array_json
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    value           jsonb not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_history_array_json_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_array_json is
'Stores previous JSON array values before modification';

-- =====================================================
-- HISTORY ARRAY BLOB
-- =====================================================

create table history_array_blob
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    value           bytea not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_history_array_blob_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_array_blob is
'Stores previous BLOB array values before modification';

-- =====================================================
-- HISTORY ARRAY UUID
-- =====================================================

create table history_array_uuid
(
    revision_id     bigint not null,

    container_id    bigint not null,
    local_id        bigint not null,

    attribute_id    integer not null,

    sequence_no     integer not null,

    value           uuid not null,

    is_deleted      boolean not null,

    primary key
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    ),

    constraint fk_history_array_uuid_revision
        foreign key (revision_id)
        references revision(revision_id)
);

comment on table history_array_uuid is
'Stores previous UUID array values before modification';