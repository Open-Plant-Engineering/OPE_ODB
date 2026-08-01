-- =====================================================
-- OPEGIT
-- CORE FUNCTIONS
-- =====================================================



-- =====================================================
-- get_chunk_by_hash
-- =====================================================

create or replace function get_chunk_by_hash
(
    p_chunk_hash varchar(64)
)
returns varchar(64)
language sql
stable
as
$$
    select chunk_hash
    from git_blob_chunk_pool
    where chunk_hash = p_chunk_hash;
$$;

comment on function get_chunk_by_hash(varchar)
is 'Returns a chunk hash.';



-- =====================================================
-- get_chunk_by_value
-- =====================================================

create or replace function get_chunk_by_value
(
    p_data_type_id smallint,
    p_string_value text default null,
    p_integer_value bigint default null,
    p_numeric_value numeric default null,
    p_real_value double precision default null,
    p_boolean_value boolean default null,
    p_date_value date default null,
    p_time_value time default null,
    p_datetime_value timestamptz default null,
    p_interval_value interval default null,
    p_uuid_value uuid default null,
    p_jsonb_value jsonb default null,
    p_binary_value bytea default null
)
returns varchar(64)
language sql
stable
as
$$
    select chunk_hash
    from git_blob_chunk_pool
    where data_type_id = p_data_type_id
      and string_value   is not distinct from p_string_value
      and integer_value  is not distinct from p_integer_value
      and numeric_value  is not distinct from p_numeric_value
      and real_value     is not distinct from p_real_value
      and boolean_value  is not distinct from p_boolean_value
      and date_value     is not distinct from p_date_value
      and time_value     is not distinct from p_time_value
      and datetime_value is not distinct from p_datetime_value
      and interval_value is not distinct from p_interval_value
      and uuid_value     is not distinct from p_uuid_value
      and jsonb_value    is not distinct from p_jsonb_value
      and binary_value   is not distinct from p_binary_value;
$$;

comment on function get_chunk_by_value
is 'Returns chunk hash for an existing typed value.';



-- =====================================================
-- create_chunk
-- =====================================================

create or replace function create_chunk
(
    p_chunk_hash varchar(64),

    p_data_type_id smallint,

    p_string_value text default null,
    p_integer_value bigint default null,
    p_numeric_value numeric default null,
    p_real_value double precision default null,
    p_boolean_value boolean default null,
    p_date_value date default null,
    p_time_value time default null,
    p_datetime_value timestamptz default null,
    p_interval_value interval default null,
    p_uuid_value uuid default null,
    p_jsonb_value jsonb default null,
    p_binary_value bytea default null
)
returns varchar(64)
language plpgsql
as
$$
declare
    v_chunk_hash varchar(64);
begin

    insert into git_blob_chunk_pool
    (
        chunk_hash,
        data_type_id,
        string_value,
        integer_value,
        numeric_value,
        real_value,
        boolean_value,
        date_value,
        time_value,
        datetime_value,
        interval_value,
        uuid_value,
        jsonb_value,
        binary_value
    )
    values
    (
        p_chunk_hash,
        p_data_type_id,
        p_string_value,
        p_integer_value,
        p_numeric_value,
        p_real_value,
        p_boolean_value,
        p_date_value,
        p_time_value,
        p_datetime_value,
        p_interval_value,
        p_uuid_value,
        p_jsonb_value,
        p_binary_value
    )
    on conflict (chunk_hash)
    do update
        set chunk_hash = excluded.chunk_hash
    returning chunk_hash
    into v_chunk_hash;

    return v_chunk_hash;

end;
$$;

comment on function create_chunk
is 'Creates a chunk and returns its hash.';



-- =====================================================
-- get_or_create_chunk
-- =====================================================

create or replace function get_or_create_chunk
(
    p_chunk_hash varchar(64),

    p_data_type_id smallint,

    p_string_value text default null,
    p_integer_value bigint default null,
    p_numeric_value numeric default null,
    p_real_value double precision default null,
    p_boolean_value boolean default null,
    p_date_value date default null,
    p_time_value time default null,
    p_datetime_value timestamptz default null,
    p_interval_value interval default null,
    p_uuid_value uuid default null,
    p_jsonb_value jsonb default null,
    p_binary_value bytea default null
)
returns varchar(64)
language plpgsql
as
$$
declare
    v_chunk_hash varchar(64);
