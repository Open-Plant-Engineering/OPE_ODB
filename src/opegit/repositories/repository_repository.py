from __future__ import annotations

from opegit.database.connection import DatabaseConnection


class RepositoryRepository:

    @staticmethod
    def repository_exists(
        repository_id: int,
    ) -> bool:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select repository_exists(%s);
                    """,
                    (repository_id,),
                )

                row = cur.fetchone()

        return bool(row[0])

    @staticmethod
    def create_repository(
        repository_name: str,
    ) -> int:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select create_repository(%s);
                    """,
                    (repository_name,),
                )

                row = cur.fetchone()

            conn.commit()

        return row[0]

    @staticmethod
    def get_repository_id(
        repository_name: str,
    ) -> int | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_repository_id(%s);
                    """,
                    (repository_name,),
                )

                row = cur.fetchone()

        return row[0] if row else None

    @staticmethod
    def get_repository_name(
        repository_id: int,
    ) -> str | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select get_repository_name(%s);
                    """,
                    (repository_id,),
                )

                row = cur.fetchone()

        return row[0] if row else None

    @staticmethod
    def delete_repository(
        repository_id: int,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select delete_repository(%s);
                    """,
                    (repository_id,),
                )

            conn.commit()

    @staticmethod
    def get_or_create_repository(
        repository_name: str,
    ) -> int:
    
        pool = DatabaseConnection.get_pool()
    
        with pool.connection() as conn:
            with conn.cursor() as cur:
            
                cur.execute(
                    """
                    select get_or_create_repository(%s);
                    """,
                    (repository_name,),
                )
    
                row = cur.fetchone()
    
            conn.commit()
    
        return row[0]