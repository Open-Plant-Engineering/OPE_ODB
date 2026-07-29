-- =====================================================
-- OPE_ODB
-- Helper Functions
-- =====================================================

-- =====================================================
-- GET TYPE ID
-- =====================================================

create or replace function get_type_id
(
    p_type_name varchar
)
returns smallint
language sql
stable
as
$$
    select type_id
    from node_type
    where upper(trim(type_name)) = upper(trim(p_type_name))
    limit 1;
$$;

comment on function get_type_id
(
    varchar
)
is
'Returns the node type identifier for a given node type name';

-- =====================================================
-- GET DATATYPE ID
-- =====================================================

create or replace function get_datatype_id
(
    p_datatype_name varchar
)
returns smallint
language sql
stable
as
$$
    select datatype_id
    from datatype
    where upper(trim(datatype_name)) = upper(trim(p_datatype_name))
    limit 1;
$$;

comment on function get_datatype_id
(
    varchar
)
is
'Returns the datatype identifier for a given datatype name';