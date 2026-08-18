from opegit.repositories.commit_graph_repository import (
    CommitGraphRepository,
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


def test_get_graph() -> None:

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

    graph = (
        CommitGraphRepository.get_graph(
            commit_2
        )
    )

    assert len(graph) == 2

    assert (
        graph[0]["commit_hash"]
        == commit_2
    )