begin

    select chunk_hash
      into v_chunk_hash
      from git_blob_chunk_pool
     where chunk_hash = p_chunk_hash;

    if v_chunk_hash is not null then
        return v_chunk_hash;
    end if;

    return create_chunk
    (
        p_chunk_hash,

        p_data_type_id,

        p_string_value,
        p_integer_value,
        p_numeric_value,
        p_real_value,
        p_boolean_value,
        p_date_value,
        p_time_value,
        p_datetime_value,
        p_interval_value,
        p_uuid_value,
        p_jsonb_value,
        p_binary_value
    );

end;
$$;

comment on function get_or_create_chunk
is 'Returns existing chunk hash or creates a new chunk.';


-- =====================================================
-- manifest_exists
-- =====================================================

create or replace function manifest_exists
(
    p_manifest_hash varchar(64)
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from git_element_manifest
        where manifest_hash = p_manifest_hash
    );
$$;

comment on function manifest_exists
is 'Returns true when manifest already exists.';


-- =====================================================
-- get_manifest_id
-- =====================================================

create or replace function get_manifest_id
(
    p_manifest_hash varchar(64)
)
returns bigint
language sql
stable
as
$$
    select manifest_id
    from git_element_manifest
    where manifest_hash = p_manifest_hash;
$$;

comment on function get_manifest_id
is 'Returns manifest identifier from manifest hash.';


-- =====================================================
-- create_manifest
-- =====================================================

create or replace function create_manifest
(
    p_manifest_hash varchar(64)
)
returns bigint
language plpgsql
as
$$
declare
    v_manifest_id bigint;
begin

    insert into git_element_manifest
    (
        manifest_hash
    )
    values
    (
        p_manifest_hash
    )
    on conflict (manifest_hash)
    do update
        set manifest_hash = excluded.manifest_hash
    returning manifest_id
    into v_manifest_id;

    return v_manifest_id;

end;
$$;

comment on function create_manifest
is 'Creates a new manifest and returns manifest identifier.';


-- =====================================================
-- get_or_create_manifest
-- =====================================================

create or replace function get_or_create_manifest
(
    p_manifest_hash varchar(64)
)
returns bigint
language plpgsql
as
$$
declare

    v_manifest_id bigint;

begin

    select manifest_id
    into v_manifest_id
    from git_element_manifest
    where manifest_hash = p_manifest_hash;

    if v_manifest_id is not null then
        return v_manifest_id;
    end if;

    return create_manifest
    (
        p_manifest_hash
    );

end;
$$;

comment on function get_or_create_manifest
is 'Returns existing manifest or creates a new manifest.';


-- =====================================================
-- add_manifest_entry
-- =====================================================

create or replace function add_manifest_entry
(
    p_manifest_id bigint,
    p_attribute_id integer,
    p_chunk_hash varchar(64)
)
returns void
language plpgsql
as
$$
begin

    insert into git_element_manifest_entry
    (
        manifest_id,
        attribute_id,
        chunk_hash
    )
    values
    (
        p_manifest_id,
        p_attribute_id,
        p_chunk_hash
    )
    on conflict
    (
        manifest_id,
        attribute_id
    )
    do update
    set chunk_hash = excluded.chunk_hash;

end;
$$;

comment on function add_manifest_entry
is 'Adds or updates an attribute value inside a manifest.';


-- =====================================================
-- get_manifest_entry
-- =====================================================

create or replace function get_manifest_entry
(
    p_manifest_id bigint,
    p_attribute_id integer
)
returns varchar(64)
language sql
stable
as
$$
    select chunk_hash
    from git_element_manifest_entry
    where manifest_id = p_manifest_id
      and attribute_id = p_attribute_id;
$$;

comment on function get_manifest_entry
is 'Returns chunk identifier for a manifest attribute.';


-- =====================================================
-- get_manifest_entries
-- =====================================================

create or replace function get_manifest_entries
(
    p_manifest_id bigint
)
returns table
(
    attribute_id integer,
    chunk_hash varchar(64)
)
language sql
stable
as
$$
    select
        attribute_id,
        chunk_hash
    from git_element_manifest_entry
    where manifest_id = p_manifest_id
    order by attribute_id;
$$;

comment on function get_manifest_entries
is 'Returns all attribute/chunk pairs belonging to a manifest.';


