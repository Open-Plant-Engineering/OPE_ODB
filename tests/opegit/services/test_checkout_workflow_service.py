from opegit.repositories.tree_repository import (
    TreeRepository,
)

from opegit.services.checkout_workflow_service import (
    CheckoutWorkflowService,
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


def test_checkout_commit() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "TEST_REPO"
        )
    )

    tree_hash = "a" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    commit_hash = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_hash,
            author_name="Test",
            author_email="test@test.com",
            message="Commit 1",
        )
    )

    CheckoutWorkflowService.checkout_commit(
        repository_id,
        commit_hash,
    )

    assert (
        HeadService.current_commit(
            repository_id
        )
        == commit_hash
    )


def test_checkout_branch() -> None:

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
        message="Commit 1",
    )

    CheckoutWorkflowService.checkout_branch(
        repository_id,
        "main",
    )

    assert (
        HeadService.current_branch(
            repository_id
        )
        == "main"
    )