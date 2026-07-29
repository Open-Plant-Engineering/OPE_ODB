create or replace function save_history_element
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

    insert into history_element
    (
        revision_id,

        container_id,
        local_id,

        type_id,

        owner_container_id,
        owner_local_id,

        sequence_no,

        is_deleted
    )
    select
        p_revision_id,

        e.container_id,
        e.local_id,

        e.type_id,

        e.owner_container_id,
        e.owner_local_id,

        e.sequence_no,

        e.is_deleted
    from element e
    where e.container_id = p_container_id
      and e.local_id     = p_local_id

    on conflict
    (
        revision_id,
        container_id,
        local_id
    )
    do nothing;

end;
$$;

-- =====================================================
-- SAVE HISTORY STRING
-- =====================================================

create or replace function save_history_string
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

    insert into history_string
    (
        revision_id,

        container_id,
        local_id,

        attribute_id,

        string_id,

        is_deleted
    )
    select
        p_revision_id,

        v.container_id,
        v.local_id,

        v.attribute_id,

        v.string_id,

        v.is_deleted
    from value_string v
    where v.container_id = p_container_id
      and v.local_id     = p_local_id
      and v.attribute_id = p_attribute_id

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    )
    do nothing;

end;
$$;

comment on function save_history_string
(
    bigint,
    bigint,
    bigint,
    integer
)
is
'Saves the original string value state for a revision';


create or replace function save_history_number
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

    insert into history_number
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        value,
        is_deleted
    )
    select
        p_revision_id,
        v.container_id,
        v.local_id,
        v.attribute_id,
        v.value,
        v.is_deleted
    from value_number v
    where v.container_id = p_container_id
      and v.local_id     = p_local_id
      and v.attribute_id = p_attribute_id

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    )
    do nothing;

end;
$$;

-- =====================================================
-- SAVE HISTORY NUMBER
-- =====================================================

create or replace function save_history_number
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

    insert into history_number
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        value,
        is_deleted
    )
    select
        p_revision_id,
        v.container_id,
        v.local_id,
        v.attribute_id,
        v.value,
        v.is_deleted
    from value_number v
    where v.container_id = p_container_id
      and v.local_id     = p_local_id
      and v.attribute_id = p_attribute_id

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    )
    do nothing;

end;
$$;

comment on function save_history_number
(
    bigint,
    bigint,
    bigint,
    integer
)
is
'Saves the original number value state for a revision';

-- =====================================================
-- SAVE HISTORY LOGICAL
-- =====================================================

create or replace function save_history_logical
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

    insert into history_logical
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        value,
        is_deleted
    )
    select
        p_revision_id,
        v.container_id,
        v.local_id,
        v.attribute_id,
        v.value,
        v.is_deleted
    from value_logical v
    where v.container_id = p_container_id
      and v.local_id     = p_local_id
      and v.attribute_id = p_attribute_id

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    )
    do nothing;

end;
$$;

comment on function save_history_logical
(
    bigint,
    bigint,
    bigint,
    integer
)
is
'Saves the original logical value state for a revision';

-- =====================================================
-- SAVE HISTORY REFERENCE
-- =====================================================

create or replace function save_history_reference
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

    insert into history_reference
    (
        revision_id,

        container_id,
        local_id,

        attribute_id,

        ref_container_id,
        ref_local_id,

        is_deleted
    )
    select
        p_revision_id,

        v.container_id,
        v.local_id,

        v.attribute_id,

        v.ref_container_id,
        v.ref_local_id,

        v.is_deleted
    from value_reference v
    where v.container_id = p_container_id
      and v.local_id     = p_local_id
      and v.attribute_id = p_attribute_id

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    )
    do nothing;

end;
$$;

comment on function save_history_reference
(
    bigint,
    bigint,
    bigint,
    integer
)
is
'Saves the original reference value state for a revision';

-- =====================================================
-- SAVE HISTORY POSITION
-- =====================================================

create or replace function save_history_position
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

    insert into history_position
    (
        revision_id,
        container_id,
        local_id,
        attribute_id,
        vector3_id,
        is_deleted
    )
    select
        p_revision_id,
        v.container_id,
        v.local_id,
        v.attribute_id,
        v.vector3_id,
        v.is_deleted
    from value_position v
    where v.container_id = p_container_id
      and v.local_id     = p_local_id
      and v.attribute_id = p_attribute_id

    on conflict
    (
        revision_id,
        container_id,
        local_id,
        attribute_id
    )
    do nothing;

end;
$$;

comment on function save_history_position
(
    bigint,
    bigint,
    bigint,
    integer
)
is
'Saves the original position value state for a revision';