-- =====================================================
-- delete_manifest_entry
-- =====================================================

create or replace function delete_manifest_entry
(
    p_manifest_id bigint,
    p_attribute_id integer
)
returns void
language plpgsql
as
$$
begin

    delete
    from git_element_manifest_entry
    where manifest_id = p_manifest_id
    and attribute_id = p_attribute_id;

end;
$$;

comment on function delete_manifest_entry
is 'Removes an attribute from a manifest.';


-- =====================================================
-- element_exists
-- =====================================================

create or replace function element_exists
(
    p_container_id bigint,
    p_local_id bigint
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from git_element
        where container_id = p_container_id
        and local_id = p_local_id
    );
$$;

comment on function element_exists(bigint,bigint)
is 'Returns true when an element exists.';


-- =====================================================
-- create_element
-- =====================================================

create or replace function create_element
(
    p_container_id bigint,
    p_local_id bigint
)
returns void
language plpgsql
as
$$
begin

    insert into git_element
    (
        container_id,
        local_id
    )
    values
    (
        p_container_id,
        p_local_id
    )
    on conflict
    (
        container_id,
        local_id
    )
    do nothing;

end;
$$;

comment on function create_element(bigint,bigint)
is 'Creates a new engineering element.';


-- =====================================================
-- get_element
-- =====================================================

create or replace function get_element
(
    p_container_id bigint,
    p_local_id bigint
)
returns table
(
    container_id bigint,
    local_id bigint
)
language sql
stable
as
$$
    select
        e.container_id,
        e.local_id
    from git_element e
    where e.container_id = p_container_id
    and e.local_id = p_local_id;
$$;

comment on function get_element(bigint,bigint)
is 'Returns element information.';


-- =====================================================
-- delete_element
-- =====================================================

create or replace function delete_element
(
    p_container_id bigint,
    p_local_id bigint
)
returns void
language plpgsql
as
$$
begin

    delete
    from git_element
    where container_id = p_container_id
    and local_id = p_local_id;

end;
$$;

comment on function delete_element(bigint,bigint)
is 'Deletes an element identity.';


-- =====================================================
-- tree_exists
-- =====================================================

create or replace function tree_exists
(
    p_tree_hash varchar(64)
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from git_tree
        where tree_hash = p_tree_hash
    );
$$;

comment on function tree_exists(varchar)
is 'Returns true if tree exists.';


-- =====================================================
-- create_tree
-- =====================================================

create or replace function create_tree
(
    p_tree_hash varchar(64)
)
returns varchar(64)
language plpgsql
as
$$
begin

    insert into git_tree
    (
        tree_hash
    )
    values
    (
        p_tree_hash
    )
    on conflict
    (
        tree_hash
    )
    do nothing;

    return p_tree_hash;

end;
$$;

comment on function create_tree(varchar)
is 'Creates a tree object.';


-- =====================================================
-- add_tree_entry
-- =====================================================

create or replace function add_tree_entry
(
    p_tree_hash varchar(64),

    p_container_id bigint,
    p_local_id bigint,

    p_manifest_id bigint
)
returns void
language plpgsql
as
$$
begin

    insert into git_tree_entry
    (
        tree_hash,
        container_id,
        local_id,
        manifest_id
    )
    values
    (
        p_tree_hash,
        p_container_id,
        p_local_id,
        p_manifest_id
    )
    on conflict
    (
        tree_hash,
        container_id,
        local_id
    )
    do update
    set manifest_id = excluded.manifest_id;

end;
$$;

comment on function add_tree_entry(varchar,bigint,bigint,bigint)
is 'Adds or updates element manifest within tree.';


-- =====================================================
-- get_tree_entries
-- =====================================================

create or replace function get_tree_entries
(
    p_tree_hash varchar(64)
)
returns table
(
    container_id bigint,
    local_id bigint,
    manifest_id bigint
)
language sql
stable
as
$$
    select
        te.container_id,
        te.local_id,
        te.manifest_id
    from git_tree_entry te
    where te.tree_hash = p_tree_hash
    order by
        te.container_id,
        te.local_id;
$$;

comment on function get_tree_entries(varchar)
is 'Returns all entries in a tree.';


-- =====================================================
-- remove_tree_entry
-- =====================================================

