from dataclasses import dataclass


@dataclass(slots=True)
class CommitResult:
    commit_hash: str
    tree_hash: str