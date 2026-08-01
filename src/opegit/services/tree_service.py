from __future__ import annotations

from opegit.hashing.tree_hash import TreeHash
from opegit.repositories.tree_repository import TreeRepository


class TreeService:

    @staticmethod
    def create_tree(
        entries: list[dict],
    ) -> str:

        tree_hash = TreeHash.calculate(
            entries
        )

        TreeRepository.create_tree(
            tree_hash
        )

        for entry in entries:

            TreeRepository.add_tree_entry(
                tree_hash=tree_hash,
                container_id=entry["container_id"],
                local_id=entry["local_id"],
                manifest_id=entry["manifest_id"],
            )

        return tree_hash