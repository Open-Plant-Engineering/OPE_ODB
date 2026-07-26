This is the document I would use as the **master architecture specification** before generating any SQL. It is written so that an LLM can directly generate PostgreSQL tables, functions, procedures, indexes, and tests from it.

***

# PostgreSQL Engineering Object Database (EODB)

## Version

```text
Version: 1.0
Status: Architecture Design
Database: PostgreSQL
Access Method: Functions and Procedures Only
```

***

# 1. Overview

EODB is a hierarchical engineering object database implemented on top of PostgreSQL.

The database is designed for:

```text
- Engineering projects
- Plant design
- BIM systems
- Digital twins
- AVEVA-like object storage
- Version-controlled engineering data
```

The system is:

```text
✓ Hierarchical
✓ Version controlled
✓ Session based
✓ Append-only history
✓ Dynamic schema
✓ Reference based
✓ Tombstone delete
✓ Function API only
```

Direct table access is forbidden.

All interaction occurs through PostgreSQL functions and procedures.

***

# 2. Core Concepts

## 2.1 Node

A node represents an engineering object.

Examples:

```text
Project
Site
Area
Unit
Equipment
Pump
Valve
Pipe
Drawing
Document
```

Every node:

```text
- Has unique NodeId
- Has one owner
- Has one node type
- Can have attributes
- Can have references
- Can have children
```

***

# 2.2 NodeId

NodeId is globally unique and immutable.

Structure:

```text
NodeId
(
    ContainerId,
    LocalId
)
```

Example:

```text
(1201,1)
(1201,2)
(1201,3)

(1202,1)
```

Rules:

```text
- Never changes
- Never reused
- Used by references
- Independent of node type
```

***

# 2.3 Hierarchy

Single ownership model.

```text
Project
 ├─ Site
 │   ├─ Area
 │   └─ Area
 └─ Library
```

Rules:

```text
- One owner only
- Multiple owners not allowed
- Cross-project move not allowed
- Circular hierarchy not allowed
```

***

# 2.4 Node Types

Node types define logical object classes.

Examples:

```text
Project
Site
Area
Valve
Pump
Pipe
```

Node types are metadata.

Node types themselves are NOT versioned.

***

# 2.5 Attributes

Attributes define node properties.

Examples:

```text
Name
Description
FlowRate
Pressure
Size
ConnectedTo
```

Rules:

```text
- Attribute names may exist on multiple types
- Attributes can be added
- Attributes can be deleted
- Attribute history must be preserved
```

***

# 3. Data Types

Supported types:

```text
STRING
REAL
BOOLEAN
REFERENCE
ARRAY
```

***

## 3.1 STRING

Example:

```text
"PUMP-101"
```

***

## 3.2 REAL

Example:

```text
125.32
```

***

## 3.3 BOOLEAN

Example:

```text
TRUE
FALSE
```

***

## 3.4 REFERENCE

Reference stores NodeId.

Example:

```text
Pump1 -> Valve1
```

stored as:

```text
(ContainerId, LocalId)
```

Rules:

```text
- References are immutable values
- References contain no version information
- References may point anywhere
```

***

## 3.5 ARRAY

Arrays contain elements of same datatype.

Valid:

```text
STRING[]
REAL[]
BOOLEAN[]
REFERENCE[]
```

Rules:

```text
- Ordered
- Duplicates allowed
- Not a set
- Preserve insertion order
```

Examples:

```text
["A","B","C"]

[10.0,20.0,30.0]

[(100,1),(100,2)]
```

***

# 4. Version Control Model

## Element Level Versioning

Versioning is performed per node.

Not repository-level.

***

Example:

```text
Pump1 modified in Session 10

Valve1 modified in Session 11

Area1 modified in Session 13
```

Each node maintains independent history.

***

## History Preservation

Nothing is physically removed.

All modifications are historical records.

***

Example:

```text
FlowRate = 10

FlowRate = 20

FlowRate Deleted
```

All three states remain in history.

***

# 5. Session Architecture

## Session

All user changes occur inside sessions.

```text
Create Session
Modify Objects
Commit Session
```

***

Example:

