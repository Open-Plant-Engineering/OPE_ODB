from __future__ import annotations

from opegit.repositories.head_repository import (
    HeadRepository,
)


class HeadService:

    @staticmethod
    def checkout_branch(
        repository_id: int,
        branch_name: str,
    ) -> None:

        HeadRepository.set_head_branch(
            repository_id=repository_id,
            ref_name=f"refs/heads/{branch_name}",
        )

    @staticmethod
    def checkout_commit(
        repository_id: int,
        commit_hash: str,
    ) -> None:

        HeadRepository.set_head_commit(
            repository_id=repository_id,
            commit_hash=commit_hash,
        )

    @staticmethod
    def current_branch(
        repository_id: int,
    ) -> str | None:

        ref_name = HeadRepository.get_head(
            repository_id
        )

        if ref_name is None:
            return None

        if ref_name.startswith(
            "refs/heads/"
        ):
            return ref_name.replace(
                "refs/heads/",
                "",
                1,
            )

        return ref_name

    @staticmethod
    def current_commit(
        repository_id: int,
    ) -> str | None:

        return HeadRepository.get_head_commit(
            repository_id
        )

    @staticmethod
    def is_detached(
        repository_id: int,
    ) -> bool:

        return HeadRepository.is_head_detached(
            repository_id
        )