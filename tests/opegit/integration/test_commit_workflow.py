from opegit.repositories.tree_repository import (
    TreeRepository,
)

from opegit.services.branch_service import (
    BranchService,
)

from opegit.services.commit_workflow_service import (
    CommitWorkflowService,
)

from opegit.services.repository_workflow_service import (
    RepositoryWorkflowService,
)


def test_full_commit_workflow() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "INTEGRATION_REPO"
        )
    )

    tree_hash = "b" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    commit_hash = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_hash,
            author_name="Test User",
            author_email="test@test.com",
            message="Initial Commit",
        )
    )

    branch_head = (
        BranchService.get_branch_head(
            repository_id,
            "main",
        )
    )

    assert len(commit_hash) == 64

    assert branch_head == commit_hash


from opegit.repositories.tree_repository import (
    TreeRepository,
)

from opegit.services.branch_service import (
    BranchService,
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


def test_full_commit_workflow() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "INTEGRATION_REPO"
        )
    )

    assert (
        HeadService.current_branch(
            repository_id
        )
        == "main"
    )

    tree_hash = "b" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    commit_hash = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_hash,
            author_name="Test User",
            author_email="test@test.com",
            message="Initial Commit",
        )
    )

    assert len(commit_hash) == 64

    assert (
        BranchService.branch_exists(
            repository_id,
            "main",
        )
    )

    assert (
        BranchService.get_branch_head(
            repository_id,
            "main",
        )
        == commit_hash
    )

    assert (
        HeadService.current_branch(
            repository_id
        )
        == "main"
    )