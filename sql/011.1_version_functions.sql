-- =====================================================
-- OPE_ODB
-- Version Functions
-- =====================================================

-- =====================================================
-- REVISION EXISTS
-- =====================================================

create or replace function revision_exists
(
    p_revision_id bigint
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from revision
        where revision_id = p_revision_id
    );
$$;

comment on function revision_exists
(
    bigint
)
is
'Returns true when a revision exists';

-- =====================================================
-- CREATE REVISION
-- =====================================================

create or replace function create_revision
(
    p_created_by varchar,
    p_comment    text default null
)
returns bigint
language plpgsql
as
$$
declare
    v_revision_id bigint;
begin

    insert into revision
    (
        created_by,
        comment
    )
    values
    (
        trim(p_created_by),
        p_comment
    )
    returning revision_id
    into v_revision_id;

    return v_revision_id;

end;
$$;

comment on function create_revision
(
    varchar,
    text
)
is
'Creates a new revision and returns the revision identifier';

-- =====================================================
-- GET LATEST REVISION ID
-- =====================================================

create or replace function get_latest_revision_id()
returns bigint
language sql
stable
as
$$
    select max(revision_id)
    from revision;
$$;

comment on function get_latest_revision_id()
is
'Returns the latest revision identifier';

-- =====================================================
-- GET REVISION CREATED AT
-- =====================================================

create or replace function get_revision_created_at
(
    p_revision_id bigint
)
returns timestamp with time zone
language sql
stable
as
$$
    select created_at
    from revision
    where revision_id = p_revision_id;
$$;

comment on function get_revision_created_at
(
    bigint
)
is
'Returns the creation timestamp of a revision';

-- =====================================================
-- GET REVISION CREATED BY
-- =====================================================

create or replace function get_revision_created_by
(
    p_revision_id bigint
)
returns varchar
language sql
stable
as
$$
    select created_by
    from revision
    where revision_id = p_revision_id;
$$;

comment on function get_revision_created_by
(
    bigint
)
is
'Returns the creator of a revision';

-- =====================================================
-- GET REVISION COMMENT
-- =====================================================

create or replace function get_revision_comment
(
    p_revision_id bigint
)
returns text
language sql
stable
as
$$
    select comment
    from revision
    where revision_id = p_revision_id;
$$;

comment on function get_revision_comment
(
    bigint
)
is
'Returns the comment of a revision';