```text
Session 101

Modify Pump1
Modify Valve1

Commit
```

***

## Session States

```text
ACTIVE
COMMITTED
ABANDONED
```

***

# 6. Conflict Detection

System uses optimistic concurrency.

Example:

User A:

```text
Edit Pump1
BaseSession = 100
```

User B:

```text
Modify Pump1
Commit Session 101
```

User A Commit:

```text
Conflict
```

Result:

```text
Pump1 rejected
```

***

Rules:

```text
No auto merge
No branch merge
No conflict resolution
```

User must:

```text
Get latest version
Reapply changes
Commit again
```

***

# 7. Delete Model

Only logical delete allowed.

Example:

```text
Delete Pump1
```

Creates:

```text
IsDeleted = TRUE
```

History remains.

***

Rules:

```text
No physical delete
No history removal
```

***

# 8. Storage Design

## 8.1 Node Master

Stores immutable identity.

Contains:

```text
ContainerId
LocalId

CreatedSession
DeletedSession
```

***

## 8.2 Node State

Stores versioned node metadata.

Contains:

```text
NodeId
SessionId
NodeType
LastModifiedSession
StateFlags
```

***

## 8.3 Ownership History

Stores versioned ownership.

Contains:

```text
NodeId
OwnerNodeId
SessionId
```

***

# 9. Value Pooling

Duplicate values should be stored once.

***

## String Pool

Example:

```text
"PUMP-100"
```

stored one time.

Many nodes can reference same value.

***

## Real Pool

Example:

```text
100.0
```

stored one time.

***

## Boolean

Can use fixed internal values.

```text
TRUE
FALSE
```

***

## Reference

References stored directly.

No pooling required.

***

# 10. Property Storage

All property changes recorded historically.

Contains:

```text
NodeId
SessionId
AttributeId
ValueType
ValueId
DeletedFlag
```

***

Example

Session 10

```text
FlowRate=100
```

Session 20

```text
FlowRate=200
```

Session 30

```text
FlowRate deleted
```

History preserved.

***

# 11. Metadata

## Node Types

Contains:

```text
TypeId
TypeName
Description
```

***

## Attributes

Contains:

```text
AttributeId
AttributeName
DataType
IsArray
```

***

## Type Attribute Mapping

Defines:

```text
Which attributes are valid for a type
```

Example:

```text
Pump
 ├─ Name
 ├─ FlowRate
 └─ Pressure
```

***

# 12. API Philosophy

Applications must never access tables.

Only functions and procedures.

***

# 13. Required Functions

## Session

```text
CreateSession()

CommitSession()

AbandonSession()

GetSession()
```

***

## Node

```text
CreateNode()

DeleteNode()

ChangeNodeType()

GetNode()

GetChildren()

GetOwner()
```

***

## Attributes

```text
SetString()

SetReal()

SetBoolean()

SetReference()

SetArray()

DeleteAttribute()

GetAttribute()

GetAttributes()
```

***

## Metadata

```text
CreateType()

DeleteType()

CreateAttribute()

AssignAttributeToType()

RemoveAttributeFromType()
```

***

## Validation

```text
ValidateNode()

ValidateSession()

ValidateType()
```

***

# 14. Future Versions (Not V1)

The following are explicitly excluded:

```text
Branching
Git-style Merge
Claim Management
Permissions
Security
Distributed Storage
Caching Layer
Replication
Audit Trail
Query Optimizer
Search Engine
Derived Attributes
```

***

# 15. Scalability Targets

Target:

```text
Millions of Nodes
Billions of Properties
Decades of History
```

Expected usage:

```text
100-500 active engineering users
```

Initial design goal:

```text
Storage scalability first
User scalability second
```

***

# Next Phase

After this document, the SQL generation should proceed in the following order:

```text
Phase 1
  Core tables

Phase 2
  Metadata tables

Phase 3
  Session tables

Phase 4
  Value pools

Phase 5
  Property storage

Phase 6
  Index strategy

Phase 7
  Core functions

Phase 8
  Conflict detection

Phase 9
  Validation procedures

Phase 10
  Test datasets
```

This is the specification I would use as the baseline architecture document for the entire PostgreSQL repository.
