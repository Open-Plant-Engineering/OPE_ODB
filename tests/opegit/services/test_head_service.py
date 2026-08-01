from opegit.repositories.repository_repository import (
    RepositoryRepository,
)

from opegit.services.head_service import (
    HeadService,
)


def test_checkout_branch() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    HeadService.checkout_branch(
        repository_id,
        "main",
    )

    assert (
        HeadService.current_branch(
            repository_id
        )
        == "main"
    )


def test_checkout_commit() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    commit_hash = "a" * 64

    HeadService.checkout_commit(
        repository_id,
        commit_hash,
    )

    assert (
        HeadService.current_commit(
            repository_id
        )
        == commit_hash
    )


def test_detached_head() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    HeadService.checkout_commit(
        repository_id,
        "b" * 64,
    )

    assert HeadService.is_detached(
        repository_id
    )