from __future__ import annotations

from opegit.services.conflict_validation_service import (
    ConflictValidationService,
)


class AtomicUpdateWorkflowService:

    @staticmethod
    def validate_update(
        tree_hash: str,
        container_id: int,
        local_id: int,
        expected_manifest_id: int,
    ) -> None:

        ConflictValidationService.validate(
            tree_hash=tree_hash,
            container_id=container_id,
            local_id=local_id,
            expected_manifest_id=(
                expected_manifest_id
            ),
        )