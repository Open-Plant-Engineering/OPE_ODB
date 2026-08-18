from opegit.repositories.chunk_repository import (
    ChunkRepository,
)

from opegit.repositories.element_repository import (
    ElementRepository,
)

from opegit.repositories.manifest_repository import (
    ManifestRepository,
)

from opegit.repositories.tree_repository import (
    TreeRepository,
)

from opegit.services.commit_workflow_service import (
    CommitWorkflowService,
)

from opegit.services.repository_workflow_service import (
    RepositoryWorkflowService,
)

from opegit.services.restore_service import (
    RestoreService,
)


def test_restore_service() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "TEST_REPO"
        )
    )

    tree_hash = "b" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    ElementRepository.create_element(
        200,
        1,
    )

    chunk_hash = (
        ChunkRepository.get_or_create_chunk(
            chunk_hash="d" * 64,
            data_type_id=1,
            string_value="VALVE-1001",
        )
    )

    manifest_id = (
        ManifestRepository.create_manifest(
            "n" * 64
        )
    )

    ManifestRepository.add_manifest_entry(
        manifest_id,
        20,
        chunk_hash,
    )

    TreeRepository.add_tree_entry(
        tree_hash,
        200,
        1,
        manifest_id,
    )

    commit_hash = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_hash,
            author_name="Test",
            author_email="test@test.com",
            message="Restore Test",
        )
    )

    restored = (
        RestoreService.restore_commit(
            commit_hash
        )
    )

    assert len(restored) == 1

    assert (
        restored[0]["container_id"]
        == 200
    )

    assert (
        restored[0]["local_id"]
        == 1
    )