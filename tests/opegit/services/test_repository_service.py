from opegit.services.repository_service import (
    RepositoryService,
)


def test_create_repository() -> None:

    repository_id = (
        RepositoryService.create_repository(
            "SERVICE_REPOSITORY"
        )
    )

    assert repository_id > 0


def test_get_repository() -> None:

    expected_id = (
        RepositoryService.create_repository(
            "SERVICE_REPOSITORY"
        )
    )

    repository_id = (
        RepositoryService.get_repository(
            "SERVICE_REPOSITORY"
        )
    )

    assert repository_id == expected_id