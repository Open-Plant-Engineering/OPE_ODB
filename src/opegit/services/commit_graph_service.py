from __future__ import annotations

from opegit.hashing import commit_hash
from opegit.repositories.commit_graph_repository import (
    CommitGraphRepository,
)


class CommitGraphService:

    @staticmethod
    def get_graph(
        commit_hash: str,
    ) -> list[dict]:
        return (
            CommitGraphRepository.get_graph(
                commit_hash
            )
        )