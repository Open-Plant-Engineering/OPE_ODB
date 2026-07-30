-- =====================================================
-- DELETE ARRAY STRING VALUE
-- =====================================================

create or replace function delete_array_string_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_array_string
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no
    );

    update array_string
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;

comment on function delete_array_string_value
(
    bigint,
    bigint,
    bigint,
    integer,
    integer
)
is
'Logically deletes a string array value';


create or replace function delete_array_number_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_array_number
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no
    );

    update array_number
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;


create or replace function delete_array_logical_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_array_logical
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no
    );

    update array_logical
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;


create or replace function delete_array_reference_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_array_reference
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no
    );

    update array_reference
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;


create or replace function delete_array_position_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_array_position
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no
    );

    update array_position
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;


create or replace function delete_array_direction_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_array_direction
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no
    );

    update array_direction
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;


create or replace function delete_array_orientation_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_array_orientation
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no
    );

    update array_orientation
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;


create or replace function delete_array_datetime_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_array_datetime
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no
    );

    update array_datetime
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;


create or replace function delete_array_json_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_array_json
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no
    );

    update array_json
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;


create or replace function delete_array_blob_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_array_blob
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no
    );

    update array_blob
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;


create or replace function delete_array_uuid_value
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns void
language plpgsql
as
$$
begin

    perform save_history_array_uuid
    (
        p_revision_id,
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_sequence_no
    );

    update array_uuid
    set
        is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;

