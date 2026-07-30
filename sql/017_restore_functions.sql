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
'Validates that a target revision exists';

-- =====================================================
-- CREATE RESTORE REVISION
-- =====================================================

create or replace function create_restore_revision
(
    p_created_by      varchar,
    p_target_revision bigint
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
-- RESTORE ATTRIBUTE
-- =====================================================

create or replace function restore_attribute
(
    p_created_by      varchar,

    p_target_revision bigint,

    p_container_id    bigint,
    p_local_id        bigint,

    p_attribute_id    integer
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
        will be added in next step.

        This function currently establishes
        the restore revision lifecycle.
    */

    return v_revision_id;

end;*$$;

comment on function restore_a*tribute
(
    varchar,
    bigint,*    bigint,
    bigint,
    intege*
)
is
'Restores an attribute to a *revious revision using a newly cre*ted revision';


-- ==============*==================================*===
-- RESTORE ELEMENT
-- ========*==================================*=========

create or replace funct*on restore_element
(
    p_created*by      varchar,

    p_target_rev*sion bigint,

    p_container_id  * bigint,
    p_local_id        big*nt
)
returns bigint
language plpgs*l
as
$$
declare
    v_revision_id *igint;
begin

    v_revision_id :=*        create_restore_revision
  *     (
            p_created_by,
 *          p_target_revision
      * );

    return v_revision_id;

en*;
$$;

comment on function restore*element
(
    varchar,
    bigint,*    bigint,
    bigint
)
is
'Resto*es an element to a previous revisi*n using a newly created revision';*


-- ===================*=================================
*- RESTORE REVISION
-- ============*==================================*=====

create or replace function *estore_revision
(
    p_created_by*     varchar,
    p_target_revisio* bigint
)
returns bigint
language *lpgsql
as
$$
declare
    v_revisio*_id bigint;
begin

    v_revision_*d :=
        create_restore_revisi*n
        (
            p_created_*y,
            p_target_revision
 *      );

    return v_revision_id*

end;
$$;

comment on function re*tore_revision
(
    varchar,
    b*gint
)
is
'Restores a database sta*e to a previous revision using a n*wly created revision';


