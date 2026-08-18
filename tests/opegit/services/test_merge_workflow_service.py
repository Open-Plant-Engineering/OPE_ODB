from opegit.repositories.tree_repository import (
    TreeRepository,
)

from opegit.services.branch_workflow_service import (
    BranchWorkflowService,
)

from opegit.services.commit_workflow_service import (
    CommitWorkflowService,
)

from opegit.services.merge_workflow_service import (
    MergeWorkflowService,
)

from opegit.services.branch_service import (
    BranchService,
)

from opegit.services.repository_workflow_service import (
    RepositoryWorkflowService,
)

from opegit.services.head_service import (
    HeadService,
)


def test_merge_branch() -> None:

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

    BranchWorkflowService.create_and_checkout_branch(
        repository_id,
        "develop",
    )

    CommitWorkflowService.commit(
        repository_id=repository_id,
        tree_hash=tree_hash,
        author_name="Test",
        author_email="test@test.com",
        message="Develop Work",
    )

    HeadService.checkout_branch(
        repository_id,
        "main",
    )

    merge_commit = (
        MergeWorkflowService.merge_branch(
            repository_id=repository_id,
            source_branch="develop",
            target_branch="main",
            tree_hash=tree_hash,
            author_name="Test",
            author_email="test@test.com",
        )
    )

    main_head = (
        BranchService.get_branch_head(
            repository_id,
            "main",
        )
    )

    assert main_head == merge_commit