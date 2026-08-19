from __future__ import annotations

from opegit.repositories.tree_repository import (
    TreeRepository,
)


class ConflictValidationService:

    @staticmethod
    def validate(
        tree_hash: str,
        container_id: int,
        local_id: int,
        expected_manifest_id: int,
    ) -> None:

        current_manifest_id = None

        entries = (
            TreeRepository.get_tree_entries(
                tree_hash
            )
        )

        for (
            entry_container_id,
            entry_local_id,
            manifest_id,
        ) in entries:

            if (
                entry_container_id == container_id
                and entry_local_id == local_id
            ):
                current_manifest_id = (
                    manifest_id
                )
                break

        if current_manifest_id != expected_manifest_id:
            raise ValueError(
                "Element has been modified by another user."
            )