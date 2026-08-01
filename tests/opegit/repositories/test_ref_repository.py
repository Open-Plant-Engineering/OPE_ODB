from opegit.repositories.repository_repository import (
    RepositoryRepository,
)

from opegit.repositories.ref_repository import (
    RefRepository,
)


def test_create_ref() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    RefRepository.create_ref(
        repository_id=repository_id,
        ref_name="refs/heads/main",
        object_hash="a" * 64,
    )

    result = RefRepository.get_ref(
        repository_id=repository_id,
        ref_name="refs/heads/main",
    )

    assert result == ("a" * 64)


def test_ref_exists() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    RefRepository.create_ref(
        repository_id=repository_id,
        ref_name="refs/heads/dev",
        object_hash="b" * 64,
    )

    assert RefRepository.ref_exists(
        repository_id=repository_id,
        ref_name="refs/heads/dev",
    )


def test_update_ref() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    RefRepository.create_ref(
        repository_id=repository_id,
        ref_name="refs/heads/test",
        object_hash="c" * 64,
    )

    RefRepository.update_ref(
        repository_id=repository_id,
        ref_name="refs/heads/test",
        object_hash="d" * 64,
    )

    result = RefRepository.get_ref(
        repository_id=repository_id,
        ref_name="refs/heads/test",
    )

    assert result == ("d" * 64)


def test_delete_ref() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPO"
        )
    )

    RefRepository.create_ref(
        repository_id=repository_id,
        ref_name="refs/heads/remove",
        object_hash="e" * 64,
    )

    RefRepository.delete_ref(
        repository_id=repository_id,
        ref_name="refs/heads/remove",
    )

    assert not RefRepository.ref_exists(
        repository_id=repository_id,
        ref_name="refs/heads/remove",
    )