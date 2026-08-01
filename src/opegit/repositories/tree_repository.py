from __future__ import annotations

from opegit.database.connection import DatabaseConnection


class TreeRepository:

    @staticmethod
    def tree_exists(
        tree_hash: str,
    ) -> bool:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    "select tree_exists(%s);",
                    (tree_hash,),
                )

                row = cur.fetchone()

        return bool(row[0])

    @staticmethod
    def create_tree(
        tree_hash: str,
    ) -> str:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    "select create_tree(%s);",
                    (tree_hash,),
                )

                row = cur.fetchone()

            conn.commit()

        return row[0]

    @staticmethod
    def add_tree_entry(
        tree_hash: str,
        container_id: int,
        local_id: int,
        manifest_id: int,
    ) -> None:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select add_tree_entry(
                        %s,
                        %s,
                        %s,
                        %s
                    );
                    """,
                    (
                        tree_hash,
                        container_id,
                        local_id,
                        manifest_id,
                    ),
                )

            conn.commit()

    @staticmethod
    def get_tree_entries(
        tree_hash: str,
    ) -> list[tuple[int, int, int]]:

        pool = DatabaseConnection.get_pool()

        with pool.connection() as conn:
            with conn.cursor() as cur:

                cur.execute(
                    """
                    select *
                    from get_tree_entries(%s);
                    """,
                    (tree_hash,),
                )

                rows = cur.fetchall()

        return rows