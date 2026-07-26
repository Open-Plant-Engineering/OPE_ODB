create or replace function import_element
(
    p_container_id       bigint,
    p_local_id           bigint,
    p_type_id            smallint,

    p_owner_container_id bigint,
    p_owner_local_id     bigint,

    p_owner_index        integer
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

        owner_index
    )
    values
    (
        p_container_id,
        p_local_id,

        p_type_id,

        p_owner_container_id,
        p_owner_local_id,

        p_owner_index
    )
    on conflict
    (
        container_id,
        local_id
    )
    do update
    set
        type_id             = excluded.type_id,
        owner_container_id  = excluded.owner_container_id,
        owner_local_id      = excluded.owner_local_id,
        owner_index         = excluded.owner_index;

end;
$$;