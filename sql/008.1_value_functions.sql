-- =====================================================
-- SET STRING VALUE
-- =====================================================

create or replace function set_string_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,
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

    insert into value_string
    (
        container_id,
        local_id,
        attribute_id,
        string_id
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        v_string_id
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id
    )
    do update
    set
        string_id = excluded.string_id;

end;
$$;

comment on function set_string_value
(
    bigint,
    bigint,
    integer,
    text
)
is
'Sets a string value for an element attribute';


-- =====================================================
-- SET NUMBER VALUE
-- =====================================================

create or replace function set_number_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,
    p_value         double precision
)
returns void
language plpgsql
as
$$
begin

    insert into value_number
    (
        container_id,
        local_id,
        attribute_id,
        value
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_value
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id
    )
    do update
    set
        value = excluded.value;

end;
$$;

comment on function set_number_value
(
    bigint,
    bigint,
    integer,
    double precision
)
is
'Sets a number value for an element attribute';

-- =====================================================
-- SET LOGICAL VALUE
-- =====================================================

create or replace function set_logical_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,
    p_value         boolean
)
returns void
language plpgsql
as
$$
begin

    insert into value_logical
    (
        container_id,
        local_id,
        attribute_id,
        value
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_value
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id
    )
    do update
    set
        value = excluded.value;

end;
$$;

comment on function set_logical_value
(
    bigint,
    bigint,
    integer,
    boolean
)
is
'Sets a logical value for an element attribute';

-- =====================================================
-- SET REFERENCE VALUE
-- =====================================================

create or replace function set_reference_value
(
    p_container_id      bigint,
    p_local_id          bigint,
    p_attribute_id      integer,

    p_ref_container_id  bigint,
    p_ref_local_id      bigint
)
returns void
language plpgsql
as
$$
begin

    insert into value_reference
    (
        container_id,
        local_id,
        attribute_id,
        ref_container_id,
        ref_local_id
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_ref_container_id,
        p_ref_local_id
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id
    )
    do update
    set
        ref_container_id = excluded.ref_container_id,
        ref_local_id     = excluded.ref_local_id;

end;
$$;

comment on function set_reference_value
(
    bigint,
    bigint,
    integer,
    bigint,
    bigint
)
is
'Sets a reference value for an element attribute';


-- =====================================================
-- SET POSITION VALUE
-- =====================================================

create or replace function set_position_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,

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

    v_vector3_id :=
        get_or_create_vector3_id
        (
            p_x_value,
            p_y_value,
            p_z_value
        );

    insert into value_position
    (
        container_id,
        local_id,
        attribute_id,
        vector3_id
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        v_vector3_id
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id
    )
    do update
    set
        vector3_id = excluded.vector3_id;

end;
$$;

comment on function set_position_value
(
    bigint,
    bigint,
    integer,
    double precision,
    double precision,
    double precision
)
is
'Sets a position value for an element attribute';


-- =====================================================
-- SET DIRECTION VALUE
-- =====================================================

create or replace function set_direction_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,

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

    v_vector3_id :=
        get_or_create_vector3_id
        (
            p_x_value,
            p_y_value,
            p_z_value
        );

    insert into value_direction
    (
        container_id,
        local_id,
        attribute_id,
        vector3_id
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        v_vector3_id
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id
    )
    do update
    set
        vector3_id = excluded.vector3_id;

end;
$$;

comment on function set_direction_value
(
    bigint,
    bigint,
    integer,
    double precision,
    double precision,
    double precision
)
is
'Sets a direction value for an element attribute';

-- =====================================================
-- SET ORIENTATION VALUE
-- =====================================================

create or replace function set_orientation_value
(
    p_container_id  bigint,
    p_local_id      bigint,
    p_attribute_id  integer,

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

    v_vector3_id :=
        get_or_create_vector3_id
        (
            p_x_value,
            p_y_value,
            p_z_value
        );

    insert into value_orientation
    (
        container_id,
        local_id,
        attribute_id,
        vector3_id
    )
    values
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        v_vector3_id
    )
    on conflict
    (
        container_id,
        local_id,
        attribute_id
    )
    do update
    set
        vector3_id = excluded.vector3_id;

end;
$$;

comment on function set_orientation_value
(
    bigint,
    bigint,
    integer,
    double precision,
    double precision,
    double precision
)
is
'Sets an orientation value for an element attribute';