create table staging_text_values
(
    container_id    bigint,
    local_id        bigint,
    attribute_name  varchar(128),
    value_text      text
);

copy staging_text_values
(
    container_id,
    local_id,
    attribute_name,
    value_text
)
from 'C:\SKRepo\OPE_ODB\E3DMigration\004_pipe_sites_stringdata.csv'
csv header;

insert into string_pool
(
    string_value
)
select distinct
    trim(value_text)
from staging_text_values
where value_text is not null
and trim(value_text) <> ''
on conflict (string_value)
do nothing;


insert into value_string
(
    container_id,
    local_id,
    attribute_id,
    string_id
)
select
    s.container_id,
    s.local_id,
    a.attribute_id,
    sp.string_id
from staging_text_values s
join attribute_definition a
    on a.attribute_name = s.attribute_name
join string_pool sp
    on sp.string_value = trim(s.value_text)
on conflict
(
    container_id,
    local_id,
    attribute_id
)
do nothing;