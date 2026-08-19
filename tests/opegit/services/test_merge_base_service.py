from opegit.repositories.tree_repository import (
    TreeRepository,
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

from opegit.services.merge_base_service import (
    MergeBaseService,
)

from opegit.services.repository_workflow_service import (
    RepositoryWorkflowService,
)


def test_find_merge_base() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "TEST_REPO"
        )
    )

    tree_hash = "a" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    base_commit = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_hash,
            author_name="Test",
            author_email="test@test.com",
            message="Base Commit",
        )
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

    main_commit = (
        CommitWorkflowService.commit(
            repository_id=repository_id,
            tree_hash=tree_hash,
            author_name="Test",
            author_email="test@test.com",
            message="Main Commit",
        )
    )

    merge_base = (
        MergeBaseService.find_merge_base(
            main_commit,
            develop_commit,
        )
    )

    assert merge_base == base_commit

def test_same_commit_is_merge_base() -> None:

    repository_id = (
        RepositoryWorkflowService.init_repository(
            "TEST_REPO"
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
            author_name="Test",
            author_email="test@test.com",
            message="Commit",
        )
    )

    merge_base = (
        MergeBaseService.find_merge_base(
            commit_hash,
            commit_hash,
        )
    )

    assert merge_base == commit_hash