create or replace function remove_tree_entry
(
    p_tree_hash varchar(64),
    p_container_id bigint,
    p_local_id bigint
)
returns void
language plpgsql
as
$$
begin

    delete
    from git_tree_entry
    where tree_hash = p_tree_hash
    and container_id = p_container_id
    and local_id = p_local_id;

end;
$$;

comment on function remove_tree_entry(varchar,bigint,bigint)
is 'Removes an element from a tree.';


-- =====================================================
-- get_tree_manifest
-- =====================================================

create or replace function get_tree_manifest
(
    p_tree_hash varchar(64),

    p_container_id bigint,
    p_local_id bigint
)
returns bigint
language sql
stable
as
$$
    select manifest_id
    from git_tree_entry
    where tree_hash = p_tree_hash
    and container_id = p_container_id
    and local_id = p_local_id;
$$;

comment on function get_tree_manifest(varchar,bigint,bigint)
is 'Returns manifest active for an element inside a tree.';


-- =====================================================
-- commit_exists
-- =====================================================

create or replace function commit_exists
(
    p_commit_hash varchar(64)
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from git_commit
        where commit_hash = p_commit_hash
    );
$$;

comment on function commit_exists(varchar)
is 'Returns true if commit exists.';


-- =====================================================
-- create_commit
-- =====================================================

create or replace function create_commit
(
    p_commit_hash varchar(64),

    p_tree_hash varchar(64),

    p_author_name text,
    p_author_email text,

    p_committer_name text,
    p_committer_email text,

    p_commit_message text,

    p_author_date timestamptz,
    p_commit_date timestamptz
)
returns varchar(64)
language plpgsql
as
$$
begin

    insert into git_commit
    (
        commit_hash,

        tree_hash,

        author_name,
        author_email,

        committer_name,
        committer_email,

        commit_message,

        author_date,
        commit_date
    )
    values
    (
        p_commit_hash,

        p_tree_hash,

        p_author_name,
        p_author_email,

        p_committer_name,
        p_committer_email,

        p_commit_message,

        p_author_date,
        p_commit_date
    )
    on conflict
    (
        commit_hash
    )
    do nothing;

    return p_commit_hash;

end;
$$;

comment on function create_commit
is 'Creates a commit object and returns the commit hash.';

-- =====================================================
-- create_commit_with_parent
-- =====================================================

create or replace function create_commit_with_parent
(
    p_commit_hash varchar(64),

    p_parent_hash varchar(64),

    p_tree_hash varchar(64),

    p_author_name text,
    p_author_email text,

    p_committer_name text,
    p_committer_email text,

    p_commit_message text,

    p_author_date timestamptz,
    p_commit_date timestamptz
)
returns varchar(64)
language plpgsql
as
$$
begin

    perform create_commit
    (
        p_commit_hash,

        p_tree_hash,

        p_author_name,
        p_author_email,

        p_committer_name,
        p_committer_email,

        p_commit_message,

        p_author_date,
        p_commit_date
    );

    perform add_commit_parent
    (
        p_commit_hash,
        p_parent_hash,
        1
    );

    return p_commit_hash;

end;
$$;

comment on function create_commit_with_parent
is 'Creates a commit and assigns a first parent commit.';


-- =====================================================
-- add_commit_parent
-- =====================================================

create or replace function add_commit_parent
(
    p_commit_hash varchar(64),

    p_parent_hash varchar(64),

    p_parent_index integer
)
returns void
language plpgsql
as
$$
begin

    insert into git_commit_parent
    (
        commit_hash,
        parent_hash,
        parent_index
    )
    values
    (
        p_commit_hash,
        p_parent_hash,
        p_parent_index
    )
    on conflict
    (
        commit_hash,
        parent_hash
    )
    do nothing;

end;
$$;

comment on function add_commit_parent
is 'Creates parent relationship between commits.';


-- =====================================================
-- get_commit
-- =====================================================

create or replace function get_commit
(
    p_commit_hash varchar(64)
)
returns table
(
    commit_hash varchar(64),
    tree_hash varchar(64),

    author_name text,
    author_email text,

    committer_name text,
    committer_email text,

    commit_message text,

    author_date timestamptz,
    commit_date timestamptz
)
language sql
stable
as
$$
    select
        c.commit_hash,
        c.tree_hash,

        c.author_name,
        c.author_email,

        c.committer_name,
        c.committer_email,

        c.commit_message,

        c.author_date,
        c.commit_date
    from git_commit c
    where c.commit_hash = p_commit_hash;
