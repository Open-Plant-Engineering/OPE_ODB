from __future__ import annotations

from opegit.repositories.commit_repository import (
    CommitRepository,
)

from opegit.repositories.diff_repository import (
    DiffRepository,
)


class DiffService:

    @staticmethod
    def diff_trees(
        tree_hash_a: str,
        tree_hash_b: str,
    ) -> dict:

        return DiffRepository.diff_trees(
            tree_hash_a,
            tree_hash_b,
        )

    @staticmethod
    def diff_commits(
        commit_hash_a: str,
        commit_hash_b: str,
    ) -> dict:

        tree_hash_a = (
            CommitRepository.get_commit_tree(
                commit_hash_a
            )
        )

        tree_hash_b = (
            CommitRepository.get_commit_tree(
                commit_hash_b
            )
        )

        return DiffRepository.diff_trees(
            tree_hash_a,
            tree_hash_b,
        )