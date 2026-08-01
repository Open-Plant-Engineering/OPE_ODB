from __future__ import annotations

from opegit.services.branch_service import (
    BranchService,
)

from opegit.services.commit_service import (
    CommitService,
)

from opegit.services.head_service import (
    HeadService,
)


class CommitWorkflowService:

    @staticmethod
    def commit(
        repository_id: int,
        tree_hash: str,
        author_name: str,
        author_email: str,
        message: str,
    ) -> str:

        branch_name = (
            HeadService.current_branch(
                repository_id
            )
        )

        if branch_name is None:
            raise ValueError(
                "HEAD is detached."
            )

        branch_exists = (
            BranchService.branch_exists(
                repository_id,
                branch_name,
            )
        )

        #
        # First commit on unborn branch
        #
        if not branch_exists:

            commit = CommitService.create_commit(
                tree_hash=tree_hash,
                author_name=author_name,
                author_email=author_email,
                commit_message=message,
                parent_hash=None,
            )

            BranchService.create_branch(
                repository_id=repository_id,
                branch_name=branch_name,
                commit_hash=commit.commit_hash,
            )

            return commit.commit_hash

        #
        # Existing branch
        #
        parent_hash = (
            BranchService.get_branch_head(
                repository_id,
                branch_name,
            )
        )

        commit = CommitService.create_commit(
            tree_hash=tree_hash,
            author_name=author_name,
            author_email=author_email,
            commit_message=message,
            parent_hash=parent_hash,
        )

        BranchService.move_branch_head(
            repository_id=repository_id,
            branch_name=branch_name,
            commit_hash=commit.commit_hash,
        )

        return commit.commit_hash