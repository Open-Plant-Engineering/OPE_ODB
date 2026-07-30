-- =====================================================
-- SAVE HISTORY ARRAY STRING
-- =====================================================

create or replace function save_history_array_string
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

    insert into history_array_string
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        string_id,
        is_deleted
    )
    select
        p_revision_id,
        a.container_id,
        a.local_id,
        a.attribute_id,
        a.sequence_no,
        a.string_id,
        a.is_deleted
    from array_string a
    where a.container_id = p_container_id
      and a.local_id     = p_local_id
      and a.attribute_id = p_attribute_id
      and a.sequence_no  = p_sequence_no

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do nothing;

end;
$$;

comment on function save_history_array_string
(
    bigint,
    bigint,
    bigint,
    integer,
    integer
)
is
'Saves the original string array value state for a revision';


-- =====================================================
-- SAVE HISTORY ARRAY NUMBER
-- =====================================================

create or replace function save_history_array_number
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

    insert into history_array_number
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        value,
        is_deleted
    )
    select
        p_revision_id,
        a.container_id,
        a.local_id,
        a.attribute_id,
        a.sequence_no,
        a.value,
        a.is_deleted
    from array_number a
    where a.container_id = p_container_id
      and a.local_id     = p_local_id
      and a.attribute_id = p_attribute_id
      and a.sequence_no  = p_sequence_no

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do nothing;

end;
$$;

comment on function save_history_array_number
(
    bigint,
    bigint,
    bigint,
    integer,
    integer
)
is
'Saves the original number array value state for a revision';


-- =====================================================
-- SAVE HISTORY ARRAY LOGICAL
-- =====================================================

create or replace function save_history_array_logical
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

    insert into history_array_logical
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        value,
        is_deleted
    )
    select
        p_revision_id,
        a.container_id,
        a.local_id,
        a.attribute_id,
        a.sequence_no,
        a.value,
        a.is_deleted
    from array_logical a
    where a.container_id = p_container_id
      and a.local_id     = p_local_id
      and a.attribute_id = p_attribute_id
      and a.sequence_no  = p_sequence_no

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do nothing;

end;
$$;

comment on function save_history_array_logical
(
    bigint,
    bigint,
    bigint,
    integer,
    integer
)
is
'Saves the original logical array value state for a revision';


-- =====================================================
-- SAVE HISTORY ARRAY REFERENCE
-- =====================================================

create or replace function save_history_array_reference
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

    insert into history_array_reference
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        ref_container_id,
        ref_local_id,
        is_deleted
    )
    select
        p_revision_id,
        a.container_id,
        a.local_id,
        a.attribute_id,
        a.sequence_no,
        a.ref_container_id,
        a.ref_local_id,
        a.is_deleted
    from array_reference a
    where a.container_id = p_container_id
      and a.local_id     = p_local_id
      and a.attribute_id = p_attribute_id
      and a.sequence_no  = p_sequence_no

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do nothing;

end;
$$;

comment on function save_history_array_reference
(
    bigint,
    bigint,
    bigint,
    integer,
    integer
)
is
'Saves the original reference array value state for a revision';


create or replace function save_history_array_position
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

    insert into history_array_position
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        vector3_id,
        is_deleted
    )
    select
        p_revision_id,
        a.container_id,
        a.local_id,
        a.attribute_id,
        a.sequence_no,
        a.vector3_id,
        a.is_deleted
    from array_position a
    where a.container_id = p_container_id
      and a.local_id     = p_local_id
      and a.attribute_id = p_attribute_id
      and a.sequence_no  = p_sequence_no

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do nothing;

end;
$$;


-- =====================================================
-- SAVE HISTORY ARRAY DIRECTION
-- =====================================================

create or replace function save_history_array_direction
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

    insert into history_array_direction
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        vector3_id,
        is_deleted
    )
    select
        p_revision_id,
        a.container_id,
        a.local_id,
        a.attribute_id,
        a.sequence_no,
        a.vector3_id,
        a.is_deleted
    from array_direction a
    where a.container_id = p_container_id
      and a.local_id     = p_local_id
      and a.attribute_id = p_attribute_id
      and a.sequence_no  = p_sequence_no

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do nothing;

end;
$$;

comment on function save_history_array_direction
(
    bigint,
    bigint,
    bigint,
    integer,
    integer
)
is
'Saves the original direction array value state for a revision';


-- =====================================================
-- SAVE HISTORY ARRAY ORIENTATION
-- =====================================================

create or replace function save_history_array_orientation
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

    insert into history_array_orientation
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        vector3_id,
        is_deleted
    )
    select
        p_revision_id,
        a.container_id,
        a.local_id,
        a.attribute_id,
        a.sequence_no,
        a.vector3_id,
        a.is_deleted
    from array_orientation a
    where a.container_id = p_container_id
      and a.local_id     = p_local_id
      and a.attribute_id = p_attribute_id
      and a.sequence_no  = p_sequence_no

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do nothing;

end;
$$;

comment on function save_history_array_orientation
(
    bigint,
    bigint,
    bigint,
    integer,
    integer
)
is
'Saves the original orientation array value state for a revision';


-- =====================================================
-- SAVE HISTORY ARRAY DATETIME
-- =====================================================

create or replace function save_history_array_datetime
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

    insert into history_array_datetime
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        value,
        is_deleted
    )
    select
        p_revision_id,
        a.container_id,
        a.local_id,
        a.attribute_id,
        a.sequence_no,
        a.value,
        a.is_deleted
    from array_datetime a
    where a.container_id = p_container_id
      and a.local_id     = p_local_id
      and a.attribute_id = p_attribute_id
      and a.sequence_no  = p_sequence_no

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do nothing;

end;
$$;

comment on function save_history_array_datetime
(
    bigint,
    bigint,
    bigint,
    integer,
    integer
)
is
'Saves the original datetime array value state for a revision';


-- =====================================================
-- SAVE HISTORY ARRAY JSON
-- =====================================================

create or replace function save_history_array_json
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

    insert into history_array_json
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        value,
        is_deleted
    )
    select
        p_revision_id,
        a.container_id,
        a.local_id,
        a.attribute_id,
        a.sequence_no,
        a.value,
        a.is_deleted
    from array_json a
    where a.container_id = p_container_id
      and a.local_id     = p_local_id
      and a.attribute_id = p_attribute_id
      and a.sequence_no  = p_sequence_no

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do nothing;

end;
$$;

comment on function save_history_array_json
(
    bigint,
    bigint,
    bigint,
    integer,
    integer
)
is
'Saves the original JSON array value state for a revision';


-- =====================================================
-- SAVE HISTORY ARRAY UUID
-- =====================================================

create or replace function save_history_array_uuid
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

    insert into history_array_uuid
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no,
        value,
        is_deleted
    )
    select
        p_revision_id,
        a.container_id,
        a.local_id,
        a.attribute_id,
        a.sequence_no,
        a.value,
        a.is_deleted
    from array_uuid a
    where a.container_id = p_container_id
      and a.local_id     = p_local_id
      and a.attribute_id = p_attribute_id
      and a.sequence_no  = p_sequence_no

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        sequence_no
    )
    do nothing;

end;
$$;

comment on function save_history_array_uuid
(
    bigint,
    bigint,
    bigint,
    integer,
    integer
)
is
'Saves the original UUID array value state for a revision';