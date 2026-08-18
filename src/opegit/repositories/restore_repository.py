from __future__ import annotations

from opegit.repositories.chunk_repository import (
    ChunkRepository,
)

from opegit.repositories.commit_repository import (
    CommitRepository,
)

from opegit.repositories.manifest_repository import (
    ManifestRepository,
)

from opegit.repositories.tree_repository import (
    TreeRepository,
)


class RestoreRepository:

    @staticmethod
    def restore_commit(
        commit_hash: str,
    ) -> list:
        tree_hash = (
            CommitRepository.get_commit_tree(
                commit_hash
            )
        )

        if tree_hash is None:
            return []

        tree_entries = (
            TreeRepository.get_tree_entries(
                tree_hash
            )
        )

        restored_elements: list[dict] = []

        for (
            container_id,
            local_id,
            manifest_id,
        ) in tree_entries:

            manifest_entries = (
                ManifestRepository.get_manifest_entries(
                    manifest_id
                )
            )

            attributes = []

            for (
                attribute_id,
                chunk_hash,
            ) in manifest_entries:

                chunk = (
                    ChunkRepository.get_chunk(
                        chunk_hash
                    )
                )

                attributes.append(
                    {
                        "attribute_id": attribute_id,
                        "chunk_hash": chunk_hash,
                        "chunk": chunk,
                    }
                )

            restored_elements.append(
                {
                    "container_id": container_id,
                    "local_id": local_id,
                    "manifest_id": manifest_id,
                    "attributes": attributes,
                }
            )

        return restored_elements