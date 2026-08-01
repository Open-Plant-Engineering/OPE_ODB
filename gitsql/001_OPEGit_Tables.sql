-- =====================================================
-- REPOSITORY
-- Equivalent to a Git repository / Project
-- =====================================================

create table repository
(
    repository_id bigint generated always as identity primary key,

    repository_name text not null unique,

    created_at timestamptz not null default now()
);

comment on table repository is
'Top-level repository containing the complete version history.';


-- =====================================================
-- CHUNK POOL
-- Global deduplicated value storage
-- One row = one unique scalar value
-- =====================================================
create table git_blob_chunk_pool
(
    chunk_hash varchar(64) not null,

    data_type_id smallint not null,

    string_value text,

    integer_value bigint,

    numeric_value numeric,

    real_value double precision,

    boolean_value boolean,

    date_value date,

    time_value time,

    datetime_value timestamptz,

    interval_value interval,

    uuid_value uuid,

    jsonb_value jsonb,

    binary_value bytea,

    constraint pk_git_blob_chunk_pool
        primary key (chunk_hash)
)
partition by hash (chunk_hash);

comment on table git_blob_chunk_pool is
'Global deduplicated value store. One unique value per row.';

comment on column git_blob_chunk_pool.chunk_hash is
'Content hash calculated from type and value.';

comment on column git_blob_chunk_pool.data_type_id is
'Reference to datatype definition.';

comment on column git_blob_chunk_pool.string_value is
'Character values such as NAME, SPEC, DESC.';

comment on column git_blob_chunk_pool.integer_value is
'Integer values.';

comment on column git_blob_chunk_pool.numeric_value is
'High precision numeric values.';

comment on column git_blob_chunk_pool.real_value is
'Floating point values.';

comment on column git_blob_chunk_pool.boolean_value is
'Boolean values.';

comment on column git_blob_chunk_pool.date_value is
'Date values.';

comment on column git_blob_chunk_pool.time_value is
'Time values.';

comment on column git_blob_chunk_pool.datetime_value is
'Timestamp values.';

comment on column git_blob_chunk_pool.interval_value is
'Interval values.';

comment on column git_blob_chunk_pool.uuid_value is
'UUID values.';

comment on column git_blob_chunk_pool.jsonb_value is
'JSON document values.';

comment on column git_blob_chunk_pool.binary_value is
'Binary/BLOB values.';


-- =====================================================
-- ELEMENT MANIFEST
-- Represents the complete state of an element.
-- Equivalent to a Git blob snapshot.
-- =====================================================

create table git_element_manifest
(
    manifest_id bigint generated always as identity primary key,

    manifest_hash varchar(64) not null unique
);

comment on table git_element_manifest is
'Represents a complete element state.';


-- =====================================================
-- ELEMENT MANIFEST ENTRY
-- Maps attributes to chunks.
-- =====================================================

create table git_element_manifest_entry
(
    manifest_id bigint not null,

    attribute_id integer not null,

    chunk_hash varchar(64) not null,

    primary key
    (
        manifest_id,
        attribute_id
    ),

    constraint fk_manifest_entry_manifest
        foreign key (manifest_id)
        references git_element_manifest(manifest_id),

    constraint fk_manifest_entry_chunk
        foreign key (chunk_hash)
        references git_blob_chunk_pool(chunk_hash)
)
partition by hash (manifest_id);

comment on table git_element_manifest_entry is
'Maps attribute values to chunk storage for a specific manifest.';


-- =====================================================
-- ELEMENT
-- Equivalent to a file in Git.
-- Permanent engineering object identity.
-- =====================================================

create table git_element
(
    container_id bigint not null,

    local_id bigint not null,

    primary key
    (
        container_id,
        local_id
    )
);

comment on table git_element is
'Permanent engineering object identity.';


-- =====================================================
-- TREE
-- Equivalent to a Git tree.
-- Represents a repository snapshot structure.
-- =====================================================

create table git_tree
(
    tree_hash varchar(64) primary key
);

comment on table git_tree is
'Content-addressed tree representing a repository state.';


-- =====================================================
-- TREE ENTRY
-- Equivalent to a file entry inside a Git tree.
-- References the manifest active for an element.
-- =====================================================

create table git_tree_entry
(
    tree_hash varchar(64) not null,

    container_id bigint not null,

    local_id bigint not null,

    manifest_id bigint not null,

    primary key
    (
        tree_hash,
        container_id,
        local_id
    ),

    constraint fk_tree_entry_manifest
        foreign key (manifest_id)
        references git_element_manifest(manifest_id),

    constraint fk_tree_entry_element
        foreign key (container_id, local_id)
        references git_element(container_id, local_id),

    constraint fk_tree_entry_tree
        foreign key (tree_hash)
        references git_tree(tree_hash)
);

