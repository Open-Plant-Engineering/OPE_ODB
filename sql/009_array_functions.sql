-- =====================================================
-- ADD STRING ARRAY VALUE
-- =====================================================

create or replace function add_string_array_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,

    p_sequence_no   integer,

    p_value         text
)
returns void
language plpgsql
as
$$
declare
    v_string_id bigint;
begin

    v_string_id := get_or_create_string_id(p_value);

    insert into array_string
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        string_id
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no,
        v_string_id
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do update
    set
        string_id = excluded.string_id,
        is_deleted = false;

end;
$$;

comment on function add_string_array_value
(
    bigint,
    bigint,
    integer,
    integer,
    text
)
is
'Adds or updates a string array value';


-- =====================================================
-- ADD NUMBER ARRAY VALUE
-- =====================================================

create or replace function add_number_array_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,

    p_sequence_no   integer,

    p_value         double precision
)
returns void
language plpgsql
as
$$
begin

    insert into array_number
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        value
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no,
        p_value
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do update
    set
        value = excluded.value,
        is_deleted = false;

end;
$$;

comment on function add_number_array_value
(
    bigint,
    bigint,
    integer,
    integer,
    double precision
)
is
'Adds or updates a number array value';


create or replace function add_logical_array_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,

    p_sequence_no   integer,

    p_value         boolean
)
returns void
language plpgsql
as
$$
begin

    insert into array_logical
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        value
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no,
        p_value
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do update
    set
        value = excluded.value,
        is_deleted = false;

end;
$$;

comment on function add_logical_array_value
(
    bigint,
    bigint,
    integer,
    integer,
    boolean
)
is
'Adds or updates a logical array value';


create or replace function add_reference_array_value
(
    p_container_id      bigint,
    p_local_id          bigint,
    p_attribute_id      integer,

    p_sequence_no       integer,

    p_ref_container_id  bigint,
    p_ref_local_id      bigint
)
returns void
language plpgsql
as
$$
begin

    insert into array_reference
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        ref_container_id,
        ref_local_id
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no,
        p_ref_container_id,
        p_ref_local_id
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do update
    set
        ref_container_id = excluded.ref_container_id,
        ref_local_id     = excluded.ref_local_id,
        is_deleted = false;

end;
$$;

comment on function add_reference_array_value
(
    bigint,
    bigint,
    integer,
    integer,
    bigint,
    bigint
)
is
'Adds or updates a reference array value';


create or replace function add_position_array_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,

    p_sequence_no   integer,

    p_x_value       double precision,
    p_y_value       double precision,
    p_z_value       double precision
)
returns void
language plpgsql
as
$$
declare
    v_vector3_id bigint;
begin

    v_vector3_id := get_or_create_vector3_id
    (
        p_x_value,
        p_y_value,
        p_z_value
    );

    insert into array_position
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        vector3_id
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no,
        v_vector3_id
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do update
    set
        vector3_id = excluded.vector3_id,
        is_deleted = false;

end;
$$;

comment on function add_position_array_value
(
    bigint,
    bigint,
    integer,
    integer,
    double precision,
    double precision,
    double precision
)
is
'Adds or updates a position array value';


create or replace function add_direction_array_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,
    p_sequence_no   integer,
    p_x_value       double precision,
    p_y_value       double precision,
    p_z_value       double precision
)
returns void
language plpgsql
as
$$
declare
    v_vector3_id bigint;
begin

    v_vector3_id := get_or_create_vector3_id
    (
        p_x_value,
        p_y_value,
        p_z_value
    );

    insert into array_direction
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        vector3_id
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no,
        v_vector3_id
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do update
    set
        vector3_id = excluded.vector3_id,
        is_deleted = false;

end;
$$;

comment on function add_direction_array_value
(
    bigint,
    bigint,
    integer,
    integer,
    double precision,
    double precision,
    double precision
)
is
'Adds or updates a direction array value';


create or replace function add_orientation_array_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,
    p_sequence_no   integer,
    p_x_value       double precision,
    p_y_value       double precision,
    p_z_value       double precision
)
returns void
language plpgsql
as
$$
declare
    v_vector3_id bigint;
begin

    v_vector3_id := get_or_create_vector3_id
    (
        p_x_value,
        p_y_value,
        p_z_value
    );

    insert into array_orientation
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        vector3_id
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no,
        v_vector3_id
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do update
    set
        vector3_id = excluded.vector3_id,
        is_deleted = false;

end;
$$;

comment on function add_orientation_array_value
(
    bigint,
    bigint,
    integer,
    integer,
    double precision,
    double precision,
    double precision
)
is
'Adds or updates an orientation array value';


-- =====================================================
-- ADD DATETIME ARRAY VALUE
-- =====================================================

create or replace function add_datetime_array_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,

    p_sequence_no   integer,

    p_value         timestamp
)
returns void
language plpgsql
as
$$
begin

    insert into array_datetime
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        value
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no,
        p_value
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do update
    set
        value = excluded.value,
        is_deleted = false;

end;
$$;

comment on function add_datetime_array_value
(
    bigint,
    bigint,
    integer,
    integer,
    timestamp
)
is
'Adds or updates a datetime array value';

-- =====================================================
-- ADD JSON ARRAY VALUE
-- =====================================================

create or replace function add_json_array_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,

    p_sequence_no   integer,

    p_value         jsonb
)
returns void
language plpgsql
as
$$
begin

    insert into array_json
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        value
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no,
        p_value
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do update
    set
        value = excluded.value,
        is_deleted = false;

end;
$$;

comment on function add_json_array_value
(
    bigint,
    bigint,
    integer,
    integer,
    jsonb
)
is
'Adds or updates a JSON array value';

-- =====================================================
-- ADD BLOB ARRAY VALUE
-- =====================================================

create or replace function add_blob_array_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,

    p_sequence_no   integer,

    p_value         bytea
)
returns void
language plpgsql
as
$$
begin

    insert into array_blob
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        value
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no,
        p_value
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do update
    set
        value = excluded.value,
        is_deleted = false;

end;
$$;

comment on function add_blob_array_value
(
    bigint,
    bigint,
    integer,
    integer,
    bytea
)
is
'Adds or updates a BLOB array value';

-- =====================================================
-- ADD UUID ARRAY VALUE
-- =====================================================

create or replace function add_uuid_array_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,

    p_sequence_no   integer,

    p_value         uuid
)
returns void
language plpgsql
as
$$
begin

    insert into array_uuid
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        value
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no,
        p_value
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do update
    set
        value = excluded.value,
        is_deleted = false;

end;
$$;

comment on function add_uuid_array_value
(
    bigint,
    bigint,
    integer,
    integer,
    uuid
)
is
'Adds or updates a UUID array value';


