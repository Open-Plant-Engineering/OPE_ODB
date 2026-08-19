from opegit.repositories.element_repository import (
    ElementRepository,
)

from opegit.repositories.manifest_repository import (
    ManifestRepository,
)

from opegit.repositories.tree_repository import (
    TreeRepository,
)

from opegit.services.atomic_update_workflow_service import (
    AtomicUpdateWorkflowService,
)


def test_validate_update() -> None:

    tree_hash = "c" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    ElementRepository.create_element(
        300,
        1,
    )

    manifest_id = (
        ManifestRepository.create_manifest(
            "3" * 64
        )
    )

    TreeRepository.add_tree_entry(
        tree_hash,
        300,
        1,
        manifest_id,
    )

    AtomicUpdateWorkflowService.validate_update(
        tree_hash=tree_hash,
        container_id=300,
        local_id=1,
        expected_manifest_id=manifest_id,
    )