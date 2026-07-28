-- =====================================================
-- OPE_ODB
-- Schema Data
-- =====================================================

-- =====================================================
-- NODE TYPES
-- =====================================================

create table node_type
(
    type_id         smallint primary key,
    type_name       varchar(64) not null unique
);

comment on table node_type is
'E3D element types such as SITE, ZONE, PIPE, BRAN, EQUI, etc.';

-- =====================================================
-- ATTRIBUTE DEFINITIONS
-- =====================================================

create table attribute_definition
(
    attribute_id        integer generated always as identity primary key,

    attribute_name      varchar(128) not null unique,

    data_type           smallint not null,

    data_length         integer not null default 1,

    constraint fk_attribute_definition_datatype
        foreign key (datatype_id)
        references datatype(datatype_id)
);

comment on table attribute_definition is
'OPE_ODB attribute catalog';

comment on column attribute_definition.datatype_id is
'Reference to datatype.datatype_id';

comment on column attribute_definition.data_length is
'E3D metadata length. Meaning depends on datatype.';

-- =====================================================
-- TYPE ATTRIBUTE MAPPING
-- =====================================================

create table type_attribute
(
    type_id         smallint not null,
    attribute_id    integer not null,

    primary key
    (
        type_id,
        attribute_id
    ),

    constraint fk_type_attribute_type
        foreign key (type_id)
        references node_type(type_id),

    constraint fk_type_attribute_attribute
        foreign key (attribute_id)
        references attribute_definition(attribute_id)
);

comment on table type_attribute is
'Maps E3D element types to valid attributes';