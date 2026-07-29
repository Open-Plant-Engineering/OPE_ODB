-- =====================================================
-- OPE_ODB
-- Logical Delete Functions
-- =====================================================

-- =====================================================
-- ELEMENT
-- =====================================================

create or replace function logical_delete_element
(
    p_container_id bigint,
    p_local_id     bigint
)
returns void
language plpgsql
as
$$
begin

    update element
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id;

end;
$$;

comment on function logical_delete_element
(
    bigint,
    bigint
)
is
'Logically deletes an element';

create or replace function restore_element
(
    p_container_id bigint,
    p_local_id     bigint
)
returns void
language plpgsql
as
$$
begin

    update element
    set is_deleted = false
    where container_id = p_container_id
      and local_id     = p_local_id;

end;
$$;

comment on function restore_element
(
    bigint,
    bigint
)
is
'Restores a logically deleted element';

-- =====================================================
-- VALUE TABLES
-- =====================================================

create or replace function logical_delete_string_value
(
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    update value_string
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;

create or replace function logical_delete_number_value
(
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    update value_number
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;

create or replace function logical_delete_logical_value
(
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    update value_logical
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;

create or replace function logical_delete_reference_value
(
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    update value_reference
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;

create or replace function logical_delete_position_value
(
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    update value_position
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;

create or replace function logical_delete_direction_value
(
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    update value_direction
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;

create or replace function logical_delete_orientation_value
(
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    update value_orientation
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;

create or replace function logical_delete_datetime_value
(
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    update value_datetime
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;

create or replace function logical_delete_json_value
(
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    update value_json
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;

create or replace function logical_delete_blob_value
(
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    update value_blob
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;

create or replace function logical_delete_uuid_value
(
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    update value_uuid
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id;

end;
$$;

-- =====================================================
-- ARRAY TABLES
-- =====================================================

create or replace function logical_delete_string_array_value
(
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

    update array_string
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;

create or replace function logical_delete_number_array_value
(
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

    update array_number
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;

create or replace function logical_delete_logical_array_value
(
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

    update array_logical
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;

create or replace function logical_delete_reference_array_value
(
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

    update array_reference
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;

create or replace function logical_delete_position_array_value
(
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

    update array_position
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;

create or replace function logical_delete_direction_array_value
(
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

    update array_direction
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;

create or replace function logical_delete_orientation_array_value
(
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

    update array_orientation
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;

create or replace function logical_delete_datetime_array_value
(
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

    update array_datetime
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;

create or replace function logical_delete_json_array_value
(
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

    update array_json
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;

create or replace function logical_delete_blob_array_value
(
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

    update array_blob
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;

create or replace function logical_delete_uuid_array_value
(
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

    update array_uuid
    set is_deleted = true
    where container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no;

end;
$$;