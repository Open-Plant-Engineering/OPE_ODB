-- =====================================================
-- VALIDATE RESTORE REVISION
-- =====================================================

create or replace function validate_restore_revision
(
    p_revision_id bigint
)
returns void
language plpgsql
as
$$
begin

    if not revision_exists(p_revision_id) then
        raise exception
        'Revision % does not exist',
        p_revision_id;
    end if;

end;
$$;

comment on function validate_restore_revision
(
    bigint
)
is
'Validates that a revision exists before restore';


-- =====================================================
-- CREATE RESTORE REVISION
-- =====================================================

create or replace function create_restore_revision
(
    p_created_by       varchar,
    p_target_revision  bigint
)
returns bigint
language plpgsql
as
$$
declare
    v_revision_id bigint;
begin

    perform validate_restore_revision
    (
        p_target_revision
    );

    v_revision_id :=
        create_revision
        (
            p_created_by,
            format
            (
                'Restore to revision %s',
                p_target_revision
            )
        );

    return v_revision_id;

end;
$$;

comment on function create_restore_revision
(
    varchar,
    bigint
)
is
'Creates a new revision for a restore operation';


-- =====================================================
-- RESTORE ELEMENT
-- =====================================================

create or replace function restore_element
(
    p_created_by        varchar,

    p_target_revision   bigint,

    p_container_id      bigint,
    p_local_id          bigint
)
returns bigint
language plpgsql
as
$$
declare
    v_revision_id bigint;
begin

    v_revision_id :=
        create_restore_revision
        (
            p_created_by,
            p_target_revision
        );

    /*
        Reconstruction logic
        implemented later.
    */

    return v_revision_id;

end;
$$;

comment on function restore_element
(
    varchar,
    bigint,
    bigint,
    bigint
)
is
'Restores a single element to a previous revision state';


-- =====================================================
-- RESTORE ATTRIBUTE
-- =====================================================

create or replace function restore_attribute
(
    p_created_by        varchar,

    p_target_revision   bigint,

    p_container_id      bigint,
    p_local_id          bigint,

    p_attribute_id      integer
)
returns bigint
language plpgsql
as
$$
declare
    v_revision_id bigint;
begin

    v_revision_id :=
        create_restore_revision
        (
            p_created_by,
            p_target_revision
        );

    /*
        Reconstruction logic
        implemented later.
    */

    return v_revision_id;

end;
$$;

comment on function restore_attribute
(
    varchar,
    bigint,
    bigint,
    bigint,
    integer
)
is
'Restores a single attribute to a previous revision state';


-- =====================================================
-- RESTORE REVISION
-- =====================================================

create or replace function restore_revision
(
    p_created_by       varchar,

    p_target_revision  bigint
)
returns bigint
language plpgsql
as
$$
declare
    v_revision_id bigint;
begin

    v_revision_id :=
        create_restore_revision
        (
            p_created_by,
            p_target_revision
        );

    /*
        Full database reconstruction
        implemented later.
    */

    return v_revision_id;

end;
$$;

comment on function restore_revision
(
    varchar,
    bigint
)
is
'Restores the complete database state to a previous revision';


