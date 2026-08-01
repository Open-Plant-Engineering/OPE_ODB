from opegit.repositories.head_repository import (
    HeadRepository,
)

from opegit.repositories.repository_repository import (
    RepositoryRepository,
)


def test_set_head_branch() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    HeadRepository.set_head_branch(
        repository_id,
        "refs/heads/main",
    )

    assert HeadRepository.get_head(
        repository_id
    ) == "refs/heads/main"


def test_set_head_commit() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    commit_hash = "a" * 64

    HeadRepository.set_head_commit(
        repository_id,
        commit_hash,
    )

    assert (
        HeadRepository.get_head_commit(
            repository_id
        )
        == commit_hash
    )


def test_head_exists() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    HeadRepository.set_head_branch(
        repository_id,
        "refs/heads/main",
    )

    assert HeadRepository.head_exists(
        repository_id
    )


def test_is_head_detached() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    HeadRepository.set_head_commit(
        repository_id,
        "b" * 64,
    )

    assert HeadRepository.is_head_detached(
        repository_id
    )


def test_delete_head() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    HeadRepository.set_head_branch(
        repository_id,
        "refs/heads/main",
    )

    HeadRepository.delete_head(
        repository_id
    )

    assert not HeadRepository.head_exists(
        repository_id
    )