$$;

comment on function get_commit(varchar)
is 'Returns commit information.';


-- =====================================================
-- get_commit_tree
-- =====================================================

create or replace function get_commit_tree
(
    p_commit_hash varchar(64)
)
returns varchar(64)
language sql
stable
as
$$
    select tree_hash
    from git_commit
    where commit_hash = p_commit_hash;
$$;

comment on function get_commit_tree(varchar)
is 'Returns tree associated with a commit.';


-- =====================================================
-- get_commit_parents
-- =====================================================

create or replace function get_commit_parents
(
    p_commit_hash varchar(64)
)
returns table
(
    parent_hash varchar(64),
    parent_index integer
)
language sql
stable
as
$$
    select
        cp.parent_hash,
        cp.parent_index
    from git_commit_parent cp
    where cp.commit_hash = p_commit_hash
    order by cp.parent_index;
$$;

comment on function get_commit_parents(varchar)
is 'Returns parent commits.';


-- =====================================================
-- get_commit_parent
-- =====================================================

create or replace function get_commit_parent
(
    p_commit_hash varchar(64)
)
returns varchar(64)
language sql
stable
as
$$
    select parent_hash
    from git_commit_parent
    where commit_hash = p_commit_hash
    and parent_index = 1;
$$;

comment on function get_commit_parent(varchar)
is 'Returns first parent of a commit.';


-- =====================================================
-- is_merge_commit
-- =====================================================

create or replace function is_merge_commit
(
    p_commit_hash varchar(64)
)
returns boolean
language sql
stable
as
$$
    select count(*) > 1
    from git_commit_parent
    where commit_hash = p_commit_hash;
$$;

comment on function is_merge_commit(varchar)
is 'Returns true if commit contains multiple parents.';


-- =====================================================
-- get_commit_count
-- =====================================================

create or replace function get_commit_count()
returns bigint
language sql
stable
as
$$
    select count(*)
    from git_commit;
$$;

comment on function get_commit_count()
is 'Returns total number of commits.';


-- =====================================================
-- get_commit_children
-- =====================================================

create or replace function get_commit_children
(
    p_commit_hash varchar(64)
)
returns table
(
    commit_hash varchar(64)
)
language sql
stable
as
$$
    select cp.commit_hash
    from git_commit_parent cp
    where cp.parent_hash = p_commit_hash
    order by cp.commit_hash;
$$;

comment on function get_commit_children(varchar)
is 'Returns direct child commits.';


-- =====================================================
-- get_latest_commit
-- =====================================================

create or replace function get_latest_commit()
returns varchar(64)
language sql
stable
as
$$
    select commit_hash
    from git_commit
    order by commit_date desc
    limit 1;
$$;

comment on function get_latest_commit()
is 'Returns most recently committed revision.';


-- =====================================================
-- ref_exists
-- =====================================================

create or replace function ref_exists
(
    p_repository_id bigint,
    p_ref_name text
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from git_ref
        where repository_id = p_repository_id
        and ref_name = p_ref_name
    );
$$;

comment on function ref_exists(bigint,text)
is 'Returns true if reference exists.';


-- =====================================================
-- create_ref
-- =====================================================

create or replace function create_ref
(
    p_repository_id bigint,
    p_ref_name text,
    p_object_hash varchar(64)
)
returns void
language plpgsql
as
$$
begin

    insert into git_ref
    (
        repository_id,
        ref_name,
        object_hash
    )
    values
    (
        p_repository_id,
        p_ref_name,
        p_object_hash
    )
    on conflict
    (
        repository_id,
        ref_name
    )
    do nothing;

end;
$$;

comment on function create_ref(bigint,text,varchar)
is 'Creates a new reference.';


-- =====================================================
-- update_ref
-- =====================================================

create or replace function update_ref
(
    p_repository_id bigint,
    p_ref_name text,
    p_object_hash varchar(64)
)
returns void
language plpgsql
as
$$
begin

    update git_ref
    set object_hash = p_object_hash
    where repository_id = p_repository_id
    and ref_name = p_ref_name;

end;
$$;

comment on function update_ref(bigint,text,varchar)
is 'Updates reference target.';


-- =====================================================
-- get_ref
-- =====================================================

create or replace function get_ref
(
    p_repository_id bigint,
    p_ref_name text
)
returns varchar(64)
language sql
stable
as
$$
    select object_hash
    from git_ref
    where repository_id = p_repository_id
    and ref_name = p_ref_name;
