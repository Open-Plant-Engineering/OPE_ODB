from __future__ import annotations

from opegit.repositories.commit_repository import (
    CommitRepository,
)

from opegit.repositories.tree_repository import (
    TreeRepository,
)


class ConflictDetectionService:

    @staticmethod
    def detect_conflicts(
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

        if tree_hash_a is None:
            raise ValueError(
                f"Commit '{commit_hash_a}' not found."
            )

        if tree_hash_b is None:
            raise ValueError(
                f"Commit '{commit_hash_b}' not found."
            )

        tree_a = {
            (container_id, local_id): manifest_id
            for (
                container_id,
                local_id,
                manifest_id,
            ) in TreeRepository.get_tree_entries(
                tree_hash_a
            )
        }

        tree_b = {
            (container_id, local_id): manifest_id
            for (
                container_id,
                local_id,
                manifest_id,
            ) in TreeRepository.get_tree_entries(
                tree_hash_b
            )
        }

        conflicts = []

        common_elements = (
            set(tree_a.keys())
            & set(tree_b.keys())
        )

        for element in common_elements:

            if (
                tree_a[element]
                != tree_b[element]
            ):
                conflicts.append(element)

        return {
            "has_conflicts": len(conflicts) > 0,
            "conflicts": sorted(conflicts),
        }