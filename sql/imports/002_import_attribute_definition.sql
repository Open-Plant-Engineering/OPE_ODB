create or replace function import_attribute_definition
(
    p_attribute_name varchar,
    p_data_type_name varchar,
    p_data_length integer
)
returns integer
language plpgsql
as
$$
declare
    v_data_type smallint;
    v_attribute_id integer;
begin

    v_data_type :=
    case upper(trim(p_data_type_name))
        when 'TEXT'        then 1
        when 'REAL'        then 2
        when 'INTEGER'     then 3
        when 'LOGICAL'     then 4
        when 'REFERENCE'   then 5
        when 'WORD'        then 6
        when 'POSITION'    then 7
        when 'DIRECTION'   then 8
        when 'ORIENTATION' then 9
        when 'DATETIME'    then 10
        when 'UNKNOWN'     then 11
        else 11
    end;

    insert into attribute_definition
    (
        attribute_name,
        data_type,
        data_lengt
    )
    values
    (
        trim(p_attribute_name),
        v_data_type,
        p_data_lengt
    )
    on conflict (attribute_name)
    do update
    set
        data_type = excluded.data_type,
        data_length = excluded.data_length
    returning attribute_id
    into v_attribute_id;

    return v_attribute_id;

end;
$$;