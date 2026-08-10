from opegit.repositories.tree_repository import (
    TreeRepository,
)

from opegit.services.branch_service import (
    BranchService,
)

from opegit.services.branch_workflow_service import (
    BranchWorkflowService,
)

from opegit.services.commit_workflow_service import (
    CommitWorkflowService,
)

from opegit.services.head_service import (
    HeadService,
)

from opegit.services.repository_workflow_service import (
    RepositoryWorkflowService,
)


def test_create_branch() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "TEST_REPO"
        )
    )

    tree_hash = "a" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    CommitWorkflowService.commit(
        repository_id=repository_id,
        tree_hash=tree_hash,
        author_name="Test",
        author_email="test@test.com",
        message="Initial Commit",
    )

    BranchWorkflowService.create_branch(
        repository_id,
        "develop",
    )

    assert (
        BranchService.branch_exists(
            repository_id,
            "develop",
        )
        is True
    )


def test_create_and_checkout_branch() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "TEST_REPO"
        )
    )

    tree_hash = "b" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    CommitWorkflowService.commit(
        repository_id=repository_id,
        tree_hash=tree_hash,
        author_name="Test",
        author_email="test@test.com",
        message="Initial Commit",
    )

    BranchWorkflowService.create_and_checkout_branch(
        repository_id,
        "develop",
    )

    assert (
        HeadService.current_branch(
            repository_id
        )
        == "develop"
    )


def test_delete_branch() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "TEST_REPO"
        )
    )

    tree_hash = "c" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    CommitWorkflowService.commit(
        repository_id=repository_id,
        tree_hash=tree_hash,
        author_name="Test",
        author_email="test@test.com",
        message="Initial Commit",
    )

    BranchWorkflowService.create_branch(
        repository_id,
        "develop",
    )

    assert (
        BranchService.branch_exists(
            repository_id,
            "develop",
        )
        is True
    )

    BranchWorkflowService.delete_branch(
        repository_id,
        "develop",
    )

    assert (
        BranchService.branch_exists(
            repository_id,
            "develop",
        )
        is False
    )