create or replace function get_type_id
(
    p_type_name varchar
)
returns smallint
language sql
as
$$
    select type_id
    from node_type
    where upper(type_name) = upper(p_type_name);
$$;