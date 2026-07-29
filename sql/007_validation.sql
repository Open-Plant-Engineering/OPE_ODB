-- =====================================================
-- OPE_ODB
-- Validation Functions
-- =====================================================

-- =====================================================
-- NODE TYPE EXISTS
-- =====================================================

create or replace function node_type_exists
(
    p_type_name varchar
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from node_type
        where upper(type_name) = upper(trim(p_type_name))
    );
$$;

comment on function node_type_exists
(
    varchar
)
is
'Returns true when a node type exists';

-- =====================================================
-- NODE TYPE ID EXISTS
-- =====================================================

create or replace function node_type_id_exists
(
    p_type_id smallint
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from node_type
        where type_id = p_type_id
    );
$$;

comment on function node_type_id_exists
(
    smallint
)
is
'Returns true when a node type identifier exists';

-- =====================================================
-- ATTRIBUTE EXISTS
-- =====================================================

create or replace function attribute_exists
(
    p_attribute_name varchar
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from attribute_definition
        where upper(attribute_name) = upper(trim(p_attribute_name))
    );
$$;

comment on function attribute_exists
(
    varchar
)
is
'Returns true when an attribute definition exists';

-- =====================================================
-- ATTRIBUTE ID EXISTS
-- =====================================================

create or replace function attribute_id_exists
(
    p_attribute_id integer
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from attribute_definition
        where attribute_id = p_attribute_id
    );
$$;

comment on function attribute_id_exists
(
    integer
)
is
'Returns true when an attribute identifier exists';

-- =====================================================
-- DATATYPE EXISTS
-- =====================================================

create or replace function datatype_exists
(
    p_datatype_name varchar
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from datatype
        where upper(datatype_name) = upper(trim(p_datatype_name))
    );
$$;

comment on function datatype_exists
(
    varchar
)
is
'Returns true when a datatype exists';

-- =====================================================
-- DATATYPE ID EXISTS
-- =====================================================

create or replace function datatype_id_exists
(
    p_datatype_id smallint
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from datatype
        where datatype_id = p_datatype_id
    );
$$;

comment on function datatype_id_exists
(
    smallint
)
is
'Returns true when a datatype identifier exists';

-- =====================================================
-- STRING EXISTS
-- =====================================================

create or replace function string_exists
(
    p_string_value text
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from string_pool
        where string_value = p_string_value
    );
$$;

comment on function string_exists
(
    text
)
is
'Returns true when a string exists in the string pool';

-- =====================================================
-- VECTOR3 EXISTS
-- =====================================================

create or replace function vector3_exists
(
    p_x_value double precision,
    p_y_value double precision,
    p_z_value double precision
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from vector3_pool
        where x_value = p_x_value
          and y_value = p_y_value
          and z_value = p_z_value
    );
$$;

comment on function vector3_exists
(
    double precision,
    double precision,
    double precision
)
is
'Returns true when a vector exists in the vector3 pool';