$$;

comment on function get_ref(bigint,text)
is 'Returns reference target hash.';


-- =====================================================
-- delete_ref
-- =====================================================

create or replace function delete_ref
(
    p_repository_id bigint,
    p_ref_name text
)
returns void
language plpgsql
as
$$
begin

    delete
    from git_ref
    where repository_id = p_repository_id
    and ref_name = p_ref_name;

end;
$$;

comment on function delete_ref(bigint,text)
is 'Deletes a reference.';


-- =====================================================
-- branch_exists
-- =====================================================

create or replace function branch_exists
(
    p_repository_id bigint,
    p_branch_name text
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from git_ref
        where repository_id = p_repository_id
        and ref_name = 'refs/heads/' || p_branch_name
    );
$$;

comment on function branch_exists(bigint,text)
is 'Returns true if branch exists.';


-- =====================================================
-- create_branch
-- =====================================================

create or replace function create_branch
(
    p_repository_id bigint,
    p_branch_name text,
    p_commit_hash varchar(64)
)
returns void
language plpgsql
as
$$
begin

    perform create_ref
    (
        p_repository_id,
        'refs/heads/' || p_branch_name,
        p_commit_hash
    );

end;
$$;

comment on function create_branch(bigint,text,varchar)
is 'Creates a branch.';


-- =====================================================
-- delete_branch
-- =====================================================

create or replace function delete_branch
(
    p_repository_id bigint,
    p_branch_name text
)
returns void
language plpgsql
as
$$
begin

    perform delete_ref
    (
        p_repository_id,
        'refs/heads/' || p_branch_name
    );

end;
$$;

comment on function delete_branch(bigint,text)
is 'Deletes branch.';


-- =====================================================
-- get_branch_head
-- =====================================================

create or replace function get_branch_head
(
    p_repository_id bigint,
    p_branch_name text
)
returns varchar(64)
language sql
stable
as
$$
    select object_hash
    from git_ref
    where repository_id = p_repository_id
    and ref_name = 'refs/heads/' || p_branch_name;
$$;

comment on function get_branch_head(bigint,text)
is 'Returns current branch head commit.';


-- =====================================================
-- move_branch_head
-- =====================================================

create or replace function move_branch_head
(
    p_repository_id bigint,
    p_branch_name text,
    p_commit_hash varchar(64)
)
returns void
language plpgsql
as
$$
begin

    perform update_ref
    (
        p_repository_id,
        'refs/heads/' || p_branch_name,
        p_commit_hash
    );

end;
$$;

comment on function move_branch_head(bigint,text,varchar)
is 'Moves branch to another commit.';


-- =====================================================
-- get_head
-- =====================================================

create or replace function get_head
(
    p_repository_id bigint
)
returns text
language sql
stable
as
$$
    select ref_name
    from git_head
    where repository_id = p_repository_id;
$$;

comment on function get_head(bigint)
is 'Returns current HEAD reference.';


-- =====================================================
-- set_head
-- =====================================================

create or replace function set_head
(
    p_repository_id bigint,
    p_ref_name text
)
returns void
language plpgsql
as
$$
begin

    insert into git_head
    (
        repository_id,
        ref_name
    )
    values
    (
        p_repository_id,
        p_ref_name
    )
    on conflict
    (
        repository_id
    )
    do update
    set ref_name = excluded.ref_name,
        detached_hash = null;

end;
$$;

comment on function set_head(bigint,text)
is 'Moves HEAD to a branch reference.';


-- =====================================================
-- detach_head
-- =====================================================

create or replace function detach_head
(
    p_repository_id bigint,
    p_commit_hash varchar(64)
)
returns void
language plpgsql
as
$$
begin

    update git_head
    set
        ref_name = null,
        detached_hash = p_commit_hash
    where repository_id = p_repository_id;

end;
$$;

comment on function detach_head(bigint,varchar)
is 'Places repository into detached HEAD state.';


-- =====================================================
-- get_head_commit
-- =====================================================

create or replace function get_head_commit
(
    p_repository_id bigint
)
returns varchar(64)
language plpgsql
as
$$
declare

    v_ref_name text;
    v_commit_hash varchar(64);

