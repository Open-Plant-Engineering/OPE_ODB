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

from opegit.services.merge_service import (
    MergeService,
)

from opegit.services.repository_workflow_service import (
    RepositoryWorkflowService,
)


def test_fast_forward_merge() -> None:

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

    develop_commit = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_hash,
            author_name="Test",
            author_email="test@test.com",
            message="Develop Commit",
        )
    )

    HeadService.checkout_branch(
        repository_id,
        "main",
    )

    MergeService.fast_forward(
        repository_id=repository_id,
        source_branch="develop",
        target_branch="main",
    )

    main_head = (
        BranchService.get_branch_head(
            repository_id,
            "main",
        )
    )

    assert main_head == develop_commit