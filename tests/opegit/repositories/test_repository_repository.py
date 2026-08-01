from opegit.repositories.repository_repository import (
    RepositoryRepository,
)


def test_create_repository() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPOSITORY"
        )
    )

    assert repository_id > 0


def test_repository_exists() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPOSITORY"
        )
    )

    exists = (
        RepositoryRepository.repository_exists(
            repository_id
        )
    )

    assert exists is True


def test_get_repository_id() -> None:

    expected_id = (
        RepositoryRepository.create_repository(
            "TEST_REPOSITORY"
        )
    )

    repository_id = (
        RepositoryRepository.get_repository_id(
            "TEST_REPOSITORY"
        )
    )

    assert repository_id == expected_id


def test_get_repository_name() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPOSITORY"
        )
    )

    repository_name = (
        RepositoryRepository.get_repository_name(
            repository_id
        )
    )

    assert repository_name == "TEST_REPOSITORY"


def test_delete_repository() -> None:

    repository_id = (
        RepositoryRepository.create_repository(
            "TEST_REPOSITORY"
        )
    )

    RepositoryRepository.delete_repository(
        repository_id
    )

    exists = (
        RepositoryRepository.repository_exists(
            repository_id
        )
    )

    assert exists is False


def test_get_or_create_repository() -> None:

    repository_id_1 = (
        RepositoryRepository.create_repository(
            "TEST_REPOSITORY"
        )
    )

    repository_id_2 = (
        RepositoryRepository.get_repository_id(
            "TEST_REPOSITORY"
        )
    )

    assert repository_id_1 == repository_id_2