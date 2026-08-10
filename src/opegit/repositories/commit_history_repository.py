from __future__ import annotations

from opegit.repositories.commit_repository import (
    CommitRepository,
)

from opegit.services.branch_service import (
    BranchService,
)


class CommitHistoryRepository:

    @staticmethod
    def get_commit_history(
        commit_hash: str,
    ) -> list:
        history = []

        current_commit = commit_hash

        while current_commit:

            history.append(
                current_commit
            )

            current_commit = (
                CommitRepository.get_commit_parent(
                    current_commit
                )
            )

        return history

    @staticmethod
    def get_branch_history(
        repository_id: int,
        branch_name: str,
    ) -> list:
        head_commit = (
            BranchService.get_branch_head(
                repository_id,
                branch_name,
            )
        )

        if head_commit is None:
            return []

        return (
            CommitHistoryRepository.get_commit_history(
                head_commit
            )
        )