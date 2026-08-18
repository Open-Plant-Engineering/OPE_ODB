from __future__ import annotations

from datetime import UTC
from datetime import datetime

from opegit.hashing.commit_hash import CommitHash
from opegit.models.commit import CommitResult

from opegit.repositories.commit_repository import (
    CommitRepository,
)


class MergeCommitService:

    @staticmethod
    def create_merge_commit(
        tree_hash: str,
        author_name: str,
        author_email: str,
        commit_message: str,
        parent_hash_1: str,
        parent_hash_2: str,
    ) -> CommitResult:

        now = datetime.now(UTC)

        commit_data = {
            "tree_hash": tree_hash,
            "parent_hash_1": parent_hash_1,
            "parent_hash_2": parent_hash_2,
            "author_name": author_name,
            "author_email": author_email,
            "commit_message": commit_message,
            "author_date": now.isoformat(),
        }

        commit_hash = CommitHash.calculate(
            commit_data
        )

        CommitRepository.create_commit(
            commit_hash=commit_hash,
            tree_hash=tree_hash,
            author_name=author_name,
            author_email=author_email,
            committer_name=author_name,
            committer_email=author_email,
            commit_message=commit_message,
            author_date=now,
            commit_date=now,
        )

        CommitRepository.add_commit_parent(
            commit_hash,
            parent_hash_1,
            1,
        )

        CommitRepository.add_commit_parent(
            commit_hash,
            parent_hash_2,
            2,
        )

        return CommitResult(
            commit_hash=commit_hash,
            tree_hash=tree_hash,
        )