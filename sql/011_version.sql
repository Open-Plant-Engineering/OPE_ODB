-- =====================================================
-- OPE_ODB
-- Versioning
-- =====================================================

-- =====================================================
-- REVISIONS
-- =====================================================

create table revision
(
    revision_id     bigint generated always as identity primary key,

    created_at      timestamp with time zone not null
                    default current_timestamp,

    created_by      varchar(256) not null,

    comment         text
);

comment on table revision is
'Stores logical database revisions';

comment on column revision.revision_id is
'Unique revision identifier';

comment on column revision.created_at is
'Revision creation timestamp';

comment on column revision.created_by is
'User or process responsible for the revision';

comment on column revision.comment is
'Optional revision description';

-- =====================================================
-- INDEXES
-- =====================================================

create index idx_revision_created_at
on revision(created_at);

create index idx_revision_created_by
on revision(created_by);