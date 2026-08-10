from __future__ import annotations

from opegit.repositories.commit_history_repository import (
    CommitHistoryRepository,
)

from opegit.repositories.commit_repository import (
    CommitRepository,
)


class CommitLogRepository:

    @staticmethod
    def get_commit_log(
        commit_hash: str,
    ) -> list:
        history = (
            CommitHistoryRepository.get_commit_history(
                commit_hash
            )
        )

        results: list[dict] = []

        for hash_value in history:

            row = (
                CommitRepository.get_commit(
                    hash_value
                )
            )

            if row is None:
                continue

            results.append(
                {
                    "commit_hash": row[0],
                    "tree_hash": row[1],
                    "author_name": row[2],
                    "author_email": row[3],
                    "committer_name": row[4],
                    "committer_email": row[5],
                    "commit_message": row[6],
                    "author_date": row[7],
                    "commit_date": row[8],
                }
            )

        return results