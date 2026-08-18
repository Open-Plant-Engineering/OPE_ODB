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

from opegit.services.conflict_detection_service import (
    ConflictDetectionService,
)

from opegit.services.repository_workflow_service import (
    RepositoryWorkflowService,
)


def test_detect_conflicts() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "TEST_REPO"
        )
    )

    ElementRepository.create_element(
        100,
        1,
    )

    manifest_1 = (
        ManifestRepository.create_manifest(
            "1" * 64
        )
    )

    manifest_2 = (
        ManifestRepository.create_manifest(
            "2" * 64
        )
    )

    tree_a = "a" * 64
    tree_b = "b" * 64

    TreeRepository.create_tree(tree_a)
    TreeRepository.create_tree(tree_b)

    TreeRepository.add_tree_entry(
        tree_a,
        100,
        1,
        manifest_1,
    )

    TreeRepository.add_tree_entry(
        tree_b,
        100,
        1,
        manifest_2,
    )

    commit_a = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_a,
            author_name="Test",
            author_email="test@test.com",
            message="Commit A",
        )
    )

    commit_b = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_b,
            author_name="Test",
            author_email="test@test.com",
            message="Commit B",
        )
    )

    result = (
        ConflictDetectionService.detect_conflicts(
            commit_a,
            commit_b,
        )
    )

    assert result["has_conflicts"] is True

    assert result["conflicts"] == [
        (
            100,
            1,
        )
    ]

def test_no_conflicts() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "TEST_REPO"
        )
    )

    ElementRepository.create_element(
        200,
        1,
    )

    manifest_id = (
        ManifestRepository.create_manifest(
            "3" * 64
        )
    )

    tree_a = "c" * 64
    tree_b = "d" * 64

    TreeRepository.create_tree(tree_a)
    TreeRepository.create_tree(tree_b)

    TreeRepository.add_tree_entry(
        tree_a,
        200,
        1,
        manifest_id,
    )

    TreeRepository.add_tree_entry(
        tree_b,
        200,
        1,
        manifest_id,
    )

    commit_a = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_a,
            author_name="Test",
            author_email="test@test.com",
            message="Commit A",
        )
    )

    commit_b = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_b,
            author_name="Test",
            author_email="test@test.com",
            message="Commit B",
        )
    )

    result = (
        ConflictDetectionService.detect_conflicts(
            commit_a,
            commit_b,
        )
    )

    assert result["has_conflicts"] is False

    assert result["conflicts"] == []