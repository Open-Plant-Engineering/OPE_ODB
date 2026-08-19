from __future__ import annotations

from opegit.repositories.commit_repository import (
    CommitRepository,
)


class MergeBaseService:

    @staticmethod
    def find_merge_base(
        commit_a: str,
        commit_b: str,
    ) -> str | None:

        ancestors_a: set[str] = set()

        def collect_ancestors(
            commit_hash: str,
        ) -> None:

            if commit_hash in ancestors_a:
                return

            ancestors_a.add(
                commit_hash
            )

            parents = (
                CommitRepository.get_commit_parents(
                    commit_hash
                )
            )

            for (
                parent_hash,
                parent_index,
            ) in parents:

                collect_ancestors(
                    parent_hash
                )

        collect_ancestors(
            commit_a
        )

        visited: set[str] = set()

        def find_common(
            commit_hash: str,
        ) -> str | None:

            if commit_hash in visited:
                return None

            visited.add(
                commit_hash
            )

            if commit_hash in ancestors_a:
                return commit_hash

            parents = (
                CommitRepository.get_commit_parents(
                    commit_hash
                )
            )

            for (
                parent_hash,
                parent_index,
            ) in parents:

                result = find_common(
                    parent_hash
                )

                if result is not None:
                    return result

            return None

        return find_common(
            commit_b
        )