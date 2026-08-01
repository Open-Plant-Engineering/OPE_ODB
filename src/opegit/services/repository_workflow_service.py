from __future__ import annotations

from opegit.repositories.repository_repository import (
    RepositoryRepository,
)

from opegit.repositories.head_repository import (
    HeadRepository,
)


class RepositoryWorkflowService:

    @staticmethod
    def init_repository(
        repository_name: str,
        default_branch: str = "main",
    ) -> int:

        repository_id = (
            RepositoryRepository.create_repository(
                repository_name
            )
        )

        HeadRepository.set_head_branch(
            repository_id,
            f"refs/heads/{default_branch}",
        )

        return repository_id