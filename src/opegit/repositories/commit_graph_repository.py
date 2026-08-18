from __future__ import annotations

from opegit.hashing import commit_hash
from opegit.repositories.commit_repository import (
    CommitRepository,
)


class CommitGraphRepository:

    @staticmethod
    def get_graph(
        commit_hash: str,
    ) -> list[dict]:
        graph: list[dict] = []
        visited: set[str] = set()

        def walk(
            current_commit: str,
        ) -> None:

            if current_commit in visited:
                return

            visited.add(
                current_commit
            )

            parents = (
                CommitRepository.get_commit_parents(
                    current_commit
                )
            )

            graph.append(
                {
                    "commit_hash": current_commit,
                    "parents": [
                        parent_hash
                        for (
                            parent_hash,
                            parent_index,
                        ) in parents
                    ],
                }
            )

            for (
                parent_hash,
                parent_index,
            ) in parents:
                walk(parent_hash)

        walk(commit_hash)

        return graph