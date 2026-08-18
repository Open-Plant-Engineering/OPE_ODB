from opegit.repositories.tree_repository import (
    TreeRepository,
)

from opegit.repositories.commit_repository import (
    CommitRepository,
)

from opegit.services.commit_workflow_service import (
    CommitWorkflowService,
)

from opegit.services.merge_commit_service import (
    MergeCommitService,
)

from opegit.services.repository_workflow_service import (
    RepositoryWorkflowService,
)


def test_create_merge_commit() -> None:

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

    merge_commit = (
        MergeCommitService.create_merge_commit(
            tree_hash=tree_hash,
            author_name="Test",
            author_email="test@test.com",
            commit_message="Merge Commit",
            parent_hash_1=commit_1,
            parent_hash_2=commit_2,
        )
    )