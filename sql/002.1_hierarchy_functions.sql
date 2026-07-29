
-- =====================================================
-- ELEMENT EXISTS
-- =====================================================

create or replace function element_exists
(
    p_container_id bigint,
    p_local_id     bigint
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from element
        where container_id = p_container_id
          and local_id = p_local_id
    );
$$;

comment on function element_exists
(
    bigint,
    bigint
)
is
'Returns true when an element exists';

-- =====================================================
-- ACTIVE ELEMENT EXISTS
-- =====================================================

create or replace function active_element_exists
(
    p_container_id bigint,
    p_local_id     bigint
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from element
        where container_id = p_container_id
          and local_id = p_local_id
          and is_deleted = false
    );
$$;

comment on function active_element_exists
(
    bigint,
    bigint
)
is
'Returns true when an active element exists';