begin

    select
        ref_name,
        detached_hash
    into
        v_ref_name,
        v_commit_hash
    from git_head
    where repository_id = p_repository_id;

    if v_ref_name is not null then

        return
        (
            select object_hash
            from git_ref
            where repository_id = p_repository_id
            and ref_name = v_ref_name
        );

    end if;

    return v_commit_hash;

end;
$$;

comment on function get_head_commit(bigint)
is 'Returns commit currently checked out by HEAD.';


-- =====================================================
-- tag_exists
-- =====================================================

create or replace function tag_exists
(
    p_tag_name text
)
returns boolean
language sql
stable
as
$$
    select exists
    (
        select 1
        from git_tag
        where tag_name = p_tag_name
    );
$$;

comment on function tag_exists(text)
is 'Returns true if tag exists.';


-- =====================================================
-- create_tag
-- =====================================================

create or replace function create_tag
(
    p_tag_hash varchar(64),
    p_target_hash varchar(64),
    p_tag_name text,
    p_tagger_name text,
    p_tagger_email text,
    p_tag_message text
)
returns varchar(64)
language plpgsql
as
$$
begin

    insert into git_tag
    (
        tag_hash,
        target_hash,
        tag_name,
        tagger_name,
        tagger_email,
        tag_message
    )
    values
    (
        p_tag_hash,
        p_target_hash,
        p_tag_name,
        p_tagger_name,
        p_tagger_email,
        p_tag_message
    )
    on conflict
    (
        tag_hash
    )
    do nothing;

    return p_tag_hash;

end;
$$;

comment on function create_tag
is 'Creates a tag object and returns the tag hash.';


-- =====================================================
-- get_tag
-- =====================================================

create or replace function get_tag
(
    p_tag_name text
)
returns varchar(64)
language sql
stable
as
$$
    select target_hash
    from git_tag
    where tag_name = p_tag_name;
$$;

comment on function get_tag(text)
is 'Returns commit referenced by tag.';


-- =====================================================
-- delete_tag
-- =====================================================

create or replace function delete_tag
(
    p_tag_name text
)
returns void
language plpgsql
as
$$
begin

    delete
    from git_tag
    where tag_name = p_tag_name;

end;
$$;

comment on function delete_tag(text)
is 'Deletes a tag.';


-- =====================================================
-- list_tags
-- =====================================================

create or replace function list_tags()
returns table
(
    tag_name text,
    target_hash varchar(64)
)
language sql
stable
as
$$
    select
        tag_name,
        target_hash
    from git_tag
    order by tag_name;
$$;

comment on function list_tags()
is 'Returns all repository tags.';


-- =====================================================
-- stage_element
-- =====================================================

create or replace function stage_element
(
    p_repository_id bigint,

    p_container_id bigint,
    p_local_id bigint,

    p_manifest_id bigint
)
returns void
language plpgsql
as
$$
begin

    insert into git_index_entry
    (
        repository_id,
        container_id,
        local_id,
        manifest_id
    )
    values
    (
        p_repository_id,
        p_container_id,
        p_local_id,
        p_manifest_id
    )
    on conflict
    (
        repository_id,
        container_id,
        local_id
    )
    do update
    set manifest_id = excluded.manifest_id;

end;
$$;

comment on function stage_element
is 'Stages an element for commit.';


-- =====================================================
-- unstage_element
-- =====================================================

create or replace function unstage_element
(
    p_repository_id bigint,
    p_container_id bigint,
    p_local_id bigint
)
returns void
language plpgsql
as
$$
begin

    delete
    from git_index_entry
    where repository_id = p_repository_id
      and container_id = p_container_id
      and local_id = p_local_id;

end;
$$;

comment on function unstage_element
is 'Removes element from index.';


-- =====================================================
-- clear_index
-- =====================================================

create or replace function clear_index
(
    p_repository_id bigint
)
returns void
language plpgsql
as
$$
begin

    delete
    from git_index_entry
    where repository_id = p_repository_id;

end;
$$;

comment on function clear_index(bigint)
is 'Clears staging area.';


-- =====================================================
-- get_staged_elements
-- =====================================================

create or replace function get_staged_elements
(
    p_repository_id bigint
)
returns table
(
    container_id bigint,
    local_id bigint,
    manifest_id bigint
)
language sql
stable
as
$$
    select
        container_id,
        local_id,
        manifest_id
    from git_index_entry
    where repository_id = p_repository_id
    order by
        container_id,
        local_id;
