from __future__ import annotations

from opegit.services.branch_service import (
    BranchService,
)

from opegit.services.head_service import (
    HeadService,
)


class CheckoutWorkflowService:

    @staticmethod
    def checkout_branch(
        repository_id: int,
        branch_name: str,
    ) -> None:

        if not BranchService.branch_exists(
            repository_id,
            branch_name,
        ):
            raise ValueError(
                f"Branch '{branch_name}' does not exist."
            )

        HeadService.checkout_branch(
            repository_id,
            branch_name,
        )

    @staticmethod
    def checkout_commit(
        repository_id: int,
        commit_hash: str,
    ) -> None:

        HeadService.checkout_commit(
            repository_id,
            commit_hash,
        )