from datetime import datetime, UTC

from opegit.repositories.commit_repository import (
    CommitRepository,
)
from opegit.repositories.tree_repository import (
    TreeRepository,
)


def test_create_commit() -> None:

    tree_hash = "a" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    commit_hash = "b" * 64

    result = CommitRepository.create_commit(
        commit_hash=commit_hash,
        tree_hash=tree_hash,
        author_name="Test",
        author_email="test@test.com",
        committer_name="Test",
        committer_email="test@test.com",
        commit_message="Initial Commit",
        author_date=datetime.now(UTC),
        commit_date=datetime.now(UTC),
    )

    assert result == commit_hash


def test_commit_exists() -> None:

    tree_hash = "c" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    commit_hash = "d" * 64

    CommitRepository.create_commit(
        commit_hash=commit_hash,
        tree_hash=tree_hash,
        author_name="Test",
        author_email="test@test.com",
        committer_name="Test",
        committer_email="test@test.com",
        commit_message="Commit",
        author_date=datetime.now(UTC),
        commit_date=datetime.now(UTC),
    )

    assert CommitRepository.commit_exists(
        commit_hash
    )


def test_get_commit_tree() -> None:

    tree_hash = "e" * 64

    TreeRepository.create_tree(
        tree_hash
    )

    commit_hash = "f" * 64

    CommitRepository.create_commit(
        commit_hash=commit_hash,
        tree_hash=tree_hash,
        author_name="Test",
        author_email="test@test.com",
        committer_name="Test",
        committer_email="test@test.com",
        commit_message="Commit",
        author_date=datetime.now(UTC),
        commit_date=datetime.now(UTC),
    )

    result = CommitRepository.get_commit_tree(
        commit_hash
    )

    assert result == tree_hash