$$;

comment on function get_staged_elements(bigint)
is 'Returns currently staged elements.';


-- =====================================================
-- checkout_branch
-- =====================================================

create or replace function checkout_branch
(
    p_repository_id bigint,
    p_branch_name text
)
returns void
language plpgsql
as
$$
begin

    perform set_head
    (
        p_repository_id,
        'refs/heads/' || p_branch_name
    );

end;
$$;

comment on function checkout_branch(bigint,text)
is 'Moves HEAD to branch.';


-- =====================================================
-- checkout_commit
-- =====================================================

create or replace function checkout_commit
(
    p_repository_id bigint,
    p_commit_hash varchar(64)
)
returns void
language plpgsql
as
$$
begin

    perform detach_head
    (
        p_repository_id,
        p_commit_hash
    );

end;
$$;

comment on function checkout_commit(bigint,varchar)
is 'Checks out a commit in detached HEAD mode.';


-- =====================================================
-- checkout_tag
-- =====================================================

create or replace function checkout_tag
(
    p_repository_id bigint,
    p_tag_name text
)
returns void
language plpgsql
as
$$
declare

    v_commit_hash varchar(64);

begin

    select target_hash
    into v_commit_hash
    from git_tag
    where tag_name = p_tag_name;

    perform detach_head
    (
        p_repository_id,
        v_commit_hash
    );

end;
$$;

comment on function checkout_tag(bigint,text)
is 'Checks out a tag in detached HEAD mode.';

create table git_blob_chunk_pool_p00
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 0);

create table git_blob_chunk_pool_p01
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 1);

create table git_blob_chunk_pool_p02
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 2);

create table git_blob_chunk_pool_p03
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 3);

create table git_blob_chunk_pool_p04
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 4);

create table git_blob_chunk_pool_p05
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 5);

create table git_blob_chunk_pool_p06
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 6);

create table git_blob_chunk_pool_p07
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 7);

create table git_blob_chunk_pool_p08
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 8);

create table git_blob_chunk_pool_p09
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 9);

create table git_blob_chunk_pool_p10
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 10);

create table git_blob_chunk_pool_p11
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 11);

create table git_blob_chunk_pool_p12
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 12);

create table git_blob_chunk_pool_p13
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 13);

create table git_blob_chunk_pool_p14
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 14);

create table git_blob_chunk_pool_p15
partition of git_blob_chunk_pool
for values with (modulus 16, remainder 15);

create table git_element_manifest_entry_p00
partition of git_element_manifest_entry
for values with (modulus 16, remainder 0);

create table git_element_manifest_entry_p01
partition of git_element_manifest_entry
for values with (modulus 16, remainder 1);

create table git_element_manifest_entry_p02
partition of git_element_manifest_entry
for values with (modulus 16, remainder 2);

create table git_element_manifest_entry_p03
partition of git_element_manifest_entry
for values with (modulus 16, remainder 3);

create table git_element_manifest_entry_p04
partition of git_element_manifest_entry
for values with (modulus 16, remainder 4);

create table git_element_manifest_entry_p05
partition of git_element_manifest_entry
for values with (modulus 16, remainder 5);

create table git_element_manifest_entry_p06
partition of git_element_manifest_entry
for values with (modulus 16, remainder 6);

create table git_element_manifest_entry_p07
partition of git_element_manifest_entry
for values with (modulus 16, remainder 7);

create table git_element_manifest_entry_p08
partition of git_element_manifest_entry
for values with (modulus 16, remainder 8);

create table git_element_manifest_entry_p09
partition of git_element_manifest_entry
for values with (modulus 16, remainder 9);

create table git_element_manifest_entry_p10
partition of git_element_manifest_entry
for values with (modulus 16, remainder 10);

create table git_element_manifest_entry_p11
partition of git_element_manifest_entry
for values with (modulus 16, remainder 11);

create table git_element_manifest_entry_p12
partition of git_element_manifest_entry
for values with (modulus 16, remainder 12);

create table git_element_manifest_entry_p13
partition of git_element_manifest_entry
for values with (modulus 16, remainder 13);

create table git_element_manifest_entry_p14
partition of git_element_manifest_entry
for values with (modulus 16, remainder 14);

create table git_element_manifest_entry_p15
partition of git_element_manifest_entry
for values with (modulus 16, remainder 15);