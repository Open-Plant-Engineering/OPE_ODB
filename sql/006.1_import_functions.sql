-- =====================================================
-- OPE_ODB
-- Import Functions
-- =====================================================

-- =====================================================
-- IMPORT NODE TYPE
-- =====================================================

create or replace function import_node_type
(
    p_type_id      smallint,
    p_type_name    varchar
)
returns void
language plpgsql
as
$$
begin

    insert into node_type
    (
        type_id,
        type_name
    )
    values
    (
        p_type_id,
        trim(p_type_name)
    )
    on conflict (type_id)
    do update
    set
        type_name = excluded.type_name;

end;
$$;

comment on function import_node_type
(
    smallint,
    varchar
)
is
'Creates or updates a node type definition';

-- =====================================================
-- IMPORT ATTRIBUTE DEFINITION BY ID
-- =====================================================

create or replace function import_attribute_definition_by_id
(
    p_attribute_name   varchar,
    p_datatype_id      smallint,
    p_data_length      integer
)
returns void
language plpgsql
as
$$
begin

    insert into attribute_definition
    (
        attribute_name,
        datatype_id,
        data_length
    )
    values
    (
        trim(p_attribute_name),
        p_datatype_id,
        p_data_length
    )
    on conflict (attribute_name)
    do update
    set
        datatype_id = excluded.datatype_id,
        data_length = excluded.data_length;

end;
$$;

comment on function import_attribute_definition_by_id
(
    varchar,
    smallint,
    integer
)
is
'Creates or updates an attribute definition using datatype identifier';

-- =====================================================
-- IMPORT ATTRIBUTE DEFINITION BY NAME
-- =====================================================

create or replace function import_attribute_definition_by_name
(
    p_attribute_name   varchar,
    p_datatype_name    varchar,
    p_data_length      integer
)
returns void
language plpgsql
as
$$
declare
    v_datatype_id smallint;
begin

    v_datatype_id := get_datatype_id(p_datatype_name);

    if v_datatype_id is null then
        raise exception
        'Unknown datatype: %',
        p_datatype_name;
    end if;

    perform import_attribute_definition_by_id
    (
        p_attribute_name,
        v_datatype_id,
        p_data_length
    );

end;
$$;

comment on function import_attribute_definition_by_name
(
    varchar,
    varchar,
    integer
)
is
'Creates or updates an attribute definition using datatype name';

-- =====================================================
-- IMPORT ELEMENT BY ID
-- =====================================================

create or replace function import_element_by_id
(
    p_container_id        bigint,
    p_local_id            bigint,

    p_type_id             smallint,

    p_owner_container_id  bigint,
    p_owner_local_id      bigint,

    p_sequence_no         integer
)
returns void
language plpgsql
as
$$
begin

    insert into element
    (
        container_id,
        local_id,

        type_id,

        owner_container_id,
        owner_local_id,

        sequence_no,

        is_deleted
    )
    values
    (
        p_container_id,
        p_local_id,

        p_type_id,

        p_owner_container_id,
        p_owner_local_id,

        p_sequence_no,

        false
    )
    on conflict
    (
        container_id,
        local_id
    )
    do update
    set
        type_id            = excluded.type_id,
        owner_container_id = excluded.owner_container_id,
        owner_local_id     = excluded.owner_local_id,
        sequence_no        = excluded.sequence_no,
        is_deleted         = false;

end;
$$;

comment on function import_element_by_id
(
    bigint,
    bigint,
    smallint,
    bigint,
    bigint,
    integer
)
is
'Creates or updates an element using node type identifier';

-- =====================================================
-- IMPORT ELEMENT BY NAME
-- =====================================================

create or replace function import_element_by_name
(
    p_container_id        bigint,
    p_local_id            bigint,

    p_type_name           varchar,

    p_owner_container_id  bigint,
    p_owner_local_id      bigint,

    p_sequence_no         integer
)
returns void
language plpgsql
as
$$
declare
    v_type_id smallint;
begin

    v_type_id := get_type_id(p_type_name);

    if v_type_id is null then
        raise exception
        'Unknown node type: %',
        p_type_name;
    end if;

    perform import_element_by_id
    (
        p_container_id,
        p_local_id,

        v_type_id,

        p_owner_container_id,
        p_owner_local_id,

        p_sequence_no
    );

end;
$$;

comment on function import_element_by_name
(
    bigint,
    bigint,
    varchar,
    bigint,
    bigint,
    integer
)
is
'Creates or updates an element using node type name';