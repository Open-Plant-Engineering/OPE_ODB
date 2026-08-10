from opegit.repositories.tree_repository import (
    TreeRepository,
)

from opegit.services.commit_log_service import (
    CommitLogService,
)

from opegit.services.commit_workflow_service import (
    CommitWorkflowService,
)

from opegit.services.repository_workflow_service import (
    RepositoryWorkflowService,
)


def test_log_branch() -> None:

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

    CommitWorkflowService.commit(
        repository_id=repository_id,
        tree_hash=tree_hash,
        author_name="Test",
        author_email="test@test.com",
        message="Commit 2",
    )

    log = (
        CommitLogService.log_branch(
            repository_id,
            "main",
        )
    )

    assert len(log) == 2

    assert (
        log[0]["commit_message"]
        == "Commit 2"
    )