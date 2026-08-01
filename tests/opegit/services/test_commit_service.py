from opegit.services.commit_service import (
    CommitService,
)
from opegit.repositories.tree_repository import (
    TreeRepository,
)


def test_create_commit() -> None:

    tree_hash = "1" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    commit = CommitService.create_commit(
        tree_hash=tree_hash,
        author_name="Shivang",
        author_email="shivang@test.com",
        commit_message="Initial Commit",
    )

    assert len(commit.commit_hash) == 64
    assert commit.tree_hash == tree_hash


def test_create_commit_with_parent() -> None:

    tree_hash = "2" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    parent = CommitService.create_commit(
        tree_hash=tree_hash,
        author_name="Shivang",
        author_email="shivang@test.com",
        commit_message="Parent Commit",
    )

    child = CommitService.create_commit(
        tree_hash=tree_hash,
        author_name="Shivang",
        author_email="shivang@test.com",
        commit_message="Child Commit",
        parent_hash=parent.commit_hash,
    )

    assert len(child.commit_hash) == 64