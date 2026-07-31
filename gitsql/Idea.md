# OPEGit Architecture

### Git-Inspired Versioning Engine for Engineering Objects

***

# 1. Overview

OPEGit is a Git-inspired version control system designed specifically for engineering object databases rather than source code repositories.

Unlike traditional Git:

```text
File
  ↓
Blob
  ↓
Commit
```

OPEGit versions:

```text
Element
  ↓
Manifest
  ↓
Attribute Values
  ↓
Commit
```

The objective is:

* Git-style commits
* Git-style branches
* Git-style merges
* Git-style tags
* Immutable history
* Maximum value deduplication
* Optimized storage for engineering data

***

# 2. Core Concepts

## Traditional Git

Git treats a file as a binary blob.

Example:

```text
pipe.json

{
    "NAME":"PIPE-100",
    "SPEC":"CS150"
}
```

Git stores:

```text
Blob
```

If one value changes:

```text
SPEC = SS316
```

Git creates a new blob.

***

## OPEGit

OPEGit treats an engineering element as a file.

Example:

```json
{
    "NAME":"PIPE-100",
    "SPEC":"CS150",
    "BORE":100
}
```

Attribute names already exist in metadata tables:

```text
attribute_definition
```

Therefore only values require versioning storage.

***

# 3. Element Model

Each element is uniquely identified by:

```text
container_id
local_id
```

Example:

```text
container_id = 100
local_id     = 5000
```

Equivalent to a filename in Git.

***

# 4. Chunk Pool

## Purpose

Stores every unique value exactly once.

Table:

```text
git_blob_chunk_pool
```

***

### Example

Element 1

```json
{
    "NAME":"PIPE-100",
    "SPEC":"CS150",
    "BORE":100
}
```

Creates:

```text
PIPE-100
CS150
100
```

***

Element 2

```json
{
    "NAME":"PIPE-101",
    "SPEC":"CS150",
    "BORE":100
}
```

Creates only:

```text
PIPE-101
```

because:

```text
CS150
100
```

already exist.

***

### Result

```text
Chunk Pool

1 -> PIPE-100
2 -> PIPE-101
3 -> CS150
4 -> 100
```

Stored only once.

***

# 5. Manifest

## Purpose

A manifest represents the complete state of an element.

Equivalent to:

```text
Git Blob
```

but implemented as attribute mappings.

***

### Example

Element

```json
{
    "NAME":"PIPE-100",
    "SPEC":"CS150",
    "BORE":100
}
```

Manifest

```text
NAME -> PIPE-100
SPEC -> CS150
BORE -> 100
```

Internally

```text
attribute_id=10 -> chunk_id=1
attribute_id=20 -> chunk_id=3
attribute_id=30 -> chunk_id=4
```

***

# 6. Manifest Hash

Every manifest receives a hash.

Example:

```text
M1
```

Generated from:

```text
attribute_id
chunk_id
```

pairs.

If contents are identical:

```text
Hash remains identical.
```

Therefore manifests are reusable.

***

# 7. Element

Elements are permanent identities.

```text
container_id
local_id
```

never change.

Only the referenced manifest changes.

***

Example:

Revision R1

```text
Element
    ↓
Manifest M1
```

Revision R2

```text
Element
    ↓
Manifest M2
```

The element remains the same.

***

# 8. Trees

Equivalent to Git directories.

Trees organize elements.

Example:

```text
SITE
 ├── ZONE1
 │    ├── PIPE100
 │    └── PIPE101
 └── ZONE2
```

Tree contains references to:

```text
(container_id, local_id)
```

instead of Git blobs.

***

# 9. Commits

A commit represents a complete repository snapshot.

Commit contains:

```text
commit_hash
tree_hash
author
timestamp
message
```

Example:

```text
R1
```

```text
Initial Import
```

***

# 10. Commit Graph

Exactly the same as Git.

History:

```text
R1
 ↓
R2
 ↓
R3
```

Each commit points to its parent.

***

# 11. Branches

Exactly the same as Git.

Example:

```text
main
  ↓
R3
```

Create branch:

```text
development
  ↓
R3
```

Both point to the same commit.

***

After new commits:

```text
main
  ↓
R3

development
  ↓
R5
```

***

# 12. Merge

Exactly the same as Git.

Example:

```text
R1
 ↓
R2
 ↓
R3
```

Development:

```text
R2
 ↓
R4
 ↓
R5
```

Merge:

```text
      R5
     /
R1-R2-R3
     \
      R6
```

R6 becomes:

```text
Merge Commit
```

with two parents.

***

# 13. Tags

Exactly the same as Git.

Example:

```text
Release-1.0
      ↓
      R10
```

Tags never move.

***

# 14. Deduplication Example

Imagine:

```text
10,000,000 pipes
```

All contain:

```text
SPEC = CS150
```

Traditional storage:

```text
CS150 repeated
10,000,000 times
```

OPEGit:

```text
CS150 stored once
```

Every manifest references the same chunk.

***

# 15. Change Example

Revision R1

```json
{
    "NAME":"PIPE-100",
    "SPEC":"CS150",
    "BORE":100
}
```

Manifest:

```text
M1
```

***

Revision R2

```json
{
    "NAME":"PIPE-100",
    "SPEC":"SS316",
    "BORE":100
}
```

New chunk created:

```text
SS316
```

New manifest:

```text
M2
```

Everything else reused.

***

Storage growth:

```text
+ 1 chunk
+ 1 manifest
+ 1 commit
```

Only.

***

# 16. Key Advantages

## Git-Like Features

```text
✓ Commit
✓ Branch
✓ Merge
✓ Tags
✓ History
✓ Restore
✓ Compare
```

***

## Engineering Data Optimizations

```text
✓ Value deduplication
✓ Manifest reuse
✓ Immutable history
✓ Small incremental storage
✓ Object-level versioning
```

***

## Storage Efficiency

Instead of storing:

```text
Entire JSON
Entire Element
Entire Snapshot
```

for every revision,

OPEGit stores:

```text
Only new values
Only new manifests
Only new commits
```

which can reduce storage dramatically in engineering models where a large percentage of attribute values are repeated across millions of elements.

***

# Architecture Summary

```text
Repository
    │
    ├── Branch
    │
    ├── Commit
    │      │
    │      └── Tree
    │              │
    │              └── Element
    │                        │
    │                        └── Manifest
    │                                  │
    │                                  └── Attribute → Chunk
    │
    └── Tags
```

In simple terms:

> OPEGit keeps Git's commit graph, branching, merging, and history model unchanged, but replaces Git's file/blob storage with a highly deduplicated element/manifest/chunk architecture optimized for engineering object databases.
