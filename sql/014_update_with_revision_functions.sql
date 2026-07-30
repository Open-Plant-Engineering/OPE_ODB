-- =====================================================
-- SAVE STRING VALUE WITH REVISION
-- =====================================================

create or replace function save_string_value
(
    p_revision_id  bigint,

    p_container_id bigint,
    p_local_id     bigint,

    p_attribute_id integer,

    p_value        text
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

    perform set_string_value
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_value
    );

end;
$$;

comment on function save_string_value
(
    bigint,
    bigint,
    bigint,
    integer,
    text
)
is
'Saves a string value while preserving revision history';


-- =====================================================
-- SAVE NUMBER VALUE WITH REVISION
-- =====================================================

create or replace function save_number_value
(
    p_revision_id  bigint,

    p_container_id bigint,
    p_local_id     bigint,

    p_attribute_id integer,

    p_value        double precision
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

    perform set_number_value
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_value
    );

end;
$$;


create or replace function save_logical_value
(
    p_revision_id  bigint,

    p_container_id bigint,
    p_local_id     bigint,

    p_attribute_id integer,

    p_value        boolean
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

    perform set_logical_value
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_value
    );

end;
$$;


create or replace function save_reference_value
(
    p_revision_id      bigint,

    p_container_id     bigint,
    p_local_id         bigint,

    p_attribute_id     integer,

    p_ref_container_id bigint,
    p_ref_local_id     bigint
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

    perform set_reference_value
    (
        p_container_id,
        p_local_id,
        p_attribute_id,
        p_ref_container_id,
        p_ref_local_id
    );

end;
$$;


-- =====================================================
-- SAVE ELEMENT
-- =====================================================

create or replace function save_element
(
    p_revision_id        bigint,

    p_container_id       bigint,
    p_local_id           bigint,

    p_type_id            smallint,

    p_owner_container_id bigint,
    p_owner_local_id     bigint,

    p_sequence_no        integer
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
        type_id            = p_type_id,
        owner_container_id = p_owner_container_id,
        owner_local_id     = p_owner_local_id,
        sequence_no        = p_sequence_no
    where container_id = p_container_id
      and local_id     = p_local_id;

end;
$$;


