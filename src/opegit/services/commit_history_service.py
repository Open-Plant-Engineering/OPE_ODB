from __future__ import annotations

from opegit.repositories.commit_history_repository import (
    CommitHistoryRepository,
)


class CommitHistoryService:

    @staticmethod
    def log_branch(
        repository_id: int,
        branch_name: str,
    ) -> list:
        return (
            CommitHistoryRepository.get_branch_history(
                repository_id,
                branch_name,
            )
        )

    @staticmethod
    def log_commit(
        commit_hash: str,
    ) -> list:
        return (
            CommitHistoryRepository.get_commit_history(
                commit_hash
            )
        )