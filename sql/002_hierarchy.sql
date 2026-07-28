-- =====================================================
-- OPE_ODB
-- Hierarchy
-- =====================================================

-- =====================================================
-- ELEMENTS
-- =====================================================

create table element
(
    container_id        bigint not null,
    local_id            bigint not null,

    type_id             smallint not null,

    owner_container_id  bigint not null,
    owner_local_id      bigint not null,

    sequence_no         integer not null default 0,

    primary key
    (
        container_id,
        local_id
    ),

    constraint fk_element_type
        foreign key (type_id)
        references node_type(type_id),

    constraint fk_element_owner
        foreign key
        (
            owner_container_id,
            owner_local_id
        )
        references element
        (
            container_id,
            local_id
        )
);

comment on table element is
'E3D hierarchy elements';

comment on column element.container_id is
'E3D container identifier';

comment on column element.local_id is
'E3D local identifier';

comment on column element.owner_container_id is
'Owner container identifier';

comment on column element.owner_local_id is
'Owner local identifier';

comment on column element.sequence_no is
'Child sequence number within owner';