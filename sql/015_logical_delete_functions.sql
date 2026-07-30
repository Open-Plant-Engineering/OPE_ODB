-- =====================================================
-- DELETE ELEMENT
-- =====================================================

create or replace function delete_element
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint
)
returns void
language plpgsql
as
$$
begin

    perform save_history_element
    (
        p_revision_id,
        p_container_id,
        p_local_id
    );

    update element
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id;

end;
$$;

comment on function delete_element
(
    bigint,
    bigint,
    bigint
)
is
'Logically deletes an element';


-- =====================================================
-- DELETE STRING VALUE
-- =====================================================

create or replace function delete_string_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_string
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id
    );

    update value_string
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;

comment on function delete_string_value
(
    bigint,
    bigint,
    bigint,
    integer
)
is
'Logically deletes a string value';


create or replace function delete_number_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_number
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id
    );

    update value_number
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;


create or replace function delete_logical_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_logical
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id
    );

    update value_logical
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;


create or replace function delete_reference_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_reference
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id
    );

    update value_reference
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;


create or replace function delete_position_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_position
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id
    );

    update value_position
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;


create or replace function delete_direction_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_direction
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id
    );

    update value_direction
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;


create or replace function delete_orientation_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_orientation
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id
    );

    update value_orientation
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;


create or replace function delete_datetime_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_datetime
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id
    );

    update value_datetime
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;


create or replace function delete_json_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_json
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id
    );

    update value_json
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;


create or replace function delete_blob_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_blob
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id
    );

    update value_blob
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;


create or replace function delete_uuid_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_uuid
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id
    );

    update value_uuid
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;


