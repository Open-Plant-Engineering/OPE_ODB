create temporary table staging_element
(
    container_id        bigint,
    local_id            bigint,
    type_id             smallint,
    owner_container_id  bigint,
    owner_local_id      bigint,
    owner_index         integer
);

copy staging_element
(
    container_id,
    local_id,
    type_id,
    owner_container_id,
    owner_local_id,
    owner_index
)
from 'C:\SKRepo\OPE_ODB\E3DMigration\003_output.csv'
csv header;


insert into element
(
    container_id,
    local_id,
    type_id,
    owner_container_id,
    owner_local_id,
    owner_index
)
select distinct
    container_id,
    local_id,
    type_id,
    owner_container_id,
    owner_local_id,
    owner_index
from staging_element
on conflict (container_id, local_id)
do nothing;