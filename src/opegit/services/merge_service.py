from __future__ import annotations

from opegit.services.branch_service import (
    BranchService,
)


class MergeService:

    @staticmethod
    def fast_forward(
        repository_id: int,
        source_branch: str,
        target_branch: str,
    ) -> None:

        source_head = (
            BranchService.get_branch_head(
                repository_id,
                source_branch,
            )
        )

        if source_head is None:
            raise ValueError(
                f"Branch '{source_branch}' has no commits."
            )

        if not BranchService.branch_exists(
            repository_id,
            target_branch,
        ):
            raise ValueError(
                f"Branch '{target_branch}' does not exist."
            )

        BranchService.move_branch_head(
            repository_id=repository_id,
            branch_name=target_branch,
            commit_hash=source_head,
        )