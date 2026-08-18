from __future__ import annotations

from opegit.repositories.restore_repository import (
    RestoreRepository,
)


class RestoreService:

    @staticmethod
    def restore_commit(
        commit_hash: str,
    ) -> list:
        return (
            RestoreRepository.restore_commit(
                commit_hash
            )
        )