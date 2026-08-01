from __future__ import annotations

from opegit.database.connection import DatabaseConnection


class BranchService:

    @staticmethod
    def branch_exists(
        repository_id: int,
        branch_name: str,
    ) -> bool:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select branch_exists(
                        %s,
                        %s
                    );
                    """,
                    (
                        repository_id,
                        branch_name,
                    ),
                )

                row = cur.fetchone()

        return bool(row[0])

    @staticmethod
    def create_branch(
        repository_id: int,
        branch_name: str,
        commit_hash: str,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select create_branch(
                        %s,
                        %s,
                        %s
                    );
                    """,
                    (
                        repository_id,
                        branch_name,
                        commit_hash,
                    ),
                )

            conn.commit()

    @staticmethod
    def get_branch_head(
        repository_id: int,
        branch_name: str,
    ) -> str | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_branch_head(
                        %s,
                        %s
                    );
                    """,
                    (
                        repository_id,
                        branch_name,
                    ),
                )

                row = cur.fetchone()

        return row[0] if row else None

    @staticmethod
    def move_branch_head(
        repository_id: int,
        branch_name: str,
        commit_hash: str,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select move_branch_head(
                        %s,
                        %s,
                        %s
                    );
                    """,
                    (
                        repository_id,
                        branch_name,
                        commit_hash,
                    ),
                )

            conn.commit()

    @staticmethod
    def delete_branch(
        repository_id: int,
        branch_name: str,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select delete_branch(
                        %s,
                        %s
                    );
                    """,
                    (
                        repository_id,
                        branch_name,
                    ),
                )

            conn.commit()