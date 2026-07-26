create or replace function import_node_type(
    p_type_id smallint,
    p_type_name varchar
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
        upper(p_type_name)
    )
    on conflict (type_id)
    do update
    set type_name = excluded.type_name;

end;
$$;