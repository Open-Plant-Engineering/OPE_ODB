from __future__ import annotations

from datetime import datetime, UTC

from opegit.hashing.commit_hash import CommitHash
from opegit.models.commit import CommitResult
from opegit.repositories.commit_repository import (
    CommitRepository,
)


class CommitService:

    @staticmethod
    def create_commit(
        tree_hash: str,
        author_name: str,
        author_email: str,
        commit_message: str,
        parent_hash: str | None = None,
    ) -> CommitResult:

        now = datetime.now(UTC)

        commit_data = {
            "tree_hash": tree_hash,
            "author_name": author_name,
            "author_email": author_email,
            "commit_message": commit_message,
            "parent_hash": parent_hash,
            "author_date": now.isoformat(),
        }

        commit_hash = CommitHash.calculate(
            commit_data
        )

        if parent_hash:

            CommitRepository.create_commit_with_parent(
                commit_hash=commit_hash,
                parent_hash=parent_hash,
                tree_hash=tree_hash,
                author_name=author_name,
                author_email=author_email,
                committer_name=author_name,
                committer_email=author_email,
                commit_message=commit_message,
                author_date=now,
                commit_date=now,
            )

        else:

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

        return CommitResult(
            commit_hash=commit_hash,
            tree_hash=tree_hash,
        )