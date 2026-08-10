from __future__ import annotations

from opegit.repositories.commit_log_repository import (
    CommitLogRepository,
)

from opegit.services.branch_service import (
    BranchService,
)


class CommitLogService:

    @staticmethod
    def log_branch(
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
            CommitLogRepository.get_commit_log(
                head_commit
            )
        )

    @staticmethod
    def log_commit(
        commit_hash: str,
    ) -> list:
        return (
            CommitLogRepository.get_commit_log(
                commit_hash
            )
        )