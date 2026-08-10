from __future__ import annotations

from opegit.repositories.tree_repository import (
    TreeRepository,
)


class DiffRepository:

    @staticmethod
    def diff_trees(
        tree_hash_a: str,
        tree_hash_b: str,
    ) -> dict:

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

        elements_a = set(tree_a.keys())
        elements_b = set(tree_b.keys())

        added = sorted(
            elements_b - elements_a
        )

        removed = sorted(
            elements_a - elements_b
        )

        modified: list[tuple[int, int]] = []

        for element in elements_a & elements_b:

            if tree_a[element] != tree_b[element]:
                modified.append(element)

        return {
            "added": added,
            "removed": removed,
            "modified": sorted(modified),
        }