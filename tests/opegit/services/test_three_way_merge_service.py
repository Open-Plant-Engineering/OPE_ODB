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

from opegit.services.three_way_merge_service import (
    ThreeWayMergeService,
)


def test_three_way_merge_conflict() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "TEST_REPO"
        )
    )

    ElementRepository.create_element(
        100,
        1,
    )

    ancestor_manifest = (
        ManifestRepository.create_manifest(
            "1" * 64
        )
    )

    source_manifest = (
        ManifestRepository.create_manifest(
            "2" * 64
        )
    )

    target_manifest = (
        ManifestRepository.create_manifest(
            "3" * 64
        )
    )

    ancestor_tree = "a" * 64
    source_tree = "b" * 64
    target_tree = "c" * 64

    TreeRepository.create_tree(
        ancestor_tree
    )

    TreeRepository.create_tree(
        source_tree
    )

    TreeRepository.create_tree(
        target_tree
    )

    TreeRepository.add_tree_entry(
        ancestor_tree,
        100,
        1,
        ancestor_manifest,
    )

    TreeRepository.add_tree_entry(
        source_tree,
        100,
        1,
        source_manifest,
    )

    TreeRepository.add_tree_entry(
        target_tree,
        100,
        1,
        target_manifest,
    )

    ancestor_commit = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=ancestor_tree,
            author_name="Test",
            author_email="test@test.com",
            message="Ancestor",
        )
    )

    source_commit = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=source_tree,
            author_name="Test",
            author_email="test@test.com",
            message="Source",
        )
    )

    target_commit = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=target_tree,
            author_name="Test",
            author_email="test@test.com",
            message="Target",
        )
    )

    result = (
        ThreeWayMergeService.merge_analysis(
            ancestor_commit,
            source_commit,
            target_commit,
        )
    )

    assert result["has_conflicts"] is True