comment on table git_tree_entry is
'Associates elements with manifests inside a tree snapshot.';


-- =====================================================
-- COMMIT
-- Equivalent to a Git commit object.
-- =====================================================

create table git_commit
(
    commit_hash varchar(64) primary key,

    tree_hash varchar(64) not null,

    author_name text not null,

    author_email text not null,

    committer_name text not null,

    committer_email text not null,

    commit_message text not null,

    author_date timestamptz not null,

    commit_date timestamptz not null,

    constraint fk_commit_tree
        foreign key (tree_hash)
        references git_tree(tree_hash)
);

comment on table git_commit is
'Immutable repository revision.';


-- =====================================================
-- COMMIT PARENTS
-- Supports normal commits and merge commits.
-- =====================================================

create table git_commit_parent
(
    commit_hash varchar(64) not null,

    parent_hash varchar(64) not null,

    parent_index integer not null,

    primary key
    (
        commit_hash,
        parent_hash
    ),
    
    constraint fk_commit_parent_commit
        foreign key (commit_hash)
        references git_commit(commit_hash),

    constraint fk_commit_parent_parent
        foreign key (parent_hash)
        references git_commit(commit_hash)
);

comment on table git_commit_parent is
'Parent relationship graph between commits.';


-- =====================================================
-- TAG
-- Equivalent to Git tags.
-- =====================================================

create table git_tag
(
    tag_hash varchar(64) primary key,

    target_hash varchar(64) not null,

    tag_name text not null unique,
    
    tagger_name text,

    tagger_email text,

    tag_message text
);

comment on table git_tag is
'Named reference to a commit.';


