from __future__ import annotations

from opegit.database.connection import DatabaseConnection


class HeadRepository:

    @staticmethod
    def head_exists(
        repository_id: int,
    ) -> bool:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select head_exists(%s);
                    """,
                    (repository_id,),
                )

                row = cur.fetchone()

        return bool(row[0])

    @staticmethod
    def set_head_branch(
        repository_id: int,
        ref_name: str,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select set_head_branch(
                        %s,
                        %s
                    );
                    """,
                    (
                        repository_id,
                        ref_name,
                    ),
                )

            conn.commit()

    @staticmethod
    def set_head_commit(
        repository_id: int,
        commit_hash: str,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select set_head_commit(
                        %s,
                        %s
                    );
                    """,
                    (
                        repository_id,
                        commit_hash,
                    ),
                )

            conn.commit()

    @staticmethod
    def get_head(
        repository_id: int,
    ) -> str | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_head(%s);
                    """,
                    (repository_id,),
                )

                row = cur.fetchone()

        return row[0] if row else None

    @staticmethod
    def get_head_commit(
        repository_id: int,
    ) -> str | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_head_commit(%s);
                    """,
                    (repository_id,),
                )

                row = cur.fetchone()

        return row[0] if row else None

    @staticmethod
    def is_head_detached(
        repository_id: int,
    ) -> bool:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select is_head_detached(%s);
                    """,
                    (repository_id,),
                )

                row = cur.fetchone()

        return bool(row[0])

    @staticmethod
    def detach_head(
        repository_id: int,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select detach_head(%s);
                    """,
                    (repository_id,),
                )

            conn.commit()

    @staticmethod
    def delete_head(
        repository_id: int,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select delete_head(%s);
                    """,
                    (repository_id,),
                )

            conn.commit()