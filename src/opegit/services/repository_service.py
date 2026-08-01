from __future__ import annotations

from opegit.repositories.repository_repository import (
    RepositoryRepository,
)


class RepositoryService:

    @staticmethod
    def create_repository(
        repository_name: str,
    ) -> int:

        return RepositoryRepository.create_repository(
            repository_name
        )

    @staticmethod
    def get_repository(
        repository_name: str,
    ) -> int | None:

        return RepositoryRepository.get_repository_id(
            repository_name
        )