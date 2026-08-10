from opegit.repositories.tree_repository import (
    TreeRepository,
)

from opegit.services.commit_history_service import (
    CommitHistoryService,
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

    tree_hash = "a" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    commit_1 = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_hash,
            author_name="Test",
            author_email="test@test.com",
            message="Commit 1",
        )
    )

    commit_2 = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_hash,
            author_name="Test",
            author_email="test@test.com",
            message="Commit 2",
        )
    )

    history = (
        CommitHistoryService.log_branch(
            repository_id,
            "main",
        )
    )

    assert len(history) == 2

    assert history[0] == commit_2
    assert history[1] == commit_1

def test_log_commit() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "TEST_REPO"
        )
    )

    tree_hash = "b" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    commit_1 = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_hash,
            author_name="Test",
            author_email="test@test.com",
            message="Commit 1",
        )
    )

    commit_2 = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_hash,
            author_name="Test",
            author_email="test@test.com",
            message="Commit 2",
        )
    )

    history = (
        CommitHistoryService.log_commit(
            commit_2
        )
    )

    assert len(history) == 2

    assert history[0] == commit_2
    assert history[1] == commit_1