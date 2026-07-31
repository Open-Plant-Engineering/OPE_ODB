-- =====================================================
-- repository
-- =====================================================

create table repository
(
    repository_id bigint generated always as identity primary key,
    name text not null unique,
    created_at timestamptz not null default now()
);

-- =====================================================
-- git_object
-- =====================================================

create table git_object
(
    object_hash char(40) primary key,
    object_type varchar(20) not null,
    object_size bigint not null,
    object_data bytea not null,
    created_at timestamptz not null default now()
);

-- =====================================================
-- git_blob
-- =====================================================

create table git_blob
(
    object_hash char(40) primary key,
    foreign key (object_hash)
        references git_object(object_hash)
);

-- =====================================================
-- git_tree
-- =====================================================

create table git_tree
(
    object_hash char(40) primary key,
    foreign key (object_hash)
        references git_object(object_hash)
);

-- =====================================================
-- git_tree_entry
-- =====================================================

create table git_tree_entry
(
    tree_hash char(40) not null,
    entry_name text not null,
    object_hash char(40) not null,
    object_mode integer not null,

    primary key
    (
        tree_hash,
        entry_name
    )
);

-- =====================================================
-- git_commit
-- =====================================================

create table git_commit
(
    object_hash char(40) primary key,

    tree_hash char(40) not null,

    author_name text not null,
    author_email text not null,

    committer_name text not null,
    committer_email text not null,

    commit_message text not null,

    author_date timestamptz not null,
    commit_date timestamptz not null
);

-- =====================================================
-- git_commit_parent
-- =====================================================

create table git_commit_parent
(
    commit_hash char(40) not null,
    parent_hash char(40) not null,
    parent_index integer not null,

    primary key
    (
        commit_hash,
        parent_hash
    )
);

-- =====================================================
-- git_commit_parent
-- =====================================================

create table git_tag
(
    object_hash char(40) primary key,

    target_hash char(40) not null,

    tag_name text not null,

    tagger_name text,
    tagger_email text,

    tag_message text
);

-- =====================================================
-- git_commit_parent
-- =====================================================

create table git_ref
(
    repository_id bigint not null,

    ref_name text not null,

    object_hash char(40) not null,

    primary key
    (
        repository_id,
        ref_name
    )
);

-- =====================================================
-- git_commit_parent
-- =====================================================

create table git_head
(
    repository_id bigint primary key,

    ref_name text,

    detached_hash char(40),

    check
    (
        ref_name is not null
        or
        detached_hash is not null
    )
);

-- =====================================================
-- git_commit_parent
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
    )
);

-- =====================================================
-- git_index_entry
-- =====================================================

create table git_index_entry
(
    repository_id bigint not null,

    file_path text not null,

    object_hash char(40) not null,

    file_mode integer not null,

    primary key
    (
        repository_id,
        file_path
    )
);

-- =====================================================
-- git_reflog
-- =====================================================

create table git_reflog
(
    reflog_id bigint generated always as identity primary key,

    repository_id bigint not null,

    ref_name text not null,

    old_hash char(40),

    new_hash char(40),

    message text,

    changed_at timestamptz not null default now()
);

-- =====================================================
-- git_pack
-- =====================================================

create table git_pack
(
    pack_id bigint generated always as identity primary key,

    repository_id bigint not null,

    pack_hash char(40),

    pack_data bytea
);

-- =====================================================
-- git_pack_object
-- =====================================================

create table git_pack_object
(
    pack_id bigint not null,

    object_hash char(40) not null,

    object_offset bigint not null,

    primary key
    (
        pack_id,
        object_hash
    )
);

-- =====================================================
-- git_alternate_repository
-- =====================================================

create table git_alternate_repository
(
    repository_id bigint not null,
    alternate_repository_id bigint not null,

    primary key
    (
        repository_id,
        alternate_repository_id
    )
);