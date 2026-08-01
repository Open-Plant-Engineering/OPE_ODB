from __future__ import annotations

from opegit.database.connection import DatabaseConnection


class ElementRepository:

    @staticmethod
    def element_exists(
        container_id: int,
        local_id: int,
    ) -> bool:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select element_exists(
                        %s,
                        %s
                    );
                    """,
                    (
                        container_id,
                        local_id,
                    ),
                )

                row = cur.fetchone()

        return bool(row[0])

    @staticmethod
    def create_element(
        container_id: int,
        local_id: int,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select create_element(
                        %s,
                        %s
                    );
                    """,
                    (
                        container_id,
                        local_id,
                    ),
                )

            conn.commit()

    @staticmethod
    def get_element(
        container_id: int,
        local_id: int,
    ) -> tuple[int, int] | None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select *
                    from get_element(
                        %s,
                        %s
                    );
                    """,
                    (
                        container_id,
                        local_id,
                    ),
                )

                row = cur.fetchone()

        return row

    @staticmethod
    def delete_element(
        container_id: int,
        local_id: int,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select delete_element(
                        %s,
                        %s
                    );
                    """,
                    (
                        container_id,
                        local_id,
                    ),
                )

            conn.commit()