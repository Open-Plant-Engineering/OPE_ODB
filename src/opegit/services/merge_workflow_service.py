from __future__ import annotations

from opegit.services.branch_service import (
    BranchService,
)

from opegit.services.merge_commit_service import (
    MergeCommitService,
)


class MergeWorkflowService:

    @staticmethod
    def merge_branch(
        repository_id: int,
        source_branch: str,
        target_branch: str,
        tree_hash: str,
        author_name: str,
        author_email: str,
    ) -> str:

        source_head = (
            BranchService.get_branch_head(
                repository_id,
                source_branch,
            )
        )

        target_head = (
            BranchService.get_branch_head(
                repository_id,
                target_branch,
            )
        )

        if source_head is None:
            raise ValueError(
                f"Source branch '{source_branch}' has no commits."
            )

        if target_head is None:
            raise ValueError(
                f"Target branch '{target_branch}' has no commits."
            )

        merge_commit = (
            MergeCommitService.create_merge_commit(
                tree_hash=tree_hash,
                author_name=author_name,
                author_email=author_email,
                commit_message=(
                    f"Merge {source_branch} into {target_branch}"
                ),
                parent_hash_1=target_head,
                parent_hash_2=source_head,
            )
        )

        BranchService.move_branch_head(
            repository_id=repository_id,
            branch_name=target_branch,
            commit_hash=merge_commit.commit_hash,
        )

        return merge_commit.commit_hash