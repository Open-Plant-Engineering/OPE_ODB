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

from opegit.services.diff_service import (
    DiffService,
)

from opegit.services.repository_workflow_service import (
    RepositoryWorkflowService,
)


def test_diff_commits() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "TEST_REPO"
        )
    )

    tree_a = "a" * 64
    tree_b = "b" * 64

    TreeRepository.create_tree(tree_a)
    TreeRepository.create_tree(tree_b)

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

    ElementRepository.create_element(
        100,
        1,
    )

    ElementRepository.create_element(
        100,
        2,
    )

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
        manifest_1,
    )

    TreeRepository.add_tree_entry(
        tree_b,
        100,
        2,
        manifest_2,
    )

    commit_1 = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_a,
            author_name="Test",
            author_email="test@test.com",
            message="Commit 1",
        )
    )

    commit_2 = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_b,
            author_name="Test",
            author_email="test@test.com",
            message="Commit 2",
        )
    )

    diff = (
        DiffService.diff_commits(
            commit_1,
            commit_2,
        )
    )

    assert len(diff["added"]) == 1
    assert len(diff["removed"]) == 0
    assert len(diff["modified"]) == 0

    assert diff["added"][0] == (
        100,
        2,
    )