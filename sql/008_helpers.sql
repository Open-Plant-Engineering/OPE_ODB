-- =====================================================
-- GET OR CREATE STRING ID
-- =====================================================

create or replace function get_or_create_string_id
(
    p_string_value text
)
returns bigint
language plpgsql
as
$$
declare
    v_string_id bigint;
begin

    insert into string_pool
    (
        string_value
    )
    values
    (
        p_string_value
    )
    on conflict (string_value)
    do nothing;

    select string_id
    into v_string_id
    from string_pool
    where string_value = p_string_value;

    return v_string_id;

end;
$$;

comment on function get_or_create_string_id
(
    text
)
is
'Returns an existing string identifier or creates a new string entry';


-- =====================================================
-- GET OR CREATE VECTOR3 ID
-- =====================================================

create or replace function get_or_create_vector3_id
(
    p_x_value double precision,
    p_y_value double precision,
    p_z_value double precision
)
returns bigint
language plpgsql
as
$$
declare
    v_vector3_id bigint;
begin

    insert into vector3_pool
    (
        x_value,
        y_value,
        z_value
    )
    values
    (
        p_x_value,
        p_y_value,
        p_z_value
    )
    on conflict
    (
        x_value,
        y_value,
        z_value
    )
    do nothing;

    select vector3_id
    into v_vector3_id
    from vector3_pool
    where x_value = p_x_value
      and y_value = p_y_value
      and z_value = p_z_value;

    return v_vector3_id;

end;
$$;

comment on function get_or_create_vector3_id
(
    double precision,
    double precision,
    double precision
)
is
'Returns an existing vector identifier or creates a new vector entry';

