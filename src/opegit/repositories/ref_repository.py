from __future__ import annotations

from opegit.database.connection import DatabaseConnection


class RefRepository:

    @staticmethod
    def ref_exists(
        repository_id: int,
        ref_name: str,
    ) -> bool:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select ref_exists(
                        %s,
                        %s
                    );
                    """,
                    (
                        repository_id,
                        ref_name,
                    ),
                )

                row = cur.fetchone()

        return bool(row[0])

    @staticmethod
    def create_ref(
        repository_id: int,
        ref_name: str,
        object_hash: str,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select create_ref(
                        %s,
                        %s,
                        %s
                    );
                    """,
                    (
                        repository_id,
                        ref_name,
                        object_hash,
                    ),
                )

            conn.commit()

    @staticmethod
    def update_ref(
        repository_id: int,
        ref_name: str,
        object_hash: str,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select update_ref(
                        %s,
                        %s,
                        %s
                    );
                    """,
                    (
                        repository_id,
                        ref_name,
                        object_hash,
                    ),
                )

            conn.commit()

    @staticmethod
    def get_ref(
        repository_id: int,
        ref_name: str,
    ) -> str | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_ref(
                        %s,
                        %s
                    );
                    """,
                    (
                        repository_id,
                        ref_name,
                    ),
                )

                row = cur.fetchone()

        return row[0] if row else None

    @staticmethod
    def delete_ref(
        repository_id: int,
        ref_name: str,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select delete_ref(
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