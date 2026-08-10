from __future__ import annotations

from opegit.services.branch_service import (
    BranchService,
)

from opegit.services.head_service import (
    HeadService,
)


class BranchWorkflowService:

    @staticmethod
    def create_branch(
        repository_id: int,
        branch_name: str,
    ) -> None:

        current_branch = (
            HeadService.current_branch(
                repository_id
            )
        )

        if current_branch is None:
            raise ValueError(
                "HEAD is detached."
            )

        commit_hash = (
            BranchService.get_branch_head(
                repository_id,
                current_branch,
            )
        )

        if commit_hash is None:
            raise ValueError(
                "Current branch has no commits."
            )

        BranchService.create_branch(
            repository_id=repository_id,
            branch_name=branch_name,
            commit_hash=commit_hash,
        )

    @staticmethod
    def create_and_checkout_branch(
        repository_id: int,
        branch_name: str,
    ) -> None:

        BranchWorkflowService.create_branch(
            repository_id,
            branch_name,
        )

        HeadService.checkout_branch(
            repository_id,
            branch_name,
        )

    @staticmethod
    def delete_branch(
        repository_id: int,
        branch_name: str,
    ) -> None:

        current_branch = (
            HeadService.current_branch(
                repository_id
            )
        )

        if current_branch == branch_name:
            raise ValueError(
                "Cannot delete checked out branch."
            )

        BranchService.delete_branch(
            repository_id,
            branch_name,
        )