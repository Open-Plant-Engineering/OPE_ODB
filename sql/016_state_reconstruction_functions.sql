-- =====================================================
-- GET HISTORY STRING BEFORE REVISION
-- =====================================================

create or replace function get_history_string_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns bigint
language sql
stable
as
$$
    select string_id
    from history_string
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;

comment on function get_history_string_before_revision
(
    bigint,
    bigint,
    bigint,
    integer
)
is
'Returns the latest historical string state before or at a revision';


create or replace function get_history_number_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns double precision
language sql
stable
as
$$
    select value
    from history_number
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_logical_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns boolean
language sql
stable
as
$$
    select value
    from history_logical
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_reference_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns history_reference
language sql
stable
as
$$
    select *
    from history_reference
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_position_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns bigint
language sql
stable
as
$$
    select vector3_id
    from history_position
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_direction_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns bigint
language sql
stable
as
$$
    select vector3_id
    from history_direction
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_orientation_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns bigint
language sql
stable
as
$$
    select vector3_id
    from history_orientation
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_datetime_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns timestamp
language sql
stable
as
$$
    select value
    from history_datetime
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_json_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns jsonb
language sql
stable
as
$$
    select value
    from history_json
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_blob_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns bytea
language sql
stable
as
$$
    select value
    from history_blob
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_uuid_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns uuid
language sql
stable
as
$$
    select value
    from history_uuid
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_string_deleted_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns boolean
language sql
stable
as
$$
    select is_deleted
    from history_string
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_array_string_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns bigint
language sql
stable
as
$$
    select string_id
    from history_array_string
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no
    order by revision_id desc
    limit 1;
$$;


-- =====================================================
-- DELETED STATE HELPERS
-- =====================================================

create or replace function get_history_string_deleted_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns boolean
language sql
stable
as
$$
    select is_deleted
    from history_string
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_number_deleted_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns boolean
language sql
stable
as
$$
    select is_deleted
    from history_number
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_logical_deleted_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns boolean
language sql
stable
as
$$
    select is_deleted
    from history_logical
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_reference_deleted_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns boolean
language sql
stable
as
$$
    select is_deleted
    from history_reference
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_position_deleted_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns boolean
language sql
stable
as
$$
    select is_deleted
    from history_position
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_direction_deleted_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns boolean
language sql
stable
as
$$
    select is_deleted
    from history_direction
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_orientation_deleted_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns boolean
language sql
stable
as
$$
    select is_deleted
    from history_orientation
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_datetime_deleted_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns boolean
language sql
stable
as
$$
    select is_deleted
    from history_datetime
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_json_deleted_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns boolean
language sql
stable
as
$$
    select is_deleted
    from history_json
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_blob_deleted_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns boolean
language sql
stable
as
$$
    select is_deleted
    from history_blob
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_uuid_deleted_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns boolean
language sql
stable
as
$$
    select is_deleted
    from history_uuid
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


-- =====================================================
-- ARRAY HISTORY HELPERS
-- =====================================================

create or replace function get_history_array_string_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns bigint
language sql
stable
as
$$
    select string_id
    from history_array_string
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_array_number_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns double precision
language sql
stable
as
$$
    select value
    from history_array_number
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_array_logical_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns boolean
language sql
stable
as
$$
    select value
    from history_array_logical
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_array_reference_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns history_array_reference
language sql
stable
as
$$
    select *
    from history_array_reference
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_array_position_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns bigint
language sql
stable
as
$$
    select vector3_id
    from history_array_position
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_array_direction_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns bigint
language sql
stable
as
$$
    select vector3_id
    from history_array_direction
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_array_orientation_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns bigint
language sql
stable
as
$$
    select vector3_id
    from history_array_orientation
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_array_datetime_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns timestamp
language sql
stable
as
$$
    select value
    from history_array_datetime
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_array_json_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns jsonb
language sql
stable
as
$$
    select value
    from history_array_json
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_array_blob_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns bytea
language sql
stable
as
$$
    select value
    from history_array_blob
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_array_uuid_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns uuid
language sql
stable
as
$$
    select value
    from history_array_uuid
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_reference_container_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns bigint
language sql
stable
as
$$
    select ref_container_id
    from history_reference
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_reference_local_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer
)
returns bigint
language sql
stable
as
$$
    select ref_local_id
    from history_reference
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
    order by revision_id desc
    limit 1;
$$;



create or replace function get_history_array_reference_container_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns bigint
language sql
stable
as
$$
    select ref_container_id
    from history_array_reference
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no
    order by revision_id desc
    limit 1;
$$;


create or replace function get_history_array_reference_local_before_revision
(
    p_revision_id  bigint,
    p_container_id bigint,
    p_local_id     bigint,
    p_attribute_id integer,
    p_sequence_no  integer
)
returns bigint
language sql
stable
as
$$
    select ref_local_id
    from history_array_reference
    where revision_id <= p_revision_id
      and container_id = p_container_id
      and local_id     = p_local_id
      and attribute_id = p_attribute_id
      and sequence_no  = p_sequence_no
    order by revision_id desc
    limit 1;
$$;


