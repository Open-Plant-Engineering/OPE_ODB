-- =====================================================
-- DATATYPES
-- =====================================================

create table datatype
(
    datatype_id     smallint primary key,
    datatype_name   varchar(32) not null unique
);

comment on table datatype is
'Supported OPE_ODB datatypes';

insert into datatype
(
    datatype_id,
    datatype_name
)
values
    (1,  'STRING'),
    (2,  'NUMBER'),
    (3,  'LOGICAL'),
    (4,  'REFERENCE'),
    (5,  'POSITION'),
    (6,  'DIRECTION'),
    (7,  'ORIENTATION'),
    (8,  'DATETIME'),
    (9,  'JSON'),
    (10, 'BLOB'),
    (11, 'UUID');