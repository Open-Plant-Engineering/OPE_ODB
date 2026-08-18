from opegit.repositories.tree_repository import (
    TreeRepository,
)

from opegit.services.commit_graph_service import (
    CommitGraphService,
)

from opegit.services.commit_workflow_service import (
    CommitWorkflowService,
)

from opegit.services.repository_workflow_service import (
    RepositoryWorkflowService,
)


def test_commit_graph_service() -> None:

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
        CommitGraphService.get_graph(
            commit_2
        )
    )

    assert len(graph) == 2