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


def test_commit_workflow() -> None:

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
            message="Initial Commit",
        )
    )

    assert len(commit_hash) == 64

    assert (
        BranchService.get_branch_head(
            repository_id,
            "main",
        )
        == commit_hash
    )