-- =====================================================
-- REFERENCES
-- Equivalent to refs/heads/* and refs/tags/*
-- =====================================================

create table git_ref
(
    repository_id bigint not null,

    ref_name text not null,

    object_hash varchar(64) not null,

    primary key
    (
        repository_id,
        ref_name
    ),

    constraint fk_git_ref_repository
        foreign key (repository_id)
        references repository(repository_id)
);

comment on table git_ref is
'Branch and tag references.';


-- =====================================================
-- HEAD
-- Current checkout position.
-- =====================================================

create table git_head
(
    repository_id bigint primary key,

    ref_name text,

    detached_hash varchar(64),

    constraint chk_git_head
        check
        (
            ref_name is not null
            or detached_hash is not null
        ),

    constraint fk_git_head_repository
        foreign key (repository_id)
        references repository(repository_id)
);

comment on table git_head is
'Current repository position.';


-- =====================================================
-- CONFIG
-- Equivalent to .git/config
-- =====================================================

create table git_config
(
    repository_id bigint not null,

    section_name text not null,

    key_name text not null,

    value_text text,

    primary key
    (
        repository_id,
        section_name,
        key_name
    ),

    constraint fk_git_config_repository
        foreign key (repository_id)
        references repository(repository_id)
);

comment on table git_config is
'Repository configuration settings.';


-- =====================================================
-- INDEX ENTRY
-- Staging area for engineering elements.
-- Equivalent to Git index.
-- =====================================================

create table git_index_entry
(
    repository_id bigint not null,

    container_id bigint not null,

    local_id bigint not null,

    manifest_id bigint not null,

    primary key
    (
        repository_id,
        container_id,
        local_id
    ),

    constraint fk_git_index_repository
        foreign key (repository_id)
        references repository(repository_id),
    
    constraint fk_git_index_element
        foreign key (container_id, local_id)
        references git_element(container_id, local_id),

    constraint fk_git_index_manifest
        foreign key (manifest_id)
        references git_element_manifest(manifest_id)
);

comment on table git_index_entry is
'Staged element changes awaiting commit.';


-- =====================================================
-- REFLOG
-- History of reference movements.
-- Equivalent to Git reflog.
-- =====================================================

create table git_reflog
(
    reflog_id bigint generated always as identity primary key,

    repository_id bigint not null,

    ref_name text not null,

    old_hash varchar(64),

    new_hash varchar(64),

    message text,

    changed_at timestamptz not null default now(),

    constraint fk_git_reflog_repository
        foreign key (repository_id)
        references repository(repository_id)
);

comment on table git_reflog is
'Historical tracking of branch and HEAD movements.';

-- =====================================================
-- INDEXES
-- OPEGit Performance Indexes
-- =====================================================


-- =====================================================
-- git_blob_chunk_pool
-- =====================================================

create unique index idx_git_blob_chunk_pool_hash
on git_blob_chunk_pool(chunk_hash);

comment on index idx_git_blob_chunk_pool_hash is
'Primary lookup index used to find existing chunks by content hash.';

create index idx_git_blob_chunk_pool_string
on git_blob_chunk_pool(string_value);

comment on index idx_git_blob_chunk_pool_string is
'Supports string value searches such as NAME, SPEC, DESCRIPTION.';

create index idx_git_blob_chunk_pool_integer
on git_blob_chunk_pool(integer_value);

comment on index idx_git_blob_chunk_pool_integer is
'Supports integer value searches and comparisons.';

create index idx_git_blob_chunk_pool_real
on git_blob_chunk_pool(real_value);

comment on index idx_git_blob_chunk_pool_real is
'Supports floating point value searches and range filters.';

create index idx_git_blob_chunk_pool_datetime
on git_blob_chunk_pool(datetime_value);

comment on index idx_git_blob_chunk_pool_datetime is
'Supports timestamp-based searches and analytics.';

create index idx_git_blob_chunk_pool_uuid
on git_blob_chunk_pool(uuid_value);

comment on index idx_git_blob_chunk_pool_uuid is
'Supports UUID value lookups.';

create index idx_git_blob_chunk_pool_jsonb
on git_blob_chunk_pool
using gin (jsonb_value);

comment on index idx_git_blob_chunk_pool_jsonb is
'GIN index for JSONB containment and path queries.';


-- =====================================================
-- git_element_manifest
-- =====================================================

create unique index idx_git_element_manifest_hash
on git_element_manifest(manifest_hash);

comment on index idx_git_element_manifest_hash is
'Detects and reuses identical manifests through hash lookup.';


-- =====================================================
-- git_element_manifest_entry
-- =====================================================

create index idx_manifest_entry_chunk
on git_element_manifest_entry(chunk_hash);

comment on index idx_manifest_entry_chunk is
'Finds all manifests referencing a specific chunk.';

create index idx_manifest_entry_attribute
on git_element_manifest_entry(attribute_id);

comment on index idx_manifest_entry_attribute is
'Supports attribute-based filtering and analytics.';

create index idx_manifest_entry_attr_chunk
on git_element_manifest_entry
(
    attribute_id,
    chunk_hash
);

comment on index idx_manifest_entry_attr_chunk is
'Optimized for attribute/value searches such as SPEC=CS150.';


-- =====================================================
-- git_element
-- =====================================================

create unique index idx_git_element
on git_element
(
    container_id,
    local_id
);

comment on index idx_git_element is
'Fast lookup of engineering elements by identity.';


-- =====================================================
-- git_tree
-- =====================================================

create unique index idx_git_tree_hash
on git_tree(tree_hash);

comment on index idx_git_tree_hash is
'Unique lookup of repository trees by hash.';


-- =====================================================
-- git_tree_entry
-- =====================================================

create index idx_tree_entry_manifest
on git_tree_entry(manifest_id);

comment on index idx_tree_entry_manifest is
'Finds elements using a specific manifest.';

create index idx_tree_entry_element
on git_tree_entry
(
    container_id,
    local_id
);

comment on index idx_tree_entry_element is
'Supports element-to-manifest resolution inside trees.';


-- =====================================================
-- git_commit
-- =====================================================

create unique index idx_commit_hash
on git_commit(commit_hash);

comment on index idx_commit_hash is
'Primary lookup for commits by commit hash.';

create index idx_commit_tree_hash
on git_commit(tree_hash);

comment on index idx_commit_tree_hash is
'Supports commit-to-tree navigation.';

create index idx_commit_author_date
on git_commit(author_date);

comment on index idx_commit_author_date is
'Supports commit history queries by author timestamp.';

create index idx_commit_commit_date
on git_commit(commit_date);

comment on index idx_commit_commit_date is
'Supports commit history queries by commit timestamp.';


-- =====================================================
-- git_commit_parent
-- =====================================================

create index idx_commit_parent_parent
on git_commit_parent(parent_hash);

comment on index idx_commit_parent_parent is
'Supports reverse traversal of the commit graph.';


-- =====================================================
-- git_ref
-- =====================================================

create unique index idx_git_ref_name
on git_ref
(
    repository_id,
    ref_name
);

comment on index idx_git_ref_name is
'Fast lookup of branches and references within a repository.';


-- =====================================================
-- git_tag
-- =====================================================

create unique index idx_git_tag_name
on git_tag(tag_name);

comment on index idx_git_tag_name is
'Ensures tag names are unique and quickly searchable.';

create index idx_git_tag_target
on git_tag(target_hash);

comment on index idx_git_tag_target is
'Finds tags pointing to a specific commit.';


-- =====================================================
-- git_index_entry
-- =====================================================

create index idx_git_index_manifest
on git_index_entry(manifest_id);

comment on index idx_git_index_manifest is
'Supports staging area lookups by manifest.';

create index idx_tree_entry_tree_manifest
on git_tree_entry
(
    tree_hash,
    manifest_id
);